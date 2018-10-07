"""
Package generic data structure
https://github.com/frictionlessdata/DataPackage.jl#package
"""

mutable struct Package
    descriptor::Dict
    strict::Bool
    errors::Array{PackageError}
    resources::Array{Resource}

    function Package(d::Dict, strict::Bool=false)
        resources = []
        if haskey(d, "resources")
            for r in d["resources"]
                if !isempty(r)
                    t = Resource(r, strict=strict)
                    push!(resources, t)
                end
            end
        end
        new(d, strict, [], resources)
    end

    Package(filename::String, strict::Bool=false) =
        Package(fetch_json(filename), strict)

    Package(strict::Bool=false) =
        Package(Dict(), strict)
end

function fetch_json(filename::String)
    if match(r"^https?://", filename) !== nothing
        req = request("GET", filename)
        j = JSON.parse(String(req.body))
    else
        j = JSON.parsefile(filename)
    end
    isempty(j) && @warn "JSON could not be loaded"
    j
end

add_resource(p::Package, r::Resource) =
    push!(p.resources, r)

get_resource(p::Package, name::String) =
    [ r for r in p.resources if r.name == name ][1]
