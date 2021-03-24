clear; clc; close all;

LT_1 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_1_LT");
RT_2 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_2_RT");
LD_3 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_3_LD");
RD_4 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_4_RD");
LT_5 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_5_LT");
RT_6 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_6_RT");
LD_7 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_7_LD");
RD_8 = readtable("C:\MinkiHong\M1013\OpenFace_2.2.0_win_x64\OpenFace_2.2.0_win_x64\processed\TEST_8_RD");


[head_origin_LT, head_direction_LT, eye_origin_LT, gaze_vector_LT] = calibration_import_module(LT_1);
[head_origin_RT, head_direction_RT, eye_origin_RT, gaze_vector_RT] = calibration_import_module(RT_2);
[head_origin_LD, head_direction_LD, eye_origin_LD, gaze_vector_LD] = calibration_import_module(LD_3);
[head_origin_RD, head_direction_RD, eye_origin_RD, gaze_vector_RD] = calibration_import_module(RD_4);

[head_origin_LT_2, head_direction_LT_2, eye_origin_LT_2, gaze_vector_LT_2] = calibration_import_module2(LT_5);
[head_origin_RT_2, head_direction_RT_2, eye_origin_RT_2, gaze_vector_RT_2] = calibration_import_module2(RT_6);
[head_origin_LD_2, head_direction_LD_2, eye_origin_LD_2, gaze_vector_LD_2] = calibration_import_module2(LD_7);
[head_origin_RD_2, head_direction_RD_2, eye_origin_RD_2, gaze_vector_RD_2] = calibration_import_module2(RD_8);


sphere_center = [(head_origin_LT(1) + head_origin_RT(1) + head_origin_LD(1) + head_origin_RD(1))/4, (head_origin_LT(2) + head_origin_RT(2) + head_origin_LD(2) + head_origin_RD(2))/4, (head_origin_LT(3) + head_origin_RT(3) + head_origin_LD(3) + head_origin_RD(3))/4 ]';
%% 구 생성
[N, R0] = tangent_plane(sphere_center, norm(sphere_center), deg2rad(180),0);
hold on
grid on

%% Vector calculation

cal_point_LT_1 = [R0(1) + 615/2, R0(2) - 365/2, R0(3)]; % 원점(웹캠) 기준 모니터 모서리 좌표
cal_point_RT_2 = [R0(1) - 615/2, R0(2) - 365/2, R0(3)];
cal_point_LD_3 = [R0(1) + 615/2, R0(2) + 365/2, R0(3)];
cal_point_RD_4 = [R0(1) - 615/2, R0(2) + 365/2, R0(3)];

cal_vect_LT_1 = cal_point_LT_1- eye_origin_LT; % eye origin 에서 시작해 reference point로 끝나는 벡터
cal_vect_RT_2 = cal_point_RT_2- eye_origin_RT;
cal_vect_LD_3 = cal_point_LD_3- eye_origin_LD;
cal_vect_RD_4 = cal_point_RD_4- eye_origin_RD;

gaze_position_LT_1 = gaze_vector_LT(1:3) + eye_origin_LT; % eye gaze position in cam coordinate (points_left, points_right in c++ visualizer)
gaze_position_RT_2 = gaze_vector_RT(1:3) + eye_origin_RT;
gaze_position_LD_3 = gaze_vector_LD(1:3) + eye_origin_LD;
gaze_position_RD_4 = gaze_vector_RD(1:3) + eye_origin_RD;

gaze_position_LT_5 = gaze_vector_LT_2(1:3) + eye_origin_LT_2; % eye gaze position in cam coordinate (points_left, points_right in c++ visualizer)
gaze_position_RT_6 = gaze_vector_RT_2(1:3) + eye_origin_RT_2;
gaze_position_LD_7 = gaze_vector_LD_2(1:3) + eye_origin_LD_2;
gaze_position_RD_8 = gaze_vector_RD_2(1:3) + eye_origin_RD_2;


