# Benchmark fadj vs map
using LightGraphs
using GraphCircuits
using BenchmarkTools
gsize = 10
gb = DiGraph(gsize)

# First worst case from Johnson
for i = 1:gsize, j = 1:gsize
  i == j && continue
  add_edge!(gb,i,j)
end

# # Second worst case from Johnson
# for i = 1:gsize-1
#   add_edge!(gb,i,i+1)
# end
# add_edge!(gb,gsize,1)

bHadwick = @benchmarkable find_circuits(gb,Val{:hadwick_james})
bJohnson  = @benchmarkable find_circuits(gb,Val{:johnson})

tune!(bHadwick)
tune!(bJohnson)
tHadwick = run(bHadwick)
tJohnson = run(bJohnson)

println(tHadwick)
println(tJohnson)
println("Mean Ratio: $(ratio(mean(tJohnson),mean(tHadwick)))")
println("Median Ratio: $(ratio(median(tJohnson),median(tHadwick)))")
