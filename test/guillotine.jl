
packer = GuillotinePacker(1024, 1024)
rects = [Rect(0, 0, rand(10:100), rand(10:100)) for i in 1:300]
push!(packer, rects)
