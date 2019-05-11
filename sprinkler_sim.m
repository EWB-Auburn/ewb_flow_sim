clear;
% Load system parameters
parameters;

% Initialize the system structure
global leaf_list;
[root, leaf_list] = init();

% Run some number of pressure/flow calculation iterations
n = 12;
leaf_flows = zeros(n, length(leaf_list));
for i = 1:n
    root = update_node_pressure(root);
    root = update_node_flow(root);
    for j = 1:length(leaf_list)
        leaf_flows(i, j) = leaf_list{j}.head;
    end
end

% Display leaf head history
for i = 1:length(leaf_list)
    fprintf('%2d: ', i);
    for j = (n-min(1-1, n-1)):1:n
        fprintf('%4.0f ', leaf_flows(j, i));
    end
    fprintf('\n');
end


% Given a node in the system, update the inbound head of every connected
% link, and call update_link_pressure() on each of those links, which will
% recursively solve all downstream parts of the system. Note that minor
% head losses due to node geometry are handled by the affected downstream
% link.
function node_out = update_node_pressure(node_in)
global leaf_list;
parameters;
% Exit condition
if node_in.head_limit > 0 % then a PRV is present at this node
    node_in.head = min(node_in.head, node_in.head_limit);
end
if ~isempty(node_in.downstream_connections)
    for i = 1:length(node_in.downstream_connections)
        node_in.downstream_connections(i).head_in = node_in.head;
        node_in.downstream_connections(i) = ...
            update_link_pressure(node_in.downstream_connections(i));
    end
end
i = node_in.local_leaf;
if i ~= -1
    % Change head in leaf by weighted average to combat resonance
    prev_head = leaf_list{i}.head;
    leaf_list{i}.head = node_in.head * (1-pressure_update_alpha)...
        + prev_head * pressure_update_alpha;
end

node_out = node_in;
end

% Given a link in the system, calculate the head loss in that link,
% including minor losses incurred at the upstream connection
function link_out = update_link_pressure(link_in)
% Note that there is no formal exit condition, because every link should be
% connected to nodes at both the upstream and downstream ends
parameters;
link_in.head_out = max(0, link_in.head_in - link_in.delta_z - ...
    link_in.velocity^2 / 2 / g * head_loss_coefficient(link_in));
link_in.pressure_iteration = link_in.pressure_iteration + 1;
link_in.downstream_node.head = link_in.head_out;
link_in.downstream_node = update_node_pressure(link_in.downstream_node);

link_out = link_in;
end

function node_out = update_node_flow(node_in)
flow = 0;
ind = node_in.local_leaf;
if ind ~= -1
    flow = flow + get_leaf_flow(ind);
end
if ~isempty(node_in.downstream_connections) % Exit condition
    for i = 1:length(node_in.downstream_connections)
        for j = 1:length( ...
                node_in.downstream_connections(i).all_downstream_leaves)
            flow = flow + get_leaf_flow( ...
                node_in.downstream_connections(i) ...
                .all_downstream_leaves(j));
        end
        node_in.downstream_connections(i) = ...
            update_link_flow(node_in.downstream_connections(i));
    end
end
node_in.flow = flow;
node_out = node_in;
end

function link_out = update_link_flow(link_in)
flow = 0;
for i = 1:length(link_in.all_downstream_leaves)
    flow = flow + get_leaf_flow(link_in.all_downstream_leaves(i));
end

link_in.velocity = flow / (pi/4 * link_in.diameter^2);
link_in.flow_iteration = link_in.flow_iteration + 1;
link_in.downstream_node = update_node_flow(link_in.downstream_node);
link_out = link_in;
end

function flow = get_leaf_flow(index)
global leaf_list;
l = leaf_list{index};
flow = l.flow_function(l.head);
end



function n = dump_node(node)
i = 1;
fprintf('===================\n');
disp(node);
while i <= length(node.downstream_connections)
    dump_link(node.downstream_connections(i));
    i = i + 1;
end
n = 0;
end

function n = dump_link(link)
fprintf('\n');
disp(link);
fprintf('%d, ', link.all_downstream_leaves);
fprintf('\n');
if ~isempty(link.downstream_node)
    dump_node(link.downstream_node);
end
n = 0;
end

