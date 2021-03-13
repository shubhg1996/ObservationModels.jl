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

    d = BuildingMap()
    @test length(d.buildings) == 0
end

@testset "sensors" begin
    roadway = gen_straight_roadway(1, 100.)

    init_noise = Noise(pos = (0, 0), vel = 0)

    scene = Scene([
        Entity(BlinkerState(VehicleState(VecSE2(0.0, 1.0, 0), roadway, 0.0), false, [], init_noise), VehicleDef(), 1),
        Entity(BlinkerState(VehicleState(VecSE2(10.0, 1.0, 0), roadway, 0.0), false, [], init_noise), VehicleDef(), 2)
    ])

    old_state = scene[1].state.veh_state
    update_noiseless!(scene[1], scene)
    @test scene[1].state.veh_state == old_state

    update_gaussian_noise!(scene[1], scene)
    @test scene[1].state.veh_state == old_state

    bmap = BuildingMap()
    fixed_sats = [
    ObservationModels.Satellite(pos=VecE3(-1e7, 1e7, 1e7), clk_bias=0.0),
    ObservationModels.Satellite(pos=VecE3(1e7, 1e7, 1e7), clk_bias=0.0),
    ObservationModels.Satellite(pos=VecE3(-1e7, 0.0, 1e7), clk_bias=0.0),
    ObservationModels.Satellite(pos=VecE3(100.0, 0.0, 1e7), clk_bias=0.0),
    ObservationModels.Satellite(pos=VecE3(1e7, 0.0, 1e7), clk_bias=0.0)
        ]

    update_gps_noise!(scene[1], scene, bmap, fixed_sats)
    @test scene[1].state.veh_state == old_state
end
