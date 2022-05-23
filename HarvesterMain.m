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

% Designgrößen
syms x_0 y_0 z_0 y_J12 x_J33 x_J44 x_J66 x_J77 x_J88 x_J910 g

x_0 = subs(x_0, 6);             % Harvester Versatz in X
y_0 = subs(y_0, 1);             % Harvester Versatz in Y
z_0 = subs(z_0, 12);            % Harvester Versatz in Z
y_J12 = subs(y_J12, 0.5);       
x_J33 = subs(x_J33, 5);
x_J44 = subs(x_J44, 3);
x_J66 = subs(x_J66, 0.3);
x_J77 = subs(x_J77, 0.4);
x_J88 = subs(x_J88, 1);
x_J910 = subs(x_J910, 0);
g = subs(g, 9.81);

designData.x_0 = 6;         % Harvester Versatz in X
designData.y_0 = 1;         % Harvester Versatz in Y
designData.z_0 = 12;        % Harvester Versatz in Z
designData.y_J12 = 0.5;     % Höhe von Body 2
designData.x_J33 = 5;       % Länge von Body 3
designData.x_J44 = 3;       % Länge von Body 4
designData.x_J66 = 0.3;     % Länge von Body 5
designData.x_J77 = 0.4;     % Länge von Body 6
designData.x_J88 = 1;       % Länge von Body 7
designData.x_J910 = 0;      % Versatz des Baumstamms
designData.g = 9.81;        % Erdbeschleunigung


% Massen
syms m_1 m_2 m_3 m_4 m_5 m_6 m_7 m_8 m_9 m_10 

m_1 = subs(m_1, 9.14e+4);
m_2 = subs(m_2, 2.89e+3);
m_3 = subs(m_3, 1.57e+3);
m_4 = subs(m_4, 2.12e+3);
m_5 = subs(m_5, 6.28e+2);
m_6 = subs(m_6, 9.42e+1);
m_7 = subs(m_7, 1.25e+2);
m_8 = subs(m_8, 7.06e+2);
m_9 = subs(m_9, 3.5e+3);
m_10 = subs(m_10, 1.81e+4);

