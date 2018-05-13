"""
Package generic data structure
https://github.com/frictionlessdata/datapackage-jl#package
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
                t = Resource(r, strict)
                push!(resources, t)
            end
        end
        new(d, strict, [], resources)
    end

    Package(filename::String, strict::Bool=false) =
        Package(JSON.parsefile(filename), strict)

    Package(strict::Bool=false) =
        Package(Dict(), strict=strict)
end