% eye에서 시작해 reference point로 끝나는 벡터를 구좌표계로 변환
[az_cal_vect_LT_1,el_cal_vect_LT_1,r_cal_vect_LT_1] = cart2sph(cal_vect_LT_1(1), cal_vect_LT_1(2), cal_vect_LT_1(3));
[az_cal_vect_RT_2,el_cal_vect_RT_2,r_cal_vect_RT_2] = cart2sph(cal_vect_RT_2(1), cal_vect_RT_2(2), cal_vect_RT_2(3));
[az_cal_vect_LD_3,el_cal_vect_LD_3,r_cal_vect_LD_3] = cart2sph(cal_vect_LD_3(1), cal_vect_LD_3(2), cal_vect_LD_3(3));
[az_cal_vect_RD_4,el_cal_vect_RD_4,r_cal_vect_RD_4] = cart2sph(cal_vect_RD_4(1), cal_vect_RD_4(2), cal_vect_RD_4(3));

% eye origin 에서 시작해 gaze position 으로 끝나는 벡터를 구좌표계로 변환
[az_eye_vect_LT_1,el_eye_vect_LT_1,r_eye_vect_LT_1] = cart2sph(gaze_position_LT_1(1) - eye_origin_LT(1), gaze_position_LT_1(2) - eye_origin_LT(2), gaze_position_LT_1(3) - eye_origin_LT(3));
[az_eye_vect_RT_2,el_eye_vect_RT_2,r_eye_vect_RT_2] = cart2sph(gaze_position_RT_2(1) - eye_origin_RT(1), gaze_position_RT_2(2) - eye_origin_RT(2), gaze_position_RT_2(3) - eye_origin_RT(3));
[az_eye_vect_LD_3,el_eye_vect_LD_3,r_eye_vect_LD_3] = cart2sph(gaze_position_LD_3(1) - eye_origin_LD(1), gaze_position_LD_3(2) - eye_origin_LD(2), gaze_position_LD_3(3) - eye_origin_LD(3));
[az_eye_vect_RD_4,el_eye_vect_RD_4,r_eye_vect_RD_4] = cart2sph(gaze_position_RD_4(1) - eye_origin_RD(1), gaze_position_RD_4(2) - eye_origin_RD(2), gaze_position_RD_4(3) - eye_origin_RD(3));

[az_eye_vect_LT_5,el_eye_vect_LT_5,r_eye_vect_LT_5] = cart2sph(gaze_position_LT_5(1) - eye_origin_LT_2(1), gaze_position_LT_5(2) - eye_origin_LT_2(2), gaze_position_LT_5(3) - eye_origin_LT_2(3));
[az_eye_vect_RT_6,el_eye_vect_RT_6,r_eye_vect_RT_6] = cart2sph(gaze_position_RT_6(1) - eye_origin_RT_2(1), gaze_position_RT_6(2) - eye_origin_RT_2(2), gaze_position_RT_6(3) - eye_origin_RT_2(3));
[az_eye_vect_LD_7,el_eye_vect_LD_7,r_eye_vect_LD_7] = cart2sph(gaze_position_LD_7(1) - eye_origin_LD_2(1), gaze_position_LD_7(2) - eye_origin_LD_2(2), gaze_position_LD_7(3) - eye_origin_LD_2(3));
[az_eye_vect_RD_8,el_eye_vect_RD_8,r_eye_vect_RD_8] = cart2sph(gaze_position_RD_8(1) - eye_origin_RD_2(1), gaze_position_RD_8(2) - eye_origin_RD_2(2), gaze_position_RD_8(3) - eye_origin_RD_2(3));


%% Calculate calibration matrix W (at least 2 points needed)
% Ref: Ohno, T., & Mukawa, N. (2004, March). A free-head, simple calibration, gaze tracking system that enables gaze-based interaction. In Proceedings of the 2004 symposium on Eye tracking research & applications (pp. 115-122).

