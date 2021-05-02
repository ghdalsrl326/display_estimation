clear; clc; close all;

raw_data = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test\1\data_robot_2.csv",'ReadVariableNames',true,'HeaderLines',0);
raw_data = raw_data(raw_data.Success==1,:);
raw_data_true = raw_data(6:end,:);

LT_1 = raw_data(1,:);
RT_2 = raw_data(2,:);
LD_3 = raw_data(3,:);
RD_4 = raw_data(4,:);

[head_origin_LT, head_direction_LT, eye_origin_LT, gaze_vector_LT] = calibration_import_module(LT_1);
[head_origin_RT, head_direction_RT, eye_origin_RT, gaze_vector_RT] = calibration_import_module(RT_2);
[head_origin_LD, head_direction_LD, eye_origin_LD, gaze_vector_LD] = calibration_import_module(LD_3);
[head_origin_RD, head_direction_RD, eye_origin_RD, gaze_vector_RD] = calibration_import_module(RD_4);

sphere_center = [(head_origin_LT(1) + head_origin_RT(1) + head_origin_LD(1) + head_origin_RD(1))/4, (head_origin_LT(2) + head_origin_RT(2) + head_origin_LD(2) + head_origin_RD(2))/4, (head_origin_LT(3) + head_origin_RT(3) + head_origin_LD(3) + head_origin_RD(3))/4 ]';

second_display_position = [-289.004, 453.985, 96.012]; % first display 좌표계 기준 second display의 중심 위치(주의: fisrt display와 달리 원점이 중심임)
second_display_position(1) = -second_display_position(1); 
second_display_position(2) = -second_display_position(2); 
second_display_position(2) = second_display_position(2) - 365/2 - 20; % camera 좌표계 기준으로 변환

[azimuth,elevation,r] = cart2sph(second_display_position(1)-sphere_center(1),second_display_position(2)-sphere_center(2),second_display_position(3)-sphere_center(3));

% azimuth = -1.0968; %ref: -2.4513
% elevation = -0.8998; %ref: -0.6076
% r = 739.3667; %ref:992.8595
% 
% [xx, yy, zz] = sph2cart(azimuth,elevation,r);
% second_display_position = [-(xx + sphere_center(1)), -(yy + sphere_center(2) + 365/2 + 20), zz + sphere_center(3)];
% second_display_position(1) = -second_display_position(1); 
% second_display_position(2) = -second_display_position(2); 
% second_display_position(2) = second_display_position(2) - 365/2 - 20; % camera 좌표계로 변환

