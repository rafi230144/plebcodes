* In `src/Solution.hs` is implemented a solution (`Solution.solution`) to LeetCode 1347 in Haskell.

* From `bench/Main.hs` is built an executable (`plebcodes-bench`) benchmarking the aforementioned solution as per the scheme prescribed in [`github.com/luciusmagn/leet-benchmark`](https://github.com/luciusmagn/leet-benchmark)\; on my machine it runs in about 2.5 seconds.

* In `Prof.sh` is a shell script printing `plebcodes-bench`\'s performance stats to stderr as well as dumping profiling data to `./prof`.

WARNING: In order to run `Prof.sh` you must have [eventlog2html](https://mpickering.github.io/eventlog2html/) installed; if you don't then just comment out the relevant line of the script.