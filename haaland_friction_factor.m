% Calculate the friction factor using the Haaland approximation for a given
% Reynolds number and relative roughness
function f = haaland_friction_factor(reynolds_number, relative_roughness)
f = (-1.8 .* log10( ...
    (relative_roughness ./ 3.7).^1.11 + (6.9 ./ reynolds_number))).^-2;
end