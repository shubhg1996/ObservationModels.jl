# Update entity with id 1 (SUT) in scene with GPS noise
function update_gps_noise!(scene::Scene, buildingmap::Any, satpos::Vector{Satellite})
    # Predetermined constants
    range_noise = 0.2

    ent = scene[1]
    ent_pos = posg(ent)
    ranges = measure_gps(ent_pos, randn(length(satpos))*range_noise, buildingmap, satpos)
    gps_ent_pos = GPS_fix(ranges)
    Δs = gps_ent_pos[1] - ent_pos[1]
    Δt = gps_ent_pos[2] - ent_pos[2]
    noise = Noise(pos=VecE2(Δs, Δt))
    scene[1] = Entity(BlinkerState(veh_state=ent.state.veh_state, blinker=ent.state.blinker, goals=ent.state.goals, noise=noise), ent.def, ent.id)
end