module ObservationModels
    using Distributions
    using Parameters
    using Random
    using LinearAlgebra
    using Statistics
    using AdversarialDriving
    using Distributed
    using AutomotiveSimulator
    using Flux
    using Zygote
    using CUDA
    using Printf

    export Landmark, SensorObservation, Building, position, noise
    include("structs.jl")

    include("utils.jl")

    export Satellite, GPSRangeMeasurement, measure_gps, GPS_fix, update_gps_noise!
    include(joinpath("gps", "structs.jl"))
    include(joinpath("gps", "measure_gps.jl"))
    include(joinpath("gps", "gps_positioning.jl"))
    include(joinpath("gps", "update_entity.jl"))

    export RangeAndBearingMeasurement, update_rb_noise!
    include(joinpath("range_bearing", "range_bearing.jl"))
    
    export INormal_Uniform, INormal_GMM, Fsig_Normal

    include(joinpath("distributions", "inormal_uniform.jl"))
    include(joinpath("distributions", "inormal_gmm.jl"))
    include(joinpath("distributions", "fixedsig_normal.jl"))

    export DistParams, gps_distribution_estimate, traj_logprob, simple_distribution_fit, calc_logprobs
    include(joinpath("learned_prob", "estimate.jl"))
end