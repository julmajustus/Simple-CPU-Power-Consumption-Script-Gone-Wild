# get_cpu_power_usage
Simple cpu power consuption script gone wild. It turned out to be a performance competition with diffrent languages, which can provide the fastest binary. I benchmarked the binaries with [poop](https://github.com/andrewrk/poop). I used `poop -d 60000` to run each benchmark for 60seconds.


`I'm not a master of any of the languages, so I relied on help of AI with languages like GO, Rust and ASM.`

### Compiling
I tried to compile binaries with default compiler settings and with possible compiler optimizations I could find.

- **C & CPP**
  - default: gcc/g++
  - optimizations: gcc/g++ -O3 -march=native -flto
  - nolibc: gcc -nostdlib -static -O3 -march=native -flto

- **GO**
  - default: go build ./get_cpu_power_usage.go
  - optimizations: go build -ldflags="-s -w" -trimpath `This did not provide good results.`

- **Rust**
  - default: rustc get_cpu_power_usage.rs 
  - optimizations: rustc -C opt-level=3 -C lto=thin -C target-cpu=native -C codegen-units=1 -C panic=abort

- **Zig**
  - default: zig build-exe get_cpu_power_usage.zig
  - optimizations: zig build-exe -O ReleaseFast get_cpu_power_usage.zig

- **ASM**
  - nasm -f elf64 get_cpu_power_usage.asm -o get_cpu_power_usage.o
  - ld -o get_cpu_power_usageASM get_cpu_power_usage.o




```code
Benchmark 1 (5873 runs): ./get_cpu_power_usageASM
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.2ms ± 19.7us    10.1ms … 10.4ms        141 ( 2%)        0%
  peak_rss            949KB ± 20.7KB     553KB …  950KB         35 ( 1%)        0%
  cpu_cycles         1.24K  ±  327       916   … 7.27K         406 ( 7%)        0%
  instructions        522   ± 0.07       522   …  523           32 ( 1%)        0%
  cache_references    122   ± 23.6        34   …  243           39 ( 1%)        0%
  cache_misses       13.0   ± 14.6         0   …  116          342 ( 6%)        0%
  branch_misses      11.1   ± 2.35         8   …   26          255 ( 4%)        0%
Benchmark 2 (5802 runs): ./get_cpu_power_usageC
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.3ms ± 54.2us    10.3ms … 11.2ms        139 ( 2%)        💩+  1.3% ±  0.0%
  peak_rss           1.63MB ± 99.4KB    1.11MB … 1.75MB        967 (17%)        💩+ 72.0% ±  0.3%
  cpu_cycles          167K  ± 24.8K      149K  …  353K         773 (13%)        💩+13322.6% ± 51.1%
  instructions        128K  ± 22.5       128K  …  128K           1 ( 0%)        💩+24440.6% ±  0.1%
  cache_references   10.7K  ±  332      9.84K  … 14.3K         324 ( 6%)        💩+8645.9% ±  7.0%
  cache_misses       4.47K  ±  265      3.77K  … 6.43K         487 ( 8%)        💩+34280.6% ± 52.1%
  branch_misses      2.39K  ± 40.2      1.98K  … 2.56K         162 ( 3%)        💩+21470.1% ±  9.3%
Benchmark 3 (5801 runs): ./get_cpu_power_usageC_optimized
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.3ms ± 54.9us    10.2ms … 10.9ms        102 ( 2%)        💩+  1.3% ±  0.0%
  peak_rss           1.63MB ± 98.8KB    1.11MB … 1.72MB        935 (16%)        💩+ 72.2% ±  0.3%
  cpu_cycles          168K  ± 27.4K      149K  …  389K         930 (16%)        💩+13414.3% ± 56.3%
  instructions        128K  ± 24.2       128K  …  129K          14 ( 0%)        💩+24480.4% ±  0.1%
  cache_references   10.6K  ±  333      9.87K  … 13.1K         393 ( 7%)        💩+8609.6% ±  7.0%
  cache_misses       4.48K  ±  255      3.58K  … 6.25K         566 (10%)        💩+34355.0% ± 50.3%
  branch_misses      2.39K  ± 39.8      1.97K  … 2.58K         183 ( 3%)        💩+21441.3% ±  9.2%
Benchmark 4 (5873 runs): ./get_cpu_power_usage_nolibcC
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.2ms ± 20.2us    10.1ms … 10.3ms        146 ( 2%)          +  0.0% ±  0.0%
  peak_rss            978KB ± 19.8KB     668KB …  979KB         37 ( 1%)        💩+  3.0% ±  0.1%
  cpu_cycles         1.95K  ±  563      1.32K  … 9.15K         428 ( 7%)        💩+ 56.9% ±  1.3%
  instructions       1.16K  ± 0.77      1.16K  … 1.20K         650 (11%)        💩+122.2% ±  0.0%
  cache_references    114   ± 30.7        69   …  381          533 ( 9%)        ⚡-  6.8% ±  0.8%
  cache_misses       16.8   ± 16.5         0   …  157          431 ( 7%)        💩+ 29.4% ±  4.3%
  branch_misses      20.8   ± 4.18        16   …   35          166 ( 3%)        💩+ 87.4% ±  1.1%
Benchmark 5 (5873 runs): ./get_cpu_power_usage_nolibcC_optimized
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.2ms ± 19.4us    10.1ms … 10.3ms        153 ( 3%)          +  0.0% ±  0.0%
  peak_rss            977KB ± 20.7KB     668KB …  979KB         38 ( 1%)        💩+  3.0% ±  0.1%
  cpu_cycles         1.18K  ±  313       828   … 5.00K         469 ( 8%)        ⚡-  4.7% ±  0.9%
  instructions        490   ± 0.23       490   …  491          331 ( 6%)        ⚡-  6.1% ±  0.0%
  cache_references    142   ± 27.8        56   …  244           30 ( 1%)        💩+ 16.3% ±  0.8%
  cache_misses       11.8   ± 14.0         0   …  116          519 ( 9%)        ⚡-  9.4% ±  4.0%
  branch_misses      13.0   ± 3.65        10   …   27          182 ( 3%)        💩+ 17.1% ±  1.0%
Benchmark 6 (5595 runs): ./get_cpu_power_usageGO
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.7ms ± 77.5us    10.5ms … 11.1ms         30 ( 1%)        💩+  5.0% ±  0.0%
  peak_rss           3.68MB ±  195KB    2.98MB … 5.91MB       2012 (36%)        💩+288.1% ±  0.5%
  cpu_cycles          463K  ± 49.2K      351K  …  778K         383 ( 7%)        💩+37136.5% ± 101.4%
  instructions        537K  ± 11.5K      496K  …  607K         112 ( 2%)        💩+102857.5% ± 56.2%
  cache_references   42.6K  ± 2.51K     36.5K  … 53.7K         108 ( 2%)        💩+34852.4% ± 52.7%
  cache_misses       13.9K  ± 1.57K     9.98K  … 21.1K         204 ( 4%)        💩+106703.2% ± 308.9%
  branch_misses      3.74K  ±  409      2.83K  … 5.17K          71 ( 1%)        💩+33644.7% ± 94.3%
Benchmark 7 (5590 runs): ./get_cpu_power_usageGO_optimized
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.7ms ± 75.9us    10.5ms … 11.2ms         30 ( 1%)        💩+  5.1% ±  0.0%
  peak_rss           3.68MB ±  204KB    2.98MB … 5.91MB       1952 (35%)        💩+288.3% ±  0.6%
  cpu_cycles          472K  ± 49.0K      356K  …  710K         304 ( 5%)        💩+37899.0% ± 100.9%
  instructions        538K  ± 11.4K      492K  …  603K         132 ( 2%)        💩+102891.7% ± 55.8%
  cache_references   43.2K  ± 2.56K     35.5K  … 54.0K         154 ( 3%)        💩+35276.5% ± 53.7%
  cache_misses       13.9K  ± 1.68K     9.94K  … 21.6K         215 ( 4%)        💩+107088.8% ± 330.5%
  branch_misses      3.80K  ±  400      2.78K  … 5.41K          62 ( 1%)        💩+34140.1% ± 92.3%
Benchmark 8 (5761 runs): ./get_cpu_power_usageRS
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.4ms ± 70.6us    10.3ms … 10.8ms         96 ( 2%)        💩+  2.0% ±  0.0%
  peak_rss           2.05MB ± 78.9KB    1.45MB … 2.22MB        413 ( 7%)        💩+116.1% ±  0.2%
  cpu_cycles          277K  ± 38.1K      250K  …  523K         809 (14%)        💩+22229.8% ± 78.5%
  instructions        303K  ±  335       303K  …  306K          49 ( 1%)        💩+58024.4% ±  1.6%
  cache_references   18.0K  ±  650      16.9K  … 23.3K         532 ( 9%)        💩+14648.5% ± 13.6%
  cache_misses       6.75K  ±  521      5.57K  … 9.70K         459 ( 8%)        💩+51836.1% ± 102.5%
  branch_misses      3.80K  ± 56.9      3.16K  … 4.05K         220 ( 4%)        💩+34198.4% ± 13.1%
Benchmark 9 (5766 runs): ./get_cpu_power_usageRS_optimized
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.4ms ± 70.0us    10.3ms … 11.4ms        154 ( 3%)        💩+  1.9% ±  0.0%
  peak_rss           2.02MB ± 95.3KB    1.50MB … 2.21MB        745 (13%)        💩+112.7% ±  0.3%
  cpu_cycles          265K  ± 34.5K      239K  …  512K         885 (15%)        💩+21262.0% ± 70.9%
  instructions        297K  ±  331       296K  …  299K          35 ( 1%)        💩+56717.8% ±  1.6%
  cache_references   17.3K  ±  572      16.1K  … 21.1K         442 ( 8%)        💩+14053.9% ± 12.0%
  cache_misses       6.33K  ±  417      5.13K  … 8.91K         562 (10%)        💩+48627.0% ± 82.1%
  branch_misses      3.68K  ± 52.1      3.08K  … 3.93K         170 ( 3%)        💩+33067.4% ± 12.0%
Benchmark 10 (5833 runs): ./get_cpu_power_usageZIG
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.3ms ± 30.7us    10.2ms … 10.4ms        304 ( 5%)          +  0.7% ±  0.0%
  peak_rss            976KB ± 27.0KB     668KB …  979KB         69 ( 1%)        💩+  2.9% ±  0.1%
  cpu_cycles         48.6K  ± 7.01K     35.8K  … 88.0K          39 ( 1%)        💩+3812.8% ± 14.4%
  instructions       26.0K  ±  169      25.7K  … 26.3K        1852 (32%)        💩+4879.6% ±  0.8%
  cache_references   3.88K  ±  433      2.89K  … 5.64K           4 ( 0%)        💩+3082.6% ±  9.1%
  cache_misses       1.44K  ±  315       575   … 2.77K           1 ( 0%)        💩+11008.3% ± 62.1%
  branch_misses       353   ± 93.8       185   …  538            0 ( 0%)        💩+3087.9% ± 21.6%
Benchmark 11 (5861 runs): ./get_cpu_power_usageZIG_optimized
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.2ms ± 24.9us    10.1ms … 10.4ms        255 ( 4%)          +  0.2% ±  0.0%
  peak_rss            977KB ± 26.6KB     614KB …  979KB         66 ( 1%)        💩+  2.9% ±  0.1%
  cpu_cycles         6.53K  ±  933      4.67K  … 14.4K          97 ( 2%)        💩+425.9% ±  2.0%
  instructions       2.56K  ±  117      2.32K  … 2.76K        1886 (32%)        💩+389.8% ±  0.6%
  cache_references    519   ± 52.2       320   …  801           35 ( 1%)        💩+325.5% ±  1.2%
  cache_misses        215   ± 67.8        52   …  417            0 ( 0%)        💩+1551.2% ± 13.6%
  branch_misses      84.9   ± 16.3        40   …  111            0 ( 0%)        💩+665.8% ±  3.8%
Benchmark 12 (565 runs): ./get_cpu_power_usage.py
  measurement          mean ± σ            min … max           outliers         delta
  wall_time           106ms ±  478us     105ms …  108ms         53 ( 9%)        💩+941.8% ±  0.1%
  peak_rss           11.0MB ±  228KB    10.1MB … 11.5MB         22 ( 4%)        💩+1061.6% ±  0.6%
  cpu_cycles         24.6M  ± 1.30M     22.1M  … 28.1M           0 ( 0%)        💩+1978420.6% ± 2665.6%
  instructions       39.2M  ± 41.6K     39.1M  … 39.4M           7 ( 1%)        💩+7515607.6% ± 203.8%
  cache_references   1.96M  ± 23.5K     1.91M  … 2.05M           2 ( 0%)        💩+1607562.2% ± 492.9%
  cache_misses        255K  ± 13.7K      230K  …  295K           2 ( 0%)        💩+1958452.4% ± 2692.7%
  branch_misses       349K  ± 3.80K      342K  …  364K          14 ( 2%)        💩+3146080.6% ± 876.2%
Benchmark 13 (582 runs): ./get_cpu_power_usage.sh
  measurement          mean ± σ            min … max           outliers         delta
  wall_time           103ms ±  196us     103ms …  105ms         10 ( 2%)        💩+911.4% ±  0.1%
  peak_rss           5.03MB ±  129KB    4.39MB … 5.21MB         23 ( 4%)        💩+429.6% ±  0.4%
  cpu_cycles         3.78M  ±  179K     3.31M  … 4.52M          12 ( 2%)        💩+304268.9% ± 368.5%
  instructions       4.47M  ±  269      4.47M  … 4.47M          11 ( 2%)        💩+855765.4% ±  1.3%
  cache_references    198K  ± 3.13K      188K  …  217K          15 ( 3%)        💩+162250.2% ± 65.7%
  cache_misses       71.4K  ± 1.96K     64.3K  … 77.5K           8 ( 1%)        💩+549347.0% ± 385.1%
  branch_misses      43.0K  ±  343      41.5K  … 43.9K          13 ( 2%)        💩+388113.7% ± 79.1%
```
**I excluded java from the competition for reasons.**   
`aka I just could not figure out how to get binaries out of java code, so it was not fair to include it to the chart.`
```
Benchmark 7 (273 runs): java java/src/main/java/get_cpu_power_usage.java
  measurement          mean ± σ            min … max           outliers         delta
  wall_time           220ms ± 2.92ms     212ms …  234ms          3 ( 1%)        💩+2036.3% ±  0.7%
  peak_rss            165MB ± 2.03MB     158MB …  170MB         12 ( 4%)        💩+10417.4% ±  3.5%
  cpu_cycles         3.61G  ± 50.6M     3.41G  … 3.76G          14 ( 5%)        💩+2259340.2% ± 811.5%
  instructions       5.48G  ± 66.9M     5.24G  … 5.58G          44 (16%)        💩+4254848.4% ± 1333.3%
  cache_references    265M  ± 3.19M      253M  …  271M          20 ( 7%)        💩+2569798.3% ± 795.1%
  cache_misses       45.7M  ±  715K     43.7M  … 47.9M           6 ( 2%)        💩+1082127.9% ± 433.8%
  branch_misses      45.8M  ±  505K     44.1M  … 46.8M          19 ( 7%)        💩+1904108.0% ± 539.3%

```
