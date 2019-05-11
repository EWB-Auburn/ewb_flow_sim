% Calculate the Reynolds number
function re = reynolds(density, velocity, diameter, viscosity)
re = density .* velocity .* diameter ./ viscosity;
end