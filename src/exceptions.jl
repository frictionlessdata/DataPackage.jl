"""
Common exceptions
https://github.com/frictionlessdata/DataPackage.jl#exceptions
"""

struct PackageError <: Exception
    message::String
end
