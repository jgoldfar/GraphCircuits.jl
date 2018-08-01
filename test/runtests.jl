using GraphCircuits
if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end
using LightGraphs

@testset "Cycles" begin
    hadwick_james_ex1 = DiGraph(5)
    add_edge!(hadwick_james_ex1, 1, 2)
    add_edge!(hadwick_james_ex1, 2, 3)
    add_edge!(hadwick_james_ex1, 3, 4)
    add_edge!(hadwick_james_ex1, 3, 5)
    add_edge!(hadwick_james_ex1, 4, 5)
    add_edge!(hadwick_james_ex1, 5, 2)

    # johnson_circuits = find_circuits(hadwick_james_ex1, Val{:johnson})
    hadwick_circuits = find_circuits(hadwick_james_ex1, Val{:hadwick_james})

    expected_circuits = Vector{Int}[
        [2, 3, 4, 5],
        [2, 3, 5]
    ]
    @test issubset(expected_circuits, hadwick_circuits)
    @test issubset(hadwick_circuits, expected_circuits)

    add_edge!(hadwick_james_ex1, 1, 1)
    add_edge!(hadwick_james_ex1, 3, 3)

    hadwick_circuits_self = find_circuits(hadwick_james_ex1, Val{:hadwick_james})

    @test issubset(expected_circuits, hadwick_circuits_self)
    @test [1] ∈ hadwick_circuits_self && [3] ∈ hadwick_circuits_self

    ex2_size = 10
    hadwick_james_ex2 = PathDiGraph(ex2_size)
    @test isempty(find_circuits(hadwick_james_ex2, Val{:hadwick_james}))

    ex3_size = 5
    hadwick_james_ex3 = CompleteDiGraph(ex3_size)
    @test length(find_circuits(hadwick_james_ex3, Val{:hadwick_james})) == length(unique(find_circuits(hadwick_james_ex3, Val{:hadwick_james})))

    # Almost fully connected DiGraph
    ex4 = DiGraph(9)
    for (src, dest) in [(1,2),(1,5),(1,7),(1,8),(2,9),(3,4),(3,6),
                        (4,5),(4,7),(5,6),(6,7),(6,8),(7,9),(8,9)]
        add_edge!(ex4, src, dest)
        add_edge!(ex4, dest, src)
    end
    ex4_output = simplecycles_hadwick_james(ex4)
    @test [1, 2] ∈ ex4_output && [8, 9] ∈ ex4_output
end
