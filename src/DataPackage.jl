"""
DataPackage module
https://github.com/frictionlessdata/datapackage-jl
"""
module DataPackage

export Package
# export Resource
# export Profile

export PackageError

# using Base.Iterators: filter
# using Base.Iterators: Repeated, repeated

using JSON

include("exceptions.jl")
include("package.jl")

end # module
