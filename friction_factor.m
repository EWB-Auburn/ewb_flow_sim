% Given a pipe diameter and fluid velocity, calculate the friction factor
% for major head loss. This function uses values for roughness, fluid
% density, and viscosity defined in the file header, as these are values
% which are considered to be constant throughout the system.
% NOTE: Diameter and velocity are given in ft and ft/s, respectively
function f = friction_factor(diameter, velocity)
parameters;
re = reynolds(rho, velocity, diameter, mu);
f = haaland_friction_factor(re, rough / diameter);
end
