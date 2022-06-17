clc
clear
close all

%% Initialisierung

% generalized coordinates
syms q_1(t) q_2(t) q_4(t) q_3(t) q_5(t) q_6(t) q_7(t) q_8(t) q_9(t)

genCoord.logiVec = logical([0; 1; 1; 1; 1; 1; 1; 1; 1]); % 1 = definiert, 0 = frei
% genCoord.logiVec = logical([0; 0; 0; 0; 0; 0; 0; 0; 0]); % 1 = definiert, 0 = frei

% q_1(t) = deg2rad(0);
q_2(t) = deg2rad(90);
q_3(t) = deg2rad(0);
q_4(t) = 1;
q_5(t) = deg2rad(0);
q_6(t) = deg2rad(0);
q_7(t) = deg2rad(0);
q_8(t) = deg2rad(0);
q_9(t) = 0;

%% Ab hier muss nichts geändert werden

% überschriebene Koordinaten
genCoord.qsTotal = [q_1(t); q_2(t); q_3(t); q_4(t); q_5(t); q_6(t); q_7(t); q_8(t); q_9(t)];
genCoord.qsDefined = genCoord.qsTotal(genCoord.logiVec);
genCoord.qsFree = genCoord.qsTotal(~genCoord.logiVec);

%% DESIGN DATA

dData.x_0 = 0;         % Harvester Versatz in X
dData.y_0 = 1;         % Harvester Versatz in Y
dData.z_0 = 0;         % Harvester Versatz in Z
dData.y_J12 = 0.5;     % Höhe von Body 2
dData.x_J33 = 5;       % Länge von Body 3
dData.x_J44 = 3;       % Länge von Body 4
dData.x_J66 = 0.3;     % Länge von Body 5
dData.x_J77 = 0.4;     % Länge von Body 6
dData.x_J88 = 1;       % Länge von Body 7
dData.x_J910 = 0;      % Versatz des Baumstamms
dData.g = 9.81;        % Erdbeschleunigung

% Mass
dData.mass.m1 = 1.67e+4;       % Masse Body 1
dData.mass.m2 = 1.17e+3;       % Masse Body 2
dData.mass.m3 = 1.11e+3;       % Masse Body 3
dData.mass.m4 = 1.48e+3;       % Masse Body 4
dData.mass.m5 = 4.10e+2;       % Masse Body 5
dData.mass.m6 = 6.93e+1;       % Masse Body 6
dData.mass.m7 = 6.93e+1;       % Masse Body 7
dData.mass.m8 = 2.42e+2;       % Masse Body 8
dData.mass.m9 = 1.60e+3;        % Masse Body 9
dData.mass.m10 = 1.17e+3;      % Masse Body 10

% Inertia-Matrix
dData.mMat.mm_1_1 = ...                  % Inertia-Matrix Body 1
    [2.0775374e+04 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 5.1254127e+04 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 4.2589749e+04];
dData.mMat.mm_2_2 = ...                  % Inertia-Matrix Body 2
    [1.8854537e+02 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.4690909e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.8854537e+02];
dData.mMat.mm_3_3 =...                   % Inertia-Matrix Body 3
    [1.0042909e+01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 2.8586474e+03 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 2.8586474e+03];
dData.mMat.mm_4_4 =...                   % Inertia-Matrix Body 4
    [3.3851210e+01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 2.5819910e+03 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 2.5819910e+03];
dData.mMat.mm_5_5 =...                   % Inertia-Matrix Body 5
    [3.6657783e+00 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.4449252e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.4449252e+02];
dData.mMat.mm_6_6 =...                   % Inertia-Matrix Body 6
    [5.6831488e-01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.0205000e+00 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 8.9035328e-01];
dData.mMat.mm_7_7 =...                   % Inertia-Matrix Body 7
    [5.6831488e-01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 8.9035328e-01 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 8.9035328e-01];
dData.mMat.mm_8_8 =...                   % Inertia-Matrix Body 8
    [5.1414109e+00 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.2875733e+01 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.2875733e+01];
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
joint.J10_9 = [dData.x_J910; 0; 0];

