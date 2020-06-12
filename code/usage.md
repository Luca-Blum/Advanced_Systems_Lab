# Baum-Welch
## Code 
### Naming schema
There are different milestones of our program. The final version of that milestone is indicated with bw-$name.c. (url has no final version.)
To each milestone version is next to the implementation also a bw-$name-cg.c file, which is used to read out cachegrind.
All other files with numbers are listed in [old_versions](../old_versions) for archive reasons.

### Intel Math Kernel (BLAS)
- download mkl and icc from [here](https://dynamicinstaller.intel.com/system-studio/download)
- get mkl to path with ~~~source /opt/intel/sw_dev_tools/compilers_and_libraries_2020.1.219/linux/bin/compilervars.sh intel64~~~
- get linking part from [here](https://software.intel.com/content/www/us/en/develop/articles/intel-mkl-link-line-advisor.html)
    - add this to other files e.g. ~~~gcc -o blas bw-bla.c io.c bw-tested.c -L${MKLROOT}/lib/intel64 -Wl,--no-as-needed -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl~~~

### Comparison with [umdhmm](https://github.com/palanceli/UMDHMM)
Inside the [umdhmm](../umdhmm/) folder:
- make

Inside the [old_versions](../old_versions/) folder:
- check that the printing of the models is uncommented in bw-vec-op.c
- gcc -O2 -mfma -o run bw-vec-op.c io.c bw.tested.c tested.h
- ./run $seed $hiddenStates $differentObservables $T
- (cd ../umdhmm && ./esthmm -I model.hmm sequence.seq)

### Compile +  run C code
- version <a href="https://www.codecogs.com/eqnedit.php?latex=\in" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\in" title="\in" /></a> {stb, cop, reo, vec, bla}
- make version 
- ./version $seed $hiddenState $differentObservable $T

### Valgrind
- sudo apt-get install [valgrind](https://valgrind.org/docs/manual/manual.html), [kcachegrind](https://kcachegrind.github.io/html/Home.html)
From inside code folder:
- gcc $flags -g -o run $file io.c bw-tested.c tested.h -lm
- valgrind --log-file=../valgrind/$abbrevation-mem ./run $seed $hiddenState $differentObservable $T
    - checks for memory leaks
- vaalgrind --tool=cachegrind --cachegrind-out-file="../valgrind/$now-$file-$seed-$hiddenState-$hiddenState-$differentObservable-$T-cache" --cache-sim=yes --branch-sim=yes ./cache $seed $hiddenState $differentObservable $T
    - generate statistics
- kcachegrind ../valgrind/$now-$file-$seed-$hiddenState-$hiddenState-$differentObservable-$T-cache
    - read-out statistics for cache misses/branch predictions etc.

### Run suites
- [N.sh](./N.sh) and [N-valgrind.sh](./N-valgrind.sh) run different version and put the results into [output_measures](./output_measures/) with the name $now-time.txt for timing and $now-cache.txt for cachegrind. Check the first lines to reduce the amount of parameters.
- All suite-$variable.sh files benchmark the impact of one variable on different sized models. Their output gets stored in: [output_measures](./output_measures/) with the name $version-$variable-$now-time.txt
- Since the BLAS version needs other libraries there are other files for this version, which are marked with "bla" for BLAS.
