clc
clear
close all

%% Init

% generalized coordinates
syms q_1(t) q_2(t) q_4(t) q_3(t) q_5(t) q_6(t) q_7(t) q_8(t) q_9(t)

genCoord.logiVec = logical([1; 1; 1; 1; 0; 0; 0; 0; 1]); % 1 = defined, 0 = free
% genCoord.logiVec = logical([0; 0; 0; 0; 0; 0; 0; 0; 0]); % 1 = defined, 0 = free


%% Setup definded q_n(t)

q_1(t) = 0;
q_2(t) = 0;
q_3(t) = 0;
q_4(t) = 0;
% q_5(t) = deg2rad(0);
% q_6(t) = deg2rad(0);
% q_7(t) = deg2rad(90);
% q_8(t) = deg2rad(90);
q_9(t) = 0;

%% Start of Script

% Setup q_n Vectors
genCoord.qsTotal = [q_1(t); q_2(t); q_3(t); q_4(t); q_5(t); q_6(t); q_7(t); q_8(t); q_9(t)];
genCoord.qsDefined = genCoord.qsTotal(genCoord.logiVec);
genCoord.qsFree = genCoord.qsTotal(~genCoord.logiVec);

%% DESIGN DATA

dData.x_0 = 0;         % harvester offset in X
dData.y_0 = 1;         % harvester offset in Y
dData.z_0 = 0;         % harvester offset in Z
dData.y_J12 = 0.5;     % height of body 2
dData.x_J33 = 5;       % length of body 3
dData.x_J44 = 3;       % length of body 4
dData.x_J66 = 0.3;     % length of body 6
dData.x_J77 = 0.3;     % length of body 7
dData.x_J88 = 1;       % length of body 8
dData.x_J99 = 0;       % offset of tree
dData.g = 9.81;        % gravitational acceleration

% Mass
dData.mass.m1 = 1.40e+4;       % mass body 1
dData.mass.m2 = 9.81e+2;       % mass body 2
dData.mass.m3 = 1.01e+3;       % mass body 3
dData.mass.m4 = 1.01e+3;       % mass body 4
dData.mass.m5 = 4.10e+2;       % mass body 5
dData.mass.m6 = 6.93e+1;       % mass body 6
dData.mass.m7 = 6.93e+1;       % mass body 7
dData.mass.m8 = 3.56e+2;       % mass body 8
dData.mass.m9 = 1.60e+3;       % mass body 9
dData.mass.m10 = 1.17e+3;      % mass body 10

% Inertia-Matrix
dData.mMat.mm_1_1 = ...                  % Inertia-Matrix Body 1
    [1.3719656e+04 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 4.0195849e+04 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 3.1267937e+04];
dData.mMat.mm_2_2 = ...                  % Inertia-Matrix Body 2
    [1.2016446e+02 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.1882324e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.2016447e+02];
dData.mMat.mm_3_3 =...                   % Inertia-Matrix Body 3
    [9.1318903e+00 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 2.1535198e+03 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 2.1535198e+03];
dData.mMat.mm_4_4 =...                   % Inertia-Matrix Body 4
    [2.2843140e+01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 8.1276327e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 8.1276327e+02];
dData.mMat.mm_5_5 =...                   % Inertia-Matrix Body 5
    [3.6657783e+00 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.4449252e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.4449252e+02];
dData.mMat.mm_6_6 =...                   % Inertia-Matrix Body 6
    [5.6831488e-01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 8.9035328e-01 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 8.9035328e-01];
dData.mMat.mm_7_7 =...                   % Inertia-Matrix Body 7
    [5.6831488e-01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 8.9035328e-01 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 8.9035328e-01];
dData.mMat.mm_8_8 =...                   % Inertia-Matrix Body 8
    [7.7778386e+00 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 3.8109359e+01 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 3.8109359e+01];
dData.mMat.mm_9_9 =...                   % Inertia-Matrix Body 9
    [1.9937447e+02 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.9937448e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 2.9385014e+02];
dData.mMat.mm_10_10 =...                 % Inertia-Matrix Body 10
    [3.6815539e+01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 9.8358851e+03 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 9.8358846e+03];

%% Rotation-Matrix

