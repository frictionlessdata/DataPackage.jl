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

end
