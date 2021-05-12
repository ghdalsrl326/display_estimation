function [Cost, second_display_position] = grid_search_mle(x, raw_data_true, sphere_center)

% azimuth = x(1); elevation = x(2); r = x(3); ele_coef = x(4);
xx = x(1); yy = x(2); zz = x(3);
ele_coef = x(4);

%%
% [xx, yy, zz] = sph2cart(azimuth,elevation,r);
% second_display_position = [xx - sphere_center(1), yy - sphere_center(2), zz - sphere_center(3)];

second_display_position = [xx, yy, zz];
[azimuth,elevation,r] = cart2sph(second_display_position(1)-sphere_center(1),second_display_position(2)-sphere_center(2),second_display_position(3)-sphere_center(3));

%% Second display 접평면 생성
% [N, R0] = tangent_plane(sphere_center, norm(second_display_position'-sphere_center), elevation, azimuth);
[N, R0] = tangent_plane_gs(sphere_center, r, elevation, azimuth);
    
% plane equation: N(1)*(x-R0(1)) + N(2)*(y-R0(2)) + N(3)*(z-R0(3)) = 0
plane_coef_first = [0,0,1,0]; % plane coefficents of first display 
plane_coef_second = [N(1), N(2), N(3), -N(1)*R0(1) - N(2)*R0(2) - N(3)*R0(3)]; % plane coefficents of second display 

%% Second display coordinate system 생성

temp_x_point = second_display_position + [200, 0, 0]; %display 하단이 cam coord의 xy plane에서 정렬되어있다고 가정했기 때문
new_x_vertical = temp_x_point + [0, 0, 100]; % temp_x_point과 접평면이 수직으로 교차하는 점
new_x_point = line_plane_intersection(temp_x_point, new_x_vertical, plane_coef_second); % cam coord에서 Second display coordinate system의 x축을 정의하기 위한 점
new_x_axis_vect = (new_x_point-second_display_position)./norm((new_x_point-second_display_position)); % x aixs (Second display coordinate system)

new_z_axis_vect = sphere_center' - second_display_position; % second_display_position에서 sphere center를 잇는 선 -> 모니터는 사용자를 바라본다고 가정했기 때문
new_z_axis_vect = new_z_axis_vect./norm(new_z_axis_vect); % z aixs (Second display coordinate system)

new_y_axis_vect = cross(new_z_axis_vect,new_x_axis_vect); % 앞서 계산한 x, z aixs를 외적
new_y_axis_vect = new_y_axis_vect./norm(new_y_axis_vect); % y aixs (Second display coordinate system)

rotm_plane_coord = [new_x_axis_vect', new_y_axis_vect', new_z_axis_vect']; %cam coord -> second display coord 회전행렬
htrans_plane_coord = [rotm_plane_coord, second_display_position'; 0, 0, 0, 1]; %cam coord -> second display coord 동차변환행렬

%% pixel coordinate -> Second display coordinate system
first_idx = find(raw_data_true{:,4}<=1920);
second_idx = find(raw_data_true{:,4}>1920);
        
raw_data_true_first = raw_data_true(first_idx,:); %first display 데이터만 추출
raw_data_true_second = raw_data_true(second_idx,:); %second display 데이터만 추출
        
p2mm_x = 615/1920; %display width/pixels width in processing
p2mm_y = 365/1080; %display height/pixels height in processing

d1_target_x = (960 - raw_data_true_first.target_x)*p2mm_x; %processing coordinate -> cam coord system (unit: mm)
d1_target_y = (raw_data_true_first.target_y - 1080)*p2mm_y - 20; %processing coordinate -> cam coord system (unit: mm)
d1_target = [d1_target_x, d1_target_y, zeros(length(d1_target_x),1)]; % first display target의 3차원 위치 (Cam 좌표계)

d2_target_x = (2880 - raw_data_true_second.mouseX)*p2mm_x; %processing coordinate -> cam coord system (unit: mm)
d2_target_y = (raw_data_true_second.mouseY - 540)*p2mm_y;%processing coordinate -> cam coord system (unit: mm)

d2_target = []; % second display target의 3차원 위치 (Cam 좌표계)
for i = 1:length(d2_target_x)
    d2_target = vertcat(d2_target, transpose(htrans_plane_coord*[d2_target_x(i), d2_target_y(i), 0, 1]'));
end

%% 헤드, 게이즈 벡터 표현
head_pose_true = [raw_data_true.pose_Tx, raw_data_true.pose_Ty, raw_data_true.pose_Tz]; % cam coordinate system
head_eul_true = [raw_data_true.pose_Rx, raw_data_true.pose_Ry, raw_data_true.pose_Rz]; % Left-handed positive

R = eul2rotm(head_eul_true,"XYZ"); % head rotation in cam coordinate system (eul unit: rad)
T = head_pose_true'; % head transpose in cam coordinate system (unit: mm)
htrans = [];
for i = 1:size(T,2)
    htrans = cat(3,htrans,[R(:,:,i), T(:,i); 0, 0, 0, 1]); % head to cam coord    
end

head_origin = [];
head_direction = [];
for i = 1:size(T,2)
    head_origin = cat(3, head_origin, htrans(:,:,i)*[0,0,0,1]');
    head_direction = cat(3, head_direction, htrans(:,:,i)*[0,0,-1500,1]');
end

%% dimension reduction & seperate first and second display data for ease of use
head_origin = transpose(reshape(head_origin,4,size(T,2)));
head_direction = transpose(reshape(head_direction,4,size(T,2))); 

head_origin_first = head_origin(first_idx,:);
head_origin_second = head_origin(second_idx,:);
head_direction_first = head_direction(first_idx,:);
head_direction_second = head_direction(second_idx,:);

%% Head calibration
% head_direction_second를 head_origin_second를 원점으로 하는 구좌표계로 변환
[az_head_vect_calib,el_head_vect_calib,r_head_vect_calib] = cart2sph(head_direction_second(:,1) - head_origin_second(:,1), head_direction_second(:,2) - head_origin_second(:,2), head_direction_second(:,3) - head_origin_second(:,3));

% 구좌표계에서 elevation*2 보정
az_head_vect_calib = (az_head_vect_calib + deg2rad(180))*1 - deg2rad(180);
el_head_vect_calib = (el_head_vect_calib + deg2rad(90))*ele_coef - deg2rad(90);

% 다시 직교좌표계로 변환 후 plot
[head_direction_second_calib_x, head_direction_second_calib_y, head_direction_second_calib_z] = sph2cart(az_head_vect_calib, el_head_vect_calib, r_head_vect_calib);
head_direction_second_calib_x = head_direction_second_calib_x + head_origin_second(:,1);
head_direction_second_calib_y = head_direction_second_calib_y + head_origin_second(:,2);
head_direction_second_calib_z = head_direction_second_calib_z + head_origin_second(:,3);
head_direction_second_calib = [head_direction_second_calib_x, head_direction_second_calib_y, head_direction_second_calib_z];


%% Ray - Tangent plane intersection

head_first_intersection = [];
head_second_intersection = [];
head_second_intersection_calib = [];

for i = 1:size(head_direction_first,1)
    head_first_intersection = vertcat(head_first_intersection, line_plane_intersection(head_origin_first(i,1:3), head_direction_first(i,1:3), plane_coef_first));
end

for i = 1:size(head_direction_second,1)
    head_second_intersection = vertcat(head_second_intersection, line_plane_intersection(head_origin_second(i,1:3), head_direction_second(i,1:3), plane_coef_second));
    head_second_intersection_calib = vertcat(head_second_intersection_calib, line_plane_intersection(head_origin_second(i,1:3), head_direction_second_calib(i,1:3), plane_coef_second));
end


d2_target_mm_d2 = [];
head_second_intersection_mm_d2 = []; % head position in display 2 
head_second_calib_intersection_mm_d2 = [];

for i=1:size(d2_target,1)
    d2_target_mm_d2 = vertcat(d2_target_mm_d2, transpose(inv(htrans_plane_coord)*d2_target(i,:)'));
    head_second_intersection_mm_d2 = vertcat(head_second_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection(i,:), 1]'));
    head_second_calib_intersection_mm_d2 = vertcat(head_second_calib_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection_calib(i,:), 1]'));
end

%% Likelihood Calculation
error_head_second_x = (head_second_intersection_mm_d2(:,1) - d2_target_mm_d2(:,1));
error_head_second_y = (head_second_intersection_mm_d2(:,2) - d2_target_mm_d2(:,2));
mu_head = [mean(error_head_second_x), mean(error_head_second_y)];
Sigma_head = cov(error_head_second_x, error_head_second_y);

head_likelihood = mvnpdf([head_second_calib_intersection_mm_d2(:,1), head_second_calib_intersection_mm_d2(:,2)], [d2_target_mm_d2(:,1), d2_target_mm_d2(:,2)], [Sigma_head(1,1), 0; 0, Sigma_head(1,1)]);
head_log_likelihood = log(head_likelihood);

Cost = sum(head_log_likelihood);

