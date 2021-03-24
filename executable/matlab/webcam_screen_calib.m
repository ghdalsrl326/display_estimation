clear; clc;

center = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\center_gaze");
corner = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\corner_gaze");

x_screen = 615;%unit: mm
y_screen = 365;%unit: mm

eye_screen = [615/2,365/4,450];%unit: mm

eye_x_ccs = (sum(table2array([center(1,123:130)]))/8 + sum(table2array([center(1,151:158)]))/8) / 2; %unit: mm
eye_y_ccs = (sum(table2array([center(1,179:186)]))/8 + sum(table2array([center(1,207:214)]))/8) / 2; %unit: mm 반대
eye_z_ccs = (sum(table2array([center(1,235:242)]))/8 + sum(table2array([center(1,263:270)]))/8) / 2; %unit: mm

gaze_x_ccs = (corner.gaze_0_x + corner.gaze_1_x)/2; %unit: mm
gaze_y_ccs = (corner.gaze_0_y + corner.gaze_1_y)/2; %unit: mm
gaze_z_ccs = (corner.gaze_0_z + corner.gaze_1_z)/2; %unit: mm

alpha = atan2d(gaze_z_ccs, gaze_y_ccs);
%rho = atand((-eye_screen(2)+y_screen)/eye_screen(3))-alpha;
rho = -25;

R = [1, 0, 0; 0, cosd(rho), -sind(rho); 0, sind(rho), cosd(rho)];
%T = eye_screen' - R*[eye_x_ccs; -eye_y_ccs; eye_z_ccs];
T = [0; -365/2; -50];
new_eye_screen = R*[eye_x_ccs, eye_y_ccs, eye_z_ccs]' + T;


