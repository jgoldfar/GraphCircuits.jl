findcycles(g::DiGraph, ::Type{Val{:johnson}}) = johnson(g)

"""

"""
function johnson(g::DiGraph)
    blocked = Dict(v => true for v in vertices(g))
    cycles = Vector{Vector{Int}}()
    B = Vector{IntSet}(nv(g))
    stack = Vector{Int}()

    for v in vertices(g)
        findcycles(g, v, v, blocked, stack, B, cycles)
        _reinit_B(B)
        _reinit_blocked!(blocked)
    end
    return cycles
end
function _reinit_blocked!(b)
    for k in eachindex(b)
        b[k] = false
    end
end
_reinit_B(B) = map!(t -> IntSet(), B)

"""

"""
function findcycles(g::DiGraph, v, s, blocked, stack, B, cycles)
    push!(stack, v)
    blocked[v] = true
    f = false
    for vert in map(src, in_edges(g, v))
        if vert == s
            push!(cycles, copy(stack))
            f = true
        elseif !blocked[vert]
            findcycles(g, vert, s, blocked, stack, B, cycles)
            f = true
        end
    end
    if f
        unblock!(v, blocked, B)
    else
        for w in map(src, in_edges(g, v))
            if !isassigned(B, w)
                B[w] = IntSet([v])
            else
                push!(B[w], v)
            end
        end
        filter!(t -> t == v, stack)
    end
    return f
end

"""

"""
function unblock!(v, blocked, B)
    blocked[v] = false
    nv = length(blocked)
    if isassigned(B, v)
        setdiff!(B[v], [w])
    end
    if blocked[w]
        unblock!(w, blocked, B)
    end
end
