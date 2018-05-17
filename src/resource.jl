"""
Resource generic data structure
https://github.com/frictionlessdata/datapackage-jl#resource
"""

mutable struct Resource
    descriptor::Dict
    strict::Bool
    name::String
    path::String
    profile::String
    dialect::Dict
    schema::Schema
    errors::Array{PackageError}

    function Resource(d::Dict, strict::Bool=false)
        schema = haskey(d, "schema") ?
            Schema(d["schema"], strict) : nothing
        name = haskey(d, "name") ?
            d["name"] : nothing
        path = haskey(d, "path") ?
            d["path"] : nothing
        profile = haskey(d, "profile") ?
            d["profile"] : nothing
        dialect = haskey(d, "dialect") ?
            d["dialect"] : nothing

        new(d, strict, name, path, profile, dialect, schema, [])
    end
end

function read(r::Resource)
    if r.profile == "tabular-data-resource"
        t = Table(r.path, r.schema)
        TableSchema.read(t)
    else
        throw(ErrorException("Not supported"))
    end
end