% Trägheitstensoren
for n=1:1
    syms mm_1_1 mm_1_1_xx mm_1_1_xy mm_1_1_xz mm_1_1_yx mm_1_1_yy mm_1_1_yz ...
        mm_1_1_zx mm_1_1_zy mm_1_1_zz
    syms mm_2_2 mm_2_2_xx mm_2_2_xy mm_2_2_xz mm_2_2_yx mm_2_2_yy mm_2_2_yz ...
        mm_2_2_zx mm_2_2_zy mm_2_2_zz
    syms mm_3_3 mm_3_3_xx mm_3_3_xy mm_3_3_xz mm_3_3_yx mm_3_3_yy mm_3_3_yz ...
        mm_3_3_zx mm_3_3_zy mm_3_3_zz
    syms mm_4_4 mm_4_4_xx mm_4_4_xy mm_4_4_xz mm_4_4_yx mm_4_4_yy mm_4_4_yz ...
        mm_4_4_zx mm_4_4_zy mm_4_4_zz
    syms mm_5_5 mm_5_5_xx mm_5_5_xy mm_5_5_xz mm_5_5_yx mm_5_5_yy mm_5_5_yz ...
        mm_5_5_zx mm_5_5_zy mm_5_5_zz
    syms mm_6_6 mm_6_6_xx mm_6_6_xy mm_6_6_xz mm_6_6_yx mm_6_6_yy mm_6_6_yz ...
        mm_6_6_zx mm_6_6_zy mm_6_6_zz
    syms mm_7_7 mm_7_7_xx mm_7_7_xy mm_7_7_xz mm_7_7_yx mm_7_7_yy mm_7_7_yz ...
        mm_7_7_zx mm_7_7_zy mm_7_7_zz
    syms mm_8_8 mm_8_8_xx mm_8_8_xy mm_8_8_xz mm_8_8_yx mm_8_8_yy mm_8_8_yz ...
        mm_8_8_zx mm_8_8_zy mm_8_8_zz
    syms mm_9_9 mm_9_9_xx mm_9_9_xy mm_9_9_xz mm_9_9_yx mm_9_9_yy mm_9_9_yz ...
        mm_9_9_zx mm_9_9_zy mm_9_9_zz
    syms mm_10_10 mm_10_10_xx mm_10_10_xy mm_10_10_xz mm_10_10_yx mm_10_10_yy mm_10_10_yz ...
        mm_10_10_zx mm_10_10_zy mm_10_10_zz

    mm_1_1 = [mm_1_1_xx mm_1_1_xy mm_1_1_xz; mm_1_1_yx mm_1_1_yy mm_1_1_yz; ...
        mm_1_1_zx mm_1_1_zy mm_1_1_zz];
    mm_2_2 = [mm_2_2_xx mm_2_2_xy mm_2_2_xz; mm_2_2_yx mm_2_2_yy mm_2_2_yz; ...
        mm_2_2_zx mm_2_2_zy mm_2_2_zz];
    mm_3_3 = [mm_3_3_xx mm_3_3_xy mm_3_3_xz; mm_3_3_yx mm_3_3_yy mm_3_3_yz; ...
        mm_3_3_zx mm_3_3_zy mm_3_3_zz];
    mm_4_4 = [mm_4_4_xx mm_4_4_xy mm_4_4_xz; mm_4_4_yx mm_4_4_yy mm_4_4_yz; ...
        mm_4_4_zx mm_4_4_zy mm_4_4_zz];
    mm_5_5 = [mm_5_5_xx mm_5_5_xy mm_5_5_xz; mm_5_5_yx mm_5_5_yy mm_5_5_yz; ...
        mm_5_5_zx mm_5_5_zy mm_5_5_zz];
    mm_6_6 = [mm_6_6_xx mm_6_6_xy mm_6_6_xz; mm_6_6_yx mm_6_6_yy mm_6_6_yz; ...
        mm_6_6_zx mm_6_6_zy mm_6_6_zz];
    mm_7_7 = [mm_7_7_xx mm_7_7_xy mm_7_7_xz; mm_7_7_yx mm_7_7_yy mm_7_7_yz; ...
        mm_7_7_zx mm_7_7_zy mm_7_7_zz];
    mm_8_8 = [mm_8_8_xx mm_8_8_xy mm_8_8_xz; mm_8_8_yx mm_8_8_yy mm_8_8_yz; ...
        mm_8_8_zx mm_8_8_zy mm_8_8_zz];
    mm_9_9 = [mm_9_9_xx mm_9_9_xy mm_9_9_xz; mm_9_9_yx mm_9_9_yy mm_9_9_yz; ...
        mm_9_9_zx mm_9_9_zy mm_9_9_zz];
    mm_10_10 = [mm_10_10_xx mm_10_10_xy mm_10_10_xz; mm_10_10_yx mm_10_10_yy mm_10_10_yz; ...
        mm_10_10_zx mm_10_10_zy mm_10_10_zz];
end

