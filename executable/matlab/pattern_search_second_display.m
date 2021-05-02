clear; clc; close all;

ref = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test\ref_coord");
sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
path = "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test\";
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\","11\","12\","13\","14\","15\","16\","17\","18\","19\","20\"];


for s = 11:11
    for n = 1:1
        ref_new = ref(s*5 - (5-n),:);
        
        raw_data = readtable(strcat(path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0);
        raw_data = raw_data(raw_data.Success==1,:);
        raw_data_true = raw_data(6:end,:); % calibration point 제외한 데이터 추출
        
        LT_1 = raw_data(1,:);
        RT_2 = raw_data(2,:);
        LD_3 = raw_data(3,:);
        RD_4 = raw_data(4,:);
        
        [head_origin_LT, head_direction_LT, eye_origin_LT, gaze_vector_LT] = calibration_import_module(LT_1);
        [head_origin_RT, head_direction_RT, eye_origin_RT, gaze_vector_RT] = calibration_import_module(RT_2);
        [head_origin_LD, head_direction_LD, eye_origin_LD, gaze_vector_LD] = calibration_import_module(LD_3);
        [head_origin_RD, head_direction_RD, eye_origin_RD, gaze_vector_RD] = calibration_import_module(RD_4);
        % sphere_center = head position의 산술 평균
        sphere_center = [(head_origin_LT(1) + head_origin_RT(1) + head_origin_LD(1) + head_origin_RD(1))/4, (head_origin_LT(2) + head_origin_RT(2) + head_origin_LD(2) + head_origin_RD(2))/4, (head_origin_LT(3) + head_origin_RT(3) + head_origin_LD(3) + head_origin_RD(3))/4 ]';
        
        first_idx = find(raw_data_true{:,4}<=1920);
        second_idx = find(raw_data_true{:,4}>1920);
        
        raw_data_true_first = raw_data_true(first_idx,:); %first display 데이터만 추출
        raw_data_true_second = raw_data_true(second_idx,:); %second display 데이터만 추출
        
        %% Optimization
        % x(1) = azimuth -> [-pi~pi]; x(2) = elevation -> [-pi/2 ~ pi/2]; x(3) = r -> [norm(sphere_center), norm(sphere_center)+1000]
        fun  = @(x)Objective_function_mle(x,raw_data,raw_data_true,sphere_center);
       
        
        if mean(raw_data_true_second.pose_Ry) > 0 % Right
            xmin = [-1500,-1500,-600,1];
            xmax = [0,-365/2,200,2];
            x0 = xmin+rand*(xmax-xmin);
            lb = [-1500,-1500,-600,1];
            ub = [0,-365/2,200,3];
            [aa,bb,cc,dd] = plane_3p(sphere_center', [-615,-365/2,0], [-615/2, -365,0]);
            A = [-aa,-bb,-cc,0];
            b = [dd];
        else % Left
            xmin = [0,-1500,-600,1];
            xmax = [1500,-365/2,200,2];
            x0 = xmin+rand*(xmax-xmin);
            lb = [0,-1500,-600,1];
            ub = [1500,-365/2,200,3];
            [aa,bb,cc,dd] = plane_3p(sphere_center', [615/2, -365,0], [615,-365/2,0]);
            A = [-aa,-bb,-cc,0];
            b = [dd];
        end
        
        Aeq = [];
        beq = [];
        
        options = optimoptions(@patternsearch,'Display','iter','PollMethod', 'MADSPositiveBasis2N','MeshTolerance',1e-8,'UseCompletePoll', true,'UseCompleteSearch', true,'MeshExpansionFactor', 1.05,'MeshContractionFactor', 0.95,'StepTolerance',1e-6, 'MaxIterations',200);
        
        x = patternsearch(fun,x0,A,b,Aeq,beq,lb,ub,options);
        
        
        
        %% Estimation 결과 시각화
        
        xx = x(1); yy = x(2); zz = x(3);
        ele_coef = x(4);
        
        %     second_display_position = [-(xx + sphere_center(1)), -(yy + sphere_center(2) + 365/2 + 20), zz + sphere_center(3)];
        %     second_display_position(1) = -second_display_position(1);
        %     second_display_position(2) = -second_display_position(2);
        %     second_display_position(2) = second_display_position(2) - 365/2 - 20; % camera 좌표계로 변환 (unit: mm)
        
        second_display_position = [xx, yy, zz];
        %sphere_center에서 second_display_postion을 잇는 벡터를 구좌표계로 표현
        [azimuth,elevation,r] = cart2sph(second_display_position(1)-sphere_center(1),second_display_position(2)-sphere_center(2),second_display_position(3)-sphere_center(3));
        
        %% Second display 접평면 생성
        % [N, R0] = tangent_plane(sphere_center, norm(second_display_position'-sphere_center), elevation, azimuth);
        [N, R0] = tangent_plane(sphere_center, r, elevation, azimuth);
        
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
        
        d2_target_x = (2880 - raw_data_true_second.target_x)*p2mm_x; %processing coordinate -> cam coord system (unit: mm)
        d2_target_y = (raw_data_true_second.target_y - 540)*p2mm_y;%processing coordinate -> cam coord system (unit: mm)
        
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
            head_direction = cat(3, head_direction, htrans(:,:,i)*[0,0,-1500,1]');
        end
        
        %% dimension reduction & seperate first and second display data for ease of use
        head_origin = transpose(reshape(head_origin,4,100));
        head_direction = transpose(reshape(head_direction,4,100));
        
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
        
        for i = 1:length(head_direction_first)
            head_first_intersection = vertcat(head_first_intersection, line_plane_intersection(head_origin_first(i,1:3), head_direction_first(i,1:3), plane_coef_first));
        end
        
        for i = 1:length(head_direction_second)
            head_second_intersection = vertcat(head_second_intersection, line_plane_intersection(head_origin_second(i,1:3), head_direction_second(i,1:3), plane_coef_second));
            head_second_intersection_calib = vertcat(head_second_intersection_calib, line_plane_intersection(head_origin_second(i,1:3), head_direction_second_calib(i,1:3), plane_coef_second));
        end
        
        d2_target_mm_d2 = [];
        head_second_intersection_mm_d2 = []; % head position in display 2
        head_second_calib_intersection_mm_d2 = [];
        
        for i=1:length(d2_target)
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
        
        Cost = -sum(head_log_likelihood);
        
        %%
        hold on
        
        for i=1:length(second_idx)
            plot3([head_origin_second(i,1), head_direction_second(i,1)], [head_origin_second(i,2), head_direction_second(i,2)], [head_origin_second(i,3), head_direction_second(i,3)],'Color', [0 0.4470 0.7410 0.25], 'LineWidth', 1.4);
            plot3([head_origin_second(i,1) head_direction_second_calib(i,1)], [head_origin_second(i,2) head_direction_second_calib(i,2)], [head_origin_second(i,3) head_direction_second_calib(i,3)],'Color',[0.9290 0.6940 0.1250 0.25], 'LineWidth', 1.4);
        end
                
        scatter3(head_second_intersection(:,1),head_second_intersection(:,2),head_second_intersection(:,3),'filled','c');
        scatter3(head_second_intersection_calib(:,1),head_second_intersection_calib(:,2),head_second_intersection_calib(:,3),'filled','k');
        scatter3(d1_target_x,d1_target_y,zeros(length(d1_target_x),1),120,'filled','k','pentagram');
        scatter3(d2_target(:,1),d2_target(:,2),d2_target(:,3),120,'filled','k','pentagram');
        
        grid on
        
        %% 시각화
        
        ref_display_position = table2array(ref_new(:,:)); % first display 좌표계 기준 second display의 중심 위치(주의: fisrt display와 달리 원점이 중심임)
        ref_display_position(1) = -ref_display_position(1);
        ref_display_position(2) = -ref_display_position(2);
        ref_display_position(2) = ref_display_position(2) - 365/2 - 20; % camera 좌표계 기준으로 변환
        plot3([ref_display_position(1), second_display_position(1)], [ref_display_position(2), second_display_position(2)], [ref_display_position(3), second_display_position(3)],'k:','LineWidth',3);
        plot3([-615/2 -615/2 615/2 615/2 -615/2], [0 -365 -365 0 0], [0 0 0 0 0], 'k', 'LineWidth',4.16);
        est_c1 = htrans_plane_coord*[-615/2 365/2 0 1]'; est_c2 = htrans_plane_coord*[-615/2 -365/2 0 1]'; est_c3 = htrans_plane_coord*[615/2 -365/2 0 1]'; est_c4 = htrans_plane_coord*[615/2 365/2 0 1]';
        plot3([est_c1(1) est_c2(1) est_c3(1) est_c4(1) est_c1(1)], [est_c1(2) est_c2(2) est_c3(2) est_c4(2) est_c1(2)], [est_c1(3) est_c2(3) est_c3(3) est_c4(3) est_c1(3)], 'b', 'LineWidth',4.16);

        
       %%
        [azimuth_ref,elevation_ref,r_ref] = cart2sph(ref_display_position(1)-sphere_center(1),ref_display_position(2)-sphere_center(2),ref_display_position(3)-sphere_center(3));
        [N_ref, R0_ref] = ref_tangent_plane(sphere_center, norm(ref_display_position'-sphere_center), elevation_ref, azimuth_ref);

        plane_coef_ref = [N_ref(1), N_ref(2), N_ref(3), -N_ref(1)*R0_ref(1) - N_ref(2)*R0_ref(2) - N_ref(3)*R0_ref(3)];
        
        temp_x_point = ref_display_position + [200, 0, 0]; %display 하단이 cam coord의 xy plane에서 정렬되어있다고 가정했기 때문
        new_x_vertical = temp_x_point + [0, 0, 100]; % temp_x_point과 접평면이 수직으로 교차하는 점
        new_x_point = line_plane_intersection(temp_x_point, new_x_vertical, plane_coef_ref); % cam coord에서 Second display coordinate system의 x축을 정의하기 위한 점
        new_x_axis_vect = (new_x_point-ref_display_position)./norm((new_x_point-ref_display_position)); % x aixs (Second display coordinate system)
        
        new_z_axis_vect = sphere_center' - ref_display_position; % second_display_position에서 sphere center를 잇는 선 -> 모니터는 사용자를 바라본다고 가정했기 때문
        new_z_axis_vect = new_z_axis_vect./norm(new_z_axis_vect); % z aixs (Second display coordinate system)
        
        new_y_axis_vect = cross(new_z_axis_vect,new_x_axis_vect); % 앞서 계산한 x, z aixs를 외적
        new_y_axis_vect = new_y_axis_vect./norm(new_y_axis_vect); % y aixs (Second display coordinate system)
        
        rotm_plane_coord_ref = [new_x_axis_vect', new_y_axis_vect', new_z_axis_vect']; %cam coord -> second display coord 회전행렬
        htrans_plane_coord_ref = [rotm_plane_coord_ref, ref_display_position'; 0, 0, 0, 1]; %cam coord -> second display coord 동차변환행렬
        ref_c1 = htrans_plane_coord_ref*[-615/2 365/2 0 1]'; ref_c2 = htrans_plane_coord_ref*[-615/2 -365/2 0 1]'; ref_c3 = htrans_plane_coord_ref*[615/2 -365/2 0 1]'; ref_c4 = htrans_plane_coord_ref*[615/2 365/2 0 1]';
        hold on

        plot3([ref_c1(1) ref_c2(1) ref_c3(1) ref_c4(1) ref_c1(1)], [ref_c1(2) ref_c2(2) ref_c3(2) ref_c4(2) ref_c1(2)], [ref_c1(3) ref_c2(3) ref_c3(3) ref_c4(3) ref_c1(3)], 'k', 'LineWidth',4.16);
        
        %%
        hold off

        saveas(gcf, strcat(path,ss(s),sub_file(n),'.fig'));
        P1 = ref_display_position - sphere_center';
        P2 = second_display_position - sphere_center';
        fprintf('Distance Error(cm): %f \n',norm(ref_display_position - second_display_position))
        fprintf('Direction Error(deg): %f \n',atan2d(norm(cross(P1,P2)),dot(P1,P2)))
        
        headers = {'Distance_Error(cm)','Direction_Error(deg)','ref_display_position_x','ref_display_position_y','ref_display_position_z','second_display_position_x','second_display_position_y','second_display_position_z','elevation_coef'};

        A = [norm(ref_display_position - second_display_position), atan2d(norm(cross(P1,P2)),dot(P1,P2)), ref_display_position(1), ref_display_position(2), ref_display_position(3), second_display_position(1), second_display_position(2), second_display_position(3), x(4)];
        title = convertStringsToChars(strcat(path,ss(s),sub_file(n),'_result.csv'));
        csvwrite_with_headers(title,A,headers);
    end
end