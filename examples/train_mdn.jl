using ObservationModels
using AutomotiveSimulator
using AutomotiveVisualization
using AdversarialDriving
using Distributions

##############################################################################
"""
Generate Roadway and scene
"""
## Geometry parameters
roadway_length = 100.

roadway = gen_straight_roadway(3, roadway_length) # lanes and length (meters)

init_noise = Noise(pos = (0, 0), vel = 0)

scene = Scene([
	Entity(BlinkerState(VehicleState(VecSE2(10.0, 6.0, 0), roadway, 10.0), false, [], init_noise), VehicleDef(), 1),
	Entity(BlinkerState(VehicleState(VecSE2(30.0, 3.0, 0), roadway, 0.0), false, [], init_noise), VehicleDef(), 2)
]);

##############################################################################
"""
Run scene simulations
"""
scenes = [scene for i=1:100]

##############################################################################
"""
Train MDN
"""

feat, y = preprocess_data(1, scenes)

params = MDNParams(batch_size=2, lr=0.001)

net = construct_mdn(params)

train_nnet!(feat, y, net..., params)
