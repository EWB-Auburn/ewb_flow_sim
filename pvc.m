% Given a nominal pipe size, return the inner diameter of the corresponding
% Schedule 40 PVC pipe. Returned diameter is given in *feet*
function d_inner = pvc(d_nominal)
d = 0;
switch d_nominal
    case '1/2'
        d = 0.622;
    case '3/4'
        d = 0.824;
    case '1'
        d = 1.049;
    case '1 1/4'
        d = 1.380;
    case '1 1/2'
        d = 1.610;
    case '2'
        d = 2.067;
    case '2 1/2'
        d = 2.469;
    case '3'
        d = 3.068;
    case '4'
        d = 4.026;
end
if d == 0
    excep = MException('SprinklerSim:PVCLookupError', ...
        ['An error occured looking up the inner diameter for the ' ...
        'specified pipe size `%s`.'], d_nominal);
    throw(excep);
end
d_inner = d / 12; % Convert from inches to feet
end
