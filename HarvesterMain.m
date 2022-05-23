clc
clear
close all

%% Variablen definieren
tic;

% Winkel
syms q_1(t) q_2(t) q_3(t) q_5(t) q_6(t) q_7(t) q_8(t)

% Translation
syms q_4(t) q_9(t)

q_2(t) = deg2rad(45 + 10*sin(t));
q_3(t) = deg2rad(-45);
q_4(t) = 1;
q_9(t) = 0;

%% DESIGN DATA

dData.x_0 = 6;         % Harvester Versatz in X
dData.y_0 = 1;         % Harvester Versatz in Y
dData.z_0 = 12;        % Harvester Versatz in Z
dData.y_J12 = 0.5;     % Höhe von Body 2
dData.x_J33 = 5;       % Länge von Body 3
dData.x_J44 = 3;       % Länge von Body 4
dData.x_J66 = 0.3;     % Länge von Body 5
dData.x_J77 = 0.4;     % Länge von Body 6
dData.x_J88 = 1;       % Länge von Body 7
dData.x_J910 = 0;      % Versatz des Baumstamms
dData.g = 9.81;        % Erdbeschleunigung

% Mass
dData.mass.m1 = 9.14e+4;       % Masse Body 1
dData.mass.m2 = 2.89e+3;       % Masse Body 2
dData.mass.m3 = 1.57e+3;       % Masse Body 3
dData.mass.m4 = 2.12e+3;       % Masse Body 4
dData.mass.m5 = 6.28e+2;       % Masse Body 5
dData.mass.m6 = 9.42e+1;       % Masse Body 6
dData.mass.m7 = 1.25e+2;       % Masse Body 7
dData.mass.m8 = 7.06e+2;       % Masse Body 8
dData.mass.m9 = 3.5e+3;        % Masse Body 9
dData.mass.m10 = 1.81e+4;      % Masse Body 10

% Inertia-Matrix
dData.mMat.mm_1_1 = ...                  % Inertia-Matrix Body 1
    [5.9723210e+04 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 2.0290949e+05 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.5841635e+05];
dData.mMat.mm_2_2 = ...                  % Inertia-Matrix Body 2
    [2.3900122e+02 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 2.4195990e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 2.3900123e+02];
dData.mMat.mm_3_3 =...                   % Inertia-Matrix Body 3
    [1.0466667e+01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 3.2760667e+03 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 3.2760667e+03];
dData.mMat.mm_4_4 =...                   % Inertia-Matrix Body 4
    [3.1792500e+01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.6055213e+03 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.6055213e+03];
dData.mMat.mm_5_5 =...                   % Inertia-Matrix Body 5
    [4.1866667e+00 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 2.1142667e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 2.1142667e+02];
dData.mMat.mm_6_6 =...                   % Inertia-Matrix Body 6
    [6.2800000e-01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 1.0205000e+00 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 1.0205000e+00];
dData.mMat.mm_7_7 =...                   % Inertia-Matrix Body 7
    [8.3733333e-01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 2.0933333e+00 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 2.0933333e+00];
dData.mMat.mm_8_8 =...                   % Inertia-Matrix Body 8
    [1.0597500e+01 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 6.4173750e+01 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 6.4173750e+01];
dData.mMat.mm_9_9 =...                   % Inertia-Matrix Body 9
    [3.2205222e+02 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 3.2205223e+02 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 4.9807341e+02];
