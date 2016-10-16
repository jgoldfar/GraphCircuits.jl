findcircuits(g::DiGraph, ::Type{Val{:johnson}}) = johnson(g)

"""

"""
function johnson(g::DiGraph) end

"""

"""
function findcycles(g::DiGraph, v, s, blocked, stack, B, cycles) end

"""

"""
function unblock!(v, blocked, B)
    blocked[v] = false
    nv = length(blocked)
    if isassigned(B, v)
        setdiff!(B[v], [new])
    end
    if blocked[new]
        unblock!(new, blocked, B)
    end
end
