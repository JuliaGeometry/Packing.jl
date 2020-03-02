module Packing
using GeometryTypes

include("rectangle.jl")
include("guillotine.jl")

export RectanglePacker, GuillotinePacker

end # module
