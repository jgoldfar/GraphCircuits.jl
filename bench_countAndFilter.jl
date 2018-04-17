function countAndFilter!(val::T, list::AbstractArray{T}) where {T <: Integer}
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
function test_countAndFilter()
    a = vcat(-1:4, 1:5, 2:10)
    countAndFilter!(1, a)
    a = vcat(-1:4, 1:5, 2:10)
    countAndFilter!(6, a)
    a
end

function countAndFilter2!(val::T, list::AbstractArray{T}) where {T <: Integer}
    n1 = count(v->v==val, list)
    filter!(v->v!=val, list)
    n1
end
function test_countAndFilter2()
    a = vcat(-1:4, 1:5, 2:10)
    countAndFilter2!(1, a)
    a = vcat(-1:4, 1:5, 2:10)
    countAndFilter2!(6, a)
    a
end

function countAndFilter3!(val::T, list::AbstractArray{T}) where {T <: Integer}
    length(list) - length(filter!(v->v != val, list))
end
function test_countAndFilter3()
    a = vcat(-1:4, 1:5, 2:10)
    countAndFilter3!(1, a)
    a = vcat(-1:4, 1:5, 2:10)
    countAndFilter3!(6, a)
    a
end
using BenchmarkTools

@show @benchmark test_countAndFilter()
@show @benchmark test_countAndFilter2()
@show @benchmark test_countAndFilter3()

t1 = test_countAndFilter()
t2 = test_countAndFilter2()
t3 = test_countAndFilter3()
@assert t1 == t2 == t3
