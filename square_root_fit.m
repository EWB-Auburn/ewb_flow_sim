% Given a dataset (x_in, y_in), find the least squares curve fit of the form
% y = a * sqrt(x), and also return the R^2 parameter for the curve fit.
% This curve fit assumes that the coefficient `a` is strictly positive.
function [a_out, R2_out] = square_root_fit(x_in, y_in)
a_lo = 1e-4; % Initial lower bound
a_hi = 1e+3; % Initial upper bound

y  = @(a, x) a .* x.^0.5; % This equation is the form desired
y_bar = sum(y_in) / length(y_in); % Average of the input data
R2 = @(a) 1 - ... % Computes statistical R2 value for a given `a`
    sum((y_in - y(a, x_in)).^2) / ...
    sum((y(a, x_in) - y_bar).^2);
mid = @(u, v) (u + v) / 2; % midpoint

for ind = 1:100
    a_mid = mid(a_lo, a_hi);
    if R2(a_lo) > R2(a_hi)
        a_hi = a_mid;
    else
        a_lo = a_mid;
    end
end

a_val = mid(a_lo, a_hi);
R2_val = R2(a_val);

% Ensure that the values for `a` and `R2` are valid
if R2_val < 0 || R2_val > 1 || a_val < 0
    excep = MException('SprinklerSim:CurveFitError', ...
        ['An unidentified error has occured in `square_root_fit()`, ' ...
        'resulting in values for `a` or `R2` that are invalid: ' ...
        'a = %f, R2 = %f'], a_val, R2_val);
    throw(excep);
end

% Return results
a_out = a_val;
R2_out = R2_val;
end