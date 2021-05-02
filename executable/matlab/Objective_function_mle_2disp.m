function Cost = Objective_function_mle_2disp(x_second, raw_data_true_second)

azimuth = x_second(1); elevation = x_second(2); r = x_second(3); %camera에서 second_display_postion을 잇는 벡터를 구좌표계로 표현 (camera 좌표계)
sphere_center = [x_second(4); x_second(5); x_second(6)]; % neutral vector == head position(camera 좌표계)
head_coef = x_second(7); % head vector를 eye gaze처럼 활용하기 위한 보정계수

[xx, yy, zz] = sph2cart(azimuth,elevation,r); % camera에서 second_display_postion을 잇는 로봇 직교좌표계로 표현

display_position = [xx + sphere_center(1), yy + sphere_center(2), zz + sphere_center(3)]; % head 기준 display position

%% Second display 접평면 생성
[N, R0] = tangent_plane(sphere_center, r, elevation, azimuth);
    
% plane equation: N(1)*(x-R0(1)) + N(2)*(y-R0(2)) + N(3)*(z-R0(3)) = 0
plane_coef = [N(1), N(2), N(3), -N(1)*R0(1) - N(2)*R0(2) - N(3)*R0(3)]; % plane coefficents of second display

%% Second display coordinate system 생성

temp_x_point = display_position + [200, 0, 0]; %display 하단이 cam coord의 xy plane에서 정렬되어있다고 가정했기 때문
new_x_vertical = temp_x_point + [0, 0, 100]; % temp_x_point과 접평면이 수직으로 교차하는 점
new_x_point = line_plane_intersection(temp_x_point, new_x_vertical, plane_coef); % cam coord에서 Second display coordinate system의 x축을 정의하기 위한 점
new_x_axis_vect = (new_x_point-display_position)./norm((new_x_point-display_position)); % x aixs (Second display coordinate system)

new_z_axis_vect = sphere_center' - display_position; % second_display_position에서 sphere center를 잇는 선 -> 모니터는 사용자를 바라본다고 가정했기 때문
new_z_axis_vect = new_z_axis_vect./norm(new_z_axis_vect); % z aixs (Second display coordinate system)

new_y_axis_vect = cross(new_z_axis_vect,new_x_axis_vect); % 앞서 계산한 x, z aixs를 외적
new_y_axis_vect = new_y_axis_vect./norm(new_y_axis_vect); % y aixs (Second display coordinate system)

