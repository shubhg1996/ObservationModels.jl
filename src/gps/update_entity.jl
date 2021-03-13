"""
Update an entity in scene with GPS noise
"""
function update_gps_noise!(ent::Entity, scene::Scene, buildingmap::BuildingMap{T}, satpos::Vector{Satellite{T}}) where T
    # Predetermined constants
    range_noise = 0.2

    ent_pos = posg(ent)
    ranges = measure_gps(ent_pos, randn(length(satpos))*range_noise, buildingmap, satpos)
    gps_ent_pos = GPS_fix(ranges)
    Δs = gps_ent_pos[1] - ent_pos[1]
    Δt = gps_ent_pos[2] - ent_pos[2]
    noise = Noise(pos=VecE2(Δs, Δt))

    scene[ent.id] = Entity(update_veh_noise(ent.state, noise), ent.def, ent.id)
end