dData.mMat.mm_10_10 =...                 % Inertia-Matrix Body 10
    [1.1102300e+03 0.0000000e+00 0.0000000e+00;...
    0.0000000e+00 5.4933735e+04 0.0000000e+00;...
    0.0000000e+00 0.0000000e+00 5.4933720e+04];

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
rotMat.T20 = simplify(rotMat.rotMat.T10*rotMat.T21);
rotMat.T30 = simplify(rotMat.rotMat.T10*rotMat.T21*rotMat.T32);
rotMat.T40 = simplify(rotMat.rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43);
rotMat.T50 = simplify(rotMat.rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54);
rotMat.T60 = simplify(rotMat.rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65);
rotMat.T70 = simplify(rotMat.rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76);
rotMat.T80 = simplify(rotMat.rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76*rotMat.T87);
rotMat.T90 = simplify(rotMat.rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76*rotMat.T87*rotMat.T98);
rotMat.rotMat.T100 = simplify(rotMat.T10*rotMat.T21*rotMat.T32*rotMat.T43*rotMat.T54*rotMat.T65*rotMat.T76*rotMat.T87*rotMat.T98*rotMat.T109);

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
coordSys.KS_1 = joint.J0_0+rotMat.rotMat.T10*joint.J1_0+rotMat.rotMat.T10*joint.J1_1;
coordSys.KS_2 = coordSys.KS_1+rotMat.rotMat.T10*joint.J1_2;
coordSys.KS_3 = simplify(coordSys.KS_2+rotMat.rotMat.T20*joint.J2_2);
coordSys.KS_4 = simplify(coordSys.KS_3+rotMat.T30*joint.J3_3);
coordSys.KS_5 = simplify(coordSys.KS_4+rotMat.T40*joint.J4_4+rotMat.T40*[q_4(t); 0; 0]);
coordSys.KS_6 = simplify(coordSys.KS_5+rotMat.T50*joint.J5_5);
coordSys.KS_7 = simplify(coordSys.KS_6+rotMat.T60*joint.J6_6);
coordSys.KS_8 = simplify(coordSys.KS_7+rotMat.T70*joint.J7_7);
coordSys.KS_9 = simplify(coordSys.KS_8+rotMat.T80*joint.J8_8);
coordSys.KS_10 = simplify(coordSys.KS_9+rotMat.T90*joint.J10_9+rotMat.T90*[q_9(t); 0; 0]);

% Schwerpunkte (Position) im Inertial-Frame
cog.SP_1_0 = joint.J0_0+rotMat.rotMat.T10*joint.J1_0+rotMat.rotMat.T10*joint.J1_1+rotMat.rotMat.T10*cog.SP1_1;
cog.SP_2_0 = coordSys.KS_1+rotMat.rotMat.T10*joint.J1_2+rotMat.rotMat.T10*cog.SP2_2;
cog.SP_3_0 = simplify(coordSys.KS_3+rotMat.T30*cog.SP3_3);
cog.SP_4_0 = simplify(coordSys.KS_4+rotMat.T40*cog.SP4_4);
cog.SP_5_0 = simplify(coordSys.KS_5+rotMat.T50*cog.SP5_5);
cog.SP_6_0 = simplify(coordSys.KS_6+rotMat.T60*cog.SP6_6);
cog.SP_7_0 = simplify(coordSys.KS_7+rotMat.T70*cog.SP7_7);
cog.SP_8_0 = simplify(coordSys.KS_8+rotMat.T80*cog.SP8_8);
cog.SP_9_0 = simplify(coordSys.KS_9+rotMat.T90*cog.SP9_9);
cog.SP_10_0 = simplify(coordSys.KS_10+rotMat.rotMat.T100*cog.SP10_10);

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

% Baumstamm darstellen (Endpunkte)
BS_1 = coordSys.KS_10 + rotMat.rotMat.T100*[3; 0; 0];
BS_2 = coordSys.KS_10 + rotMat.rotMat.T100*[-3; 0; 0];


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
dData.mMat.mm_0_1 = rotMat.T10 * dData.mMat.mm_1_1 * transpose(rotMat.T10);
dData.mMat.mm_0_2 = rotMat.T20 * dData.mMat.mm_2_2 * transpose(rotMat.T20);
dData.mMat.mm_0_3 = rotMat.T30 * dData.mMat.mm_3_3 * transpose(rotMat.T30);
dData.mMat.mm_0_4 = rotMat.T40 * dData.mMat.mm_4_4 * transpose(rotMat.T40);
dData.mMat.mm_0_5 = rotMat.T50 * dData.mMat.mm_5_5 * transpose(rotMat.T50);
dData.mMat.mm_0_6 = rotMat.T60 * dData.mMat.mm_6_6 * transpose(rotMat.T60);
dData.mMat.mm_0_7 = rotMat.T70 * dData.mMat.mm_7_7 * transpose(rotMat.T70);
dData.mMat.mm_0_8 = rotMat.T80 * dData.mMat.mm_8_8 * transpose(rotMat.T80);
dData.mMat.mm_0_9 = rotMat.T90 * dData.mMat.mm_9_9 * transpose(rotMat.T90);
dData.mMat.mm_0_10 =rotMat.T100 * dData.mMat.mm_10_10 * transpose(rotMat.T100);

