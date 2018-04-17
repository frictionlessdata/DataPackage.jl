"""
Common exceptions
https://github.com/frictionlessdata/datapackage-jl#exceptions
"""

struct PackageError <: Exception
    message::String
end
