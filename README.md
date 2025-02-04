# get_cpu_power_usage

```code
/mnt/Hm3/Projects/get_cpu_power_usage main > poop -d 60000 ./get_cpu_power_usageC ./get_cpu_power_usageCPP ./get_cpu_power_usage_safe_CPP ./get_cpu_power_usageGO ./get_cpu_power_usageRS ./get_cpu_power_usageZIG "java java/src/main/java/get_cpu_power_usage.java" ./get_cpu_power_usage.py ./get_cpu_power_usage.sh 
Benchmark 1 (5815 runs): ./get_cpu_power_usageC
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.3ms ± 57.2us    10.2ms … 11.1ms         23 ( 0%)        0%
  peak_rss           1.57MB ±  122KB    1.09MB … 1.87MB          6 ( 0%)        0%
  cpu_cycles          160K  ± 13.8K      142K  …  335K         595 (10%)        0%
  instructions        129K  ± 21.3       129K  …  129K           1 ( 0%)        0%
  cache_references   10.3K  ±  342      9.64K  … 14.5K         405 ( 7%)        0%
  cache_misses       4.23K  ±  250      3.15K  … 6.08K         564 (10%)        0%
  branch_misses      2.40K  ± 43.5      1.86K  … 2.58K         311 ( 5%)        0%
Benchmark 2 (5634 runs): ./get_cpu_power_usageCPP
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.6ms ±  137us    10.5ms … 12.1ms         14 ( 0%)        💩+  3.2% ±  0.0%
  peak_rss           3.63MB ± 77.6KB    3.04MB … 3.99MB        499 ( 9%)        💩+131.1% ±  0.2%
  cpu_cycles         1.21M  ± 94.5K     1.13M  … 2.38M        1462 (26%)        💩+659.2% ±  1.5%
  instructions       2.52M  ± 23.0      2.52M  … 2.52M          10 ( 0%)        💩+1856.1% ±  0.0%
  cache_references   53.0K  ± 2.49K     50.6K  …  115K         678 (12%)        💩+414.2% ±  0.6%
  cache_misses       12.6K  ± 1.12K     10.6K  … 20.8K         637 (11%)        💩+198.2% ±  0.7%
  branch_misses      13.7K  ±  121      12.2K  … 14.5K         266 ( 5%)        💩+470.0% ±  0.1%
Benchmark 3 (5632 runs): ./get_cpu_power_usage_safe_CPP
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.6ms ±  135us    10.5ms … 11.7ms         17 ( 0%)        💩+  3.3% ±  0.0%
  peak_rss           3.64MB ± 79.1KB    3.09MB … 3.96MB        435 ( 8%)        💩+132.2% ±  0.2%
  cpu_cycles         1.26M  ± 92.9K     1.19M  … 2.50M        1328 (24%)        💩+686.3% ±  1.5%
  instructions       2.56M  ± 21.3      2.56M  … 2.56M           1 ( 0%)        💩+1885.2% ±  0.0%
  cache_references   56.5K  ± 2.46K     54.2K  …  123K         517 ( 9%)        💩+448.5% ±  0.6%
  cache_misses       13.2K  ± 1.18K     11.4K  … 21.9K         501 ( 9%)        💩+211.7% ±  0.7%
  branch_misses      14.6K  ±  130      13.4K  … 15.5K         307 ( 5%)        💩+505.5% ±  0.1%
Benchmark 4 (5598 runs): ./get_cpu_power_usageGO
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.7ms ± 89.3us    10.5ms … 11.9ms         97 ( 2%)        💩+  3.9% ±  0.0%
  peak_rss           3.66MB ±  184KB    2.98MB … 5.91MB       2370 (42%)        💩+133.4% ±  0.4%
  cpu_cycles          447K  ± 40.4K      351K  …  687K         388 ( 7%)        💩+179.8% ±  0.7%
  instructions        541K  ± 11.5K      488K  …  623K          71 ( 1%)        💩+319.6% ±  0.2%
  cache_references   41.6K  ± 2.24K     35.2K  … 53.9K         225 ( 4%)        💩+303.6% ±  0.6%
  cache_misses       12.8K  ± 1.36K     10.1K  … 21.8K         387 ( 7%)        💩+203.8% ±  0.8%
  branch_misses      3.53K  ±  379      2.69K  … 5.58K         415 ( 7%)        💩+ 46.9% ±  0.4%
Benchmark 5 (5772 runs): ./get_cpu_power_usageRS
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.4ms ± 77.2us    10.3ms … 11.3ms         15 ( 0%)          +  0.8% ±  0.0%
  peak_rss           2.04MB ± 83.5KB    1.55MB … 2.30MB        601 (10%)        💩+ 29.9% ±  0.2%
  cpu_cycles          267K  ± 21.5K      243K  …  501K         731 (13%)        💩+ 67.0% ±  0.4%
  instructions        302K  ±  325       301K  …  304K          39 ( 1%)        💩+134.4% ±  0.0%
  cache_references   17.8K  ±  526      16.9K  … 21.4K         466 ( 8%)        💩+ 73.1% ±  0.2%
  cache_misses       6.50K  ±  441      5.35K  … 9.32K         833 (14%)        💩+ 53.7% ±  0.3%
  branch_misses      3.79K  ± 58.8      3.09K  … 4.06K         273 ( 5%)        💩+ 57.8% ±  0.1%
Benchmark 6 (5830 runs): ./get_cpu_power_usageZIG
  measurement          mean ± σ            min … max           outliers         delta
  wall_time          10.3ms ± 37.9us    10.2ms … 11.1ms         42 ( 1%)          -  0.3% ±  0.0%
  peak_rss            974KB ± 36.2KB     647KB …  979KB        112 ( 2%)        ⚡- 37.9% ±  0.2%
  cpu_cycles         45.7K  ± 5.75K     33.0K  … 87.0K          83 ( 1%)        ⚡- 71.5% ±  0.2%
  instructions       25.6K  ±  170      25.3K  … 25.8K        1936 (33%)        ⚡- 80.1% ±  0.0%
  cache_references   3.70K  ±  447      2.74K  … 5.63K          13 ( 0%)        ⚡- 64.1% ±  0.1%
  cache_misses       1.31K  ±  323       360   … 2.93K          34 ( 1%)        ⚡- 69.1% ±  0.2%
  branch_misses       322   ± 86.0       126   …  523            0 ( 0%)        ⚡- 86.6% ±  0.1%
Benchmark 7 (273 runs): java java/src/main/java/get_cpu_power_usage.java
  measurement          mean ± σ            min … max           outliers         delta
  wall_time           220ms ± 2.92ms     212ms …  234ms          3 ( 1%)        💩+2036.3% ±  0.7%
  peak_rss            165MB ± 2.03MB     158MB …  170MB         12 ( 4%)        💩+10417.4% ±  3.5%
  cpu_cycles         3.61G  ± 50.6M     3.41G  … 3.76G          14 ( 5%)        💩+2259340.2% ± 811.5%
  instructions       5.48G  ± 66.9M     5.24G  … 5.58G          44 (16%)        💩+4254848.4% ± 1333.3%
  cache_references    265M  ± 3.19M      253M  …  271M          20 ( 7%)        💩+2569798.3% ± 795.1%
  cache_misses       45.7M  ±  715K     43.7M  … 47.9M           6 ( 2%)        💩+1082127.9% ± 433.8%
  branch_misses      45.8M  ±  505K     44.1M  … 46.8M          19 ( 7%)        💩+1904108.0% ± 539.3%
Benchmark 8 (567 runs): ./get_cpu_power_usage.py
  measurement          mean ± σ            min … max           outliers         delta
  wall_time           106ms ±  481us     105ms …  108ms          3 ( 1%)        💩+928.4% ±  0.1%
  peak_rss           11.1MB ±  203KB    10.1MB … 11.4MB         13 ( 2%)        💩+604.3% ±  0.7%
  cpu_cycles         23.5M  ± 1.09M     22.0M  … 27.8M           2 ( 0%)        💩+14603.2% ± 17.5%
  instructions       39.2M  ± 39.8K     39.1M  … 39.4M          10 ( 2%)        💩+30346.9% ±  0.8%
  cache_references   1.97M  ± 24.1K     1.92M  … 2.09M          13 ( 2%)        💩+19047.2% ±  6.0%
  cache_misses        251K  ± 13.1K      228K  …  293K           0 ( 0%)        💩+5835.2% ±  8.0%
  branch_misses       349K  ± 3.47K      342K  …  364K          15 ( 3%)        💩+14405.2% ±  3.7%
Benchmark 9 (583 runs): ./get_cpu_power_usage.sh
  measurement          mean ± σ            min … max           outliers         delta
  wall_time           103ms ±  207us     103ms …  105ms          4 ( 1%)        💩+900.0% ±  0.1%
  peak_rss           5.03MB ±  123KB    4.41MB … 5.37MB         51 ( 9%)        💩+220.7% ±  0.7%
  cpu_cycles         3.52M  ±  130K     3.28M  … 4.16M          33 ( 6%)        💩+2103.8% ±  2.2%
  instructions       4.49M  ±  269      4.49M  … 4.49M          39 ( 7%)        💩+3386.9% ±  0.0%
  cache_references    195K  ± 2.94K      186K  …  211K          17 ( 3%)        💩+1795.2% ±  0.8%
  cache_misses       69.4K  ± 1.87K     62.5K  … 76.0K          11 ( 2%)        💩+1541.7% ±  1.2%
  branch_misses      42.9K  ±  322      41.5K  … 44.0K           8 ( 1%)        💩+1686.0% ±  0.4%
```
