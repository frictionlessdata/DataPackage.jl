@testset "Read a DataPackage from file" begin

    @testset "Basic reading" begin
        p = Package("data/cities/datapackage.json")
        # Check basic package attributes
        @test p.descriptor["name"] == "datapackage"
        @test length(p.resources) == 1
        @test p.resources[1]["name"] == "cities"
    end

end