T_rot = simplify( ...
    1/2 * transpose(angVel.omega_1_0_0) * dData.mMat.mm_0_1 * angVel.omega_1_0_0 + ...  % Body 1
    1/2 * transpose(angVel.omega_2_0_0) * dData.mMat.mm_0_2 * angVel.omega_2_0_0 + ...  % Body 2
    1/2 * transpose(angVel.omega_3_0_0) * dData.mMat.mm_0_3 * angVel.omega_3_0_0 + ...  % Body 3
    1/2 * transpose(angVel.omega_4_0_0) * dData.mMat.mm_0_4 * angVel.omega_4_0_0 + ...  % Body 4
    1/2 * transpose(angVel.omega_5_0_0) * dData.mMat.mm_0_5 * angVel.omega_5_0_0 + ...  % Body 5
    1/2 * transpose(angVel.omega_6_0_0) * dData.mMat.mm_0_6 * angVel.omega_6_0_0 + ...  % Body 6
    1/2 * transpose(angVel.omega_7_0_0) * dData.mMat.mm_0_7 * angVel.omega_7_0_0 + ...  % Body 7
    1/2 * transpose(angVel.omega_8_0_0) * dData.mMat.mm_0_8 * angVel.omega_8_0_0 + ...  % Body 8
    1/2 * transpose(angVel.omega_9_0_0) * dData.mMat.mm_0_9 * angVel.omega_9_0_0 + ...  % Body 9
    1/2 * transpose(angVel.omega_10_0_0) * dData.mMat.mm_0_10 * angVel.omega_10_0_0);   % Body 10

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


%% Partielle Ableitungen
tic;

dTdq = ...
    [diff(T,q_1(t)) ...
    diff(T,q_5(t)) ...
    diff(T,q_6(t)) ...
    diff(T,q_7(t)) ...
    diff(T,q_8(t))];

runtime.dTdq = toc;
disp(strcat('Runtime for dTdq:', 32, num2str(runtime.dTdq)));
runtime.sum = runtime.sum + runtime.dTdq;
tic;

dqdt = ...
    [diff(q_1(t), t) ...
    diff(q_5(t), t) ...
    diff(q_6(t), t) ...
    diff(q_7(t), t) ...
    diff(q_8(t), t)];

runtime.dqdt = toc;
disp(strcat('Runtime for dqdt:', 32, num2str(runtime.dqdt)));
runtime.sum = runtime.sum + runtime.dqdt;
tic;

dTdqpktdt = ... % d/dt * (dT/dq_pkt)
    [diff(diff(T, dqdt(1)),t) ...
    diff(diff(T, dqdt(2)),t) ...
    diff(diff(T, dqdt(3)),t) ...
    diff(diff(T, dqdt(4)),t) ...
    diff(diff(T, dqdt(5)),t)];

runtime.dTdqpktdt = toc;
disp(strcat('Runtime for dTdqpktdt:', 32, num2str(runtime.dTdqpktdt)));
runtime.sum = runtime.sum + runtime.dTdqpktdt;
tic;

dVdq = ...
    [diff(V,q_1(t)) ...
    diff(V,q_5(t)) ...
    diff(V,q_6(t)) ...
    diff(V,q_7(t)) ...
    diff(V,q_8(t))];

runtime.dVdq = toc;
disp(strcat('Runtime for dVdq:', 32, num2str(runtime.dVdq)));
runtime.sum = runtime.sum + runtime.dVdq;
tic;

% Equations of Motion
syms Qs Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9
Qs = [0 0 0 0 0];
EOMs = (dTdqpktdt - dTdq + dVdq) == Qs;

runtime.eoms = toc;
disp(strcat('Runtime for EOMs:', 32, num2str(runtime.eoms)));
runtime.sum = runtime.sum + runtime.eoms;
tic;

%% Preparing Equations of Motion

qVec = [q_1(t) q_5(t) q_6(t) q_7(t) q_8(t)];