% rotation matrix in local CS
rotMat.T10 = [1 0 0; 0 1 0; 0 0 1];
rotMat.T21 = [cos(q_1(t)) 0 sin(q_1(t)); 0 1 0; -sin(q_1(t)) 0 cos(q_1(t))];
rotMat.T32 = [cos(q_2(t)) -sin(q_2(t)) 0; sin(q_2(t)) cos(q_2(t)) 0; 0 0 1];
rotMat.T43 = [cos(q_3(t)) -sin(q_3(t)) 0; sin(q_3(t)) cos(q_3(t)) 0; 0 0 1];
rotMat.T54 = [1 0 0; 0 1 0; 0 0 1];
rotMat.T65 = [cos(q_5(t)) -sin(q_5(t)) 0; sin(q_5(t)) cos(q_5(t)) 0; 0 0 1];
rotMat.T76 = [cos(q_6(t)) 0 sin(q_6(t)); 0 1 0; -sin(q_6(t)) 0 cos(q_6(t))];
rotMat.T87 = [1 0 0; 0 cos(q_7(t)) -sin(q_7(t)); 0 sin(q_7(t)) cos(q_7(t))];
rotMat.T98 = [cos(q_8(t)) -sin(q_8(t)) 0; sin(q_8(t)) cos(q_8(t)) 0; 0 0 1];
rotMat.T109 = [1 0 0; 0 1 0; 0 0 1];

% rotation matrix in inertial CS
rotMat.T20 = simplify(rotMat.T10*rotMat.T21);
rotMat.T30 = simplify(rotMat.T10*rotMat.T21*rotMat.T32);
rotMat.T40 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43);
rotMat.T50 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54);
rotMat.T60 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65);
rotMat.T70 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76);
rotMat.T80 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76*rotMat.T87);
rotMat.T90 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76*rotMat.T87*rotMat.T98);
rotMat.T100 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76*rotMat.T87*rotMat.T98*rotMat.T109);

disp("Setup Rotation-Matrix completed")
%% Joints

joint.J0_0 = [dData.x_0; dData.y_0; dData.z_0];
joint.J1_0 = [0; 0; 0];
joint.J1_1 = [0; 0; 0];
joint.J1_2 = [0; dData.y_J12; 0];
joint.J2_2 = [0; 0; 0];
joint.J3_3 = [dData.x_J33; 0; 0];
joint.J4_4 = [dData.x_J44; 0; 0];
joint.J5_5 = [0; 0; 0];
joint.J6_6 = [dData.x_J66; 0; 0];
joint.J7_7 = [dData.x_J77; 0; 0];
joint.J8_8 = [dData.x_J88; 0; 0];
joint.J9_9 = [dData.x_J99; 0; 0];

%% Definition of COGs (in local CS)

cog.SP1_1 = [0; -0.5; 0];
cog.SP2_2 = [0; -0.25; 0];
cog.SP3_3 = [2.5; 0; 0];
cog.SP4_4 = [1.5; 0; 0];
cog.SP5_5 = [-1; 0; 0];
cog.SP6_6 = [0.15; 0; 0];
cog.SP7_7 = [0.15; 0; 0];
cog.SP8_8 = [0.5; 0; 0];
cog.SP9_9 = [0; 0; 0];
cog.SP10_10 = [0; 0; 0];

%% Coordinate Systems & COGs in Inertial-Frame

% Coordinate Systems (Position) in Inertial Frame
coordSys.KS_1 = joint.J0_0+rotMat.T10*joint.J1_0+rotMat.T10*joint.J1_1;
coordSys.KS_2 = coordSys.KS_1+rotMat.T10*joint.J1_2;
coordSys.KS_3 = simplify(coordSys.KS_2+rotMat.T20*joint.J2_2);
coordSys.KS_4 = simplify(coordSys.KS_3+rotMat.T30*joint.J3_3);
coordSys.KS_5 = simplify(coordSys.KS_4+rotMat.T40*joint.J4_4+rotMat.T40*[q_4(t); 0; 0]);
coordSys.KS_6 = simplify(coordSys.KS_5+rotMat.T50*joint.J5_5);
coordSys.KS_7 = simplify(coordSys.KS_6+rotMat.T60*joint.J6_6);
coordSys.KS_8 = simplify(coordSys.KS_7+rotMat.T70*joint.J7_7);
coordSys.KS_9 = simplify(coordSys.KS_8+rotMat.T80*joint.J8_8);
coordSys.KS_10 = simplify(coordSys.KS_9+rotMat.T90*joint.J9_9+rotMat.T90*[q_9(t); 0; 0]);