% A = gaze matrix
% A = [az_eye_vect_LT_1, 1, 0, 0;...
%     0, 0, el_eye_vect_LT_1, 1;...
%     az_eye_vect_RT_2, 1, 0, 0;...
%     0, 0, el_eye_vect_RT_2, 1;...
%     az_eye_vect_LD_3, 1, 0, 0;...
%     0, 0, el_eye_vect_LD_3, 1;...
%     az_eye_vect_RD_4, 1, 0, 0;...
%     0, 0, el_eye_vect_RD_4, 1;...
%     ];

A = [
    az_eye_vect_LD_3, 1, 0, 0;...
    0, 0, el_eye_vect_LD_3, 1;...
    az_eye_vect_RD_4, 1, 0, 0;...
    0, 0, el_eye_vect_RD_4, 1;...
    ];


% B = reference gaze matrix
% B = [az_cal_vect_LT_1, el_cal_vect_LT_1, az_cal_vect_RT_2, el_cal_vect_RT_2, az_cal_vect_LD_3, el_cal_vect_LD_3, az_cal_vect_RD_4, el_cal_vect_RD_4]';
B = [az_cal_vect_LD_3, el_cal_vect_LD_3, az_cal_vect_RD_4, el_cal_vect_RD_4]';

% X = calibration coefficients (Least square method for overdetermind linear system)
X = A\B;
% W = calibration matrix *The main purpose of this code*
W = [1, 0, 0, 0; 0, X(1), 0, X(2); 0, 0, X(3), X(4); 0, 0, 0, 1]; 

%% Verification with reference vectors

TEST_LT_1 = W*[r_eye_vect_LT_1,az_eye_vect_LT_1,el_eye_vect_LT_1,1]'; % should similar with [r_cal_vect_LT_1, az_cal_vect_LT_1,el_cal_vect_LT_1]
TEST_RT_2 = W*[r_eye_vect_RT_2,az_eye_vect_RT_2,el_eye_vect_RT_2,1]'; % should similar with [r_cal_vect_RT_2, az_cal_vect_RT_2,el_cal_vect_RT_2]
TEST_LD_3 = W*[r_eye_vect_LD_3,az_eye_vect_LD_3,el_eye_vect_LD_3,1]'; % should similar with [r_cal_vect_LD_3, az_cal_vect_LD_3,el_cal_vect_LD_3]
TEST_RD_4 = W*[r_eye_vect_RD_4,az_eye_vect_RD_4,el_eye_vect_RD_4,1]'; % should similar with [r_cal_vect_RD_4, az_cal_vect_RD_4,el_cal_vect_RD_4]

head_eul_LT_2 = [LT_5.pose_Rx, LT_5.pose_Ry, LT_5.pose_Rz]; % Left-handed positive
R_LT_2 = eul2rotm(head_eul_LT_2,"XYZ"); % world coordinate system
head_eul_RT_2 = [RT_6.pose_Rx, RT_6.pose_Ry, RT_6.pose_Rz]; % Left-handed positive
R_RT_2 = eul2rotm(head_eul_RT_2,"XYZ"); % world coordinate system
head_eul_LD_3 = [LD_7.pose_Rx, LD_7.pose_Ry, LD_7.pose_Rz]; % Left-handed positive
R_LD_3 = eul2rotm(head_eul_LD_3,"XYZ"); % world coordinate system
head_eul_RD_4 = [RD_8.pose_Rx, RD_8.pose_Ry, RD_8.pose_Rz]; % Left-handed positive
R_RD_4 = eul2rotm(head_eul_RD_4,"XYZ"); % world coordinate system
T0 = [0,0,0]';

