SECTION .data
    filename:    db "/sys/class/hwmon/hwmon7/energy17_input", 0

SECTION .bss
    readbuf:     resb 64        ; buffer for reading file
    outbuf:      resb 64        ; buffer for output string

SECTION .text
global _start

_start:
    ; --- Open the file using SYS_openat (syscall 257) ---
    mov     rax, 257           ; syscall number for openat
    mov     rdi, -100          ; AT_FDCWD
    lea     rsi, [rel filename] ; pointer to filename
    mov     rdx, 0             ; flags: O_RDONLY (0)
    xor     r10, r10           ; mode = 0
    xor     r8, r8
    xor     r9, r9
    syscall
    ; Check if error (rax < 0)
    test    rax, rax
    js      exit_error
    mov     rbx, rax           ; save file descriptor in rbx

    ; --- First reading: pread (syscall 17) ---
    mov     rax, 17            ; SYS_pread64
    mov     rdi, rbx           ; file descriptor
    lea     rsi, [rel readbuf] ; buffer pointer
    mov     rdx, 63            ; read up to 63 bytes (reserve space for null)
    xor     r10, r10           ; offset = 0
    xor     r8, r8
    xor     r9, r9
    syscall
    cmp     rax, 1             ; require at least one byte read
    jl      exit_error
    mov     rcx, rax           ; save byte count in rcx
    ; Null-terminate the string: readbuf[rcx] = 0
    lea     rdi, [rel readbuf]
    add     rdi, rcx
    mov     byte [rdi], 0

    ; --- Parse first number from readbuf ---
    lea     rsi, [rel readbuf]
    call    parse_number       ; result returned in rax
    mov     r12, rax           ; r12 = initial energy

    ; --- Sleep 10ms using SYS_nanosleep (syscall 35) ---
    sub     rsp, 16            ; allocate 16 bytes for a timespec struct
    mov     qword [rsp], 0     ; tv_sec = 0
    mov     qword [rsp+8], 10000000 ; tv_nsec = 10,000,000 ns (10ms)
    mov     rax, 35            ; SYS_nanosleep
    mov     rdi, rsp           ; pointer to timespec
    xor     rsi, rsi           ; no remainder pointer
    syscall
    add     rsp, 16            ; deallocate timespec

    ; --- Second reading: pread again ---
    mov     rax, 17
    mov     rdi, rbx
    lea     rsi, [rel readbuf]
    mov     rdx, 63
    xor     r10, r10
    xor     r8, r8
    xor     r9, r9
    syscall
    cmp     rax, 1
    jl      exit_error
    mov     rcx, rax
    lea     rdi, [rel readbuf]
    add     rdi, rcx
    mov     byte [rdi], 0

    ; --- Parse second number ---
    lea     rsi, [rel readbuf]
    call    parse_number
    mov     r13, rax           ; r13 = final energy

    ; --- Close file (SYS_close, syscall 3) ---
    mov     rax, 3
    mov     rdi, rbx
    syscall

    ; --- Compute energy difference ---
    mov     rax, r13
    sub     rax, r12           ; rax = energy_diff (in microjoules)

    ; --- Compute power usage in watts ---
    ; power = (energy_diff in µJ) / 1e6 / 0.01 = energy_diff/10000.
    ; To format with one decimal digit, compute:
    ;   power_times10 = (energy_diff + 500) / 1000
    add     rax, 500           ; for rounding
    mov     rbx, 1000
    xor     rdx, rdx
    div     rbx                ; rax = power_times10 (i.e. power*10 rounded)
    mov     r12, rax           ; save power_times10 in r12

    ; --- Split into integer and fractional parts ---
    mov     rax, r12
    xor     rdx, rdx
    mov     rbx, 10
    div     rbx                ; quotient in rax = integer part, remainder in rdx = fraction
    mov     r14, rax           ; r14 = integer part
    mov     r15, rdx           ; r15 = fractional digit

    ; --- Convert integer part to string into outbuf ---
    lea     rdi, [rel outbuf]  ; rdi points to outbuf (output buffer)
    cmp     r14, 0
    jne     convert_int
    mov     byte [rdi], '0'
    inc     rdi
    jmp     after_int

convert_int:
    ; Convert r14 to decimal in reverse order in a temporary area at outbuf+32.
    lea     rbx, [rel outbuf+32]  ; temporary buffer for digits
    xor     rcx, rcx           ; digit counter = 0
convert_int_loop:
    cmp     r14, 0
    je      convert_int_done
    xor     rdx, rdx
    mov     rax, r14
    mov     r8, 10
    div     r8                 ; rax = r14/10, rdx = r14 mod 10
    add     rdx, '0'
    mov     byte [rbx + rcx], dl
    inc     rcx
    mov     r14, rax
    jmp     convert_int_loop

convert_int_done:
    dec     rcx              ; rcx = last index
reverse_loop:
    cmp     rcx, -1
    je      after_int
    mov     al, [rbx + rcx]
    mov     [rdi], al
    inc     rdi
    dec     rcx
    jmp     reverse_loop

after_int:
    ; Append decimal point, fractional digit, and newline.
    mov     byte [rdi], '.'
    inc     rdi
    add     r15, '0'
    mov     byte [rdi], r15b
    inc     rdi
    mov     byte [rdi], 10
    inc     rdi

    ; --- Write the output using SYS_write (syscall 1) ---
    lea     rax, [rel outbuf]  ; start address of outbuf
    mov     rcx, rdi
    sub     rcx, rax          ; rcx now holds the length
    mov     rax, 1            ; SYS_write
    mov     rdi, 1            ; stdout
    lea     rsi, [rel outbuf]
    mov     rdx, rcx          ; length
    syscall

    ; --- Exit normally (SYS_exit, syscall 60) ---
    mov     rax, 60
    xor     rdi, rdi
    syscall

exit_error:
    mov     rax, 60            ; SYS_exit
    mov     rdi, 1             ; exit code 1
    syscall

;--------------------------------------------------
; Function: parse_number
; Parses a null-terminated ASCII number from the address in rsi.
; Returns the 64-bit unsigned number in rax.
; Exits with error if no digits are found.
; (This version preserves rbx so as not to clobber the saved file descriptor.)
parse_number:
    push    rbx              ; preserve rbx
    mov     r8, rsi          ; save starting pointer
    xor     rax, rax         ; accumulator = 0
.parse_loop:
    mov     bl, byte [rsi]
    cmp     bl, 0
    je      .parse_end
    cmp     bl, '0'
    jb      .parse_end
    cmp     bl, '9'
    ja      .parse_end
    imul    rax, rax, 10
    sub     bl, '0'
    movzx   rbx, bl
    add     rax, rbx
    inc     rsi
    jmp     .parse_loop
.parse_end:
    cmp     rsi, r8          ; if no digits were processed…
    je      .parse_fail
    pop     rbx
    ret
.parse_fail:
    pop     rbx
    mov     rax, 60
    mov     rdi, 1
    syscall