% Coordinate Systems combined in one Vector, preperation for Plot
syms temp
coordSys.sumKS(3,1) = temp;
for n=1:10
    coordSys.sumKS(:,n) = coordSys.(strcat('KS_', num2str(n)));
end
clearvars n temp

% COGs (Position) in Inertial-Frame
cog.SP_1_0 = coordSys.KS_1+rotMat.T10*cog.SP1_1;
cog.SP_2_0 = coordSys.KS_2+rotMat.T20*cog.SP2_2;
cog.SP_3_0 = simplify(coordSys.KS_3+rotMat.T30*cog.SP3_3);
cog.SP_4_0 = simplify(coordSys.KS_4+rotMat.T40*cog.SP4_4);
cog.SP_5_0 = simplify(coordSys.KS_5+rotMat.T50*cog.SP5_5);
cog.SP_6_0 = simplify(coordSys.KS_6+rotMat.T60*cog.SP6_6);
cog.SP_7_0 = simplify(coordSys.KS_7+rotMat.T70*cog.SP7_7);
cog.SP_8_0 = simplify(coordSys.KS_8+rotMat.T80*cog.SP8_8);
cog.SP_9_0 = simplify(coordSys.KS_9+rotMat.T90*cog.SP9_9);
cog.SP_10_0 = simplify(coordSys.KS_10+rotMat.T100*cog.SP10_10);

% COGs (velocity)
vcog.vSP_1_0 = simplify(diff(cog.SP_1_0, t));
vcog.vSP_2_0 = simplify(diff(cog.SP_2_0, t));
vcog.vSP_3_0 = simplify(diff(cog.SP_3_0, t));
vcog.vSP_4_0 = simplify(diff(cog.SP_4_0, t));
vcog.vSP_5_0 = simplify(diff(cog.SP_5_0, t));
vcog.vSP_6_0 = simplify(diff(cog.SP_6_0, t));
vcog.vSP_7_0 = simplify(diff(cog.SP_7_0, t));
vcog.vSP_8_0 = simplify(diff(cog.SP_8_0, t));
vcog.vSP_9_0 = simplify(diff(cog.SP_9_0, t));
vcog.vSP_10_0 = simplify(diff(cog.SP_10_0, t));

disp("Calculated Velocity of COGs")

%% Visual Points for Tree-Trunk
coordSys.BS_1 = coordSys.KS_10 + rotMat.T100*[5; 0; 0];
coordSys.BS_2 = coordSys.KS_10 + rotMat.T100*[-5; 0; 0];
coordSys.sumBS = [coordSys.BS_1 coordSys.BS_2];

%% Calculation of Energy
tic
% Kinetic Energy (Translation)
T_trans =  ...
    0.5*dData.mass.m1*transpose(vcog.vSP_1_0)*vcog.vSP_1_0+...    % Body 1
    0.5*dData.mass.m2*transpose(vcog.vSP_2_0)*vcog.vSP_2_0+...    % Body 2
    0.5*dData.mass.m3*transpose(vcog.vSP_3_0)*vcog.vSP_3_0+...    % Body 3
    0.5*dData.mass.m4*transpose(vcog.vSP_4_0)*vcog.vSP_4_0+...    % Body 4
    0.5*dData.mass.m5*transpose(vcog.vSP_5_0)*vcog.vSP_5_0+...    % Body 5
    0.5*dData.mass.m6*transpose(vcog.vSP_6_0)*vcog.vSP_6_0+...    % Body 6
    0.5*dData.mass.m7*transpose(vcog.vSP_7_0)*vcog.vSP_7_0+...    % Body 7
    0.5*dData.mass.m8*transpose(vcog.vSP_8_0)*vcog.vSP_8_0+...    % Body 8
    0.5*dData.mass.m9*transpose(vcog.vSP_9_0)*vcog.vSP_9_0+...    % Body 9
    0.5*dData.mass.m10*transpose(vcog.vSP_10_0)*vcog.vSP_10_0;    % Body 10
