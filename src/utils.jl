"""
Creates a copy of the vehicle state with the new specified noise
"""
update_veh_noise(s::NoisyPedState, noise::Noise) = NoisyPedState(s.veh_state, noise)
update_veh_noise(s::BlinkerState, noise::Noise) = BlinkerState(s.veh_state, s.blinker, s.goals, noise)