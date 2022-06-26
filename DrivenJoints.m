syms t
time = linspace(0, 5, 1000);

% k1 = 0.2;
% k2 = 1.2;
% ke = 2;
% ka = -10;

% Verlauf
% t(0-k1) = 0 Gelenkt bewegt sicht die erste Sekunde nicht
% t(k1-k2) = linear von 0 auf -10
% t(k2-10) = -10

% testQ1(t) = deg2rad((0 * heaviside(-t+k1)) ...
%     + heaviside(t-k1) * (((ka/2) * cos(kt*(t-k1)))-ka/2) * heaviside(-t+k2) ...
%     + heaviside(t-k2) * -ka);

% testQ1(t) = deg2rad((ke * heaviside(-t+k1)) ...
%     + heaviside(t-k1) * ((t-k1)*(ka-ke)/(k2-k1)+ke) * heaviside(-t+k2) ...
%     + heaviside(t-k2) * ka);

drivenJoints.t = [0 1.5];
drivenJoints.q2 = [0 -10];

testQ1(t) = deg2rad((drivenJoints.q2(1) * heaviside(-t+drivenJoints.t(1))) ...
    + heaviside(t-drivenJoints.t(1)) * ((t-drivenJoints.t(1))*(drivenJoints.q2(2)-drivenJoints.q2(1))/(drivenJoints.t(2)-drivenJoints.t(1))+drivenJoints.q2(1)) * heaviside(-t+drivenJoints.t(2)) ...
    + heaviside(t-drivenJoints.t(2)) * drivenJoints.q2(2));

% testQ1(t) = ((drivenJoints.q1(2)-drivenJoints.q1(1))/(drivenJoints.t(2)-drivenJoints.t(1)))*t + drivenJoints.q1(1);

testQ1d(t) = simplify(diff(testQ1, t));
testQ1dd(t) = simplify(diff(testQ1d, t));

plot(time, testQ1(time), time, testQ1d(time), time, testQ1dd(time))


%% Backup

% q_1(t) = deg2rad(drivenJoints.q1(2)-drivenJoints.q1(1))/(drivenJoints.t(2)-drivenJoints.t(1))+drivenJoints.q1(1));
% q_2(t) = deg2rad((drivenJoints.q2(1) * heaviside(-t+drivenJoints.t(1))) ...
%     + heaviside(t-drivenJoints.t(1)) * ((t-drivenJoints.t(1))*(drivenJoints.q2(2)-drivenJoints.q2(1))/(drivenJoints.t(2)-drivenJoints.t(1))+drivenJoints.q2(1)) * heaviside(-t+drivenJoints.t(2)) ...
%     + heaviside(t-drivenJoints.t(2)) * drivenJoints.q2(2));
% q_3(t) = deg2rad((drivenJoints.q3(1) * heaviside(-t+drivenJoints.t(1))) ...
%     + heaviside(t-drivenJoints.t(1)) * ((t-drivenJoints.t(1))*(drivenJoints.q3(2)-drivenJoints.q3(1))/(drivenJoints.t(2)-drivenJoints.t(1))+drivenJoints.q3(1)) * heaviside(-t+drivenJoints.t(2)) ...
%     + heaviside(t-drivenJoints.t(2)) * drivenJoints.q3(2));
% q_4(t) = deg2rad((drivenJoints.q4(1) * heaviside(-t+drivenJoints.t(1))) ...
%     + heaviside(t-drivenJoints.t(1)) * ((t-drivenJoints.t(1))*(drivenJoints.q4(2)-drivenJoints.q4(1))/(drivenJoints.t(2)-drivenJoints.t(1))+drivenJoints.q4(1)) * heaviside(-t+drivenJoints.t(2)) ...
%     + heaviside(t-drivenJoints.t(2)) * drivenJoints.q4(2));
% q_9(t) = 4.5;


% drivenJoints.t = [0 1.5];
% drivenJoints.q1 = [0 -10];
% drivenJoints.q2 = [50 57];
% drivenJoints.q3 = [-100 -88];
% drivenJoints.q4 = [1.5 1.3];
% 
% q_1(t) = deg2rad(((drivenJoints.q1(2)-drivenJoints.q1(1))/(drivenJoints.t(2)-drivenJoints.t(1)))*t + drivenJoints.q1(1));
% q_2(t) = deg2rad(((drivenJoints.q2(2)-drivenJoints.q2(1))/(drivenJoints.t(2)-drivenJoints.t(1)))*t + drivenJoints.q2(1));
% q_3(t) = deg2rad(((drivenJoints.q3(2)-drivenJoints.q3(1))/(drivenJoints.t(2)-drivenJoints.t(1)))*t + drivenJoints.q3(1));
% q_4(t) = deg2rad(((drivenJoints.q4(2)-drivenJoints.q4(1))/(drivenJoints.t(2)-drivenJoints.t(1)))*t + drivenJoints.q4(1));
% q_9(t) = 4.2;


