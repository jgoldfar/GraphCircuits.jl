module GraphCircuits
using LightGraphs

include("johnson.jl")

include("hadwick_james.jl")

findcycles(g::DiGraph) = findcycles(g, Val{:johnson})

end # module