% first order differentail equation
[eqs, vars] = reduceDifferentialOrder(EOMs, transpose(qVec));

runtime.redode = toc;
disp(strcat('Runtime for reduceDifferentialOrder:', 32, num2str(runtime.redode)));
runtime.sum = runtime.sum + runtime.redode;
tic;

% transform into form Mass matrix
[massMatrix, rhsVector] = massMatrixForm(eqs, vars);

runtime.mmf = toc;
disp(strcat('Runtime for massMatrixForm:', 32, num2str(runtime.mmf)));
runtime.sum = runtime.sum + runtime.mmf;
tic;

% rename equations of first order

syms Y1 Y2 Y3 Y4 Y5 Y6 Y7 Y8 Y9 Y10 Y11 Y12 Y13 Y14 Y15 ...
    Y16 Y17 Y18 
vecY = [Y1; Y2; Y3; Y4; Y5; Y6; Y7; Y8; Y9; Y10];
massMatrix = subs(massMatrix, vars, vecY);
rhsVector = subs(rhsVector, vars, vecY);

runtime.subsmmrhs = toc;
disp(strcat('Runtime for subs in massMatrix and rhsVector:', 32, num2str(runtime.subsmmrhs)));
runtime.sum = runtime.sum + runtime.subsmmrhs;
tic;

% create function handle
MM = matlabFunction(massMatrix, 'vars', {t, vecY});
FF = matlabFunction(rhsVector, 'vars', {t, vecY});

runtime.functionhandle = toc;
disp(strcat('Runtime for matlab Function Handle:', 32, num2str(runtime.functionhandle)));
runtime.sum = runtime.sum + runtime.functionhandle;

%% Simulation
tic;

initConditions = ...
    [deg2rad(90); deg2rad(-90); deg2rad(0); deg2rad(45); deg2rad(90); 0; 0; 0; 0; 0];

opt = odeset('Mass', MM, 'MaxStep', 1e-2);
sol = ode45(FF, [0,10], initConditions, opt);

runtime.simulation = toc;
disp(strcat('Runtime for ode45 Simulation:', 32, num2str(runtime.simulation)));

%% Plot Validation (Koordinatensysteme, Schwerpunkte) 

% SP_0 = [SP_1_0 SP_2_0 SP_3_0 SP_4_0 SP_5_0 SP_6_0 SP_7_0 SP_8_0 SP_9_0 SP_10_0];
% SP_0 = subs(SP_0, qVec, [deg2rad(45) deg2rad(45) deg2rad(-45) 1 deg2rad(-90) deg2rad(0) deg2rad(45) deg2rad(90) 0]);
% 
% BS_0 = [BS_1 BS_2];
% BS_0 = subs(BS_0, qVec, [deg2rad(45) deg2rad(45) deg2rad(-45) 1 deg2rad(-90) deg2rad(0) deg2rad(45) deg2rad(90) 0]);
% 
% KS_0 = [KS_1 KS_2 KS_3 KS_4 KS_5 KS_6 KS_7 KS_8 KS_9 KS_10];
% KS_0 = subs(KS_0, qVec, [deg2rad(45) deg2rad(45) deg2rad(-45) 1 deg2rad(-90) deg2rad(0) deg2rad(45) deg2rad(90) 0]);
% 
% plot3(KS_0(1,:),KS_0(3,:),KS_0(2,:),'-o');
% hold on
% plot3(BS_0(1,:),BS_0(3,:),BS_0(2,:),'-o');
% % plot3(SP_0(1,:),SP_0(3,:),SP_0(2,:),'.');
% axis([0 20 0 20 0 15])
% grid

%% Plot Start and End of Simulation

% time = linspace(sol.x(1),sol.x(end), 30);
% y = transpose(deval(sol, time));
% 
% figure('Name', 'Start and End')
% KS_0 = [KS_1 KS_2 KS_3 KS_4 KS_5 KS_6 KS_7 KS_8 KS_9 KS_10];
% BS_0 = [BS_1 BS_2];
% 
% % Start Conditions
% KS_0_start = subs(KS_0, qVec, [y(1,1) y(1,3) y(1,5) y(1,7) y(1,9) y(1,11) y(1,13) y(1,15) y(1,17)]);
% plot3(KS_0_start(1,:),KS_0_start(3,:),KS_0_start(2,:),'-o');
% hold on
% % Final Conditions
% KS_0_end = subs(KS_0, qVec, [y(end,1) y(end,3) y(end,5) y(end,7) y(end,9) y(end,11) y(end,13) y(end,15) y(end,17)]);
% plot3(KS_0_end(1,:),KS_0_end(3,:),KS_0_end(2,:),'-o');
% axis([0 20 0 20 0 15])
% view(3, 10)
% set(gcf,'position',[100,100,1000,600])
% grid

