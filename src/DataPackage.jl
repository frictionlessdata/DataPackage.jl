"""
DataPackage module
https://github.com/frictionlessdata/DataPackage.jl
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
import TableSchema: read, infer, validate, is_empty

import HTTP: request

include("exceptions.jl")
include("resource.jl")
include("package.jl")

export import_table

end # module
