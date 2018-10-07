"""
Resource generic data structure
https://github.com/frictionlessdata/DataPackage.jl#resource
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

    function Resource(d::Dict ; strict::Bool=false)
        schema = haskey(d, "schema") ?
            Schema(d["schema"], strict) : Schema()
        name = haskey(d, "name") ?
            d["name"] : nothing
        path = haskey(d, "path") ?
            d["path"] : nothing
        profile = haskey(d, "profile") ?
            d["profile"] : nothing
        dialect = haskey(d, "dialect") ?
            d["dialect"] : Dict()

        new(d, strict, name, path, profile, dialect, schema, [])
    end

    function Resource(path::String ; strict::Bool=false, name::String=nothing)
        name = isempty(name) ? path.split('/')[-1] : name
        new(
            Dict(), strict, name, path, "tabular-data-resource", Dict(), Schema(), []
        )
    end
end

function fields_to_descriptor(s::Schema)
    f_dict = []
    for f in s.fields
        push!(f_dict, Dict(
            "name" => f.name,
            "type" => f.typed
        ))
    end
    Dict("fields" => f_dict)
end

function get_table(r::Resource, basepath::String="")
    if !isempty(basepath)
        r.path = joinpath(basepath, r.path)
    end
    if is_empty(r.schema)
        s = Schema()
        t = Table(r.path)
        tr = read(t, cast=false)
        infer(s, tr, t.headers)
        s.errors = []
        s.descriptor = fields_to_descriptor(s)
        validate(s, r.strict)
        r.schema = t.schema = s
        t
    else
        Table(r.path, r.schema)
    end
end

function read(r::Resource, basepath::String="")
    if r.profile == "tabular-data-resource"
        t = get_table(r, basepath)
        if typeof(t) == Table
            read(t, cast=false)
        else
            @warn t
            throw(ErrorException("Could not read tabular data"))
        end
    else
        throw(ErrorException("Not supported"))
    end
end
