using Packing, GeometryTypes
using Test

# write your own tests here
include("test_rectangle.jl")
include("guillotine.jl")


scatter(rand(4))

text("henllooooooasdkjhgp;aid")
using GeometryTypes
SimpleRectangle(Rect(0, 0, 1,1))
using AbstractPlotting
atlas = AbstractPlotting.get_texture_atlas()

using ImageShow, Colors
mini, maxi = extrema(atlas.data)
rotr90(Gray.((atlas.data .- mini) ./ (10 - mini)))

atlas = AbstractPlotting.TextureAtlas();
for c in '\u0000':'\u00ff' #make sure all ascii is mapped linearly
    AbstractPlotting.insert_glyph!(atlas, c, AbstractPlotting.defaultfont())
end
AbstractPlotting.global_texture_atlas[] = atlas

text(" '*+-@[\\]`bdgijpq{|} ¡¤¦©«¬®°±»ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖ×ØÙÚÛæ")
