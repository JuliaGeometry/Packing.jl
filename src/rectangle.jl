mutable struct BinaryNode{T}
    left::Union{Nothing, T}
    right::Union{Nothing, T}

    BinaryNode{T}() where {T} = new{T}(nothing, nothing)
    BinaryNode(left::T, right::T) where {T} = new{T}(nothing, nothing)
    BinaryNode{T}(left::T, right::T) where {T} = new{T}(nothing, nothing)
end
mutable struct RectanglePacker{T}
    children::BinaryNode{RectanglePacker{T}}
    area::SimpleRectangle{T}
end

left(a::RectanglePacker)                                = a.children.left
left(a::RectanglePacker{T}, r::RectanglePacker{T}) where {T}   = (a.children.left = r)
right(a::RectanglePacker)                               = a.children.right
right(a::RectanglePacker{T}, r::RectanglePacker{T}) where {T}  = (a.children.right = r)
RectanglePacker(area::SimpleRectangle{T}) where {T}            = RectanglePacker{T}(BinaryNode{RectanglePacker{T}}(), area)
isleaf(a::RectanglePacker)                              = (a.children.left) == nothing && (a.children.right == nothing)

# This is rather append, but it seems odd to use another function here.
# Maybe its a bad idea, to call it push regardless!?
function Base.push!(node::RectanglePacker{T}, areas::Vector{SimpleRectangle{T}}) where T
    sort!(areas)
    RectanglePacker{T}[push!(node, area) for area in areas]
end
function Base.push!(node::RectanglePacker{T}, area::SimpleRectangle{T}) where T
    if !isleaf(node)
        l = push!(left(node), area)
        l == nothing && return push!(right(node), area) # if left does not have space, try right
        return l
    end
    newarea = RectanglePacker(area).area
    if newarea.w <= node.area.w && newarea.h <= node.area.h
        oax,oay,oaxw,oayh   = node.area.x+newarea.w, node.area.y, xwidth(node.area), node.area.y + newarea.h
        nax,nay,naxw,nayh   = node.area.x, node.area.y+newarea.h, xwidth(node.area), yheight(node.area)
        rax,ray,raxw,rayh   = node.area.x, node.area.y, node.area.x+newarea.w, node.area.y+newarea.h
        left(node,  RectanglePacker(SimpleRectangle(oax, oay, oaxw-oax, oayh-oay)))
        right(node, RectanglePacker(SimpleRectangle(nax, nay, naxw-nax, nayh-nay)))
        return RectanglePacker(SimpleRectangle(rax,ray,raxw-rax,rayh-ray))
    end
end
