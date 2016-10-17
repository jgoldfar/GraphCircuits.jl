using GraphCircuits
using Base.Test
using LightGraphs

@testset begin
    # k = 10
    # tarjan_worst_case = DiGraph(k)
    # Note: This is a CycleDiGraph(k)
    # for i in 1:(k-1)
    #     add_edge!(tarjan_worst_case, i, i + 1)
    # end
    # add_edge!(tarjan_worst_case, k, 1)
    # johnson_circuits = find_circuits(tarjan_worst_case, Val{:johnson})
    #
    # hadwick_circuits = find_circuits(tarjan_worst_case, Val{:hadwick_james})
    #
    # @test johnson_circuits == hadwick_circuits

    hadwick_james_ex1 = DiGraph(5)
    add_edge!(hadwick_james_ex1, 1, 2)
    add_edge!(hadwick_james_ex1, 2, 3)
    add_edge!(hadwick_james_ex1, 3, 4)
    add_edge!(hadwick_james_ex1, 3, 5)
    add_edge!(hadwick_james_ex1, 4, 5)
    add_edge!(hadwick_james_ex1, 5, 2)

    johnson_circuits = find_circuits(hadwick_james_ex1, Val{:johnson})
    hadwick_circuits = find_circuits(hadwick_james_ex1, Val{:hadwick_james})

    expected_circuits = Vector{Int}[
        [2, 3, 4, 5],
        [2, 3, 5]
    ]
    @test issubset(expected_circuits, hadwick_circuits)
    @test issubset(hadwick_circuits, expected_circuits)
end
