include("../src/DataPackage.jl")
using DataPackage
import DataPackage: Package, read

data_url = "https://datahub.io/core/pharmaceutical-drug-spending/datapackage.json"

# to load Data Package into storage
package = Package(data_url)

# to load only tabular data
resources = package.resources
for resource in resources
    if resource.profile == "tabular-data-resource"
        data = read(resource)
        println(data)
    end
end
