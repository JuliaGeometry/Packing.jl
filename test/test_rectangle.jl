
const root = RectanglePacker(Rectangle(0,0,1024,1024))
push!(root, Rectangle(0,0,20,20))
push!(root, Rectangle(0,0,20,20))
push!(root, [Rectangle(0,0,rand(5:50), rand(5:50)) for i=1:20])

