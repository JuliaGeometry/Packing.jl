
const root = RectanglePacker(SimpleRectangle(0,0,1024,1024))
push!(root, SimpleRectangle(0,0,20,20))
push!(root, SimpleRectangle(0,0,20,20))
push!(root, [SimpleRectangle(0,0,rand(5:50), rand(5:50)) for i=1:20])