% Werte den Trägheitstensoren zuweisen
for n=1:1
    realMM.mm_1_1 = ...
        [5.9723210e+04 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 2.0290949e+05 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 1.5841635e+05];
    realMM.mm_2_2 = ...
        [2.3900122e+02 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 2.4195990e+02 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 2.3900123e+02];
    realMM.mm_3_3 =...
        [1.0466667e+01 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 3.2760667e+03 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 3.2760667e+03];
    realMM.mm_4_4 =...
        [3.1792500e+01 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 1.6055213e+03 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 1.6055213e+03];
    realMM.mm_5_5 =...
        [4.1866667e+00 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 2.1142667e+02 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 2.1142667e+02];
    realMM.mm_6_6 =...
        [6.2800000e-01 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 1.0205000e+00 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 1.0205000e+00];
    realMM.mm_7_7 =...
        [8.3733333e-01 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 2.0933333e+00 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 2.0933333e+00];
    realMM.mm_8_8 =...
        [1.0597500e+01 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 6.4173750e+01 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 6.4173750e+01];
    realMM.mm_9_9 =...
        [3.2205222e+02 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 3.2205223e+02 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 4.9807341e+02];
    realMM.mm_10_10 =...
        [1.1102300e+03 0.0000000e+00 0.0000000e+00...
        0.0000000e+00 5.4933735e+04 0.0000000e+00...
        0.0000000e+00 0.0000000e+00 5.4933720e+04];

    mm_1_1 = subs(mm_1_1, [mm_1_1_xx mm_1_1_xy mm_1_1_xz mm_1_1_yx mm_1_1_yy mm_1_1_yz ...
        mm_1_1_zx mm_1_1_zy mm_1_1_zz], realMM.mm_1_1);
    mm_2_2 = subs(mm_2_2, [mm_2_2_xx mm_2_2_xy mm_2_2_xz mm_2_2_yx mm_2_2_yy mm_2_2_yz ...
        mm_2_2_zx mm_2_2_zy mm_2_2_zz], realMM.mm_2_2);
    mm_3_3 = subs(mm_3_3, [mm_3_3_xx mm_3_3_xy mm_3_3_xz mm_3_3_yx mm_3_3_yy mm_3_3_yz ...
        mm_3_3_zx mm_3_3_zy mm_3_3_zz], realMM.mm_3_3);
    mm_4_4 = subs(mm_4_4, [mm_4_4_xx mm_4_4_xy mm_4_4_xz mm_4_4_yx mm_4_4_yy mm_4_4_yz ...
        mm_4_4_zx mm_4_4_zy mm_4_4_zz], realMM.mm_4_4);
    mm_5_5 = subs(mm_5_5, [mm_5_5_xx mm_5_5_xy mm_5_5_xz mm_5_5_yx mm_5_5_yy mm_5_5_yz ...
        mm_5_5_zx mm_5_5_zy mm_5_5_zz], realMM.mm_5_5);
    mm_6_6 = subs(mm_6_6, [mm_6_6_xx mm_6_6_xy mm_6_6_xz mm_6_6_yx mm_6_6_yy mm_6_6_yz ...
        mm_6_6_zx mm_6_6_zy mm_6_6_zz], realMM.mm_6_6);
    mm_7_7 = subs(mm_7_7, [mm_7_7_xx mm_7_7_xy mm_7_7_xz mm_7_7_yx mm_7_7_yy mm_7_7_yz ...
        mm_7_7_zx mm_7_7_zy mm_7_7_zz], realMM.mm_7_7);
    mm_8_8 = subs(mm_8_8, [mm_8_8_xx mm_8_8_xy mm_8_8_xz mm_8_8_yx mm_8_8_yy mm_8_8_yz ...
        mm_8_8_zx mm_8_8_zy mm_8_8_zz], realMM.mm_8_8);
    mm_9_9 = subs(mm_9_9, [mm_9_9_xx mm_9_9_xy mm_9_9_xz mm_9_9_yx mm_9_9_yy mm_9_9_yz ...
        mm_9_9_zx mm_9_9_zy mm_9_9_zz], realMM.mm_9_9);
    mm_10_10 = subs(mm_10_10, [mm_10_10_xx mm_10_10_xy mm_10_10_xz mm_10_10_yx mm_10_10_yy mm_10_10_yz ...
        mm_10_10_zx mm_10_10_zy mm_10_10_zz], realMM.mm_10_10);
end


runtime.massmatrix = toc;
disp(strcat('Runtime for Massmatrix:', 32, num2str(runtime.massmatrix)));
runtime.sum = runtime.massmatrix;
tic;
%% Drehmatrizen definieren

