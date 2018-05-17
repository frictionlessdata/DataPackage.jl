# Needs to be installed, e.g. via:
#   julia -e 'Pkg.clone("git@github.com:loleg/TableSchema.jl.git")'
using TableSchema
import TableSchema: read, is_valid, validate

include("../src/DataPackage.jl")
using DataPackage

p = Package("data/cities/datapackage.json")

println("Loaded a Data Package, resources: ", length(p.resources))

r = DataPackage.get_resource(p, "cities")

data = DataPackage.read(r)
println( "The number of cells is ", length(data[:,1]) )
println( "Sum of column 1 is ", sum([ row for row in data[1] ]) )

table = DataPackage.get_table(r)
if validate(table); println("The table is valid according to the Schema"); end
