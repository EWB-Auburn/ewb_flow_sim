% Generate a curve fit for the sprinkler 1 data, collected Fall 2018. The
% curve fit is returned as the coefficient `a` such that 
% V_dot = a * h.^0.5.
%
% Heads and flow rates use the foot-poundforce-second system of units.
function [a, R2] = sprinkler_1_data()
% Load system parameters
parameters;

% Original data
p_orig = (5:2.5:35); % Pressure, psi
v_dot_orig = [6.83, 7.77, 8.75, 9.53, 10.30, 10.82, 11.87, 12.29, ...
    12.84, 13.18, 13.53, 14.70, 15.53]; % Volumetric flowrate, in^3/s

% Convert to more useful units
p_psf = p_orig .* 12^2; % Pressure, psf
head_ft = p_psf ./ gam; % Head, ft
v_dot_ft3s = v_dot_orig ./ 12^3; % Volumetric flowrate, ft^3/s

% Curve fit
[a, R2] = square_root_fit(head_ft, v_dot_ft3s);
end