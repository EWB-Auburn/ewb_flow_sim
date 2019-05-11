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
hose_k = 1.08 * 50; % minor head loss coefficient for 50 feet of hose

% Give a function handle here that will initialize the system structure.
% This function must return both a root node and a cell array of leaves
% (`root` and `leaves` respectively).
init = @tank_2_init_lower_half; %FIXME Changed input