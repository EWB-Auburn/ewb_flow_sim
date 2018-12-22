% Given a node, generate a list including the local leaf (if any), as well
% as leaves connected to all downstream nodes.
function list = countl(start_node)
list = [];
if isempty(start_node)
    return;
end
if start_node.local_leaf ~= -1
    list = [start_node.local_leaf];
end
if ~isempty(start_node.downstream_connections)
    for link = start_node.downstream_connections
        list = cat(1, list, link.all_downstream_leaves);
    end
end
end
