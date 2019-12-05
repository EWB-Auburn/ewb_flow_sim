% Initializes the system structure for flow coming from the tank. The
% two returned values, `root` and `leaves` represent the most upstream node
% and a cell array of all leaves, respectively.
function [root, leaves] = trunk_line()
% Load system parameters
parameters;

% Define the leaves first
leaf_count = 79;
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

n76 = flow_node('n76', [], 79);
n75n76 = flow_link('n75n76', n76, pvc('x'), y, -21.00, countl(n76), k_thru);
n75 = flow_node('n75', n75n76, 78);
n74n75 = flow_link('n74n75', n75, pvc('x'), y, -13.80, countl(n75), k_thru);
n74 = flow_node('n74', n74n75, 77);
n73n74 = flow_link('n73n74', n74, pvc('x'), y, -12.00, countl(n74), k_thru);
n73 = flow_node('n73', n73n74, 76);
n72n73 = flow_link('n72n73', n73, pvc('x'), y, -8.00, countl(73), k_thru);
n72 = flow_node('n72', n72n73, 75);
n71n72 = flow_link('n71n72', n72, pvc('x'), y, -23.25, countl(72), k_thru);
n71 = flow_node('n71', n71n72, 74);
n70n71 = flow_link('n70n71', n71, pvc('x'), y, -10.30, countl(71), k_thru);
n70 = flow_node('n70', n70n71, 73);
n69n70 = flow_link('n69n70', n70, pvc('x'), y, -2.20, countl(70), k_thru);
n69 = flow_node('n69', n69n70, 72);
n68n69 = flow_link('n68n69', n69, pvc('x'), y, -14.81, countl(69), k_thru);
n68 = flow_node('n68', n68n69, 71);
n67n68 = flow_link('n67n68', n68, pvc('x'), y, -20.50, countl(68), k_thru);
n67 = flow_node('n67', n67n68, 70);
n66n67 = flow_link('n66n67', n67, pvc('x'), y, -19.05, countl(67), k_thru);
n66 = flow_node('n66', n66n67, 69);
n65n66 = flow_link('n65n66', n66, pvc('x'), y, -26.28, countl(66), k_thru);
n65 = flow_node('n65', n65n66, 68);
n64n65 = flow_link('n64n65', n65, pvc('x'), y, -7.00, countl(65), k_thru);
n64 = flow_node('n64', n64n65, 67);
n63n64 = flow_link('n63n64', n64, pvc('x'), y, -4.96); 
n63 = flow_node('n63', n63n64, 66);
n62n63 = flow_link('n62n63', n63, pvc('x'), y, -4.36);
n62 = flow_node('n62', n62n63, 65);
n61n62 = flow_link('n61n62', n62, pvc('x'), y, -2.00);
n61 = flow_node('n61', n61n62, 64);
n60n61 = flow_link('n60n61', n61, pvc('x'), y, -4.10);
n60 = flow_node('n60', n60n61, 63);
n59n60 = flow_link('n59n60', n60, pvc('x'), y, -11.45);
n59 = flow_node('n59', n59n60, 62);
n58n59 = flow_link('n58n59', n59, pvc('x'), y, -18.00);
n58 = flow_node('n58', n58n59, 61);
n57n58 = flow_link('n57n58', n58, pvc('x'), y, -8.00);
n57 = flow_node('n57', n57n58, 60);
n56n57 = flow_link('n56n57', n57, pvc('x'), y, -16.30);
n56 = flow_node('n56', n56n57, 59);
n55n56 = flow_link('n55n56', n56, pvc('x'), y, -28.45);
n55 = flow_node('n55', n55n56, 58);
n54n55 = flow_link('n54n55', n55, pvc('x'), y, -7.65);
n54 = flow_node('n54', n54n55, 57);
n53n54 = flow_link('n53n54', n54, pvc('x'), y, -1.20);
n53 = flow_node('n53', n53n54, 56);
n52n53 = flow_link('n52n53', n53, pvc('x'), y, -1.54);
n52 = flow_node('n52', n52n53, 55);
n51n52 = flow_link('n51n52', n52, pvc('x'), y, -1.90);
n51 = flow_node('n51', n51n52, 54);
n50n51 = flow_link('n50n51', n51, pvc('x'), y, -2.85);
n50 = flow_node('n50', n50n51, 53);
n49n50 = flow_link('n49n50', n50, pvc('x'), y, -5.10);
n49 = flow_node('n49', n49n50, 52);
n48n49 = flow_link('n48n49', n49, pvc('x'), y, -2.47);
n48 = flow_node('n48', n48n49, 51);
n47n48 = flow_link('n47n48', n48, pvc('x'), y, -2.31);
n47 = flow_node('n47', n47n48, 50);
n46n47 = flow_link('n46n47', n47, pvc('x'), y, -2.40);
n46 = flow_node('n46', n46n47, 49);
n45n46 = flow_link('n45n46', n46, pvc('x'), y, -2.10);
n45 = flow_node('n45', n45n46, 48);
n44n45 = flow_link('n44n45', n45, pvc('x'), y, -0.97);
n44 = flow_node('n44', n44n45, 47);
n43n44 = flow_link('n43n44', n44, pvc('x'), y, -2.77);
n43 = flow_node('n43', n43n44, 46);
n42n43 = flow_link('n42n43', n43, pvc('x'), y, -1.80);
n42 = flow_node('n42', n42n43, 45);
n41n42 = flow_link('n41n42', n42, pvc('x'), y, -2.08);
n41 = flow_node('n41', n41n42, 44);
n40n41 = flow_link('n40n41', n41, pvc('x'), y, -2.70);
n40 = flow_node('n40', n40n41, 43);
n39n40 = flow_link('n39n40', n40, pvc('x'), y, -1.85);
n39 = flow_node('n39', n39n40, 42);
n38n39 = flow_link('n38n39', n39, pvc('x'), y, -0.85);
n38 = flow_node('n38', n38n39, 41);
n37n38 = flow_link('n37n38', n38, pvc('x'), y, -1.85);
n37 = flow_node('n37', n37n38, 40);
n36n37 = flow_link('n36n37', n37, pvc('x'), y, -1.50);
n36 = flow_node('n36', n36n37, 39);
n35n36 = flow_link('n35n36', n36, pvc('x'), y, -1.60);
n35 = flow_node('n35', n35n36, 38);
n34n35 = flow_link('n34n35', n35, pvc('x'), y, 1.70);
n34 = flow_node('n34', n34n35, 37);
n33n34 = flow_link('n33n34', n34, pvc('x'), y, 2.60);
n33 = flow_node('n33', n33n34, 36);
n32n33 = flow_link('n32n33', n33, pvc('x'), y, -1.35);
n32 = flow_node('n32', n32n33, 35);
n31n32 = flow_link('n31n32', n32, pvc('x'), y, -6.04);
n31 = flow_node('n31', n31n32, 34);
n30n31 = flow_link('n30n31', n31, pvc('x'), y, -16.44);
n30 = flow_node('n30', n30n31, 33);
n29n30 = flow_link('n29n30', n30, pvc('x'), y, -21.03);
n29 = flow_node('n29', n29n30, 32);
n28n29 = flow_link('n28n29', n29, pvc('x'), y, -0.65);
n28 = flow_node('n28', n28n29, 31);
n27n28 = flow_link('n27n28', n28, pvc('x'), y, -1.20);
n27 = flow_node('n27', n27n28, 30);
n26n27 = flow_link('n26n27', n27, pvc('x'), y, -1.26);
n26 = flow_node('n26', n26n27, 29);
n25n26 = flow_link('n25n26', n26, pvc('x'), y, -2.00);
n25 = flow_node('n25', n25n26, 28);
n24n25 = flow_link('n24n25', n25, pvc('x'), y, -1.15);
n24 = flow_node('n24', n24n25, 27);
n23n24 = flow_link('n23n24', n24, pvc('x'), y, -0.45);
n23 = flow_node('n23', n23n24, 26);
n22n23 = flow_link('n22n23', n23, pvc('x'), y, -0.60);
n22 = flow_node('n22', n22n23, 25);
n21n22 = flow_link('n21n22', n22, pvc('x'), y, -1.81);
n21 = flow_node('n21', n21n22, 24);
n20n21 = flow_link('n20n21', n21, pvc('x'), y, -3.95);
n20 = flow_node('n20', n20n21, 23);
n19n20 = flow_link('n19n20', n20, pvc('x'), y, -2.42);
n19 = flow_node('n19', n19n20, 22);
n18n19 = flow_link('n18n19', n19, pvc('x'), y, -2.10);
n18 = flow_node('n18', n18n19, 21);
n17n18 = flow_link('n17n18', n18, pvc('x'), y, -3.30);
n17 = flow_node('n17', n17n18, 20);
n16n17 = flow_link('n16n17', n17, pvc('x'), y, -1.05);
n16 = flow_node('n16', n16n17, 19);
n15n16 = flow_link('n15n16', n16, pvc('x'), y, -1.30);
n15 = flow_node('n15', n15n16, 18);
n14n15 = flow_link('n14n15', n15, pvc('x'), y, -9.00);
n14 = flow_node('n14', n14n15, 17);
n13n14 = flow_link('n13n14', n14, pvc('x'), y, -5.00);
n13 = flow_node('n13', n13n14, 16);
n12n13 = flow_link('n12n13', n13, pvc('x'), y, -6.15);
n12 = flow_node('n12', n12n13, 15);
n11n12 = flow_link('n11n12', n12, pvc('x'), y, -2.86);
n11 = flow_node('n11', n11n12, 14);
n10n11 = flow_link('n10n11', n11, pvc('x'), y, -5.50);
n10 = flow_node('n10', n10n11, 13);
n9n10 = flow_link('n9n10', n10, pvc('x'), y, -12.58);
n9 = flow_node('n9', n9n10, 12);
n8n9 = flow_link('n8n9', n9, pvc('x'), y, -19.50);
n8 = flow_node('n8', n8n9, 11);
n7n8 = flow_link('n7n8', n8, pvc('x'), y, -19.00);
n7 = flow_node('n7', n7n8, 10);
n6n7 = flow_link('n6n7', n7, pvc('x'), y, -18.65);
n6 = flow_node('n6', n6n7, 9);
n5n6 = flow_link('n5n6', n6, pvc('x'), y, -19.80);
n5 = flow_node('n5', n5n6, 8);
n4n5 = flow_link('n4n5', n5, pvc('x'), y, -18.50);
n4 = flow_node('n4', n4n45, 7);
n3n4 = flow_link('n3n4', n4, pvc('x'), y, -16.40);
n3 = flow_node('n3', n3n4, 6);
n2n3 = flow_link('n2n3', n3, pvc('x'), y, -15.16);
n2 = flow_node('n2', n2n3, 5);
n1n2 = flow_link('n1n2', n2, pvc('x'), y, -17.70);
n1 = flow_node('n1', n1n2, 4);
nCn1 = flow_link('nCn1', n1, pvc('x'), y, -19.30);
nC = flow_node('nC', nCn1, 3);
nBnC = flow_link('nBnC', nC, pvc('x'), y, -25.75);
nB = flow_node('nB', nBnC, 2);
nBnA = flow_link('nBnA', nB, pvc('x'), y, -28.00);
nA = flow_node('nA', nBnA, 1);

end





