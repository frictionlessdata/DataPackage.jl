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

    function Resource(path::String, strict::Bool=false, name::String=nothing)
        if name == nothing
            name = path.split('/')[-1]
        end
        t = Table(path)
        tr = TableSchema.read(t, cast=false)
        s = Schema()
        TableSchema.infer(s, tr, t.headers)
        new(
            Dict(), strict, name, path, "tabular-data-resource", Dict(), s, []
        )
    end
end

get_table(r::Resource) = Table(r.path, r.schema)

function read(r::Resource)
    if r.profile == "tabular-data-resource"
        t = get_table(r)
        TableSchema.read(t)
    else
        throw(ErrorException("Not supported"))
    end
end
