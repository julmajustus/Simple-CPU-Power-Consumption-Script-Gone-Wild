#define SYS_read       0
#define SYS_write      1
#define SYS_openat     257
#define SYS_close      3
#define SYS_pread64    17
#define SYS_nanosleep  35
#define SYS_exit       60

#define O_RDONLY       0
#define AT_FDCWD       -100LL

typedef unsigned long long uint64_t;
typedef unsigned long size_t;
typedef long ssize_t;

struct timespec {
    long tv_sec;
    long tv_nsec;
};

#define BUFFER_SIZE 64
#define CPU_INPUT_FILE "/sys/class/hwmon/hwmon7/energy17_input"

static inline long sys_call(long num, long arg1, long arg2, long arg3,
                              long arg4, long arg5, long arg6) {
    long ret;
    register long r10 asm("r10") = arg4;
    register long r8  asm("r8")  = arg5;
    register long r9  asm("r9")  = arg6;
    asm volatile (
        "syscall"
        : "=a" (ret)
        : "a" (num),
          "D" (arg1),
          "S" (arg2),
          "d" (arg3),
          "r" (r10),
          "r" (r8),
          "r" (r9)
        : "rcx", "r11", "memory"
    );
    return ret;
}

static inline void my_exit(int code) __attribute__((noreturn));
static inline void my_exit(int code) {
    sys_call(SYS_exit, code, 0, 0, 0, 0, 0);
    while (1) { }
}

static inline ssize_t my_pread(int fd, void *buf, size_t count, long offset) {
    return sys_call(SYS_pread64, fd, (long)buf, count, offset, 0, 0);
}

static inline int my_nanosleep(const struct timespec *req, struct timespec *rem) {
    return sys_call(SYS_nanosleep, (long)req, (long)rem, 0, 0, 0, 0);
}

static uint64_t parse_uint64(const char *s, ssize_t len) {
    uint64_t result = 0;
    for (ssize_t i = 0; i < len; i++) {
        char c = s[i];
        if (c < '0' || c > '9')
            break;
        result = result * 10 + (c - '0');
    }
    return result;
}

static uint64_t get_cpu_energy(int fd) {
    char buf[BUFFER_SIZE];
    ssize_t bytes = my_pread(fd, buf, BUFFER_SIZE, 0);
    if (bytes <= 0)
        my_exit(1);
    return parse_uint64(buf, bytes);
}

void _start(void) {
    int fd = sys_call(SYS_openat, AT_FDCWD, (long)CPU_INPUT_FILE, O_RDONLY, 0, 0, 0);
    if (fd < 0)
        my_exit(1);

    uint64_t initial_energy = get_cpu_energy(fd);

    struct timespec req = { .tv_sec = 0, .tv_nsec = 10000000 };
    my_nanosleep(&req, 0);

    uint64_t final_energy = get_cpu_energy(fd);
    sys_call(SYS_close, fd, 0, 0, 0, 0, 0);

    uint64_t energy_diff = final_energy - initial_energy;
    uint64_t power_times10 = (energy_diff + 500) / 1000; 
    uint64_t int_part = power_times10 / 10;
    uint64_t frac_part = power_times10 % 10;

    char outbuf[64];
    int pos = 0;
    if (int_part == 0) {
        outbuf[pos++] = '0';
    } else {
        char temp[32];
        int temp_pos = 0;
        while (int_part) {
            temp[temp_pos++] = '0' + (int_part % 10);
            int_part /= 10;
        }
        for (int i = temp_pos - 1; i >= 0; i--) {
            outbuf[pos++] = temp[i];
        }
    }
    outbuf[pos++] = '.';
    outbuf[pos++] = '0' + frac_part;
    outbuf[pos++] = '\n';

    sys_call(SYS_write, 1, (long)outbuf, pos, 0, 0, 0);
    my_exit(0);
}