%% Schwerpunkte definieren (im lokalen KS des dazugehörigen Körper)

cog.SP1_1 = [0; -0.5; 0];
cog.SP2_2 = [0; -0.25; 0];
cog.SP3_3 = [2.5; 0; 0];
cog.SP4_4 = [1.5; 0; 0];
cog.SP5_5 = [-1; 0; 0];
cog.SP6_6 = [0.15; 0; 0];
cog.SP7_7 = [0.2; 0; 0];
cog.SP8_8 = [0.5; 0; 0];
cog.SP9_9 = [0; 0; 0];
cog.SP10_10 = [0; 0; 0];

%% Koordinatensysteme & Schwerpunkte im Inertial-Frame

% Koordinatensysteme (Position) im Inertial Frame
coordSys.KS_1 = joint.J0_0+rotMat.T10*joint.J1_0+rotMat.T10*joint.J1_1;
coordSys.KS_2 = coordSys.KS_1+rotMat.T10*joint.J1_2;
coordSys.KS_3 = simplify(coordSys.KS_2+rotMat.T20*joint.J2_2);
coordSys.KS_4 = simplify(coordSys.KS_3+rotMat.T30*joint.J3_3);
coordSys.KS_5 = simplify(coordSys.KS_4+rotMat.T40*joint.J4_4+rotMat.T40*[q_4(t); 0; 0]);
coordSys.KS_6 = simplify(coordSys.KS_5+rotMat.T50*joint.J5_5);
coordSys.KS_7 = simplify(coordSys.KS_6+rotMat.T60*joint.J6_6);
coordSys.KS_8 = simplify(coordSys.KS_7+rotMat.T70*joint.J7_7);
coordSys.KS_9 = simplify(coordSys.KS_8+rotMat.T80*joint.J8_8);
coordSys.KS_10 = simplify(coordSys.KS_9+rotMat.T90*joint.J10_9+rotMat.T90*[q_9(t); 0; 0]);

% Koordinatensysteme in einem Vektor zusammenfassen, wird für Plot benötigt
syms temp
coordSys.sumKS(3,1) = temp;
for n=1:10
    coordSys.sumKS(:,n) = coordSys.(strcat('KS_', num2str(n)));
end
clearvars n temp

% Schwerpunkte (Position) im Inertial-Frame
cog.SP_1_0 = joint.J0_0+rotMat.T10*joint.J1_0+rotMat.T10*joint.J1_1+rotMat.T10*cog.SP1_1;
cog.SP_2_0 = coordSys.KS_1+rotMat.T10*joint.J1_2+rotMat.T10*cog.SP2_2;
cog.SP_3_0 = simplify(coordSys.KS_3+rotMat.T30*cog.SP3_3);
cog.SP_4_0 = simplify(coordSys.KS_4+rotMat.T40*cog.SP4_4);
cog.SP_5_0 = simplify(coordSys.KS_5+rotMat.T50*cog.SP5_5);
cog.SP_6_0 = simplify(coordSys.KS_6+rotMat.T60*cog.SP6_6);
cog.SP_7_0 = simplify(coordSys.KS_7+rotMat.T70*cog.SP7_7);
cog.SP_8_0 = simplify(coordSys.KS_8+rotMat.T80*cog.SP8_8);
cog.SP_9_0 = simplify(coordSys.KS_9+rotMat.T90*cog.SP9_9);
cog.SP_10_0 = simplify(coordSys.KS_10+rotMat.T100*cog.SP10_10);

% Schwerpunkte (Geschwindigkeit)
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

%% Visuelle Punkte für Darstellung der Körper
% Baumstamm darstellen (Endpunkte)
coordSys.BS_1 = coordSys.KS_10 + rotMat.T100*[6; 0; 0];
coordSys.BS_2 = coordSys.KS_10 + rotMat.T100*[-6; 0; 0];
coordSys.sumBS = [coordSys.BS_1 coordSys.BS_2];

