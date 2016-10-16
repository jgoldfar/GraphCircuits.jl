module GraphCircuits
using LightGraphs

export find_circuits

include("johnson.jl")

include("hadwick_james.jl")

"""

"""
find_circuits(g::DiGraph) = findcircuits(g, Val{:johnson})

end # module
