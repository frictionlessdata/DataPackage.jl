"""
Package generic data structure
https://github.com/frictionlessdata/datapackage-jl#package
"""

mutable struct Package
    descriptor::Dict
    strict::Bool
    errors::Array{PackageError}

    function Package(d::Dict, strict::Bool=false)
        new(d, strict, [])
    end

    Package(filename::String, strict::Bool=false) =
        Package(JSON.parsefile(filename), strict)

    Package(strict::Bool=false) =
        Package(Dict(), strict=strict)
end
