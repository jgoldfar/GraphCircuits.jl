module GraphCircuits
using LightGraphs

include("johnson.jl")

include("hadwick_james.jl")

findcircuits(g::DiGraph) = findcircuits(g, Val{:johnson})

end # module
