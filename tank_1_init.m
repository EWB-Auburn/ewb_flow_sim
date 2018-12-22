%
function [root, leaves] = tank_1_init()
% Load system parameters
parameters;

% Define the leaves first
leaf_count = 32;
leaves = cell(leaf_count, 1);
hose_flow = sprinkler_1_data();
a = hose_flow(1);
hose_velocity = @(flow) flow / (pi/4 * (0.5/12)^2);
hose_loss = @(v) hose_k * hose_velocity(hose_flow(v))^2/2/g;
flow_func = @(v) min(a * (v - hose_loss(v)).^0.5, leaf_limit);


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


AN = flow_node('AN', [], 32);
AMAN = flow_link('AMAN', AN, pvc('1/2'), 330, -160.08, countl(AN), k_thru);
AM = flow_node('AM', AMAN, 31);
% AM.head_limit = 30*144/gam;

ALAM = flow_link('ALAM', AM, pvc('1'), 100, 0, countl(AM), k_thru);
AL = flow_node('AL', ALAM, 30);
AKAL = flow_link('AKAL', AL, pvc('1'), 100, 0, countl(AL), k_thru);
AK = flow_node('AK', AKAL, 29);
AHAK = flow_link('AHAK', AK, pvc('1'), 100, -49.33, countl(AK), k_thru);

AU = flow_node('AU', [], 27);
AHAU = flow_link('AHAU', AU, pvc('1/2'), 108.9, 0, countl(AU), k_turn);
AI = flow_node('AI', [], 28);
AHAI = flow_link('AHAI', AI, pvc('1/2'), 108.9, 0, countl(AI), k_turn);

AH = flow_node('AH', [AHAU, AHAK, AHAI], -1);
AGAH = flow_link('AGAH', AH, pvc('1'), 50, 0, countl(AH), k_thru);
AG = flow_node('AG', AGAH, -1);
ADAG = flow_link('ADAG', AG, pvc('1'), 50, -25.88, countl(AG), k_thru);

AF = flow_node('AF', [], 25);
ADAF = flow_link('ADAF', AF, pvc('1/2'), 99, 0, countl(AF), k_turn);
AE = flow_node('AE', [], 26);
ADAE = flow_link('ADAE', AE, pvc('1/2'), 99, 0, countl(AE), k_turn);

AD = flow_node('AD', [ADAF, ADAE, ADAG], -1);
AAAD = flow_link('AAAD', AD, pvc('1'), 99, 0, countl(AD), k_thru);

AC = flow_node('AC', [], 23);
AAAC = flow_link('AAAC', AC, pvc('1/2'), 89.1, 0, countl(AC), k_turn);
AB = flow_node('AB', [], 24);
AAAB = flow_link('AAAB', AB, pvc('1/2'), 89.1, 0, countl(AB), k_turn);

AA = flow_node('AA', [AAAB, AAAC, AAAD], -1);
ZAA = flow_link('ZAA', AA, pvc('1'), 49.5, -117.79, countl(AA), k_thru);

Z = flow_node('Z', ZAA, 22);
Z.head_limit = 30*144/gam; % This is where the PRV is installed

WZ = flow_link('WZ', Z, pvc('1'), 49.5, 0, countl(Z), k_thru);

Y = flow_node('Y', [], 20);
WY = flow_link('WY', Y, pvc('1/2'), 99, 0, countl(Y), k_turn);
X = flow_node('X', [], 21);
WX = flow_link('WX', X, pvc('1/2'), 99, 0, countl(X), k_turn);

W = flow_node('W', [WX, WY, WZ], -1);
SW = flow_link('SW', W, pvc('1'), 100, -20.88, countl(W), k_thru);
S = flow_node('S', SW, -1);
TS = flow_link('TS', S, pvc('2'), 99, 0, countl(S), k_thru);
T = flow_node('T', TS, 19);
RT = flow_link('RT', T, pvc('2'), 66, -18.29, countl(T), k_turn);

U = flow_node('U', [], 18);
RU = flow_link('RU', U, pvc('1/2'), 136, -43.21, countl(U), k_turn);
R = flow_node('R', [RU, RT], -1);

PR = flow_link('PR', R, pvc('2'), 36, -15.5, countl(R), k_thru);
Q = flow_node('Q', [], 17);
PQ = flow_link('PQ', Q, pvc('1/2'), 52, -15.5, countl(Q), k_turn);
P = flow_node('P', [PQ, PR], -1);