toc

disp("Calculated Translatory Energy")

tic
% Kinetic Energy (Rotation)

% Notation: angVel.omega_a_b_c ^= angVel.omega of body a in relation to
% body b in reference of CS c

% Body 1 - No rotation in reference to CS0
angVel.omega_1_0_0 = [0; 0; 0];

% Body 2 - Rotation around y_1
angVel.omega_2_1_1 = [0; diff(q_1(t), t); 0];
angVel.omega_2_1_0 = rotMat.T10 * angVel.omega_2_1_1;
angVel.omega_2_0_0 = simplify(angVel.omega_1_0_0 + angVel.omega_2_1_0);

% Body 3 - Rotation around z_2
angVel.omega_3_2_2 = [0; 0; diff(q_2(t), t)];
angVel.omega_3_2_0 = rotMat.T20 * angVel.omega_3_2_2;
angVel.omega_3_0_0 = simplify(angVel.omega_2_0_0 + angVel.omega_3_2_0);

% Body 4 - Rotation around z_3
angVel.omega_4_3_3 = [0; 0; diff(q_3(t), t)];
angVel.omega_4_3_0 = rotMat.T30 * angVel.omega_4_3_3;
angVel.omega_4_0_0 = simplify(angVel.omega_3_0_0 + angVel.omega_4_3_0);

% Body 5 - No rotation in reference to CS4
angVel.omega_5_4_4 = [0; 0; 0];
angVel.omega_5_4_0 = rotMat.T40 * angVel.omega_5_4_4;
angVel.omega_5_0_0 = simplify(angVel.omega_4_0_0 + angVel.omega_5_4_0);

% Body 6 - Rotation around z_5
angVel.omega_6_5_5 = [0; 0; simplify(diff(q_5(t), t))];
angVel.omega_6_5_0 = rotMat.T50 * angVel.omega_6_5_5;
angVel.omega_6_0_0 = simplify(angVel.omega_5_0_0 + angVel.omega_6_5_0);

% Body 7 - Rotation around y_6
angVel.omega_7_6_6 = [0; diff(q_6(t), t); 0];
angVel.omega_7_6_0 = rotMat.T60 * angVel.omega_7_6_6;
angVel.omega_7_0_0 = simplify(angVel.omega_6_0_0 + angVel.omega_7_6_0);

% Body 8 - Rotation around x_7
angVel.omega_8_7_7 = [diff(q_7(t), t); 0; 0];
angVel.omega_8_7_0 = rotMat.T70 * angVel.omega_8_7_7;
angVel.omega_8_0_0 = simplify(angVel.omega_7_0_0 + angVel.omega_8_7_0);

% Body 9 - Rotation around z_8
angVel.omega_9_8_8 = [0; 0; diff(q_8(t), t)];
angVel.omega_9_8_0 = rotMat.T80 * angVel.omega_9_8_8;
angVel.omega_9_0_0 = simplify(angVel.omega_8_0_0 + angVel.omega_9_8_0);

% Body 10 - No rotation in reference to CS9
angVel.omega_10_9_9 = [0; 0; 0];
angVel.omega_10_9_0 = rotMat.T90 * angVel.omega_10_9_9;
angVel.omega_10_0_0 = simplify(angVel.omega_9_0_0 + angVel.omega_10_9_0);

% Inertia in Inertial-Frame (MD_ExtensiveExample p.20) 
dData.mMat.mm_1_0 = rotMat.T10 * dData.mMat.mm_1_1 * transpose(rotMat.T10);
dData.mMat.mm_2_0 = rotMat.T20 * dData.mMat.mm_2_2 * transpose(rotMat.T20);
dData.mMat.mm_3_0 = rotMat.T30 * dData.mMat.mm_3_3 * transpose(rotMat.T30);
dData.mMat.mm_4_0 = rotMat.T40 * dData.mMat.mm_4_4 * transpose(rotMat.T40);
dData.mMat.mm_5_0 = rotMat.T50 * dData.mMat.mm_5_5 * transpose(rotMat.T50);
dData.mMat.mm_6_0 = rotMat.T60 * dData.mMat.mm_6_6 * transpose(rotMat.T60);
dData.mMat.mm_7_0 = rotMat.T70 * dData.mMat.mm_7_7 * transpose(rotMat.T70);
dData.mMat.mm_8_0 = rotMat.T80 * dData.mMat.mm_8_8 * transpose(rotMat.T80);
dData.mMat.mm_9_0 = rotMat.T90 * dData.mMat.mm_9_9 * transpose(rotMat.T90);
dData.mMat.mm_10_0 =rotMat.T100 * dData.mMat.mm_10_10 * transpose(rotMat.T100);