%% Second display 접평면 생성
[N, R0] = tangent_plane(sphere_center, norm(second_display_position'-sphere_center), elevation, azimuth);
hold on
scatter3(0,0,0,120,'filled','y','pentagram');
scatter3(second_display_position(1),second_display_position(2),second_display_position(3),120,'filled','y','pentagram');
grid on

xlim([-1500, 1100]);
ylim([-1500, 1100]);
zlim([-1100, 1600]);
% plane equation: N(1)*(x-R0(1)) + N(2)*(y-R0(2)) + N(3)*(z-R0(3)) = 0
plane_coef_first = [0,0,1,0];
plane_coef_second = [N(1), N(2), N(3), -N(1)*R0(1) - N(2)*R0(2) - N(3)*R0(3)]; 

%% Second display coordinate system 생성(display 중심이 원점)

temp_x_point = second_display_position + [200, 0, 0];
new_x_vertical = temp_x_point + [0, 0, 100];
new_x_point = line_plane_intersection(temp_x_point, new_x_vertical, plane_coef_second); % cam coord
new_x_axis_vect = (new_x_point-second_display_position)./norm((new_x_point-second_display_position));
new_x_point2 = new_x_axis_vect.*200 + second_display_position;
scatter3(new_x_point2(1),new_x_point2(2),new_x_point2(3),120,'filled','y','pentagram');
arrow3(second_display_position, new_x_point2, 'LineWidth', 0.4);

new_z_axis_vect = sphere_center' - second_display_position;
new_z_axis_vect = new_z_axis_vect./norm(new_z_axis_vect);
arrow3(second_display_position, sphere_center', 'LineWidth', 0.4);

new_y_axis_vect = cross(new_z_axis_vect,new_x_axis_vect);
new_y_axis_vect = new_y_axis_vect./norm(new_y_axis_vect);
new_y_point = new_y_axis_vect.*200 + second_display_position;
scatter3(new_y_point(1),new_y_point(2),new_y_point(3),120,'filled','y','pentagram');
arrow3(second_display_position, new_y_point, 'LineWidth', 0.4);

rotm_plane_coord = [new_x_axis_vect', new_y_axis_vect', new_z_axis_vect'];
htrans_plane_coord = [rotm_plane_coord, second_display_position'; 0, 0, 0, 1]; 

%% pixel coordinate -> Second display coordinate system
raw_data_true_first = raw_data_true(2:2:end,:);
raw_data_true_second = raw_data_true(1:2:end,:);

p2mm_x = 615/1920; %display width/pixels width in processing
p2mm_y = 365/1080; %display height/pixels height in processing
d1_target_x = (960 - raw_data_true_first.target_x)*p2mm_x; %processing coordinate -> cam coord system (unit: mm)
d1_target_y = (raw_data_true_first.target_y - 1080)*p2mm_y - 20; %processing coordinate -> cam coord system (unit: mm)
d1_target = [d1_target_x, d1_target_y, zeros(length(d1_target_x),1)]; % first display target의 3차원 위치 (Cam 좌표계)

scatter3(d1_target_x,d1_target_y,zeros(length(d1_target_x),1),120,'filled','r','pentagram'); 

d2_target_x = (2880 - raw_data_true_second.target_x)*p2mm_x; %processing coordinate -> cam coord system (unit: mm)
d2_target_y = (raw_data_true_second.target_y - 540)*p2mm_y;%processing coordinate -> cam coord system (unit: mm)

d2_target = []; % second display target의 3차원 위치 (Cam 좌표계) unit:mm
for i = 1:length(d2_target_x)
    d2_target = vertcat(d2_target, transpose(htrans_plane_coord*[d2_target_x(i), d2_target_y(i), 0, 1]'));
end
scatter3(d2_target(:,1),d2_target(:,2),d2_target(:,3),120,'filled','r','pentagram'); 

%% 헤드, 게이즈 벡터 표현
head_pose_true = [raw_data_true.pose_Tx, raw_data_true.pose_Ty, raw_data_true.pose_Tz]; % cam coordinate system
head_eul_true = [raw_data_true.pose_Rx, raw_data_true.pose_Ry, raw_data_true.pose_Rz]; % Left-handed positive

R = eul2rotm(head_eul_true,"XYZ"); % world coordinate system
T = head_pose_true'; % unit: mm
htrans = [];
for i = 1:length(T)
    htrans = cat(3,htrans,[R(:,:,i), T(:,i); 0, 0, 0, 1]); % head to cam coord    
end

head_origin = [];
head_direction = [];
for i = 1:length(T)
    head_origin = cat(3, head_origin, htrans(:,:,i)*[0,0,0,1]');
    head_direction = cat(3, head_direction, htrans(:,:,i)*[0,0,-1500,1]');  
end

% eyeR_lmk_X = (raw_data_true.eye_lmk_X_0 + raw_data_true.eye_lmk_X_1 + raw_data_true.eye_lmk_X_2 + raw_data_true.eye_lmk_X_3 + raw_data_true.eye_lmk_X_4 + raw_data_true.eye_lmk_X_5 + raw_data_true.eye_lmk_X_6 + raw_data_true.eye_lmk_X_7)/8;
% eyeR_lmk_Y = (raw_data_true.eye_lmk_Y_0 + raw_data_true.eye_lmk_Y_1 + raw_data_true.eye_lmk_Y_2 + raw_data_true.eye_lmk_Y_3 + raw_data_true.eye_lmk_Y_4 + raw_data_true.eye_lmk_Y_5 + raw_data_true.eye_lmk_Y_6 + raw_data_true.eye_lmk_Y_7)/8;
% eyeR_lmk_Z = (raw_data_true.eye_lmk_Z_0 + raw_data_true.eye_lmk_Z_1 + raw_data_true.eye_lmk_Z_2 + raw_data_true.eye_lmk_Z_3 + raw_data_true.eye_lmk_Z_4 + raw_data_true.eye_lmk_Z_5 + raw_data_true.eye_lmk_Z_6 + raw_data_true.eye_lmk_Z_7)/8;
% 
% eyeL_lmk_X = (raw_data_true.eye_lmk_X_28 + raw_data_true.eye_lmk_X_29 + raw_data_true.eye_lmk_X_30 + raw_data_true.eye_lmk_X_31 + raw_data_true.eye_lmk_X_32 + raw_data_true.eye_lmk_X_33 + raw_data_true.eye_lmk_X_34 + raw_data_true.eye_lmk_X_35)/8;
% eyeL_lmk_Y = (raw_data_true.eye_lmk_Y_28 + raw_data_true.eye_lmk_Y_29 + raw_data_true.eye_lmk_Y_30 + raw_data_true.eye_lmk_Y_31 + raw_data_true.eye_lmk_Y_32 + raw_data_true.eye_lmk_Y_33 + raw_data_true.eye_lmk_Y_34 + raw_data_true.eye_lmk_Y_35)/8;
% eyeL_lmk_Z = (raw_data_true.eye_lmk_Z_28 + raw_data_true.eye_lmk_Z_29 + raw_data_true.eye_lmk_Z_30 + raw_data_true.eye_lmk_Z_31 + raw_data_true.eye_lmk_Z_32 + raw_data_true.eye_lmk_Z_33 + raw_data_true.eye_lmk_Z_34 + raw_data_true.eye_lmk_Z_35)/8;
% 
% eye_origin = [eyeR_lmk_X + eyeL_lmk_X, eyeR_lmk_Y + eyeL_lmk_Y, eyeR_lmk_Z + eyeL_lmk_Z]./2; % cam coord(pupil location)
% gaze_vector = [];
% gg = [(raw_data_true.gaze_0_x + raw_data_true.gaze_1_x), (raw_data_true.gaze_0_y + raw_data_true.gaze_1_y - 0.5), (raw_data_true.gaze_0_z + raw_data_true.gaze_1_z)];
% for i = 1:length(T)
%     gaze_vector = cat(3, gaze_vector, gg(i,:)*inv(R(:,:,i)).*(350));
% end

%% dimension reduction & seperate first and second display data for ease of use
head_origin = transpose(reshape(head_origin,4,100));
head_direction = transpose(reshape(head_direction,4,100)); 
% eye_origin = eye_origin;
% gaze_vector = transpose(reshape(gaze_vector,3,100));

head_origin_first = head_origin(2:2:end,:);
head_origin_second = head_origin(1:2:end,:);
head_direction_first = head_direction(2:2:end,:);
head_direction_second = head_direction(1:2:end,:);
% eye_origin_first = eye_origin(2:2:end,:);
% eye_origin_second = eye_origin(1:2:end,:);
% gaze_vector_first = gaze_vector(2:2:end,:);
% gaze_vector_second = gaze_vector(1:2:end,:);

%% Head calibration
% head_direction_second를 head_origin_second를 원점으로 하는 구좌표계로 변환
% azimuth in [-pi,pi], elevation in [-pi/2,pi/2]
[az_head_vect_calib,el_head_vect_calib,r_head_vect_calib] = cart2sph(head_direction_second(:,1) - head_origin_second(:,1), head_direction_second(:,2) - head_origin_second(:,2), head_direction_second(:,3) - head_origin_second(:,3));
% 구좌표계에서 elevation * 2
% 이부분 수정 필요
az_head_vect_calib = (az_head_vect_calib + deg2rad(180))*1.2 - deg2rad(180);
el_head_vect_calib = (el_head_vect_calib + deg2rad(90))*2 - deg2rad(90);

% 다시 직교좌표계로 변환 후 plot
[head_direction_second_calib_x, head_direction_second_calib_y, head_direction_second_calib_z] = sph2cart(az_head_vect_calib, el_head_vect_calib, r_head_vect_calib);
head_direction_second_calib_x = head_direction_second_calib_x + head_origin_second(:,1);
head_direction_second_calib_y = head_direction_second_calib_y + head_origin_second(:,2);
head_direction_second_calib_z = head_direction_second_calib_z + head_origin_second(:,3);
head_direction_second_calib = [head_direction_second_calib_x, head_direction_second_calib_y, head_direction_second_calib_z];

% scatter3(head_direction_calib_x,head_direction_calib_y,head_direction_calib_z,'filled','k');

%%
% eye gaze position in cam coordinate (points_left, points_right in c++ visualizer)
% gaze_position_first = gaze_vector_first + eye_origin_first; 
% gaze_position_second = gaze_vector_second + eye_origin_second; 
% % eye origin 에서 시작해 gaze position 으로 끝나는 벡터를 구좌표계로 변환
% [az_eye_vect_first,el_eye_vect_first,r_eye_vect_first] = cart2sph(gaze_position_first(:,1) - eye_origin_first(:,1), gaze_position_first(:,2) - eye_origin_first(:,2), gaze_position_first(:,3) - eye_origin_first(:,3));
% [az_eye_vect_second,el_eye_vect_second,r_eye_vect_second] = cart2sph(gaze_position_second(:,1) - eye_origin_second(:,1), gaze_position_second(:,2) - eye_origin_second(:,2), gaze_position_second(:,3) - eye_origin_second(:,3));
% 
% TEST_frist = [];
% TEST_second = [];
% for i = 1:length(gaze_position_first)
%     TEST_frist = cat(3, TEST_frist, W*[r_eye_vect_first(i),az_eye_vect_first(i),el_eye_vect_first(i),1]');
%     TEST_second = cat(3, TEST_second, W*[r_eye_vect_second(i),az_eye_vect_second(i),el_eye_vect_second(i),1]'); 
% end
% TEST_frist = transpose(reshape(TEST_frist,4,50));
% TEST_second = transpose(reshape(TEST_second,4,50));
% 
% [TEST_first_cart_x, TEST_first_cart_y, TEST_first_cart_z] = sph2cart(TEST_frist(:,2), TEST_frist(:,3), TEST_frist(:,1));
% [TEST_second_cart_x, TEST_second_cart_y, TEST_second_cart_z] = sph2cart(TEST_second(:,2), TEST_second(:,3), TEST_second(:,1));

%% Ray - Tangent plane intersection
for i = 1:length(head_origin_second)
%     plot3([head_origin_first(i,1), head_direction_first(i,1)], [head_origin_first(i,2), head_direction_first(i,2)], [head_origin_first(i,3), head_direction_first(i,3)],'-b');
    plot3([head_origin_second(i,1), head_direction_second(i,1)], [head_origin_second(i,2), head_direction_second(i,2)], [head_origin_second(i,3), head_direction_second(i,3)],'-b');
    plot3([head_origin_second(i,1) head_direction_second_calib(i,1)], [head_origin_second(i,2) head_direction_second_calib(i,2)], [head_origin_second(i,3) head_direction_second_calib(i,3)],'-y');
%     plot3([eye_origin_first(i,1), gaze_position_first(i,1)], [eye_origin_first(i,2), gaze_position_first(i,2)], [eye_origin_first(i,3), gaze_position_first(i,3)],'-r');
%     plot3([eye_origin_second(i,1), gaze_position_second(i,1)], [eye_origin_second(i,2), gaze_position_second(i,2)], [eye_origin_second(i,3), gaze_position_second(i,3)],'-r');

%     plot3([eye_origin_first(i,1), TEST_first_cart_x(i)+eye_origin_first(i,1)], [eye_origin_first(i,2), TEST_first_cart_y(i)+eye_origin_first(i,2)], [eye_origin_first(i,3), TEST_first_cart_z(i)+eye_origin_first(i,3)],'-g');
%     plot3([eye_origin_second(i,1), TEST_second_cart_x(i)+eye_origin_second(i,1)], [eye_origin_second(i,2), TEST_second_cart_y(i)+eye_origin_second(i,2)], [eye_origin_second(i,3), TEST_second_cart_z(i)+eye_origin_second(i,3)],'-g');
end

head_first_intersection = [];
head_second_intersection = [];
head_second_intersection_calib = [];

% gaze_first_intersection = [];
% gaze_second_intersection = [];
for i = 1:length(head_origin_second)
    head_first_intersection = vertcat(head_first_intersection, line_plane_intersection(head_origin_first(i,1:3), head_direction_first(i,1:3), plane_coef_first));
    head_second_intersection = vertcat(head_second_intersection, line_plane_intersection(head_origin_second(i,1:3), head_direction_second(i,1:3), plane_coef_second));
    head_second_intersection_calib = vertcat(head_second_intersection_calib, line_plane_intersection(head_origin_second(i,1:3), head_direction_second_calib(i,1:3), plane_coef_second));

%     gaze_first_intersection = vertcat(gaze_first_intersection, line_plane_intersection(eye_origin_first(i,1:3), gaze_position_first(i,1:3), plane_coef_first));
%     gaze_second_intersection = vertcat(gaze_second_intersection, line_plane_intersection(eye_origin_second(i,1:3), gaze_position_second(i,1:3), plane_coef_second));
end

scatter3(head_first_intersection(:,1),head_first_intersection(:,2),head_first_intersection(:,3),'filled','c');
scatter3(head_second_intersection(:,1),head_second_intersection(:,2),head_second_intersection(:,3),'filled','c');
scatter3(head_second_intersection_calib(:,1),head_second_intersection_calib(:,2),head_second_intersection_calib(:,3),'filled','k');
% scatter3(gaze_first_intersection(:,1),gaze_first_intersection(:,2),gaze_first_intersection(:,3),'filled','m');
% scatter3(gaze_second_intersection(:,1),gaze_second_intersection(:,2),gaze_second_intersection(:,3),'filled','m');

d2_target_mm_d2 = [];
head_second_intersection_mm_d2 = []; % head position in display 2 
head_second_calib_intersection_mm_d2 = []; % head position in display 2 

% gaze_second_intersection_mm_d2 = [];

for i=1:length(d2_target)
    d2_target_mm_d2 = vertcat(d2_target_mm_d2, transpose(inv(htrans_plane_coord)*d2_target(i,:)'));
    head_second_intersection_mm_d2 = vertcat(head_second_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection(i,:), 1]'));
    head_second_calib_intersection_mm_d2 = vertcat(head_second_calib_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection_calib(i,:), 1]'));
%     gaze_second_intersection_mm_d2 = vertcat(gaze_second_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[gaze_second_intersection(i,:), 1]'));
end

% %% 2D-Gaussian error plot: Click <-> Target
% error_click_x = (raw_data_true_second.target_x - raw_data_true_second.mouseX)*p2mm;
% error_click_y = (raw_data_true_second.mouseY - raw_data_true_second.target_y)*p2mm;
% 
% figure;
% scatter(error_click_x, error_click_y,'k','filled');
% grid on
% axis equal 
% title('2D-Gaussian error plot: Click <-> Target');
% xlabel('error_x [mm]');
% ylabel('error_y [mm]');
% %% 2D-Gaussian error plot: Head Vector <-> Target
error_head_second_x = (head_second_intersection_mm_d2(:,1) - d2_target_mm_d2(:,1));
error_head_second_y = (head_second_intersection_mm_d2(:,2) - d2_target_mm_d2(:,2));
% 
% figure;
% scatter(error_head_second_x, error_head_second_y,'k','filled');
% grid on
% axis equal 
% title('2D-Gaussian error plot: Head looking at Second display <-> Target');
% xlabel('error head second_x [mm]');
% ylabel('error head second_y [mm]');
% 
% %% 2D-Gaussian error plot: Gaze vector <-> Target
% error_gaze_second_x = (gaze_second_intersection_mm_d2(:,1) - d2_target_mm_d2(:,1));
% error_gaze_second_y = (gaze_second_intersection_mm_d2(:,2) - d2_target_mm_d2(:,2));
% 
% figure;
% scatter(error_gaze_second_x, error_gaze_second_y,'k','filled');
% grid on
% axis equal 
% title('2D-Gaussian error plot: Gaze looking at Second display <-> Target');
% xlabel('error gaze second_x [mm]');
% ylabel('error gaze second_y [mm]');
% 
% figure;
% hold on
% mu_click = [mean(error_click_x), mean(error_click_y)];%plane coord
% Sigma_click = cov(error_click_x, error_click_y);
% 
mu_head = [mean(error_head_second_x), mean(error_head_second_y)];
Sigma_head = cov(error_head_second_x, error_head_second_y);
% 
% mu_gaze = [mean(error_gaze_second_x), mean(error_gaze_second_y)];
% Sigma_gaze = cov(error_gaze_second_x, error_gaze_second_y);
% 
% x1 = -1000:10:1000;
% x2 = -1000:10:1000;
% [X1,X2] = meshgrid(x1,x2);
% X = [X1(:) X2(:)];
% 
% y_click = mvnpdf(X,mu_click,Sigma_click);
% y_head = mvnpdf(X,mu_head,Sigma_head);
% y_gaze = mvnpdf(X,mu_gaze,Sigma_gaze);
% 
% y_click = reshape(y_click,length(x2),length(x1));
% y_head = reshape(y_head,length(x2),length(x1));
% y_gaze = reshape(y_gaze,length(x2),length(x1));
% 
% surf(x1,x2,y_click)
% surf(x1,x2,y_head)
% surf(x1,x2,y_gaze)
% caxis([min(y_gaze(:))-0.5*range(y_gaze(:)),max(y_gaze(:))])
% axis([-1000 1000 -1000 1000])
% xlabel('error_x')
% ylabel('error_y')
% zlabel('Probability Density')
% 
%% Likelihood Calculation
head_likelihood = mvnpdf([head_second_calib_intersection_mm_d2(:,1), head_second_calib_intersection_mm_d2(:,2)], [d2_target_mm_d2(:,1), d2_target_mm_d2(:,2)], [Sigma_head(1,1), 0; 0, Sigma_head(1,1)]);
head_log_likelihood = log(head_likelihood);
Cost = -sum(head_log_likelihood);

figure;
h1 = axes;
hold on
grid on
scatter(head_second_intersection_mm_d2(:,1), head_second_intersection_mm_d2(:,2),'filled','c')
scatter(d2_target_mm_d2(:,1), d2_target_mm_d2(:,2),'filled','r')
scatter(head_second_calib_intersection_mm_d2(:,1), head_second_calib_intersection_mm_d2(:,2), 'filled', 'b')
set(h1, 'Xdir', 'reverse', 'Ydir', 'reverse')