NP = flow_link('NP', P, pvc('2'), 124, -30.66, countl(P), k_thru);
O = flow_node('O', [], 16);
NO = flow_link('NO', O, pvc('1/2'), 61, 0, countl(O), k_turn);
N = flow_node('N', [NO, NP], 15);
LN = flow_link('LN', N, pvc('2'), 16, 0, countl(N), k_thru);

M = flow_node('M', [], 14);
LM = flow_link('LM', M, pvc('1/2'), 51, -1.25, countl(M), k_turn);
L = flow_node('L', [LM, LN], -1);

KL = flow_link('KL', L, pvc('2'), 84, 0, countl(L), k_turn);
n13 = flow_node('n13', [], 13);

% According to the layout diagram, this node flows uphill, as indicated by
% the positive delta-z.
PFB5 = flow_link('PFB5', n13, pvc('1/2'), 55.8, 30.5, countl(n13), k_turn);

K = flow_node('K', [PFB5, KL], -1);
GK = flow_link('GK', K, pvc('2'), 14, -23.13, countl(K), k_turn);

J = flow_node('J', [], 12);
IJ = flow_link('IJ', J, pvc('1'), 155, -24.88, countl(J), k_turn);
I = flow_node('I', IJ, 11);
HI = flow_link('HI', I, pvc('1'), 95, 0, countl(I), k_turn);
H = flow_node('H', HI, 10);
GH = flow_link('GH', H, pvc('1'), 61, -35.08, countl(H), k_turn);

G = flow_node('G', [GH, GK], 9);
FG = flow_link('FG', G, pvc('2'), 148, 0, countl(G), k_turn);
F = flow_node('F', FG, -1);
EF = flow_link('EF', F, pvc('2'), 91, -38.62, countl(F), k_thru);

% Many of the lengths and delta-z values in this set of unsurveyed nodes
% and links may be extremely rough estimates. Unsurveyed points are
% designated by sprinkler number, rather than letter. Nodes given by a `Z`
% designation are non-sprinkler, non-survey-point nodes.
n8 = flow_node('n8', [], 8);
n7n8 = flow_link('n7n8', n8, pvc('1'), 200, 0, countl(n8), k_thru);
n7 = flow_node('n7', n7n8, 7);
% One half of PFB3
Z1n7 = flow_link('Z1n7', n7, pvc('1'), 269/2, -18.08/2, countl(n7), k_thru);
n6 = flow_node('n6', [], 6);
Z1n6 = flow_link('Z1n6', n6, pvc('1'), 20, 0, countl(n6), k_turn);
Z1 = flow_node('Z1', [Z1n6, Z1n7], -1);
% Other half of PFB3
n5Z1 = flow_link('n5Z1', Z1, pvc('1'), 269/2, -18.08/2, countl(Z1), k_turn);
n5 = flow_node('n5', n5Z1, 5);
En5 = flow_link('En5', n5, pvc('1'), 20, 0, countl(n5), k_turn);

E = flow_node('E', [En5, EF], -1);
DE = flow_link('DE', E, pvc('2'), 89, -16.63, countl(E), k_thru);

% More non-survey sprinkler nodes
n4 = flow_node('n4', [], 4);
PFB2 = flow_link('PFB2', n4, pvc('1'), 119, 0, countl(n4), k_thru);
n3 = flow_node('n3', PFB2, 3);
Dn3 = flow_link('Dn3', n3, pvc('1'), 20, 0, countl(n3), k_turn);

D = flow_node('D', [Dn3, DE], -1);
CD = flow_link('CD', D, pvc('2'), 35, -31.06, countl(D), k_thru);
C = flow_node('C', CD, -1);
BC = flow_link('BC', C, pvc('2'), 34, 0, countl(C), k_thru);

% More non-survey sprinkler nodes
n2 = flow_node('n2', [], 2);
PFB1 = flow_link('PFB1', n2, pvc('2'), 137, 0, countl(n2), k_thru);
n1 = flow_node('n1', PFB1, 1);
Bn1 = flow_link('Bn1', n1, pvc('2'), 20, 0, countl(n1), k_turn);

B = flow_node('B', [BC, Bn1], -1);
AB = flow_link('AB', B, pvc('3'), 124.4, 0, countl(B), k_thru);
A = flow_node('A', AB, -1);

% Connection to A from the upper tank `ut`
utA = flow_link('utA', A, pvc('3'), 203.6, -50, countl(A), k_thru);
ut = flow_node('ut', utA, -1);


root = ut;
end