% Seperate from the main functionality of the program, this script
% generates a chart for the flow characterization of the test sprinkler

clear;
[a, r2] = sprinkler_1_data();
flow_func = @(h) a * h.^0.5;
parameters;

p_orig = (5:2.5:35); % Pressure, psi
v_dot_orig = [6.83, 7.77, 8.75, 9.53, 10.30, 10.82, 11.87, 12.29, ...
    12.84, 13.18, 13.53, 14.70, 15.53]; % Volumetric flowrate, in^3/s


figure(1);
clf;
hold on;

plot((p_orig .* 12^2), (v_dot_orig ./ 12^3), 'rx');

fprintf('a  = %.3e ft^2.5/s\na  = %.3e ft^4/s/lbf^0.5\nr2 = %.3f\n', ...
    a(1), a(1)/sqrt(gam), r2);

p_theoretical = 0:0.01:15000;
v_dot_theoretical = flow_func(p_theoretical / gam);
plot(p_theoretical, v_dot_theoretical, 'k-');

xlabel('Pressure (lbf/ft^2)');
ylabel('Volumetric Flowrate (ft^3/s)');

axis([0, 15000, 0, 0.016]);

xticks(0:5000:15000);
yticks(0:0.004:0.016);