% Body 1
coordSys.Body_1.P1 = coordSys.KS_1 + rotMat.T10*[3; 0; 0];
coordSys.Body_1.P2 = coordSys.KS_1 + rotMat.T10*[-3; 0; 0];
coordSys.Body_1.P3 = coordSys.KS_1 + rotMat.T10*[3; 0; 2];
coordSys.Body_1.P4 = coordSys.KS_1 + rotMat.T10*[-3; 0; 2];
coordSys.Body_1.sum = [coordSys.Body_1.P1 coordSys.Body_1.P2 coordSys.Body_1.P3 coordSys.Body_1.P4];

%% Energien berechnen

% Kinetische Energie (Translation)
T_trans = simplify( ...
    0.5*dData.mass.m1*transpose(vcog.vSP_1_0)*vcog.vSP_1_0+...    % Body 1
    0.5*dData.mass.m2*transpose(vcog.vSP_2_0)*vcog.vSP_2_0+...    % Body 2
    0.5*dData.mass.m3*transpose(vcog.vSP_3_0)*vcog.vSP_3_0+...    % Body 3
    0.5*dData.mass.m4*transpose(vcog.vSP_4_0)*vcog.vSP_4_0+...    % Body 4
    0.5*dData.mass.m5*transpose(vcog.vSP_5_0)*vcog.vSP_5_0+...    % Body 5
    0.5*dData.mass.m6*transpose(vcog.vSP_6_0)*vcog.vSP_6_0+...    % Body 6
    0.5*dData.mass.m7*transpose(vcog.vSP_7_0)*vcog.vSP_7_0+...    % Body 7
    0.5*dData.mass.m8*transpose(vcog.vSP_8_0)*vcog.vSP_8_0+...    % Body 8
    0.5*dData.mass.m9*transpose(vcog.vSP_9_0)*vcog.vSP_9_0+...    % Body 9
    0.5*dData.mass.m10*transpose(vcog.vSP_10_0)*vcog.vSP_10_0);   % Body 10

%% temp

% Kinetische Energie (Rotation)

% Notation: angVel.omega_a_b_c ^= angVel.omega von Körper a in Verhältnis zu Körper b im
% Bezug auf Koordinatensystem c

% Body 1 - Keine Rotation im Verhältnis zu KS0
angVel.omega_1_0_0 = [0; 0; 0];

% Body 2 - Rotation um y_1
angVel.omega_2_1_1 = [0; diff(q_1(t), t); 0];
angVel.omega_2_1_0 = rotMat.T10 * angVel.omega_2_1_1;
angVel.omega_2_0_0 = simplify(angVel.omega_1_0_0 + angVel.omega_2_1_0);

% Body 3 - Rotation um z_2
angVel.omega_3_2_2 = [0; 0; diff(q_2(t), t)];
angVel.omega_3_2_0 = rotMat.T20 * angVel.omega_3_2_2;
angVel.omega_3_0_0 = simplify(angVel.omega_2_0_0 + angVel.omega_3_2_0);

% Body 4 - Rotation um z_3
angVel.omega_4_3_3 = [0; 0; diff(q_3(t), t)];
angVel.omega_4_3_0 = rotMat.T30 * angVel.omega_4_3_3;
angVel.omega_4_0_0 = simplify(angVel.omega_3_0_0 + angVel.omega_4_3_0);

% Body 5 - Keine Rotation im Verhältnis zu KS4
angVel.omega_5_4_4 = [0; 0; 0];
angVel.omega_5_4_0 = rotMat.T40 * angVel.omega_5_4_4;
angVel.omega_5_0_0 = simplify(angVel.omega_4_0_0 + angVel.omega_5_4_0);

% Body 6 - Rotation um z_5
angVel.omega_6_5_5 = [0; 0; diff(q_5(t), t)];
angVel.omega_6_5_0 = rotMat.T50 * angVel.omega_6_5_5;
angVel.omega_6_0_0 = simplify(angVel.omega_5_0_0 + angVel.omega_6_5_0);

