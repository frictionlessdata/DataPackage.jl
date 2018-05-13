"""
Resource generic data structure
https://github.com/frictionlessdata/datapackage-jl#resource
"""

mutable struct Resource
    descriptor::Dict
    strict::Bool
    schema::Schema
    errors::Array{PackageError}

    function Resource(d::Dict, strict::Bool=false)
        s = nothing
        if haskey(d, "schema")
            s = Schema(d["schema"], strict)
        end
        new(d, strict, s, [])
    end
end