toc
tic

T_rot =  ...
    1/2 * transpose(angVel.omega_1_0_0) * dData.mMat.mm_1_0 * angVel.omega_1_0_0 + ...  % Body 1
    1/2 * transpose(angVel.omega_2_0_0) * dData.mMat.mm_2_0 * angVel.omega_2_0_0 + ...  % Body 2
    1/2 * transpose(angVel.omega_3_0_0) * dData.mMat.mm_3_0 * angVel.omega_3_0_0 + ...  % Body 3
    1/2 * transpose(angVel.omega_4_0_0) * dData.mMat.mm_4_0 * angVel.omega_4_0_0 + ...  % Body 4
    1/2 * transpose(angVel.omega_5_0_0) * dData.mMat.mm_5_0 * angVel.omega_5_0_0 + ...  % Body 5
    1/2 * transpose(angVel.omega_6_0_0) * dData.mMat.mm_6_0 * angVel.omega_6_0_0 + ...  % Body 6
    1/2 * transpose(angVel.omega_7_0_0) * dData.mMat.mm_7_0 * angVel.omega_7_0_0 + ...  % Body 7
    1/2 * transpose(angVel.omega_8_0_0) * dData.mMat.mm_8_0 * angVel.omega_8_0_0 + ...  % Body 8
    1/2 * transpose(angVel.omega_9_0_0) * dData.mMat.mm_9_0 * angVel.omega_9_0_0 + ...  % Body 9
    1/2 * transpose(angVel.omega_10_0_0) * dData.mMat.mm_10_0 * angVel.omega_10_0_0;   % Body 10

toc

disp("Calculated Rotational Energy")

% Sum of Kinetic Energy
T = T_trans + T_rot;

tic

% Potential Energy V
V = ...
    dData.mass.m1*dData.g*cog.SP_1_0(2)+...   % Body 1
    dData.mass.m2*dData.g*cog.SP_2_0(2)+...   % Body 2
    dData.mass.m3*dData.g*cog.SP_3_0(2)+...   % Body 3
    dData.mass.m4*dData.g*cog.SP_4_0(2)+...   % Body 4
    dData.mass.m5*dData.g*cog.SP_5_0(2)+...   % Body 5
    dData.mass.m6*dData.g*cog.SP_6_0(2)+...   % Body 6
    dData.mass.m7*dData.g*cog.SP_7_0(2)+...   % Body 7
    dData.mass.m8*dData.g*cog.SP_8_0(2)+...   % Body 8
    dData.mass.m9*dData.g*cog.SP_9_0(2)+...   % Body 9
    dData.mass.m10*dData.g*cog.SP_10_0(2);    % Body 10

toc

disp("Calculated Potential Energy")

%% Lagrangian Mechanics 
% only executed if all qs are free (needed for reverse calculation of
% moments and forces)

L = T - V;

% Damping d in each Joint
dData.damping.all = [15000; 15000; 10000; 0; 2000; 2000; 1000; 5000; 0]; % Translatory-Joints q4, q9 without damping
% Damping coefficients for free qs
dData.damping.free = dData.damping.all(~genCoord.logiVec);