% Body 7 - Rotation um y_6
angVel.omega_7_6_6 = [0; diff(q_6(t), t); 0];
angVel.omega_7_6_0 = rotMat.T60 * angVel.omega_7_6_6;
angVel.omega_7_0_0 = simplify(angVel.omega_6_0_0 + angVel.omega_7_6_0);

% Body 8 - Rotation um x_7
angVel.omega_8_7_7 = [diff(q_7(t), t); 0; 0];
angVel.omega_8_7_0 = rotMat.T70 * angVel.omega_8_7_7;
angVel.omega_8_0_0 = simplify(angVel.omega_7_0_0 + angVel.omega_8_7_0);

% Body 9 - Rotation um z_8
angVel.omega_9_8_8 = [0; 0; diff(q_8(t), t)];
angVel.omega_9_8_0 = rotMat.T80 * angVel.omega_9_8_8;
angVel.omega_9_0_0 = simplify(angVel.omega_8_0_0 + angVel.omega_9_8_0);

% Body 10 - Keine Rotation im Verhältnis zu KS9
angVel.omega_10_9_9 = [0; 0; 0];
angVel.omega_10_9_0 = rotMat.T90 * angVel.omega_10_9_9;
angVel.omega_10_0_0 = simplify(angVel.omega_9_0_0 + angVel.omega_10_9_0);

% Trägheit im Inertial-Frame (MD_ExtensiveExample S.20) 
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

T_rot = simplify( ...
    1/2 * transpose(angVel.omega_1_0_0) * dData.mMat.mm_1_0 * angVel.omega_1_0_0 + ...  % Body 1
    1/2 * transpose(angVel.omega_2_0_0) * dData.mMat.mm_2_0 * angVel.omega_2_0_0 + ...  % Body 2
    1/2 * transpose(angVel.omega_3_0_0) * dData.mMat.mm_3_0 * angVel.omega_3_0_0 + ...  % Body 3
    1/2 * transpose(angVel.omega_4_0_0) * dData.mMat.mm_4_0 * angVel.omega_4_0_0 + ...  % Body 4
    1/2 * transpose(angVel.omega_5_0_0) * dData.mMat.mm_5_0 * angVel.omega_5_0_0 + ...  % Body 5
    1/2 * transpose(angVel.omega_6_0_0) * dData.mMat.mm_6_0 * angVel.omega_6_0_0 + ...  % Body 6
    1/2 * transpose(angVel.omega_7_0_0) * dData.mMat.mm_7_0 * angVel.omega_7_0_0 + ...  % Body 7
    1/2 * transpose(angVel.omega_8_0_0) * dData.mMat.mm_8_0 * angVel.omega_8_0_0 + ...  % Body 8
    1/2 * transpose(angVel.omega_9_0_0) * dData.mMat.mm_9_0 * angVel.omega_9_0_0 + ...  % Body 9
    1/2 * transpose(angVel.omega_10_0_0) * dData.mMat.mm_10_0 * angVel.omega_10_0_0);   % Body 10


% Gesamte Kinetische Energie
T = T_trans + T_rot;

% Potentielle Energie V
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

%% Lagrangian Mechanics 
% nur ausführbar, wenn alle Freiheitsgrade offen sind

L = T - V;

% Dämpfung d in Gelenken
dData.damping.all = [15000; 15000; 10000; 0; 2000; 2000; 1000; 5000; 0]; % Translationsgelenke q4, q9 ohne Dämpfung
% Dämpfung für freie Gelenke definieren
dData.damping.free = dData.damping.all(~genCoord.logiVec);

