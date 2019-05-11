% Given an established system root node, walk the tree and add a link to
% each node with a leaf, moving said leaf to the end of the new link. This
% is to model each sprinkler being attached to the system by a length of
% hose.
%
% The naming convention for the newly created links and nodes are as
% follows. Care should be taken to avoid collisions in the resulting tree.
% Link: hose_link_{n}
% Node: hose_node_{n}
% where {n} refers to the applicable leaf index.
function root_out = add_hoses(root_in)
% Load system parameters
parameters;

% First, add hoses everywhere downstream.
for i = 1:length(root_in.downstream_connections)
    root_in.downstream_connections(i).downstream_node = ...
        add_hoses(root_in.downstream_connections(i).downstream_node);
end
% Does `root` have a leaf?
if root_in.local_leaf ~= -1
    root_in.downstream_connections(end + 1, 1) = ...
        init_hose(root_in.local_leaf);
    root_in.local_leaf = -1;
end
root_out = root_in;
end

% Initialize a hose link with a given name and downstream node/leaf
function link = init_hose(leaf_index)
% Load system parameters
parameters;

node = flow_node(sprintf('hose_node_%d', leaf_index), [], leaf_index);
link = flow_link(sprintf('hose_link_%d', leaf_index), node, hose_dia, ...
    hose_len, hose_dz, leaf_index, hose_upstream_k);
end