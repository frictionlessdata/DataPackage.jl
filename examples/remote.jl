using TableSchema
import TableSchema: read, validate

include("../src/DataPackage.jl")
using DataPackage
import DataPackage: Resource, add_resource, get_table, read

# Initialise a resource from a remote file
REMOTE_URL = "https://raw.githubusercontent.com/frictionlessdata/TableSchema.jl/master/data/data_simple.csv"
res = Resource(REMOTE_URL, strict=false, name="sample")

# Add this resource to a blank data package
p = Package()
add_resource(p, res)

# Read the data from the table
data = read(res)
println( "The number of cells is ", length(data[:,1]) )
println( "Column 1 is called ", res.schema.fields[1].name )
println( join([ row for row in data[:,1] ], ", ", " and ") )

# Validate the table
table = get_table(res)
if validate(table); println("The table is valid according to the Schema"); end