% Setup for EOMs with all DOFs
if length(genCoord.qsFree) == 9 

    syms q1 q2 q3 q4 q5 q6 q7 q8 q9
    syms q1d q2d q3d q4d q5d q6d q7d q8d q9d
    syms q1dd q2dd q3dd q4dd q5dd q6dd q7dd q8dd q9dd

    MnF.qVec = [q1; q2; q3; q4; q5; q6; q7; q8; q9];
    MnF.qdVec = [q1d; q2d; q3d; q4d; q5d; q6d; q7d; q8d; q9d];
    MnF.qddVec = [q1dd; q2dd; q3dd; q4dd; q5dd; q6dd; q7dd; q8dd; q9dd];

    for n=1:9 %MFqn = (d/dt)(dL/dqnpkt)-(dL/dqn) + (dD/dqdt)
        Dtemp = 0.5*dData.damping.all(n)*(diff(genCoord.qsTotal(n), t))^2; % dissipation function for damping Dn = 1/2 * dn * |vrel|??
        MnF.(strcat('q_', num2str(n))) = diff(L, diff(genCoord.qsTotal(n), t), t) - diff(L, genCoord.qsTotal(n)) + ...
            diff(Dtemp, diff(genCoord.qsTotal(n), t));
        for i=1:9   % substitute diff(q_n, t, t) => qndd; diff(q_n, t) => qnd; q_n => qn / needed for subs command later
            MnF.(strcat('q_', num2str(n))) = subs(MnF.(strcat('q_', num2str(n))), diff(genCoord.qsTotal(i), t, t), MnF.qddVec(i));
            MnF.(strcat('q_', num2str(n))) = subs(MnF.(strcat('q_', num2str(n))), diff(genCoord.qsTotal(i), t), MnF.qdVec(i));
            MnF.(strcat('q_', num2str(n))) = subs(MnF.(strcat('q_', num2str(n))), genCoord.qsTotal(i), MnF.qVec(i));
        end
    end

    clearvars n i q1 q2 q3 q4 q5 q6 q7 q8 q9 q1d q2d q3d q4d q5d q6d q7d q8d q9d q1dd q2dd q3dd q4dd q5dd q6dd q7dd q8dd q9dd Dtemp

    % Function Handle
    MnF.qFunHandle = matlabFunction(MnF.q_1, MnF.q_2, MnF.q_3, MnF.q_4, MnF.q_5, MnF.q_6, MnF.q_7, MnF.q_8, MnF.q_9);
else
    % loads the EOMs with all DOFs, needed for moments and forces
    load('MnF.mat');
end


%% Lagrangian Mechanics (with definied DOFs)

% Partial derivative
for n=1:length(genCoord.qsFree)
    dqdt(n) = diff(genCoord.qsFree(n), t);
    dLdq(n) = diff(L, genCoord.qsFree(n));
    dLdqpdt(n) = diff(L, dqdt(n), t);
    
end
clearvars n

% Damping
for n=1:length(genCoord.qsFree)
    D(n) = 0.5*dData.damping.free(n)*(dqdt(n)^2); % Dn = 1/2 * dn * |vrel|??
    dDdqp(n) = diff(D(n), dqdt(n));
end

% Equations of Motion
EOMs = dLdqpdt - dLdq + dDdqp == 0;

%% Preparing Equations of Motion

% first order differentail equation
[eqs, vars] = reduceDifferentialOrder(EOMs, genCoord.qsFree);

% transform into form Mass matrix
[massMatrix, rhsVector] = massMatrixForm(eqs, vars);

% rename equations of first order

syms Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 Y9 Y10 Y11 Y12 Y13 Y14 Y15 Y16 Y17 Y18 
genCoord.vecY = [Y1; Y2; Y3; Y4; Y5; Y6; Y7; Y8; Y9; Y10; Y11; Y12; Y13; Y14; Y15; Y16; Y17; Y18];
clearvars Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 Y9 Y10 Y11 Y12 Y13 Y14 Y15 Y16 Y17 Y18
genCoord.vecY = genCoord.vecY(~[genCoord.logiVec; genCoord.logiVec]);

massMatrix = subs(massMatrix, vars, genCoord.vecY);
rhsVector = subs(rhsVector, vars, genCoord.vecY);

% create function handle
MM = matlabFunction(massMatrix, 'vars', {t, genCoord.vecY});
FF = matlabFunction(rhsVector, 'vars', {t, genCoord.vecY});

disp("EOM Vorbereitung durchgef??hrt")

%% Simulation