% Lokale Drehmatrizen
T10 = [1 0 0; 0 1 0; 0 0 1];
T21 = [cos(q_1(t)) 0 sin(q_1(t)); 0 1 0; -sin(q_1(t)) 0 cos(q_1(t))];
T32 = [cos(q_2(t)) -sin(q_2(t)) 0; sin(q_2(t)) cos(q_2(t)) 0; 0 0 1];
T43 = [cos(q_3(t)) -sin(q_3(t)) 0; sin(q_3(t)) cos(q_3(t)) 0; 0 0 1];
T54 = [1 0 0; 0 1 0; 0 0 1];
T65 = [cos(q_5(t)) -sin(q_5(t)) 0; sin(q_5(t)) cos(q_5(t)) 0; 0 0 1];
T76 = [cos(q_6(t)) 0 sin(q_6(t)); 0 1 0; -sin(q_6(t)) 0 cos(q_6(t))];
T87 = [1 0 0; 0 cos(q_7(t)) -sin(q_7(t)); 0 sin(q_7(t)) cos(q_7(t))];
T98 = [cos(q_8(t)) -sin(q_8(t)) 0; sin(q_8(t)) cos(q_8(t)) 0; 0 0 1];
T109 = [1 0 0; 0 1 0; 0 0 1];

% Drehmatrizen für Ursprung
T20 = simplify(T10*T21);
T30 = simplify(T10*T21*T32);
T40 = simplify(T10*T21*T32*T43);
T50 = simplify(T10*T21*T32*T43*T54);
T60 = simplify(T10*T21*T32*T43*T54*T65);
T70 = simplify(T10*T21*T32*T43*T54*T65*T76);
T80 = simplify(T10*T21*T32*T43*T54*T65*T76*T87);
T90 = simplify(T10*T21*T32*T43*T54*T65*T76*T87*T98);
T100 = simplify(T10*T21*T32*T43*T54*T65*T76*T87*T98*T109);

runtime.rotationmatrix = toc;
disp(strcat('Runtime for Rotation Matrix:', 32, num2str(runtime.rotationmatrix)));
runtime.sum = runtime.sum + runtime.rotationmatrix;
tic;

%% Gelenke definieren

J0_0 = [x_0; y_0; z_0];
J1_0 = [0; 0; 0];
J1_1 = [0; 0; 0];
J1_2 = [0; y_J12; 0];
J2_2 = [0; 0; 0];
J3_3 = [x_J33; 0; 0];
J4_4 = [x_J44; 0; 0];
J5_5 = [0; 0; 0];
J6_6 = [x_J66; 0; 0];
J7_7 = [x_J77; 0; 0];
J8_8 = [x_J88; 0; 0];
J10_9 = [x_J910; 0; 0];


%% Schwerpunkte definieren (im lokalen KS des dazugehörigen Körper)

SP1_1 = [0; -0.5; 0];
SP2_2 = [0; -0.25; 0];
SP3_3 = [2.5; 0; 0];
SP4_4 = [1.5; 0; 0];
SP5_5 = [-1; 0; 0];
SP6_6 = [0.15; 0; 0];
SP7_7 = [0.2; 0; 0];
SP8_8 = [0.5; 0; 0];
SP9_9 = [0; 0; 0];
SP10_10 = [0; 0; 0];

%% Koordinatensysteme & Schwerpunkte im Inertial-Frame

% Koordinatensysteme (Position) im Inertial Frame
KS_1 = simplify(J0_0+T10*J1_0+T10*J1_1);
KS_2 = simplify(KS_1+T10*J1_2);
KS_3 = simplify(KS_2+T20*J2_2);
KS_4 = simplify(KS_3+T30*J3_3);
KS_5 = simplify(KS_4+T40*J4_4+T40*[q_4(t); 0; 0]);
KS_6 = simplify(KS_5+T50*J5_5);
KS_7 = simplify(KS_6+T60*J6_6);
KS_8 = simplify(KS_7+T70*J7_7);
KS_9 = simplify(KS_8+T80*J8_8);
KS_10 = simplify(KS_9+T90*J10_9+T90*[q_9(t); 0; 0]);

% Schwerpunkte (Position) im Inertial-Frame
SP_1_0 = simplify(J0_0+T10*J1_0+T10*J1_1+T10*SP1_1);
SP_2_0 = simplify(KS_1+T10*J1_2+T10*SP2_2);
SP_3_0 = simplify(KS_3+T30*SP3_3);
SP_4_0 = simplify(KS_4+T40*SP4_4);
SP_5_0 = simplify(KS_5+T50*SP5_5);
SP_6_0 = simplify(KS_6+T60*SP6_6);
SP_7_0 = simplify(KS_7+T70*SP7_7);
SP_8_0 = simplify(KS_8+T80*SP8_8);
SP_9_0 = simplify(KS_9+T90*SP9_9);
SP_10_0 = simplify(KS_10+T100*SP10_10);

