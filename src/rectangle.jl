type BinaryNode{T}
    left::Nullable{T}
    right::Nullable{T}
    BinaryNode()                  = new(Nullable{T}(), Nullable{T}())
    BinaryNode(left::T, right::T) = new(Nullable{T}(a), Nullable{T}(b))
end
type RectanglePacker{T}
    children::BinaryNode{RectanglePacker{T}}
    area::SimpleRectangle{T}
end

left(a::RectanglePacker)                                = get(a.children.left)
left{T}(a::RectanglePacker{T}, r::RectanglePacker{T})   = (a.children.left = Nullable(r))
right(a::RectanglePacker)                               = get(a.children.right)
right{T}(a::RectanglePacker{T}, r::RectanglePacker{T})  = (a.children.right = Nullable(r))
RectanglePacker{T}(area::SimpleRectangle{T})            = RectanglePacker{T}(BinaryNode{RectanglePacker{T}}(), area)
isleaf(a::RectanglePacker)                              = isnull(a.children.left) && isnull(a.children.right)

# This is rather append, but it seems odd to use another function here.
# Maybe its a bad idea, to call it push regardless!?
function Base.push!{T}(node::RectanglePacker{T}, areas::Vector{SimpleRectangle{T}})
    sort!(areas)
    RectanglePacker{T}[push!(node, area) for area in areas]
end
function Base.push!{T}(node::RectanglePacker{T}, area::SimpleRectangle{T})
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