%% Update Plot

time = linspace(sol.x(1),sol.x(end), 200);
y = transpose(deval(sol, time));

% Vorgegebene q in Ergebnisvektor einfügen
yTemp = y;
y(:,1) = yTemp(:,1);
y(:,2) = [q_2(time)]';
y(:,3) = [q_3(time)]';
y(:,4) = [q_4(time)]';
y(:,5) = yTemp(:,2);
y(:,6) = yTemp(:,3);
y(:,7) = yTemp(:,4);
y(:,8) = yTemp(:,5);
y(:,9) = [q_9(time)]';

qVec = [q_1(t) q_2(t) q_3(t) q_4(t) q_5(t) q_6(t) q_7(t) q_8(t) q_9(t) t];

figure('Name', 'Update Plot')
KS_0 = [KS_1 KS_2 KS_3 KS_4 KS_5 KS_6 KS_7 KS_8 KS_9 KS_10];

% Start Conditions
KS_0_temp = subs(KS_0, qVec, [y(1,1) y(1,2) y(1,3) y(1,4) y(1,5) y(1,6) y(1,7) y(1,8) y(1,9) time(1)]);

% XYZ definieren
KS_0_tempX = KS_0_temp(logical([1;0;0]));
KS_0_tempY = KS_0_temp(logical([0;1;0]));
KS_0_tempZ = KS_0_temp(logical([0;0;1]));

vidPlot = plot3(KS_0_tempX,KS_0_tempZ,KS_0_tempY,'-o');
vidPlot.XDataSource = 'KS_0_tempX';
vidPlot.YDataSource = 'KS_0_tempY';
vidPlot.ZDataSource = 'KS_0_tempZ';

% Baumstamm darstellen
BS_0 = [BS_1 BS_2];
BS_0_temp = subs(BS_0, qVec, [y(1,1) y(1,2) y(1,3) y(1,4) y(1,5) y(1,6) y(1,7) y(1,8) y(1,9) time(1)]);
BS_0_tempX = BS_0_temp(logical([1;0;0]));
BS_0_tempY = BS_0_temp(logical([0;1;0]));
BS_0_tempZ = BS_0_temp(logical([0;0;1]));
hold on
vidPlotBS = plot3(KS_0_tempX,KS_0_tempZ,KS_0_tempY,'-o');
vidPlotBS.XDataSource = 'BS_0_tempX';
vidPlotBS.YDataSource = 'BS_0_tempY';
vidPlotBS.ZDataSource = 'BS_0_tempZ';

axis([-15 15 0 20 -15 15])
view(-76, 17)
set(gcf,'position',[50,50,1000,900])
grid

for n = 1:1:length(y)
    KS_0_temp = subs(KS_0, qVec, [y(n,1) y(n,2) y(n,3) y(n,4) y(n,5) y(n,6) y(n,7) y(n,8) y(n,9) time(n)]);
    BS_0_temp = subs(BS_0, qVec, [y(n,1) y(n,2) y(n,3) y(n,4) y(n,5) y(n,6) y(n,7) y(n,8) y(n,9) time(n)]);

    KS_0_tempX = KS_0_temp(1,:);
    KS_0_tempY = KS_0_temp(3,:);
    KS_0_tempZ = KS_0_temp(2,:);

    BS_0_tempX = BS_0_temp(1,:);
    BS_0_tempY = BS_0_temp(3,:);
    BS_0_tempZ = BS_0_temp(2,:);

    refreshdata
    pause(0.01)
    disp(strcat('updated ', num2str(n), '%'))
end

%% Runtime Disp
runtime.sum = runtime.sum + runtime.simulation;
disp(strcat('Runtime:', 32, num2str(runtime.sum)));
