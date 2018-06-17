using TableSchema
import TableSchema: read, validate

include("../src/DataPackage.jl")
using DataPackage
import DataPackage: add_resource

p = Package()
res = Resource("data/health/hopitaux_ch_2016_Sample_fr.csv", false, "hopitaux")

add_resource(p, res)

data = DataPackage.read(res)
println( "The number of cells is ", length(data[:,1]) )
println( "Column 8 is called ", res.schema.fields[8].name )
println( "Sum of column 8 is ", sum([ row for row in data[:,8] ]) )

table = DataPackage.get_table(res)
if validate(table); println("The table is valid according to the Schema"); end
