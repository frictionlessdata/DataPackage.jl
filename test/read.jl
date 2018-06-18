@testset "Read a DataPackage from file" begin

    @testset "Basic reading" begin
        p = Package("data/cities/datapackage.json")
        # Check basic package attributes
        @test p.descriptor["name"] == "datapackage"
        @test length(p.resources) == 1
        # Check resources
        @test p.resources[1].descriptor["name"] == "cities"
        # Check the schema
        @test length(p.resources[1].schema.fields) == 2
    end

    @testset "Read data from package" begin
        p = Package("data/cities/datapackage.json")
        r = get_resource(p, "cities")
        data = read(r)
        @test data[2,1] == "London"
    end

    @testset "Read remote data package" begin
        p = Package("https://raw.githubusercontent.com/frictionlessdata/datapackage-jl/master/data/cities/datapackage.json")
        r = get_resource(p, "cities")
        r.path = "https://raw.githubusercontent.com/frictionlessdata/datapackage-jl/master/data/cities/cities.csv"
        data = read(r)
        @test data[2,1] == "London"
    end

end
