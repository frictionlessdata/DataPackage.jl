using TableSchema
import TableSchema: read, validate

include("../src/DataPackage.jl")
using DataPackage
import DataPackage: add_resource

# Initialise a resource from a CSV file
# Source: https://opendata.swiss/en/dataset/kennzahlen-der-schweizer-pflegeheime
res = Resource("data/health/hopitaux_ch_2016_Sample_fr.csv", strict=false, name="hopitaux")

# Add this resource to a blank data package
p = Package()
add_resource(p, res)

# Read the data from the table
data = DataPackage.read(res)
println( "The number of cells is ", length(data[:,1]) )
println( "Column 8 is called ", res.schema.fields[8].name )
println( "Sum of column 8 is ", sum([ row for row in data[:,8] ]) )

# Validate the table
table = DataPackage.get_table(res)
if validate(table); println("The table is valid according to the Schema"); end
