find_circuits(g::DiGraph, ::Type{Val{:hadwick_james}}) = hadwick_james(g)

function hadwick_james(g::DiGraph)
B = Vector{Vector{Int}}()
blocked = Vector{Bool}()
lengthHisto = Vector{Culong}()
vertexPopularity = Vector{Vector{Culong}}()
cycles = Vector{Vector{Int}}()

return cycles
end

countAkArcs(g) = ne(g) # Number of edges (Arcs) in graph

function countAndFilter!{T}(val::T, list::AbstractArray{T})
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

function unblock!{T}(v::T, blocked::Vector{Bool}, B::Vector{Vector{T}})
    blocked[v] = false
    wPos = 1
    Bv = B[v]
    while wPos <= length(Bv)
        w = Bv[wPos]
        wPos += 1- countAndFilter!(w, Bv)
        if blocked(w)
            unblock!(w, blocked, B)
        end
    end
    return nothing
end
