% Dump all properties from a root node and its decendents to a file in JSON
% format.
function out = save_json(root, filename, element_name)
f = fopen(filename, 'w');
if nargin < 3
    element = root;
else
    element = get_element(root, element_name);
end
fprintf(f, jsonencode(element));
out = 0;
end