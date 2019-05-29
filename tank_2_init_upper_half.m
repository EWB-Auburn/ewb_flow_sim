% Initializes the system structure for flow coming from the upper tank. The
% two returned values, `root` and `leaves` represent the most upstream node
% and a cell array of all leaves, respectively.
function [root, leaves] = tank_2_init_upper_half()
% Load system parameters
parameters;

% Define the leaves first
leaf_count = 19;
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



% More non-survey sprinkler nodes
n2 = flow_node('n2', [], 19);
PFB1 = flow_link('PFB1', n2, pvc('2'), 137, 0, countl(n2), k_thru);
n1 = flow_node('n1', PFB1, 18);
Bn1 = flow_link('Bn1', n1, pvc('2'), 20, 0, countl(n1), k_turn);

B = flow_node('B', Bn1, -1);
BC = flow_link('BC', B, pvc('2'), 34, 0, countl(B), k_thru);
C = flow_node('C', BC, -1);
CD = flow_link('CD', C, pvc('2'), 35, 31.06, countl(C), k_thru);

n4 = flow_node('n4', [], 17);
PFB2 = flow_link('PFB2', n4, pvc('1'), 119, 0, countl(n4), k_thru);
n3 = flow_node('n3', PFB2, 16);
% More non-survey sprinkler nodes
Dn3 = flow_link('Dn3', n3, pvc('1'), 20, 0, countl(n3), k_turn);
D = flow_node('D', [Dn3, CD], -1);
DE = flow_link('DE', D, pvc('2'), 89, 16.63, countl(D), k_thru);

% Many of the lengths and delta-z values in this set of unsurveyed nodes
% and links may be extremely rough estimates. Unsurveyed points are
% designated by sprinkler number, rather than letter. Nodes given by a `Z`
% designation are non-sprinkler, non-survey-point nodes.
% One half of PFB3
n8 = flow_node('n8', [], 12);
n7n8 = flow_link('n7n8', n8, pvc('1'), 200, 0, countl(n8), k_thru);
n7 = flow_node('n7', n7n8, 13);
Z1n7 = flow_link('Z1n7', n7, pvc('1'), 269/2, 18.08/2, countl(n7), k_thru);
% Other half of PFB3
n6 = flow_node('n6', [], 14);
Z1n6 = flow_link('Z1n6', n6, pvc('1'), 20, 0, countl(n6), k_turn);
Z1 = flow_node('Z1', [Z1n6, Z1n7], -1);
n5Z1 = flow_link('n5Z1', Z1, pvc('1'), 269/2, 18.08/2, countl(Z1), k_turn);
n5 = flow_node('n5', n5Z1, 15);
En5 = flow_link('En5', n5, pvc('1'), 20, 0, countl(n5), k_turn);

E = flow_node('E', [En5, DE], -1);
EF = flow_link('EF', E, pvc('2'), 91, 38.62, countl(E), k_thru);
F = flow_node('F', EF, -1);
FG = flow_link('FG', F, pvc('2'), 148, 0, countl(F), k_turn);

J = flow_node('J', [], 10);
IJ = flow_link('IJ', J, pvc('1'), 155, 24.88, countl(J), k_turn);
I = flow_node('I', IJ, 9);
HI = flow_link('HI', I, pvc('1'), 95, 0, countl(I), k_turn);
H = flow_node('H', HI, 8);
GH = flow_link('GH', H, pvc('1'), 61, 35.08, countl(H), k_turn);

G = flow_node('G', [GH, FG], 11);
GK = flow_link('GK', G, pvc('2'), 14, 23.13, countl(G), k_turn);

% According to the layout diagram, this node flows uphill, as indicated by
% the positive delta-z.
n13 = flow_node('n13', [], 7);
PFB5 = flow_link('PFB5', n13, pvc('1/2'), 55.8, -30.5, countl(n13), k_turn);

K = flow_node('K', [PFB5, GK], -1);
KL = flow_link('KL', K, pvc('2'), 84, 0, countl(K), k_turn);

M = flow_node('M', [], 6);
LM = flow_link('LM', M, pvc('1/2'), 51, 1.25, countl(M), k_turn);
L = flow_node('L', [LM, KL], -1);

LN = flow_link('LN', L, pvc('2'), 16, 0, countl(L), k_thru);
O = flow_node('O', [], 5);
NO = flow_link('NO', O, pvc('1/2'), 61, 0, countl(O), k_turn);
N = flow_node('N', [NO, LN], 4);
NP = flow_link('NP', N, pvc('2'), 124, 30.66, countl(N), k_thru);

Q = flow_node('Q', [], 3);
PQ = flow_link('PQ', Q, pvc('1/2'), 52, 15.5, countl(Q), k_turn);
P = flow_node('P', [PQ, NP], -1);
PR = flow_link('PR', P, pvc('2'), 36, 15.5, countl(P), k_thru);

U = flow_node('U', [], 2);
RU = flow_link('RU', U, pvc('1/2'), 136, 43.21, countl(U), k_turn);
R = flow_node('R', [RU, PR], -1);

TR = flow_link('TR', R, pvc('2'), 66, 18.29, countl(R), k_turn);
T = flow_node('T', TR, 1);
TS = flow_link('TS', T, pvc('2'), 99, 0, countl(T), k_thru);
S = flow_node('S', TS, -1);

% Connection to S from the upper tank `lt`
ltS = flow_link('ltS', S, pvc('3'), 300, -195.89, countl(S), k_thru);
lt = flow_node('lt', ltS, -1);

root = add_hoses(lt);

end