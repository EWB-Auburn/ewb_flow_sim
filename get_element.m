% Given a root element, search for an element by name. This function works
% for both `flow_node` and `flow_link` objects, and returns `-1` if no
% element with the given name is found. No guarentees are made as to which
% element will be returned if there is more than one element in the given
% tree with the same name.
function element = get_element(root, name)
% NOTE: this algorithm happens to implement depth-first search
% fprintf('-----> %s\n', root.name); % Display current element
if root.name == name
    element = root;
elseif isa(root, 'flow_link')
    if isempty(root.downstream_node)
        element = -1;
    else
        element = get_element(root.downstream_node, name);
    end
elseif isa(root, 'flow_node')
    for i = 1:length(root.downstream_connections)
        element = get_element(root.downstream_connections(i), name);
        % If the previous statement returns `-1`, then the sought element
        % is not in that branch. Otherwise, the element has been found. The
        % check is done as a class check because equality is not defined
        % for flow_link and flow_node objects. The only instance under
        % which the class of `element` would be `double` would be if a `-1`
        % was returned downstream.
        if ~isa(element, 'double')
            return;
        end
    end
    % If this point is reached, then the sought element is not downstream
    % of this element, or else there are no downstream connections.
    element = -1;
else
    % If this point is reached, there is something in the structure that is
    % neither a `flow_link` nor a `flow_node`. Raise an exception.
    error('Invalid object type');
end 
end