% berechnet die Bewegungsgleichungen mit allen Freiheitsgraden (benötigt
% für Momente und Kräfte)
if length(genCoord.qsFree) == 9 

    syms q1 q2 q3 q4 q5 q6 q7 q8 q9
    syms q1d q2d q3d q4d q5d q6d q7d q8d q9d
    syms q1dd q2dd q3dd q4dd q5dd q6dd q7dd q8dd q9dd

    MnF.qVec = [q1; q2; q3; q4; q5; q6; q7; q8; q9];
    MnF.qdVec = [q1d; q2d; q3d; q4d; q5d; q6d; q7d; q8d; q9d];
    MnF.qddVec = [q1dd; q2dd; q3dd; q4dd; q5dd; q6dd; q7dd; q8dd; q9dd];

    for n=1:9 %MFqn = (d/dt)(dL/dqnpkt)-(dL/dqn) + (dD/dqdt)
        Dtemp = 0.5*dData.damping.all(n)*(diff(genCoord.qsTotal(n), t))^2; % Dissipationsfunktion für Dämpfung Dn = 1/2 * dn * |vrel|²
        MnF.(strcat('q_', num2str(n))) = diff(L, diff(genCoord.qsTotal(n), t), t) - diff(L, genCoord.qsTotal(n)) + ...
            diff(Dtemp, diff(genCoord.qsTotal(n), t));
        for i=1:9   % substituiert diff(q_n, t, t) => qndd; diff(q_n, t) => qnd; q_n => qn / wird später zum Einsetzen benötigt
            MnF.(strcat('q_', num2str(n))) = subs(MnF.(strcat('q_', num2str(n))), diff(genCoord.qsTotal(i), t, t), MnF.qddVec(i));
            MnF.(strcat('q_', num2str(n))) = subs(MnF.(strcat('q_', num2str(n))), diff(genCoord.qsTotal(i), t), MnF.qdVec(i));
            MnF.(strcat('q_', num2str(n))) = subs(MnF.(strcat('q_', num2str(n))), genCoord.qsTotal(i), MnF.qVec(i));
        end
    end

    clearvars n i q1 q2 q3 q4 q5 q6 q7 q8 q9 q1d q2d q3d q4d q5d q6d q7d q8d q9d q1dd q2dd q3dd q4dd q5dd q6dd q7dd q8dd q9dd Dtemp

    % Function Handle -> ermöglicht das Einsetzen der Ergebnisvektoren 
    MnF.qFunHandle = matlabFunction(MnF.q_1, MnF.q_2, MnF.q_3, MnF.q_4, MnF.q_5, MnF.q_6, MnF.q_7, MnF.q_8, MnF.q_9);
else
    % läd die Bewegungsgleichung für Momente und Kräfte
    load('MnF.mat');
end


%% Lagrangian Mechanics (mit eingeschränkten Freiheitsgraden)

% Partielle Ableitungen berechnen
for n=1:length(genCoord.qsFree)
    dqdt(n) = diff(genCoord.qsFree(n), t);
    dLdq(n) = diff(L, genCoord.qsFree(n));
    dLdqpdt(n) = diff(L, dqdt(n), t);
    
end
clearvars n

% Dämpfungsterm
for n=1:length(genCoord.qsFree)
    D(n) = 0.5*dData.damping.free(n)*(dqdt(n)^2); % Dn = 1/2 * dn * |vrel|²
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

%% Simulation

if length(genCoord.qsFree) == 9
    % Init für alle Freiheitsgrade
    simu.initCon = [deg2rad(0); deg2rad(45); deg2rad(-45); 1; deg2rad(-90); deg2rad(0); deg2rad(0); deg2rad(0); 0; ...
        0; 0; 0; 0; 0; 0; 0; 0; 0];
else
    % Init für eingeschränkte Freiheitsgrade
    simu.initCon = [deg2rad(0); ...
        deg2rad(0)];
end

simu.timeInterv = [0 20];

opt = odeset('Mass', MM, 'MaxStep', 1e-2);
sol = ode45(FF, simu.timeInterv, simu.initCon, opt);
clearvars opt 

%% Ergebnisvektor erstellen
plotData.nSteps = 200;
plotData.dT = simu.timeInterv(2)/plotData.nSteps;
plotData.time = linspace(sol.x(1),sol.x(end), plotData.nSteps);
[plotData.devalY, plotData.devalYd] = deval(sol, plotData.time);

plotData.devalY = transpose(plotData.devalY);
plotData.devalYd = transpose(plotData.devalYd);