if length(genCoord.qsFree) == 9
    % Init for all DOFs
    simu.initCon = [deg2rad(0); deg2rad(45); deg2rad(-45); 1; deg2rad(-90); deg2rad(0); deg2rad(0); deg2rad(0); 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0];
else
    % Init for free DOFs
        simu.initCon = [deg2rad(0); deg2rad(0); deg2rad(0); deg2rad(0);...
            deg2rad(0); deg2rad(0); deg2rad(0); deg2rad(0)];
end

simu.timeInterv = [0 4];

opt = odeset('Mass', MM, 'MaxStep', 1e-2);
sol = ode45(FF, simu.timeInterv, simu.initCon, opt);
clearvars opt 

disp("Simulation abgeschlossen")

%% Combine ode results and pre-defined qs
plotData.nSteps = 100;
plotData.dT = simu.timeInterv(2)/plotData.nSteps;
plotData.time = linspace(sol.x(1),sol.x(end), plotData.nSteps);
[plotData.devalY, plotData.devalYd] = deval(sol, plotData.time);

plotData.devalY = transpose(plotData.devalY);
plotData.devalYd = transpose(plotData.devalYd);

qFreeCount = 1;
qDefinedCount = 1;

plotData.y = zeros(plotData.nSteps, 9);
plotData.yd =  zeros(plotData.nSteps, 9);
plotData.ydd =  zeros(plotData.nSteps, 9);

for n=1:9
    switch genCoord.logiVec(n)
        case 1  % pre-defined qs
            syms qTemp(t) qdTemp(t) qddTemp(t)
            qTemp(t) = genCoord.qsDefined(qDefinedCount);
            plotData.y(:,n) = [qTemp(plotData.time)]';  % q
            qdTemp(t) = diff(genCoord.qsDefined(qDefinedCount), t);
            plotData.yd(:,n) = [qdTemp(plotData.time)]'; % qdot
            qddTemp(t) = diff(genCoord.qsDefined(qDefinedCount), t, t);
            plotData.ydd(:,n) = [qddTemp(plotData.time)]'; % qdotdot
            qDefinedCount = qDefinedCount + 1;

        case 0  % ode calculated qs
            plotData.y(:,n) = plotData.devalY(:,qFreeCount);  % q
            plotData.yd(:,n) = plotData.devalY(:,qFreeCount+length(genCoord.qsFree));    % qdot
            plotData.ydd(:,n) = plotData.devalYd(:,qFreeCount+length(genCoord.qsFree));   % qdotdot
            qFreeCount = qFreeCount + 1;
    end
end
clearvars qFreeCount qDefinedCount qTemp qDotTemp n

%% Joint Torque and Forces

% Insert results (y, yd, ydd) in EOMs with all DOFs
[q1MF, q2MF, q3MF, q4MF, q5MF, q6MF, q7MF, q8MF, q9MF] = ...
    MnF.qFunHandle(plotData.y(:,1),plotData.y(:,2), plotData.y(:,3), plotData.y(:,4), plotData.y(:,5), plotData.y(:,6), plotData.y(:,7), plotData.y(:,8), plotData.y(:,9), ...
    plotData.yd(:,1),plotData.yd(:,2),plotData.yd(:,3),plotData.yd(:,4),plotData.yd(:,5),plotData.yd(:,6),plotData.yd(:,7),plotData.yd(:,8),plotData.yd(:,9), ...
    plotData.ydd(:,1),plotData.ydd(:,2),plotData.ydd(:,3),plotData.ydd(:,4),plotData.ydd(:,5),plotData.ydd(:,6),plotData.ydd(:,7),plotData.ydd(:,8),plotData.ydd(:,9));
plotData.MnF = [q1MF, q2MF, q3MF, q4MF, q5MF, q6MF, q7MF, q8MF, q9MF];
clearvars q1MF q2MF q3MF q4MF q5MF q6MF q7MF q8MF q9MF

%% Update Plot
tic;

figure('Name', 'Update Plot')

% Start Conditions
plotData.subsVec = [q_1(t) q_2(t) q_3(t) q_4(t) q_5(t) q_6(t) q_7(t) q_8(t) q_9(t) t];
CSPlotHarvTemp = subs(coordSys.sumKS, plotData.subsVec, [plotData.y(1,1:9) plotData.time(1)]);
CSPlotTreeTemp = subs(coordSys.sumBS, plotData.subsVec, [plotData.y(1,1:9) plotData.time(1)]);

