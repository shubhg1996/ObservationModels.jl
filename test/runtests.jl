using Test
using ObservationModels
using AutomotiveSimulator

struct DummyLandmark <: Landmark end
struct DummySensorObservation <: SensorObservation end

@testset "structs" begin
    d = DummyLandmark()
    @test_throws ErrorException ObservationModels.position(d)

    d = DummySensorObservation()
    @test_throws ErrorException ObservationModels.noise(d)

    d = Building(1, 1., 1., VecSE2(0., 0., 0.))
    @test ObservationModels.position(d) == VecE3(0., 0., 0.)

    d = Satellite()
    @test ObservationModels.position(d) == VecE3(0., 0., 0.)

    d = GPSRangeMeasurement()
    @test ObservationModels.noise(d)[1] == 0.0
end