TEST_LT_5 = W*[r_eye_vect_LT_5,az_eye_vect_LT_5,el_eye_vect_LT_5,1]'; % should similar with [r_cal_vect_LT_1, az_cal_vect_LT_1,el_cal_vect_LT_1]
TEST_RT_6 = W*[r_eye_vect_RT_6,az_eye_vect_RT_6,el_eye_vect_RT_6,1]'; % should similar with [r_cal_vect_RT_2, az_cal_vect_RT_2,el_cal_vect_RT_2]
TEST_LD_7 = W*[r_eye_vect_LD_7,az_eye_vect_LD_7,el_eye_vect_LD_7,1]'; % should similar with [r_cal_vect_LD_3, az_cal_vect_LD_3,el_cal_vect_LD_3]
TEST_RD_8 = W*[r_eye_vect_RD_8,az_eye_vect_RD_8,el_eye_vect_RD_8,1]'; % should similar with [r_cal_vect_RD_4, az_cal_vect_RD_4,el_cal_vect_RD_4]

[TEST_LT_1_cart_x, TEST_LT_1_cart_y, TEST_LT_1_cart_z] = sph2cart(TEST_LT_1(2), TEST_LT_1(3), TEST_LT_1(1));
[TEST_RT_2_cart_x, TEST_RT_2_cart_y, TEST_RT_2_cart_z] = sph2cart(TEST_RT_2(2), TEST_RT_2(3), TEST_RT_2(1)); 
[TEST_LD_3_cart_x, TEST_LD_3_cart_y, TEST_LD_3_cart_z] = sph2cart(TEST_LD_3(2), TEST_LD_3(3), TEST_LD_3(1)); 
[TEST_RD_4_cart_x, TEST_RD_4_cart_y, TEST_RD_4_cart_z] = sph2cart(TEST_RD_4(2), TEST_RD_4(3), TEST_RD_4(1)); 

[TEST_LT_5_cart_x, TEST_LT_5_cart_y, TEST_LT_5_cart_z] = sph2cart(TEST_LT_5(2), TEST_LT_5(3), TEST_LT_5(1));
[TEST_RT_6_cart_x, TEST_RT_6_cart_y, TEST_RT_6_cart_z] = sph2cart(TEST_RT_6(2), TEST_RT_6(3), TEST_RT_6(1)); 
[TEST_LD_7_cart_x, TEST_LD_7_cart_y, TEST_LD_7_cart_z] = sph2cart(TEST_LD_7(2), TEST_LD_7(3), TEST_LD_7(1)); 
[TEST_RD_8_cart_x, TEST_RD_8_cart_y, TEST_RD_8_cart_z] = sph2cart(TEST_RD_8(2), TEST_RD_8(3), TEST_RD_8(1)); 


%% verification with plotting
axis equal
%% First Display
pp_head_LT = plot3([head_origin_LT(1), head_direction_LT(1)], [head_origin_LT(2), head_direction_LT(2)], [head_origin_LT(3), head_direction_LT(3)],'-b');
pp_head_RT = plot3([head_origin_RT(1), head_direction_RT(1)], [head_origin_RT(2), head_direction_RT(2)], [head_origin_RT(3), head_direction_RT(3)],'-b');
pp_head_LD = plot3([head_origin_LD(1), head_direction_LD(1)], [head_origin_LD(2), head_direction_LD(2)], [head_origin_LD(3), head_direction_LD(3)],'-b');
pp_head_RD = plot3([head_origin_RD(1), head_direction_RD(1)], [head_origin_RD(2), head_direction_RD(2)], [head_origin_RD(3), head_direction_RD(3)],'-b');

pp_eye_LT = plot3([eye_origin_LT(1), gaze_position_LT_1(1)], [eye_origin_LT(2), gaze_position_LT_1(2)], [eye_origin_LT(3), gaze_position_LT_1(3)],'-r');
pp_eye_LD = plot3([eye_origin_LD(1), gaze_position_RT_2(1)], [eye_origin_LD(2), gaze_position_RT_2(2)], [eye_origin_LD(3), gaze_position_RT_2(3)],'-r');
pp_eye_RT = plot3([eye_origin_RT(1), gaze_position_LD_3(1)], [eye_origin_RT(2), gaze_position_LD_3(2)], [eye_origin_RT(3), gaze_position_LD_3(3)],'-m');
pp_eye_RD = plot3([eye_origin_RD(1), gaze_position_RD_4(1)], [eye_origin_RD(2), gaze_position_RD_4(2)], [eye_origin_RD(3), gaze_position_RD_4(3)],'-m');

