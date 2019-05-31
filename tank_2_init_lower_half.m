% Initializes the system structure for flow coming from the lower tank. The
% two returned values, `root` and `leaves` represent the most upstream node
% and a cell array of all leaves, respectively.
function [root, leaves] = tank_2_init_lower_half()
% Load system parameters
parameters;

% Define the leaves first
leaf_count = 13;
leaves = cell(leaf_count, 1);
a = sprinkler_1_data();
flow_func = @(v) min(a * v.^0.5, leaf_limit);


for i = 1:leaf_count
    leaves{i} = flow_leaf();
    leaves{i}.flow_function = flow_func;
end

% Start from the bottom and work towards the root.
% All nodes modeled as tees, assuming flanged joins. Data from Neutrium
% (https://neutrium.net/fluid_flow/...
% pressure-loss-from-fittings-excess-head-k-method/)
k_thru = 0.4;
k_turn = 1;


AN = flow_node('AN', [], 13);
AMAN = flow_link('AMAN', AN, pvc('1/2'), 330, -160.08, countl(AN), k_thru);
AM = flow_node('AM', AMAN, 12);
% AM.head_limit = 30*144/gam;

ALAM = flow_link('ALAM', AM, pvc('1'), 100, 0, countl(AM), k_thru);
AL = flow_node('AL', ALAM, 11);
AKAL = flow_link('AKAL', AL, pvc('1'), 100, 0, countl(AL), k_thru);
AK = flow_node('AK', AKAL, 10);
AHAK = flow_link('AHAK', AK, pvc('1'), 100, -49.33, countl(AK), k_thru);

AU = flow_node('AU', [], 8);
AHAU = flow_link('AHAU', AU, pvc('1/2'), 108.9, 0, countl(AU), k_turn);
AI = flow_node('AI', [], 9);
AHAI = flow_link('AHAI', AI, pvc('1/2'), 108.9, 0, countl(AI), k_turn);

AH = flow_node('AH', [AHAU, AHAK, AHAI], -1);
AGAH = flow_link('AGAH', AH, pvc('1'), 50, 0, countl(AH), k_thru);
AG = flow_node('AG', AGAH, -1);
ADAG = flow_link('ADAG', AG, pvc('1'), 50, -25.88, countl(AG), k_thru);

AF = flow_node('AF', [], 6);
ADAF = flow_link('ADAF', AF, pvc('1/2'), 99, 0, countl(AF), k_turn);
AE = flow_node('AE', [], 7);
ADAE = flow_link('ADAE', AE, pvc('1/2'), 99, 0, countl(AE), k_turn);

AD = flow_node('AD', [ADAF, ADAE, ADAG], -1);
AAAD = flow_link('AAAD', AD, pvc('1'), 99, 0, countl(AD), k_thru);

AC = flow_node('AC', [], 4);
AAAC = flow_link('AAAC', AC, pvc('1/2'), 89.1, 0, countl(AC), k_turn);
AB = flow_node('AB', [], 5);
AAAB = flow_link('AAAB', AB, pvc('1/2'), 89.1, 0, countl(AB), k_turn);

AA = flow_node('AA', [AAAB, AAAC, AAAD], -1);
ZAA = flow_link('ZAA', AA, pvc('1'), 49.5, -117.79, countl(AA), k_thru);

Z = flow_node('Z', ZAA, 3);
Z.head_limit = 30*144/gam; % This is where the PRV is installed

WZ = flow_link('WZ', Z, pvc('1'), 49.5, 0, countl(Z), k_thru); %Changed from 1" to 2" PVC at Dr. Burch's recommendation

Y = flow_node('Y', [], 1);
WY = flow_link('WY', Y, pvc('1/2'), 99, 0, countl(Y), k_turn);
X = flow_node('X', [], 2);
WX = flow_link('WX', X, pvc('1/2'), 99, 0, countl(X), k_turn);

W = flow_node('W', [WX, WY, WZ], -1);
SW = flow_link('SW', W, pvc('1'), 100, -20.88, countl(W), k_thru); %Changed from 1" to 2" PVC at Dr. Burch's recommendation
S = flow_node('S', SW, -1);

% Connection to S from the lower tank `lt`
ltS = flow_link('ltS', S, pvc('3'), 300, -195.89, countl(S), k_thru); %FIXME measurements
lt = flow_node('lt', ltS, -1);


root = add_hoses(lt);
end