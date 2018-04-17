@testset "Read a DataPackage from file" begin

    @testset "Basic reading" begin
        p = Package("data/cities/datapackage.json")
        @test p.descriptor["name"] == "datapackage"
    end

end
