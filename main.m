% This is the main driver for ewb_flow_sim. This script calls
% `sprinkler_sim()` for each of the `init_files` listed.

clear;
init_funcs = {'tank_1_init', 'tank_2_init_lower_half', ...
    'tank_2_init_upper_half'};
n = 12; % number if iterations to run

for i = 1:length(init_funcs)
    fprintf('%s\n', init_funcs{i});
    func = str2func(init_funcs{i});
    
    tic;
    results = sprinkler_sim(func, n);
    toc;
    
    a = sprinkler_1_data();
    flow_func = @(h) a * h.^0.5;
    
    fprintf('Leaf h_ft GPM\n');
    for j = 1:length(results)
        fprintf('%2d: %4.0f %4.1f\n', j, results(n, j), ...
            flow_func(results(n, j)) * 448.83117);
    end
    fprintf('\n');
end