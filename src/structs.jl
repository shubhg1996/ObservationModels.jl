abstract type Landmark end

position(def::Landmark) = error("position not implemented for landmark of type $(typeof(def))")

abstract type SensorObservation end

noise(def::SensorObservation) = error("noise not implemented for sensor observation of type $(typeof(def))")

"""
Struct for a building as a Landmark in an environment
"""
mutable struct Building{T<:Real} <: Landmark
    id::Int64
    width1::T # [m]
    width2::T # [m]
    pos::VecSE2{T}
end

Base.show(io::IO, b::Building) = @printf(io, "Building({%.3f, %.3f, %.3f}, %.3f, %.3f)", b.pos.x, b.pos.y, b.pos.θ, b.width1, b.width2)

position(b::Building) = VecE3(b.pos.x, b.pos.y, 0.0)