% Ergebnisvektor erstellen
qFreeCount = 1;
qDefinedCount = 1;

plotData.y = zeros(plotData.nSteps, 9);
plotData.yd =  zeros(plotData.nSteps, 9);
plotData.ydd =  zeros(plotData.nSteps, 9);

for n=1:9
    switch genCoord.logiVec(n)
        case 1  % Ergebnisvektor mit definiertem q beschreiben
            syms qTemp(t) qdTemp(t) qddTemp(t)
            qTemp(t) = genCoord.qsDefined(qDefinedCount);
            plotData.y(:,n) = [qTemp(plotData.time)]';  % q
            qdTemp(t) = diff(genCoord.qsDefined(qDefinedCount), t);
            plotData.yd(:,n) = [qdTemp(plotData.time)]'; % qdot
            qddTemp(t) = diff(genCoord.qsDefined(qDefinedCount), t, t);
            plotData.ydd(:,n) = [qddTemp(plotData.time)]'; % qdotdot
            qDefinedCount = qDefinedCount + 1;

        case 0  % Ergebnisvektor mit ode-Ergebnis beschreiben
            plotData.y(:,n) = plotData.devalY(:,qFreeCount);  % q
            plotData.yd(:,n) = plotData.devalY(:,qFreeCount+length(genCoord.qsFree));    % qdot
            plotData.ydd(:,n) = plotData.devalYd(:,qFreeCount+length(genCoord.qsFree));   % qdotdot
            qFreeCount = qFreeCount + 1;
    end
end
clearvars qFreeCount qDefinedCount qTemp qDotTemp n

%% Joint Torque and Forces

% Einsetzen der Ergebnisse (y, yd, ydd) in Bewegungsgleichung mit allen Freiheitsgraden 
% zur Berechnung der Momente und Kräfte in Gelenken
[q1MF, q2MF, q3MF, q4MF, q5MF, q6MF, q7MF, q8MF, q9MF] = ...
    MnF.qFunHandle(plotData.y(:,1),plotData.y(:,2), plotData.y(:,3), plotData.y(:,4), plotData.y(:,5), plotData.y(:,6), plotData.y(:,7), plotData.y(:,8), plotData.y(:,9), ...
    plotData.yd(:,1),plotData.yd(:,2),plotData.yd(:,3),plotData.yd(:,4),plotData.yd(:,5),plotData.yd(:,6),plotData.yd(:,7),plotData.yd(:,8),plotData.yd(:,9), ...
    plotData.ydd(:,1),plotData.ydd(:,2),plotData.ydd(:,3),plotData.ydd(:,4),plotData.ydd(:,5),plotData.ydd(:,6),plotData.ydd(:,7),plotData.ydd(:,8),plotData.ydd(:,9));
plotData.MnF = [q1MF, q2MF, q3MF, q4MF, q5MF, q6MF, q7MF, q8MF, q9MF];
clearvars q1MF q2MF q3MF q4MF q5MF q6MF q7MF q8MF q9MF

%% Update Plot
tic;

figure('Name', 'Update Plot')

% Start Conditions für Harvester
plotData.subsVec = [q_1(t) q_2(t) q_3(t) q_4(t) q_5(t) q_6(t) q_7(t) q_8(t) q_9(t) t];
CSPlotHarvTemp = subs(coordSys.sumKS, plotData.subsVec, [plotData.y(1,1:9) plotData.time(1)]);
CSPlotTreeTemp = subs(coordSys.sumBS, plotData.subsVec, [plotData.y(1,1:9) plotData.time(1)]);

% for i=1:1
%     vidPlot.(strcat('Body_', num2str(i))).temp = ...
%         subs(coordSys.(strcat('Body_', num2str(i))).sum, plotData.subsVec, [plotData.y(1,1:9) plotData.time(1)]);
% end

% XYZ definieren für Harvester Plot
vidPlot.Harv = plot3(CSPlotHarvTemp(1),CSPlotHarvTemp(3),CSPlotHarvTemp(2),'-o');
vidPlot.Harv.XDataSource = 'CSPlotHarv_X';
vidPlot.Harv.YDataSource = 'CSPlotHarv_Y';
vidPlot.Harv.ZDataSource = 'CSPlotHarv_Z';