%% Second Display
pp_head_LT_2 = plot3([head_origin_LT_2(1), head_direction_LT_2(1)], [head_origin_LT_2(2), head_direction_LT_2(2)], [head_origin_LT_2(3), head_direction_LT_2(3)],'-.b');
pp_head_RT_2 = plot3([head_origin_RT_2(1), head_direction_RT_2(1)], [head_origin_RT_2(2), head_direction_RT_2(2)], [head_origin_RT_2(3), head_direction_RT_2(3)],'-.b');
pp_head_LD_2 = plot3([head_origin_LD_2(1), head_direction_LD_2(1)], [head_origin_LD_2(2), head_direction_LD_2(2)], [head_origin_LD_2(3), head_direction_LD_2(3)],'-.b');
pp_head_RD_2 = plot3([head_origin_RD_2(1), head_direction_RD_2(1)], [head_origin_RD_2(2), head_direction_RD_2(2)], [head_origin_RD_2(3), head_direction_RD_2(3)],'-.b');

pp_eye_LT_2 = plot3([eye_origin_LT_2(1), gaze_position_LT_5(1)], [eye_origin_LT_2(2), gaze_position_LT_5(2)], [eye_origin_LT_2(3), gaze_position_LT_5(3)],'-.r');
pp_eye_LD_2 = plot3([eye_origin_LD_2(1), gaze_position_RT_6(1)], [eye_origin_LD_2(2), gaze_position_RT_6(2)], [eye_origin_LD_2(3), gaze_position_RT_6(3)],'-.r');
pp_eye_RT_2 = plot3([eye_origin_RT_2(1), gaze_position_LD_7(1)], [eye_origin_RT_2(2), gaze_position_LD_7(2)], [eye_origin_RT_2(3), gaze_position_LD_7(3)],'-.m');
pp_eye_RD_2 = plot3([eye_origin_RD_2(1), gaze_position_RD_8(1)], [eye_origin_RD_2(2), gaze_position_RD_8(2)], [eye_origin_RD_2(3), gaze_position_RD_8(3)],'-.m');

%%

scatter3(head_origin_LT(1),head_origin_LT(2),head_origin_LT(3),'filled','k');
text(sphere_center(1),sphere_center(2),sphere_center(3),'  Head Origin(Initial Sphere Center)')
scatter3(0,0,0,'filled','k');
text(0,0,0,'  Camera Origin(World Coordinate System)')

pp_ref_eye_LT = plot3([eye_origin_LT(1), cal_point_LT_1(1)], [eye_origin_LT(2), cal_point_LT_1(2)], [eye_origin_LT(3), cal_point_LT_1(3)],'-k');
pp_ref_eye_RT = plot3([eye_origin_RT(1), cal_point_RT_2(1)], [eye_origin_RT(2), cal_point_RT_2(2)], [eye_origin_RT(3), cal_point_RT_2(3)],'-k');
pp_ref_eye_LD =  plot3([eye_origin_LD(1), cal_point_LD_3(1)], [eye_origin_LD(2), cal_point_LD_3(2)], [eye_origin_LD(3), cal_point_LD_3(3)],'-k');
pp_ref_eye_RD = plot3([eye_origin_RD(1), cal_point_RD_4(1)], [eye_origin_RD(2), cal_point_RD_4(2)], [eye_origin_RD(3), cal_point_RD_4(3)],'-k');

