"""
DataPackage module
https://github.com/frictionlessdata/datapackage-jl
"""
module DataPackage

export Package
export Resource
# export Profile

export PackageError

# using Base.Iterators: filter
# using Base.Iterators: Repeated, repeated

using JSON

using TableSchema
import TableSchema: Schema

include("exceptions.jl")
include("resource.jl")
include("package.jl")

end # module