rotm_plane_coord = [new_x_axis_vect', new_y_axis_vect', new_z_axis_vect']; %cam coord -> second display coord 회전행렬
htrans_plane_coord = [rotm_plane_coord, display_position'; 0, 0, 0, 1]; %cam coord -> second display coord 동차변환행렬

%% pixel coordinate -> Second display coordinate system
% raw_data_true_first = raw_data_true(2:2:end,:); %first display 데이터만 추출
% raw_data_true_second = raw_data_true(1:2:end,:); %second display 데이터만 추출

p2mm_x = 615/1920; %display width/pixels width in processing
p2mm_y = 365/1080; %display height/pixels height in processing

% d1_target_x = (960 - raw_data_true_first.target_x)*p2mm_x; %processing coordinate -> cam coord system (unit: mm)
% d1_target_y = (raw_data_true_first.target_y - 1080)*p2mm_y - 20; %processing coordinate -> cam coord system (unit: mm)
% d1_target = [d1_target_x, d1_target_y, zeros(length(d1_target_x),1)]; % first display target의 3차원 위치 (Cam 좌표계)

target_x = (2880 - raw_data_true_second.target_x)*p2mm_x; %processing coordinate -> cam coord system (unit: mm)
target_y = (raw_data_true_second.target_y - 540)*p2mm_y;%processing coordinate -> cam coord system (unit: mm)

target = []; % second display target의 3차원 위치 (Cam 좌표계)
for i = 1:length(target_x)
    target = vertcat(target, transpose(htrans_plane_coord*[target_x(i), target_y(i), 0, 1]'));
end

%% 헤드 벡터 표현
% head_pose_true = [raw_data_true.pose_Tx, raw_data_true.pose_Ty, raw_data_true.pose_Tz]; % cam coordinate system
head_eul_true = [raw_data_true_second.pose_Rx, raw_data_true_second.pose_Ry, raw_data_true_second.pose_Rz]; % Left-handed positive

R = eul2rotm(head_eul_true,"XYZ"); % head rotation in cam coordinate system (eul unit: rad)
% T = head_pose_true'; % head transpose in cam coordinate system (unit: mm)
T = repmat(sphere_center, 1,length(R));
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

%% dimension reduction & seperate first and second display data for ease of use
head_origin = transpose(reshape(head_origin,4,length(T)));
head_direction = transpose(reshape(head_direction,4,length(T))); 

% head_origin_first = head_origin(2:2:end,:);
% head_origin = head_origin(1:2:end,:);
% head_direction_first = head_direction(2:2:end,:);
% head_direction = head_direction(1:2:end,:);

%% Head calibration
% head_origin_second를 원점으로 하고 head_direction_second를 향하는 벡터를 구좌표계로 변환
[az_head_vect_calib,el_head_vect_calib,r_head_vect_calib] = cart2sph(head_direction(:,1) - head_origin(:,1), head_direction(:,2) - head_origin(:,2), head_direction(:,3) - head_origin(:,3));

% 구좌표계에서 elevation*2 보정
az_head_vect_calib = az_head_vect_calib;
el_head_vect_calib = (el_head_vect_calib + deg2rad(90))*head_coef - deg2rad(90);

% 다시 직교좌표계로 변환
[head_direction_calib_x, head_direction_calib_y, head_direction_calib_z] = sph2cart(az_head_vect_calib, el_head_vect_calib, r_head_vect_calib);
head_direction_calib_x = head_direction_calib_x + head_origin(:,1);
head_direction_calib_y = head_direction_calib_y + head_origin(:,2);
head_direction_calib_z = head_direction_calib_z + head_origin(:,3);
head_direction_calib = [head_direction_calib_x, head_direction_calib_y, head_direction_calib_z];


%% Ray - Plane intersection

% head_first_intersection = [];
head_intersection = [];
head_intersection_calib = [];

for i = 1:length(T)
%     head_first_intersection = vertcat(head_first_intersection, line_plane_intersection(head_origin_first(i,1:3), head_direction_first(i,1:3), plane_coef_first));
    head_intersection = vertcat(head_intersection, line_plane_intersection(head_origin(i,1:3), head_direction(i,1:3), plane_coef));
    head_intersection_calib = vertcat(head_intersection_calib, line_plane_intersection(head_origin(i,1:3), head_direction_calib(i,1:3), plane_coef));
end

target_mm_d2 = [];
head_intersection_mm_d2 = []; % head position in display 2 
head_calib_intersection_mm_d2 = [];

for i=1:length(target)
    target_mm_d2 = vertcat(target_mm_d2, transpose(inv(htrans_plane_coord)*target(i,:)'));
    head_intersection_mm_d2 = vertcat(head_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_intersection(i,:), 1]'));
    head_calib_intersection_mm_d2 = vertcat(head_calib_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_intersection_calib(i,:), 1]'));
end

%% Likelihood Calculation
error_head_second_x = (head_intersection_mm_d2(:,1) - target_mm_d2(:,1));
error_head_second_y = (head_intersection_mm_d2(:,2) - target_mm_d2(:,2));
mu_head = [mean(error_head_second_x), mean(error_head_second_y)];
Sigma_head = cov(error_head_second_x, error_head_second_y);

head_likelihood = mvnpdf([head_calib_intersection_mm_d2(:,1), head_calib_intersection_mm_d2(:,2)], [target_mm_d2(:,1), target_mm_d2(:,2)], [Sigma_head(1,1), 0; 0, Sigma_head(1,1)]);
head_log_likelihood = log(head_likelihood);

Cost = -sum(head_log_likelihood);