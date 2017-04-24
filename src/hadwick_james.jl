"""
Define the `hadwick_james` find_circuits algorithm.
"""
find_circuits(g::DiGraph, ::Type{Val{:hadwick_james}}) = hadwick_james(g)

"""
Find circuits using circuit! for each vertex in the graph `g`.
"""
function hadwick_james(g::DiGraph)
    nvg = nv(g)
    T = eltype(g)
    B = [T[] for i in 1:nvg]
    blocked = [false for i in 1:nvg]
    stack = T[]
    cycles = Vector{Vector{T}}()
    for v in vertices(g)
        circuit!(g, v, v, blocked, B, stack, cycles)
        resetblocked!(blocked)
        resetB!(B)
    end
    return cycles
end

"""
Reset B work structure.
"""
resetB!(B) = map!(empty!, B, B)

"""
Reset vector of "blocked" vertices.
"""
resetblocked!(blocked) = fill!(blocked, false)

"""
Find circuits starting from v1 recursively.
"""
function circuit!(g::DiGraph, v1::T, v2::T, blocked::Vector{Bool}, B::Vector{Vector{T}}, stack::Vector{T}, cycles::Vector{Vector{T}}) where T
    f = false
    push!(stack, v2)
    blocked[v2] = true

    Av = out_neighbors(g, v2)
    for w in Av
        (w < v1) && continue
        if w == v1 # Found a circuit
            push!(cycles, copy(stack))
            f = true
        elseif !blocked[w]
            f = circuit!(g, v1, w, blocked, B, stack, cycles)
        end
    end
    if f
        unblock!(v2, blocked, B)
    else
        for w in Av
            (w < v1) && continue
            if !(v2 in B[w])
                push!(B[w], v2)
            end
        end
    end
    pop!(stack)
    return f
end

"""
Simultaneously count and remove occurences of a value `val` in the array `list`.
"""
function countAndFilter!(val::T, list::AbstractArray{T}) where T
    nocc = 0
    function doFilter(v)
        if v == val
            nocc += 1
            false
        else
            true
        end
    end
    filter!(doFilter, list)
    return nocc
end

"""
Unblock the value `v` from the blocked list and remove from `B`.
"""
function unblock!(v::T, blocked::Vector{Bool}, B::Vector{Vector{T}}) where T
    blocked[v] = false
    wPos = 1
    Bv = B[v]
    while wPos <= length(Bv)
        w = Bv[wPos]
        wPos += 1 - countAndFilter!(w, Bv)
        blocked[w] && unblock!(w, blocked, B)
    end
    return nothing
end
