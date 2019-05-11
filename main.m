% This is the main driver for ewb_flow_sim. This script calls
% `sprinkler_sim()` for each of the `init_files` listed.

clear;
init_funcs = {'tank_1_init', 'tank_2_init_lower_half', ...
    'tank_2_init_upper_half'};
n = 12; % number if iterations to run
for i = 1:length(init_funcs)
    results = sprinkler_sim(str2func(init_funcs{i}), n);
    
    fprintf('%s\n', init_funcs{i});
    % Display leaf head history
    for j = 1:length(results)
        fprintf('%2d: ', j);
        for k = (n-min(1-1, n-1)):1:n
            fprintf('%4.0f ', results(k, j));
        end
        fprintf('\n');
    end
    fprintf('\n');
end