% Schwerpunkte (Geschwindigkeit)
vSP_1_0 = simplify(diff(SP_1_0, t));
vSP_2_0 = simplify(diff(SP_2_0, t));
vSP_3_0 = simplify(diff(SP_3_0, t));
vSP_4_0 = simplify(diff(SP_4_0, t));
vSP_5_0 = simplify(diff(SP_5_0, t));
vSP_6_0 = simplify(diff(SP_6_0, t));
vSP_7_0 = simplify(diff(SP_7_0, t));
vSP_8_0 = simplify(diff(SP_8_0, t));
vSP_9_0 = simplify(diff(SP_9_0, t));
vSP_10_0 = simplify(diff(SP_10_0, t));

% Baumstamm darstellen (Endpunkte)
BS_1 = KS_10 + T100*[3; 0; 0];
BS_2 = KS_10 + T100*[-3; 0; 0];

runtime.cs = toc;
disp(strcat('Runtime for Coordinate-Systems and COG:', 32, num2str(runtime.cs)));
runtime.sum = runtime.sum + runtime.cs;
tic;

%% Energien berechnen

% Kinetische Energie (Translation)
T_trans = simplify( ...
    0.5*m_1*transpose(vSP_1_0)*vSP_1_0+...  % Body 1
    0.5*m_2*transpose(vSP_2_0)*vSP_2_0+...  % Body 2
    0.5*m_3*transpose(vSP_3_0)*vSP_3_0+...  % Body 3
    0.5*m_4*transpose(vSP_4_0)*vSP_4_0+...  % Body 4
    0.5*m_5*transpose(vSP_5_0)*vSP_5_0+...  % Body 5
    0.5*m_6*transpose(vSP_6_0)*vSP_6_0+...  % Body 6
    0.5*m_7*transpose(vSP_7_0)*vSP_7_0+...  % Body 7
    0.5*m_8*transpose(vSP_8_0)*vSP_8_0+...  % Body 8
    0.5*m_9*transpose(vSP_9_0)*vSP_9_0+...  % Body 9
    0.5*m_10*transpose(vSP_10_0)*vSP_10_0);   % Body 10

runtime.trans = toc;
disp(strcat('Runtime for Kinetic Trans:', 32, num2str(runtime.trans)));
runtime.sum = runtime.sum + runtime.trans;
tic;

% Kinetische Energie (Rotation)

% Notation: omega_a_b_c ^= omega von Körper a in Verhältnis zu Körper b im
% Bezug auf Koordinatensystem c

% Body 1 - Keine Rotation im Verhältnis zu KS0
omega_1_0_0 = [0; 0; 0];

% Body 2 - Rotation um y_1
omega_2_1_1 = [0; diff(q_1(t), t); 0];
omega_2_1_0 = T10 * omega_2_1_1;
omega_2_0_0 = simplify(omega_1_0_0 + omega_2_1_0);

% Body 3 - Rotation um z_2
omega_3_2_2 = [0; 0; diff(q_2(t), t)];
omega_3_2_0 = T20 * omega_3_2_2;
omega_3_0_0 = simplify(omega_2_0_0 + omega_3_2_0);

% Body 4 - Rotation um z_3
omega_4_3_3 = [0; 0; diff(q_3(t), t)];
omega_4_3_0 = T30 * omega_4_3_3;
omega_4_0_0 = simplify(omega_3_0_0 + omega_4_3_0);

% Body 5 - Keine Rotation im Verhältnis zu KS4
omega_5_4_4 = [0; 0; 0];
omega_5_4_0 = T40 * omega_5_4_4;
omega_5_0_0 = simplify(omega_4_0_0 + omega_5_4_0);

