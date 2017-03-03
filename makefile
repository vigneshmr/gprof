.PHONY: test
test:
	# Build the target
	go build

	# Move old profiles
	-mv prof_cpu.out prof_cpu_old.out
	-mv profile_block.out profile_block_old.out
	-mv prof_mem.out prof_mem_old.out
	-mv prof_bench.out prof_bench_old.out

	# Run tests
	go test --bench=. -cpuprofile prof_cpu.out -blockprofile profile_block.out -memprofile prof_mem.out -benchtime=5s -benchmem -count=1 > prof_bench.out

	# Create profiles
	go tool pprof -pdf gprof.test prof_cpu.out > result_cpu.pdf
	go tool pprof -pdf gprof.test profile_block.out > result_block.pdf
	go tool pprof -pdf gprof.test prof_mem.out > result_mem.pdf

	# Display diffs
	benchcmp prof_bench_old.out prof_bench.out > result_diff_bench.txt
	echo 'Benchmark performance difference:'
	cat result_diff_bench.txt

	# Open profiles
	open result_cpu.pdf -a safari
	open result_block.pdf -a safari
	open result_mem.pdf -a safari

	cat result_diff_bench.txt | benchviz > result_diff_bench.svg
	open result_diff_bench.svg -a safari

	go-torch gprof.test prof_cpu.out --file=result_cpu_flames.svg
	open result_cpu_flames.svg -a safari

# 1. CRUD
# 2. Comparison
# 3. Viz
# 4. Part of process

# Benchmark comparison: benchcmp prof_bench_0.out prof_bench.out


# Setup:
# Install graphviz
# go get github.com/ajstarks/svgo/benchviz
# go get golang.org/x/tools/cmd/benchcmp
#
# go get github.com/uber/go-torch
#   $ cd $GOPATH/src/github.com/uber/go-torch
#   $ git clone https://github.com/brendangregg/FlameGraph.git -> Add to PATH pls.
#   $ glide install
