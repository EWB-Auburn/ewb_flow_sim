% This script defines many useful parameters which may be used anywhere in
% the program. A function or script may load these parameters by calling
% `parameters;`.

% Properties of water at 40 deg F
mu    = 32.34e-6; % viscosity, lbf*s/ft^2
rho   =  1.94   ; % density, slug/ft^3
gam   = 62.43   ; % spc. gravity, lbf/ft^3
rough = 20e-6   ; % upper bound roughness for PVC, ft
g     = 32.2    ; % acceleration of gravity, ft/s^2

pressure_update_alpha = 0.75;

leaf_limit = 5 / 448.83117; % maximum flowrate through leaves, ft^3/s

% Properties of the hose lengths
hose_rough = 0.07 / 25.4 / 12; % upper bound roughness for tubing, ft
hose_dia = 0.5 / 12; % hose diameter, ft
hose_len = 50; % hose length, ft
hose_dz = 0; % hose elevation change, ft
hose_upstream_k = 0.4; % hose upstream minor head loss coefficient