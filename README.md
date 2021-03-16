# Observation Models

A Julia package containing sensor observation models and state estimation tools. Currently supports [AdversarialDriving](https://github.com/sisl/AdversarialDriving.jl) and [AutomotiveSimulator](https://github.com/sisl/AutomotiveSimulator.jl)

For visualization code please see [AutomotiveVisualization](https://github.com/sisl/AutomotiveVisualization.jl).

# Example

An example implementation of the building model is provided for a simple case:
* **Julia source**: [`examples\generate_buildings.jl`](https://github.com/shubhg1996/ObservationModels.jl/blob/master/examples\generate_buildings.jl)

An example implementation of the MDN training on simulated scenes is provided for a simple case:
* **Julia source**: [`examples\train_mdn.jl`](https://github.com/shubhg1996/ObservationModels.jl/blob/master/examples\train_mdn.jl)

# Installation 

Install `AdversarialDriving.jl`, `Vec.jl` and then the `ObservationModels.jl` package via:
```julia 
using Pkg
pkg"add https://github.com/sisl/AdversarialDriving.jl"
pkg"add https://github.com/sisl/Vec.jl.git"
pkg"add https://github.com/shubhg1996/ObservationModels.jl"
```

### Testing
To run the test suite, you can use the Julia package manager.
```julia
] test ObservationModels
```

---
Package maintained by Shubh Gupta: shubhg1996@stanford.edu
