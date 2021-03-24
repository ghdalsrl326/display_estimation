function Cost = Objective_function_mle(x, raw_data, raw_data_true, sphere_center)

%sphere_center에서 second_display_postion을 잇는 벡터를 구좌표계로 표현
azimuth = x(1); elevation = x(2); r = x(3);

[xx, yy, zz] = sph2cart(azimuth,elevation,r);
second_display_position = [-(xx + sphere_center(1)), -(yy + sphere_center(2) + 365/2 + 20), zz + sphere_center(3)];
second_display_position(1) = -second_display_position(1); 
second_display_position(2) = -second_display_position(2); 
second_display_position(2) = second_display_position(2) - 365/2 - 20; % camera 좌표계로 변환 (unit: mm)

%% Second display 접평면 생성
% [N, R0] = tangent_plane(sphere_center, norm(second_display_position'-sphere_center), elevation, azimuth);
[N, R0] = tangent_plane(sphere_center, r, elevation, azimuth);
    
% plane equation: N(1)*(x-R0(1)) + N(2)*(y-R0(2)) + N(3)*(z-R0(3)) = 0
plane_coef_first = [0,0,1,0]; % plane coefficents of first display 
plane_coef_second = [N(1), N(2), N(3), -N(1)*R0(1) - N(2)*R0(2) - N(3)*R0(3)]; % plane coefficents of second display 

%% Second display coordinate system 생성

temp_x_point = second_display_position + [-200, 0, 0]; %display 하단이 cam coord의 xy plane에서 정렬되어있다고 가정했기 때문
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
raw_data_true_first = raw_data_true(2:2:end,:); %first display 데이터만 추출
raw_data_true_second = raw_data_true(1:2:end,:); %second display 데이터만 추출

p2mm = 307.5/960; %pixel to mm (display half width/pixels half width in processing)
d1_target_x = (raw_data_true_first.target_x - 960)*p2mm + sphere_center(1);
d1_target_y = (540 - raw_data_true_first.target_y)*p2mm + sphere_center(2);
d1_target = [d1_target_x, d1_target_y, zeros(length(d1_target_x),1)]; % first display target의 3차원 위치 (Cam 좌표계)

d2_target_x = (raw_data_true_second.target_x - 2880)*p2mm;
d2_target_y = (540 - raw_data_true_second.target_y)*p2mm;
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
for i = 1:length(T)
    htrans = cat(3,htrans,[R(:,:,i), T(:,i); 0, 0, 0, 1]); % head to cam coord    
end

head_origin = [];
head_direction = [];
for i = 1:length(T)
    head_origin = cat(3, head_origin, htrans(:,:,i)*[0,0,0,1]');
    head_direction = cat(3, head_direction, htrans(:,:,i)*[0,0,-1000,1]');
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

% % eye gaze position in cam coordinate (points_left, points_right in c++ visualizer)
% gaze_position_first = gaze_vector_first + eye_origin_first; 
% gaze_position_second = gaze_vector_second + eye_origin_second; 
% % eye origin 에서 시작해 gaze position 으로 끝나는 벡터를 구좌표계로 변환
% [az_eye_vect_first,el_eye_vect_first,r_eye_vect_first] = cart2sph(gaze_position_first(:,1) - eye_origin_first(:,1), gaze_position_first(:,2) - eye_origin_first(:,2), gaze_position_first(:,3) - eye_origin_first(:,3));
% [az_eye_vect_second,el_eye_vect_second,r_eye_vect_second] = cart2sph(gaze_position_second(:,1) - eye_origin_second(:,1), gaze_position_second(:,2) - eye_origin_second(:,2), gaze_position_second(:,3) - eye_origin_second(:,3));

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

%% Head calibration
% head_direction_second를 head_origin_second를 원점으로 하는 구좌표계로 변환
[az_head_vect_calib,el_head_vect_calib,r_head_vect_calib] = cart2sph(head_direction_second(:,1) - head_origin_second(:,1), head_direction_second(:,2) - head_origin_second(:,2), head_direction_second(:,3) - head_origin_second(:,3));

% 구좌표계에서 azimutal, elevation * 1.5
az_head_vect_calib = az_head_vect_calib*(-1.5);
el_head_vect_calib = el_head_vect_calib*(1);

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
% gaze_first_intersection = [];
% gaze_second_intersection = [];
for i = 1:length(head_direction_first)
    head_first_intersection = vertcat(head_first_intersection, line_plane_intersection(head_origin_first(i,1:3), head_direction_first(i,1:3), plane_coef_first));
    head_second_intersection = vertcat(head_second_intersection, line_plane_intersection(head_origin_second(i,1:3), head_direction_second(i,1:3), plane_coef_second));
    head_second_intersection_calib = vertcat(head_second_intersection_calib, line_plane_intersection(head_origin_second(i,1:3), head_direction_second_calib(i,1:3), plane_coef_second));
%     gaze_first_intersection = vertcat(gaze_first_intersection, line_plane_intersection(eye_origin_first(i,1:3), gaze_position_first(i,1:3), plane_coef_first));
%     gaze_second_intersection = vertcat(gaze_second_intersection, line_plane_intersection(eye_origin_second(i,1:3), gaze_position_second(i,1:3), plane_coef_second));
end

d2_target_mm_d2 = [];
head_second_intersection_mm_d2 = []; % head position in display 2 
head_second_calib_intersection_mm_d2 = [];
% gaze_second_intersection_mm_d2 = [];
for i=1:length(d2_target)
    d2_target_mm_d2 = vertcat(d2_target_mm_d2, transpose(inv(htrans_plane_coord)*d2_target(i,:)'));
    head_second_intersection_mm_d2 = vertcat(head_second_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection(i,:), 1]'));
    head_second_calib_intersection_mm_d2 = vertcat(head_second_calib_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection_calib(i,:), 1]'));

    %     gaze_second_intersection_mm_d2 = vertcat(gaze_second_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[gaze_second_intersection(i,:), 1]'));
end

%% Likelihood Calculation
error_head_second_x = (head_second_intersection_mm_d2(:,1) - d2_target_mm_d2(:,1));
error_head_second_y = (head_second_intersection_mm_d2(:,2) - d2_target_mm_d2(:,2));
mu_head = [mean(error_head_second_x), mean(error_head_second_y)];
Sigma_head = cov(error_head_second_x, error_head_second_y);
% 
% 
% head_likelihood = mvnpdf([head_second_intersection_mm_d2(:,1), head_second_intersection_mm_d2(:,2)], [d2_target_x, d2_target_y], [Sigma_head(1,1), 0; 0, Sigma_head(1,1)]);
% head_log_likelihood = log(head_likelihood);


head_likelihood = mvnpdf([head_second_calib_intersection_mm_d2(:,1), head_second_calib_intersection_mm_d2(:,2)], [d2_target_x, d2_target_y], [Sigma_head(1,1), 0; 0, Sigma_head(1,1)]);
head_log_likelihood = log(head_likelihood);

% Cost = -sum(head_log_likelihood);
Cost = -sum(head_log_likelihood);