% Body 6 - Rotation um z_5
omega_6_5_5 = [0; 0; diff(q_5(t), t)];
omega_6_5_0 = T50 * omega_6_5_5;
omega_6_0_0 = simplify(omega_5_0_0 + omega_6_5_0);

% Body 7 - Rotation um y_6
omega_7_6_6 = [0; diff(q_6(t), t); 0];
omega_7_6_0 = T60 * omega_7_6_6;
omega_7_0_0 = simplify(omega_6_0_0 + omega_7_6_0);

% Body 8 - Rotation um x_7
omega_8_7_7 = [diff(q_7(t), t); 0; 0];
omega_8_7_0 = T70 * omega_8_7_7;
omega_8_0_0 = simplify(omega_7_0_0 + omega_8_7_0);

% Body 9 - Rotation um z_8
omega_9_8_8 = [0; 0; diff(q_8(t), t)];
omega_9_8_0 = T80 * omega_9_8_8;
omega_9_0_0 = simplify(omega_8_0_0 + omega_9_8_0);

% Body 10 - Keine Rotation im Verhältnis zu KS9
omega_10_9_9 = [0; 0; 0];
omega_10_9_0 = T90 * omega_10_9_9;
omega_10_0_0 = simplify(omega_9_0_0 + omega_10_9_0);

% Trägheit im Inertial-Frame (MD_ExtensiveExample S.20) 
mm_0_1 = T10 * mm_1_1 * transpose(T10);
mm_0_2 = T20 * mm_2_2 * transpose(T20);
mm_0_3 = T30 * mm_3_3 * transpose(T30);
mm_0_4 = T40 * mm_4_4 * transpose(T40);
mm_0_5 = T50 * mm_5_5 * transpose(T50);
mm_0_6 = T60 * mm_6_6 * transpose(T60);
mm_0_7 = T70 * mm_7_7 * transpose(T70);
mm_0_8 = T80 * mm_8_8 * transpose(T80);
mm_0_9 = T90 * mm_9_9 * transpose(T90);
mm_0_10 =T100 * mm_10_10 * transpose(T100);

T_rot = simplify( ...
    1/2 * transpose(omega_1_0_0) * mm_0_1 * omega_1_0_0 + ... % Body 1
    1/2 * transpose(omega_2_0_0) * mm_0_2 * omega_2_0_0 + ... % Body 2
    1/2 * transpose(omega_3_0_0) * mm_0_3 * omega_3_0_0 + ... % Body 3
    1/2 * transpose(omega_4_0_0) * mm_0_4 * omega_4_0_0 + ... % Body 4
    1/2 * transpose(omega_5_0_0) * mm_0_5 * omega_5_0_0 + ... % Body 5
    1/2 * transpose(omega_6_0_0) * mm_0_6 * omega_6_0_0 + ... % Body 6
    1/2 * transpose(omega_7_0_0) * mm_0_7 * omega_7_0_0 + ... % Body 7
    1/2 * transpose(omega_8_0_0) * mm_0_8 * omega_8_0_0 + ... % Body 8
    1/2 * transpose(omega_9_0_0) * mm_0_9 * omega_9_0_0 + ... % Body 9
    1/2 * transpose(omega_10_0_0) * mm_0_10 * omega_10_0_0);   % Body 10

runtime.rot = toc;
disp(strcat('Runtime for Kinetic Rot:', 32, num2str(runtime.rot)));
runtime.sum = runtime.sum + runtime.rot;
tic;
    

% Gesamte Kinetische Energie
T = T_trans + T_rot;



% Potentielle Energie V
V = ...
    m_1*g*SP_1_0(2)+...   % Body 1
    m_2*g*SP_2_0(2)+...   % Body 2
    m_3*g*SP_3_0(2)+...   % Body 3
    m_4*g*SP_4_0(2)+...   % Body 4
    m_5*g*SP_5_0(2)+...   % Body 5
    m_6*g*SP_6_0(2)+...   % Body 6
    m_7*g*SP_7_0(2)+...   % Body 7
    m_8*g*SP_8_0(2)+...   % Body 8
    m_9*g*SP_9_0(2)+...   % Body 9
    m_10*g*SP_10_0(2);    % Body 10


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