hold on

% XYZ definieren für Tree Plot
vidPlot.Tree = plot3(CSPlotTreeTemp(1),CSPlotTreeTemp(3),CSPlotTreeTemp(2),'-o');
vidPlot.Tree.XDataSource = 'CSPlotTree_X';
vidPlot.Tree.YDataSource = 'CSPlotTree_Y';
vidPlot.Tree.ZDataSource = 'CSPlotTree_Z';

% XYZ definieren für Skelette
% for n=1:1
%     vidPlot.(strcat('Body_', num2str(n))).plot = plot3(...
%         vidPlot.(strcat('Body_', num2str(n))).temp(1),...
%         vidPlot.(strcat('Body_', num2str(n))).temp(3),...
%         vidPlot.(strcat('Body_', num2str(n))).temp(2),'-o');
% 
%     vidPlot.(strcat('Body_', num2str(n))).dataString = ...
%         [strcat('Body', num2str(n),'_X'); strcat('Body', num2str(n),'_Y'); strcat('Body', num2str(n),'_Z')];
%     vidPlot.(strcat('Body_', num2str(n))).XDataSource = vidPlot.(strcat('Body_', num2str(n))).dataString(1);
%     vidPlot.(strcat('Body_', num2str(n))).YDataSource = vidPlot.(strcat('Body_', num2str(n))).dataString(2);
%     vidPlot.(strcat('Body_', num2str(n))).ZDataSource = vidPlot.(strcat('Body_', num2str(n))).dataString(3);
% end

axis([-15 15 -15 15 -15 15])
view(45, 45)
set(gcf,'position',[50,50,1000,900])
grid

for n = 1:1:length(plotData.y)
    CSPlotHarvTemp = subs(coordSys.sumKS, plotData.subsVec, [plotData.y(n,1:9) plotData.time(n)]);
    CSPlotTreeTemp = subs(coordSys.sumBS, plotData.subsVec, [plotData.y(n,1:9) plotData.time(n)]);

%     for i=1:1
%         vidPlot.(strcat('Body_', num2str(i))).temp = ...
%             subs(coordSys.(strcat('Body_', num2str(i))).sum, plotData.subsVec, [plotData.y(n,1:9) plotData.time(n)]);
%         vidPlot.(strcat('Body_', num2str(i))).dataString(1) = vidPlot.(strcat('Body_', num2str(i))).temp(1,:);
%         vidPlot.(strcat('Body_', num2str(i))).dataString(2) = vidPlot.(strcat('Body_', num2str(i))).temp(3,:);
%         vidPlot.(strcat('Body_', num2str(i))).dataString(3) = vidPlot.(strcat('Body_', num2str(i))).temp(2,:);
% 
%     end

    CSPlotHarv_X = CSPlotHarvTemp(1,:);
    CSPlotHarv_Y = CSPlotHarvTemp(3,:);
    CSPlotHarv_Z = CSPlotHarvTemp(2,:);

    CSPlotTree_X = CSPlotTreeTemp(1,:);
    CSPlotTree_Y = CSPlotTreeTemp(3,:);
    CSPlotTree_Z = CSPlotTreeTemp(2,:);

    refreshdata
    pause(0.01)
    disp(strcat('updated ', num2str(n), '/ ', num2str(length(plotData.y))))
end

clearvars n CSPlotHarv_X CSPlotHarv_Y CSPlotHarv_Z CSPlotTree_X CSPlotTree_Y CSPlotTree_Z ...
    CSPlotHarvTemp CSPlotTreeTemp

toc

%% Plot Moments and Forces

figure('Name', 'Moments and Forces')
plot(plotData.time, plotData.MnF)
set(gcf, 'Position', [100 100 900 400])
xlabel('time [s]')
ylabel('Moment [Nm] / Force [N]')
title('Moments and Forces')
legend('q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'q7', 'q8', 'q9')
grid
