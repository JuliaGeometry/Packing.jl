root = RectanglePacker(Rect2D(0,0,1024,1024))
push!(root, Rect2D(0,0,20,20))
push!(root, Rect2D(0,0,20,20))
push!(root, [Rect2D(0,0, rand(5:50), rand(5:50)) for i=1:20])


# function get_rectangles(packer::Nothing, rectangles=IRect2D[])
#     return rectangles
# end
#
# function get_rectangles(packer, rectangles)
#     push!(rectangles, packer.area)
#     get_rectangles(packer.children.left, rectangles)
#     get_rectangles(packer.children.right, rectangles)
#     return rectangles
# end
# function get_rectangles(packer)
#     rectangles = IRect2D[]
#     get_rectangles(packer.children.left, rectangles)
#     get_rectangles(packer.children.right, rectangles)
#     return rectangles
# end
#
# rectangles = get_rectangles(root)
# using Makie
# linesegments(FRect(0, 0, 1024, 1024))
# poly!(rectangles, color = (:red, 0.1), strokewidth=1, strokecolor=:black)
#
scatter(1:4)