pp_c_eye_LT = plot3([eye_origin_LT(1), TEST_LT_1_cart_x+eye_origin_LT(1)], [eye_origin_LT(2), TEST_LT_1_cart_y+eye_origin_LT(2)], [eye_origin_LT(3), TEST_LT_1_cart_z+eye_origin_LT(3)],'-g');
pp_c_eye_RT = plot3([eye_origin_RT(1), TEST_RT_2_cart_x+eye_origin_RT(1)], [eye_origin_RT(2), TEST_RT_2_cart_y+eye_origin_RT(2)], [eye_origin_RT(3), TEST_RT_2_cart_z+eye_origin_RT(3)],'-g');
pp_c_eye_LD = plot3([eye_origin_LD(1), TEST_LD_3_cart_x+eye_origin_LD(1)], [eye_origin_LD(2), TEST_LD_3_cart_y+eye_origin_LD(2)], [eye_origin_LD(3), TEST_LD_3_cart_z+eye_origin_LD(3)],'-g');
pp_c_eye_RD = plot3([eye_origin_RD(1), TEST_RD_4_cart_x+eye_origin_RD(1)], [eye_origin_RD(2), TEST_RD_4_cart_y+eye_origin_RD(2)], [eye_origin_RD(3), TEST_RD_4_cart_z+eye_origin_RD(3)],'-g');

pp_c_eye_LT_2 = plot3([eye_origin_LT_2(1), TEST_LT_5_cart_x+eye_origin_LT_2(1)], [eye_origin_LT_2(2), TEST_LT_5_cart_y+eye_origin_LT_2(2)], [eye_origin_LT_2(3), TEST_LT_5_cart_z+eye_origin_LT_2(3)],'-.c');
pp_c_eye_RT_2 = plot3([eye_origin_RT_2(1), TEST_RT_6_cart_x+eye_origin_RT_2(1)], [eye_origin_RT_2(2), TEST_RT_6_cart_y+eye_origin_RT_2(2)], [eye_origin_RT_2(3), TEST_RT_6_cart_z+eye_origin_RT_2(3)],'-.c');
pp_c_eye_LD_2 = plot3([eye_origin_LD_2(1), TEST_LD_7_cart_x+eye_origin_LD_2(1)], [eye_origin_LD_2(2), TEST_LD_7_cart_y+eye_origin_LD_2(2)], [eye_origin_LD_2(3), TEST_LD_7_cart_z+eye_origin_LD_2(3)],'-.c');
pp_c_eye_RD_2 = plot3([eye_origin_RD_2(1), TEST_RD_8_cart_x+eye_origin_RD_2(1)], [eye_origin_RD_2(2), TEST_RD_8_cart_y+eye_origin_RD_2(2)], [eye_origin_RD_2(3), TEST_RD_8_cart_z+eye_origin_RD_2(3)],'-.c');


pp_head_LT.LineWidth = 2; pp_head_RT.LineWidth = 2;  pp_head_LD.LineWidth = 2; pp_head_RD.LineWidth = 2;
pp_eye_LT.LineWidth = 2; pp_eye_RT.LineWidth = 2; pp_eye_LD.LineWidth = 2; pp_eye_RD.LineWidth = 2;
pp_ref_eye_LT.LineWidth = 2; pp_ref_eye_LD.LineWidth = 2; pp_ref_eye_RT.LineWidth = 2; pp_ref_eye_RD.LineWidth = 2;
pp_c_eye_LT.LineWidth = 2; pp_c_eye_RT.LineWidth = 2; pp_c_eye_LD.LineWidth = 2; pp_c_eye_RD.LineWidth = 2;

pp_head_LT_2.LineWidth = 2; pp_head_RT_2.LineWidth = 2; pp_head_LD_2.LineWidth = 2; pp_head_RD_2.LineWidth = 2;
pp_eye_LT_2.LineWidth = 2; pp_eye_RT_2.LineWidth = 2; pp_eye_LD_2.LineWidth = 2; pp_eye_RD_2.LineWidth = 2;
pp_c_eye_LT_2.LineWidth = 2; pp_c_eye_RT_2.LineWidth = 2; pp_c_eye_LD_2.LineWidth = 2; pp_c_eye_RD_2.LineWidth = 2;
