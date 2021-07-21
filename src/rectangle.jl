mutable struct BinaryNode{T}
    left::Union{Nothing, T}
    right::Union{Nothing, T}

    BinaryNode{T}() where {T} = new{T}(nothing, nothing)
    BinaryNode(left::T, right::T) where {T} = new{T}(nothing, nothing)
    BinaryNode{T}(left::T, right::T) where {T} = new{T}(nothing, nothing)
end

mutable struct RectanglePacker{T}
    children::BinaryNode{RectanglePacker{T}}
    area::Rect2{T}
end

left(a::RectanglePacker) = a.children.left
left(a::RectanglePacker{T}, r::RectanglePacker{T}) where {T} = (a.children.left = r)
right(a::RectanglePacker) = a.children.right
right(a::RectanglePacker{T}, r::RectanglePacker{T}) where {T} = (a.children.right = r)
RectanglePacker(area::Rect2{T}) where {T} = RectanglePacker{T}(BinaryNode{RectanglePacker{T}}(), area)
isleaf(a::RectanglePacker) = (a.children.left) == nothing && (a.children.right == nothing)
# This is rather append, but it seems odd to use another function here.
# Maybe its a bad idea, to call it push regardless!?
function Base.push!(node::RectanglePacker{T}, areas::Vector{Rect2{T}}) where T
    sort!(areas, by=GeometryBasics.norm ∘ widths)
    return RectanglePacker{T}[push!(node, area) for area in areas]
end

function Base.push!(node::RectanglePacker{T}, area::Rect2{T}) where T
    if !isleaf(node)
        l = push!(left(node), area)
        l !== nothing && return l
        # if left does not have space, try right
        return push!(right(node), area)
    end
    newarea = RectanglePacker(area).area
    if all(widths(newarea) .<= widths(node.area))
        neww, newh = widths(newarea)
        xmin, ymin = minimum(node.area)
        xmax, ymax = maximum(node.area)
        w, h = widths(node.area)
        oax,oay,oaxw,oayh = xmin + neww, ymin, xmax, ymin + newh
        nax,nay,naxw,nayh = xmin, ymin + newh, xmax, ymax
        rax,ray,raxw,rayh = xmin, ymin, xmin + neww, ymin + newh
        left(node, RectanglePacker(Rect2(oax, oay, oaxw - oax, oayh - oay)))
        right(node, RectanglePacker(Rect2(nax, nay, naxw - nax, nayh - nay)))
        return RectanglePacker(Rect2(rax, ray, raxw - rax, rayh - ray))
    end
    return nothing
end