% define XYZ for harvester plot
vidPlot.Harv = plot3(CSPlotHarvTemp(1),CSPlotHarvTemp(3),CSPlotHarvTemp(2),'-o');
vidPlot.Harv.XDataSource = 'CSPlotHarv_X';
vidPlot.Harv.YDataSource = 'CSPlotHarv_Y';
vidPlot.Harv.ZDataSource = 'CSPlotHarv_Z';

hold on

% define XYZ for tree plot
vidPlot.Tree = plot3(CSPlotTreeTemp(1),CSPlotTreeTemp(3),CSPlotTreeTemp(2),'-o');
vidPlot.Tree.XDataSource = 'CSPlotTree_X';
vidPlot.Tree.YDataSource = 'CSPlotTree_Y';
vidPlot.Tree.ZDataSource = 'CSPlotTree_Z';

title('0 Position')
xlabel('x-Position (m)')
ylabel('y-Position (m)')
zlabel('z-Position (m)')
% axis([-15 15 -15 15 0 15])
axis([-5 15 -15 15 0 5]) % ISO View
% axis([5 8 -2.5 2.5 0 3]) % Close Up 

% view(45, 45)
view(27, 15) % ISO Ansicht
% view(19, 24) % Close Up 1
% view(80, 17) % Close Up 2

set(gcf,'DefaultTextFontSize', 12, 'position',[50,50,1000,500]) % Big
% Frame
% set(gcf,'DefaultTextFontSize', 12, 'position',[50,50,600,300]) % Small Frame
grid

% for n = 1:1:length(plotData.y)
% for n = 1:1:68
for n = 1:1:1
    CSPlotHarvTemp = subs(coordSys.sumKS, plotData.subsVec, [plotData.y(n,1:9) plotData.time(n)]);
    CSPlotTreeTemp = subs(coordSys.sumBS, plotData.subsVec, [plotData.y(n,1:9) plotData.time(n)]);

    CSPlotHarv_X = CSPlotHarvTemp(1,:);
    CSPlotHarv_Y = CSPlotHarvTemp(3,:);
    CSPlotHarv_Z = CSPlotHarvTemp(2,:);

    CSPlotTree_X = CSPlotTreeTemp(1,:);
    CSPlotTree_Y = CSPlotTreeTemp(3,:);
    CSPlotTree_Z = CSPlotTreeTemp(2,:);

    refreshdata
    pause(0.01)
    disp(strcat('updated ', num2str(n), '/ ', num2str(length(plotData.y))))

    savestring = strcat('C:\Users\Frieder\Desktop\TreeCutV1\CloseUp1\Title\Frame_', num2str(n), '.png');
    saveas(gcf, savestring);
end

clearvars n CSPlotHarv_X CSPlotHarv_Y CSPlotHarv_Z CSPlotTree_X CSPlotTree_Y CSPlotTree_Z ...
    CSPlotHarvTemp CSPlotTreeTemp

toc

%% Plot Moments and Forces

figure('Name', 'Moments and Forces')
plot(plotData.time(1,1:68), plotData.MnF(1:68,:), 'LineWidth', 1.5)
% set(gcf, 'Position', [100 100 900 400])
xlabel('time [s]')
ylabel('Moment [Nm] / Force [N]')
title('Moments and Forces')
legend('q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'q7', 'q8', 'q9')
grid

set (gcf, 'DefaultTextFontSize', 12, 'units', 'centimeters', 'position', [0 0 17 10])


%% Plot Joint Angles

figure('Name', 'Joing Angles')
plot(plotData.time(1,1:68), rad2deg(plotData.y(1:68,[1 2 3 5 6 7 8])), 'LineWidth', 1.5)
% set(gcf, 'Position', [100 100 900 400])
xlabel('time [s]')
ylabel('Joint Angles [deg]')
title('Joint Angles')
legend('q1', 'q2', 'q3', 'q5', 'q6', 'q7', 'q8')
grid

set (gcf, 'DefaultTextFontSize', 12, 'units', 'centimeters', 'position', [0 0 17 10])