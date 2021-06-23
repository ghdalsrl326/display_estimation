function [Cost, second_display_position] = grid_search_mle(x, raw_data_true, sphere_center)

xx = x(1); yy = x(2); zz = x(3); ele_coef = x(4); % 초기 파라미터 설정

second_display_position = [xx, yy, zz]; % 임의 부모니터 위치
[azimuth,elevation,r] = cart2sph(second_display_position(1)-sphere_center(1),second_display_position(2)-sphere_center(2),second_display_position(3)-sphere_center(3)); % 극좌표로 변경

%% 부모니터(구의 접평면) 생성
[N, R0] = tangent_plane_gs(sphere_center, r, elevation, azimuth); % N=normal vector, R0=구와 접평면의 접점
    
% plane equation: N(1)*(x-R0(1)) + N(2)*(y-R0(2)) + N(3)*(z-R0(3)) = 0
plane_coef_first = [0,0,1,0]; % plane coefficents of first display(주모니터)
plane_coef_second = [N(1), N(2), N(3), -N(1)*R0(1) - N(2)*R0(2) - N(3)*R0(3)]; % plane coefficents of second display (부모니터)

%% 부모니터 좌표계 생성

temp_x_point = second_display_position + [200, 0, 0]; %display 하단이 cam coord의 xy plane에서 정렬되어있다고 가정했기 때문
new_x_vertical = temp_x_point + [0, 0, 100]; % temp_x_point과 접평면이 수직으로 교차하는 점
new_x_point = line_plane_intersection(temp_x_point, new_x_vertical, plane_coef_second); % cam coord에서 Second display coordinate system의 x축을 정의하기 위한 점
new_x_axis_vect = (new_x_point-second_display_position)./norm((new_x_point-second_display_position)); % x aixs (Second display coordinate system)

new_z_axis_vect = sphere_center' - second_display_position; % second_display_position에서 sphere center를 잇는 선 -> 모니터는 사용자를 바라본다고 가정했기 때문
new_z_axis_vect = new_z_axis_vect./norm(new_z_axis_vect); % z aixs (Second display coordinate system)

new_y_axis_vect = cross(new_z_axis_vect,new_x_axis_vect); % 앞서 계산한 x, z aixs를 외적
new_y_axis_vect = new_y_axis_vect./norm(new_y_axis_vect); % y aixs (Second display coordinate system)

rotm_plane_coord = [new_x_axis_vect', new_y_axis_vect', new_z_axis_vect']; %webcam coord -> second display coord 회전행렬
htrans_plane_coord = [rotm_plane_coord, second_display_position'; 0, 0, 0, 1]; %webcam coord -> second display coord 동차변환행렬

%% 타겟 위치 표현변환(픽셀 좌표계 -> 웹캠 좌표계)
first_idx = find(raw_data_true{:,4}<=1920); % 주모니터에 생성된 타겟의 인덱스
second_idx = find(raw_data_true{:,4}>1920); % 부모니터에 생성된 타겟의 인덱스
        
raw_data_true_first = raw_data_true(first_idx,:); %주모니터 데이터만 추출
raw_data_true_second = raw_data_true(second_idx,:); %부모니터 데이터만 추출
        
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

%% 머리 방향벡터 벡터 표현
head_pose_true = [raw_data_true.pose_Tx, raw_data_true.pose_Ty, raw_data_true.pose_Tz]; % cam coordinate system
head_eul_true = [raw_data_true.pose_Rx, raw_data_true.pose_Ry, raw_data_true.pose_Rz]; % Left-handed positive

R = eul2rotm(head_eul_true,"XYZ"); % head rotation in cam coordinate system (eul unit: rad)
T = head_pose_true'; % head transpose in cam coordinate system (unit: mm)
htrans = [];
for i = 1:size(T,2)
    htrans = cat(3,htrans,[R(:,:,i), T(:,i); 0, 0, 0, 1]); % head to cam coord    
end

head_origin = []; % 머리 방향벡터의 시작점
head_direction = []; % 머리 방향벡터의 끝점
for i = 1:size(T,2)
    head_origin = cat(3, head_origin, htrans(:,:,i)*[0,0,0,1]');
    head_direction = cat(3, head_direction, htrans(:,:,i)*[0,0,-1500,1]');
end

head_origin = transpose(reshape(head_origin,4,size(T,2)));
head_direction = transpose(reshape(head_direction,4,size(T,2))); 

%% 머리 방향벡터의 주모니터, 부모니터 케이스 분리
head_origin_first = head_origin(first_idx,:);
head_origin_second = head_origin(second_idx,:);
head_direction_first = head_direction(first_idx,:);
head_direction_second = head_direction(second_idx,:);

%% Head-Gaze calibration
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


%% 웹캠 좌표계 기준 Ray(머리 방향벡터) - Tangent plane(주/부 모니터) 교점 계산

head_first_intersection = []; % 머리 방향벡터 - 주모니터 교점
head_second_intersection = []; % 머리 방향벡터(고도각 보정 전) - 부모니터 교점
head_second_intersection_calib = []; % 머리 방향벡터(고도각 보정 후) - 부모니터 교점

for i = 1:size(head_direction_first,1)
    head_first_intersection = vertcat(head_first_intersection, line_plane_intersection(head_origin_first(i,1:3), head_direction_first(i,1:3), plane_coef_first));
end

for i = 1:size(head_direction_second,1)
    head_second_intersection = vertcat(head_second_intersection, line_plane_intersection(head_origin_second(i,1:3), head_direction_second(i,1:3), plane_coef_second));
    head_second_intersection_calib = vertcat(head_second_intersection_calib, line_plane_intersection(head_origin_second(i,1:3), head_direction_second_calib(i,1:3), plane_coef_second));
end

%% 타겟과 머리 방향벡터 좌표계 변경(웹캠 좌표계 -> 부모니터 좌표계)
d2_target_mm_d2 = []; % 부모니터 타겟 위치표현 변환
head_second_intersection_mm_d2 = []; % 머리 방향벡터(고도각 보정 전) - 부모니터 교점 변환
head_second_calib_intersection_mm_d2 = []; % 머리 방향벡터(고도각 보정 후) - 부모니터 교점 변환

for i=1:size(d2_target,1)
    d2_target_mm_d2 = vertcat(d2_target_mm_d2, transpose(inv(htrans_plane_coord)*d2_target(i,:)'));
    head_second_intersection_mm_d2 = vertcat(head_second_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection(i,:), 1]'));
    head_second_calib_intersection_mm_d2 = vertcat(head_second_calib_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection_calib(i,:), 1]'));
end

%% Likelihood Calculation(타겟 위치를 평균으로 하는 2차원 정규분포)
error_head_second_x = (head_second_intersection_mm_d2(:,1) - d2_target_mm_d2(:,1));
error_head_second_y = (head_second_intersection_mm_d2(:,2) - d2_target_mm_d2(:,2));
% mu_head = [mean(error_head_second_x), mean(error_head_second_y)];
Sigma_head = cov(error_head_second_x, error_head_second_y);

head_likelihood = mvnpdf([head_second_calib_intersection_mm_d2(:,1), head_second_calib_intersection_mm_d2(:,2)], [d2_target_mm_d2(:,1), d2_target_mm_d2(:,2)], [Sigma_head(1,1), 0; 0, Sigma_head(1,1)]);
head_log_likelihood = log(head_likelihood);

Cost = sum(head_log_likelihood);

