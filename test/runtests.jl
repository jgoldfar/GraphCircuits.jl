using GraphCircuits
using Base.Test
using LightGraphs
# write your own tests here
@testset begin
    k = 10
    tarjan_worst_case = DiGraph(k)
    for i in 1:(k-1)
        add_edge!(tarjan_worst_case, i, i + 1)
    end
    add_edge!(tarjan_worst_case, k, 1)
    find_circuits(tarjan_worst_case)
end
