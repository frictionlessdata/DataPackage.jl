using TableSchema
import TableSchema: read, is_valid, validate

include("../src/DataPackage.jl")
using DataPackage
import DataPackage: add_resource

p = Package()
res = Resource("data/health/hopitaux_ch_2016_Sample_fr.csv", false, "hopitaux")

add_resource(p, res)

data = DataPackage.read(res)
println( "The number of cells is ", length(data[:,1]) )
println( "Sum of column 1 is ", sum([ row for row in data[1] ]) )

table = DataPackage.get_table(res)
if validate(table); println("The table is valid according to the Schema"); end
