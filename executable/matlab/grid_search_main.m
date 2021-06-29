clear; clc; close all;

%% 데이터 경로 (다른 instruction case로 변경할 경우, ref, path에서 user_test_case*_gs 숫자만 변경)
ref = readtable('../../dataset/user_test_case3_gs/ref_coord');
% ref = 레퍼런스 부모니터 중심점 위치가 담긴 파일의 경로
path = "user_test_case3_gs\";
% path = 인스트럭션 케이스(user_test_case1_gs: 가능한 정확하게, user_test_case2_gs: 가능한 빠르게, user_test_case3_gs; 가능한 빠르고 정확하게)
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];
% ss = 피험자 번호
sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
% sub_file = 피험자 데이터 로그 파일 (data_robot_1: 부모니터가 사용자 기준 우측에 위치한 경우, data_robot_2: 중앙, data_robot_3: 좌측, data_robot_4: 좌측, data_robot_5: 우측)

%% 분석 시작
for s = 1:10 % 1번 피험자 ~ 10번 피험자 데이터
    for n = 1:5 % 1번 부모니터 위치 ~ 5번 부모니터 레퍼런스 위치 (우축, 중앙, 좌측, 좌측, 우측)
        ref_new = ref(s*5 - (5-n),:); % ref = 모든 피험자의 레퍼런스 부모니터 위치가 스택 -> ref_new = s번 피험자의 n번 부모니터 레퍼런스 위치
        % 주모니터 좌표계(원점: 주모니터 중심, x축: 주모니터 우측+, y축: 주모니터 상단+, z축: 사용자 방향+)
        ref_display_position = table2array(ref_new(:,:)); % 주모니터 좌표계 기준 부모니터 중심 위치
        % 웹캠 좌표계(원점: 웹캠, x축: 웹캠 좌측+, y축: 웹캠 하단+, z축: 사용자 방향+)
        ref_display_position(1) = -ref_display_position(1); % 주모니터 좌표계 x축 -> 웹캠 좌표계로 변환
        ref_display_position(2) = -ref_display_position(2); % 주모니터 좌표계 y축 -> 웹캠 좌표계로 변환
        ref_display_position(2) = ref_display_position(2) - 365/2 - 20; % 주모니터 좌표계 y축 -> 웹캠 좌표계로 변환
        
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        
        raw_data = raw_data(raw_data.click==1,:); % 전체 기록 중 클릭한 시점의 데이터만 추출
        raw_data_calib_points = raw_data(raw_data.Success==1,:); % 105회 클릭 중 최초 5회 calibration point 식별. (calibration은 클릭 성공만 카운트, 나머지 100회는 성공/실패 모두 카운트)
        last_calib_idx = find(raw_data.Success==1 & raw_data.target_x==960 & raw_data.target_y==540); %  마지막 calibration point 식별
        raw_data_true = raw_data(last_calib_idx+1:end,:); % calibration point 제외한 데이터 추출 -> 얘네만 추정에 활용
        
        trial_fileID = fopen(strcat('..\..\dataset\',path,ss(s),sub_file(n),"_trials_AE40_2.txt"),'w'); % 포함시키는 트라이얼의 갯수에 따라 정확도 정밀도가 어떻게 변하는지 확인용 파일
        fprintf(trial_fileID,"trials,Distance_Error(cm),Direction_Error(deg),ref_display_position_x,ref_display_position_y,ref_display_position_z,second_display_position_x,second_display_position_y,second_display_position_z,elevation_coef,azimuth_coef,Cost\n");
        %% 위치 추정에 사용할 클릭 trial 개수 조정
        for t = 40:2:40 % 40 trial로 고정하려면 40:2:40 으로 대체, 각 모니터 최소 2회 필요하므로 최소값은 4, 최대값은 100
        
       %% calibration process: 머리 벡터 ray가 시작되는 원점(sphere_center) 계산
        LT_1 = raw_data_calib_points(1,:); %calibration point 1: 주모니터 좌측 상단을 클릭할 시점의 사용자 로그
        RT_2 = raw_data_calib_points(2,:); %calibration point 2: 주모니터 우측 상단을 클릭할 시점의 사용자 로그
        LD_3 = raw_data_calib_points(3,:); %calibration point 3: 주모니터 좌측 하단을 클릭할 시점의 사용자 로그
        RD_4 = raw_data_calib_points(4,:); %calibration point 4: 주모니터 우측 하단을 클릭할 시점의 사용자 로그
        
        head_origin_LT = [LT_1.pose_Tx, LT_1.pose_Ty, LT_1.pose_Tz]; % 주모니터 좌측 상단을 클릭할 시점의 머리 위치
        head_origin_RT = [RT_2.pose_Tx, RT_2.pose_Ty, RT_2.pose_Tz]; % 주모니터 우측 상단을 클릭할 시점의 머리 위치
        head_origin_LD = [LD_3.pose_Tx, LD_3.pose_Ty, LD_3.pose_Tz]; % 주모니터 좌측 하단을 클릭할 시점의 머리 위치
        head_origin_RD = [RD_4.pose_Tx, RD_4.pose_Ty, RD_4.pose_Tz]; % 주모니터 우측 하단을 클릭할 시점의 머리 위치
        
        % sphere_center = calibration point 머리 위치의 산술 평균
        sphere_center = [(head_origin_LT(1) + head_origin_RT(1) + head_origin_LD(1) + head_origin_RD(1))/4, (head_origin_LT(2) + head_origin_RT(2) + head_origin_LD(2) + head_origin_RD(2))/4, (head_origin_LT(3) + head_origin_RT(3) + head_origin_LD(3) + head_origin_RD(3))/4 ]';
        
        %% calibration 제외한 데이터 추리기
        raw_data_true_trial = raw_data_true(1:t,:); %raw_data_true_trial = 1~t개 클릭 데이터 (calibration point 제외)        
        first_idx = find(raw_data_true_trial{:,4}<=1920); % 타겟 위치를 기준으로 주모니터 데이터의 인덱스 선별(1920 = 주모니터 가로축 해상도)
        second_idx = find(raw_data_true_trial{:,4}>1920); % 타겟 위치를 기준으로 부모니터 데이터의 인덱스 선별
        
        raw_data_true_first = raw_data_true_trial(first_idx,:); % 주모니터 데이터만 추출
        raw_data_true_second = raw_data_true_trial(second_idx,:); % 부모니터 데이터만 추출
        
       %% Grid Search Optimization
        
        % grid space setting (m1: 가능도 계산할 부모니터 x 위치 간격, m2: y 위치 간격, m3: z 위치 간격, m4,m5: 머리-시선 보정계수 간격)
        m1 = 8; m2 = 8; m3 = 7; m4 = 12; m5 = 12;

        % construct grid
        if mean(raw_data_true_second.pose_Ry) > 0 % 머리를 평균적으로 우측으로 회전한 경우
            G1 = linspace(-800,0,m1); % 탐색할 그리드 포인트 x
            G5 = linspace(-4,-1,m5); % 탐색할 그리드 포인트의 머리-시선 보정계수(azimuth angle coef)
        else % 머리를 평균적으로 좌측으로 회전한 경우
            G1 = linspace(0,800,m1); % 탐색할 그리드 포인트 x
            G5 = linspace(1,4,m5); % 탐색할 그리드 포인트의 머리-시선 보정계수(azimuth angle coef)
        end        
        G2 = linspace(-800,-365/2,m2); % 탐색할 그리드 포인트 y
        G3 = linspace(-300,300,m3); % 탐색할 그리드 포인트 z
        G4 = linspace(1,4,m4); % 탐색할 그리드 포인트의 머리-시선 보정계수(elevation angle coef)
        
        
        % initial values
        x1_max = -1e+10; x2_max = -1e+10; x3_max = -1e+10; x4_max = -1e+10; x5_max = -1e+10;           
        Cost_max = -1e+10;
        second_display_position_max = [0,0,0];
        
        A_cand = []; % Answer candidate 초기화: 거리오차, 각도오차, 레퍼런스 부모니터 위치, 추정 부모니터 위치, 머리 시선 보정계수, 가능도, feasible check
               
        p_Cost_max = zeros(m1,1); % p_: 병렬 연산용(parfor) 파라미터 컨테이너. 모든 그리드 포인트에서 계산 후 최대값 추출
        p_x1_max = zeros(m1,1); p_x2_max = zeros(m1,1); p_x3_max = zeros(m1,1); p_x4_max = zeros(m1,1); p_x5_max = zeros(m1,1);       

        tic
        parfor Q = 1:m1
            x1_max = -1e+10; x2_max = -1e+10; x3_max = -1e+10; x4_max = -1e+10; x5_max = -1e+10;        
            Cost_max = -1e+10;
            second_display_position_max = [0,0,0];
            
        for W = 1:m2
        for E = 1:m3
        for R = 1:m4
        for T = 1:m5
            x = [G1(Q), G2(W), G3(E), G4(R), G5(T)];
            [Cost, second_display_position] = grid_search_mle(x, raw_data_true_trial, sphere_center); % grid_search_mle: 로그 가능도 합 계산하는 함수
            
            [aa_R,bb_R,cc_R,dd_R] = plane_3p(sphere_center', [-615,-365/2,0], [-615/2, -365,0]); % FoV 제약조건 평면 생성
            A_R = [-aa_R,-bb_R,-cc_R,0,0];
            b_R = [dd_R];
            
            [aa_L,bb_L,cc_L,dd_L] = plane_3p(sphere_center', [615/2, -365,0], [615,-365/2,0]); % FoV 제약조건 평면 생성
            A_L = [-aa_L,-bb_L,-cc_L,0,0];
            b_L = [dd_L];
            
            if (A_L*x'<=b_L) | (A_R*x'<=b_R) % 탐색한 그리드 포인트가 FoV 제약 조건을 만족하는지
                if (norm([-615/2-sphere_center(1), -365/2-sphere_center(2), 0-sphere_center(3)]) < norm([G1(Q)-sphere_center(1), G2(W)-sphere_center(2), G3(E)-sphere_center(3)])) % 탐색한 그리드 포인트가 최소 거리 제약조건(추정이 과도하게 사용자와 가깝게 되지 않도록)을 만족하는지
                    feasible = 1; % 탐색한 그리드 포인트가 Feasible region 안에 있는지
                    if (Cost >= Cost_max) % 탐색한 그리드 포인트의 가능도가 기존 가능도 비교
                        Cost_max = Cost;
                        x1_max = G1(Q);
                        x2_max = G2(W);
                        x3_max = G3(E);
                        x4_max = G4(R);
                        x5_max = G5(T);
                        second_display_position_max = second_display_position;
                    end
                else
                    feasible = 0;
                end
            else
                feasible = 0;
            end            
            P1_cand = ref_display_position - sphere_center'; % 각도 오차 계산용 벡터(머리 위치 -> 레퍼런스 부모니터 중심점)
            P2_cand = second_display_position - sphere_center'; %  각도 오차 계산용 벡터(머리 위치 -> 추정 부모니터 중심점)
            
            A_cand = vertcat(A_cand,[norm(ref_display_position - second_display_position), atan2d(norm(cross(P1_cand,P2_cand)),dot(P1_cand,P2_cand)), ref_display_position(1), ref_display_position(2), ref_display_position(3), second_display_position(1), second_display_position(2), second_display_position(3), x(4), x(5), Cost, feasible]);
            % A_cand = Answer candidate: 거리오차, 각도오차, 레퍼런스 부모니터 위치, 추정 부모니터 위치, 머리 시선 보정계수, 가능도, feasible check

        end
        end
        end
        end        
            p_Cost_max(Q) = Cost_max; % 병렬 연산된 최대값 그리드 포인트들 중의 최대값 그리드 포인트 추출
            p_x1_max(Q) = x1_max; p_x2_max(Q) = x2_max; p_x3_max(Q) = x3_max; p_x4_max(Q) = x4_max; p_x5_max(Q) = x5_max;        
        end
        
        [M, M_Idx] = max(p_Cost_max); % 최대값 및 최대값의 인덱스
        max_second_display_position = [p_x1_max(M_Idx), p_x2_max(M_Idx), p_x3_max(M_Idx)];
        toc
        %% 결과 저장
        %_cand = 모든 그리드 포인트에 대해 계산한 결과
        headers_cand = {'Distance_Error(cm)','Direction_Error(deg)','ref_display_position_x','ref_display_position_y','ref_display_position_z','second_display_position_x','second_display_position_y','second_display_position_z','elevation_coef','azimuth_coef','Cost','feasible'};
        title_cand = convertStringsToChars(strcat('..\..\dataset\',path,ss(s),sub_file(n),'_cand_AE40_2'));
        csvwrite_with_headers(title_cand,A_cand,headers_cand);

        %_trial = 위치 추정에 사용할 클릭 trial 개수 조정해가며 추정한 최종 결과
        P1_trial = ref_display_position - sphere_center'; 
        P2_trial = max_second_display_position - sphere_center';
        A_trial = [t,norm(ref_display_position - max_second_display_position), atan2d(norm(cross(P1_trial,P2_trial)),dot(P1_trial,P2_trial)), ref_display_position(1), ref_display_position(2), ref_display_position(3), max_second_display_position(1), max_second_display_position(2), max_second_display_position(3), p_x4_max(M_Idx), p_x5_max(M_Idx), M];
        fprintf(trial_fileID,'%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',A_trial);
        end
        
        fclose(trial_fileID);

       %% 추정 결과 시각화 (여기서부터는 grid_search_mle.m 파일과 동일)
        xx = p_x1_max(M_Idx); yy = p_x2_max(M_Idx); zz = p_x3_max(M_Idx); ele_coef = p_x4_max(M_Idx); azi_coef = p_x5_max(M_Idx); % 초기 파라미터 설정
        second_display_position = [xx, yy, zz]; % 임의 부모니터 위치 입력
        [azimuth,elevation,r] = cart2sph(second_display_position(1)-sphere_center(1),second_display_position(2)-sphere_center(2),second_display_position(3)-sphere_center(3)); % 극좌표로 변경
        
        %% 부모니터(구의 접평면) 생성
        [N, R0] = tangent_plane(sphere_center, r, elevation, azimuth); % N=normal vector, R0=구와 접평면의 접점
        
        % plane equation: N(1)*(x-R0(1)) + N(2)*(y-R0(2)) + N(3)*(z-R0(3)) = 0
        plane_coef_first = [0,0,1,0]; % plane coefficents of first display(주모니터)
        plane_coef_second = [N(1), N(2), N(3), -N(1)*R0(1) - N(2)*R0(2) - N(3)*R0(3)]; % plane coefficents of second display(부모니터)
        
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
        
        d2_target = []; % second display target의 3차원 위치 (웹캠 좌표계)
        for i = 1:length(d2_target_x)
            d2_target = vertcat(d2_target, transpose(htrans_plane_coord*[d2_target_x(i), d2_target_y(i), 0, 1]'));
        end
        
        %% 머리 방향벡터 벡터 표현
        head_pose_true = [raw_data_true.pose_Tx, raw_data_true.pose_Ty, raw_data_true.pose_Tz]; % cam coordinate system
        head_eul_true = [raw_data_true.pose_Rx, raw_data_true.pose_Ry, raw_data_true.pose_Rz]; % Left-handed positive
        
        R = eul2rotm(head_eul_true,"XYZ"); % head rotation in cam coordinate system (eul unit: rad)
        T = head_pose_true'; % head transpose in cam coordinate system (unit: mm)
        htrans = [];
        for i = 1:length(T)
            htrans = cat(3,htrans,[R(:,:,i), T(:,i); 0, 0, 0, 1]); % head to cam coord
        end
        
        head_origin = []; % 머리 방향벡터의 시작점
        head_direction = []; % 머리 방향벡터의 끝점
        for i = 1:length(T)
            head_origin = cat(3, head_origin, htrans(:,:,i)*[0,0,0,1]');
            head_direction = cat(3, head_direction, htrans(:,:,i)*[0,0,-1500,1]');
        end
        
        head_origin = transpose(reshape(head_origin,4,size(T,2)));
        head_direction = transpose(reshape(head_direction,4,size(T,2)));
        
        %% 머리 방향벡터의 주모니터, 부모니터 데이터 분리
        head_origin_first = head_origin(first_idx,:); 
        head_origin_second = head_origin(second_idx,:);
        head_direction_first = head_direction(first_idx,:);
        head_direction_second = head_direction(second_idx,:);
        
        %% Head-Gaze calibration
        % head_direction_second를 head_origin_second를 원점으로 하는 구좌표계로 변환
        [az_head_vect_calib,el_head_vect_calib,r_head_vect_calib] = cart2sph(head_direction_second(:,1) - head_origin_second(:,1), head_direction_second(:,2) - head_origin_second(:,2), head_direction_second(:,3) - head_origin_second(:,3));
        
        % 구좌표계에서 azimuth, elevation angle 보정
        az_head_vect_calib = (az_head_vect_calib + deg2rad(180))*azi_coef - deg2rad(180);
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
        
        for i = 1:length(head_direction_first)
            head_first_intersection = vertcat(head_first_intersection, line_plane_intersection(head_origin_first(i,1:3), head_direction_first(i,1:3), plane_coef_first));
        end
        
        for i = 1:length(head_direction_second)
            head_second_intersection = vertcat(head_second_intersection, line_plane_intersection(head_origin_second(i,1:3), head_direction_second(i,1:3), plane_coef_second));
            head_second_intersection_calib = vertcat(head_second_intersection_calib, line_plane_intersection(head_origin_second(i,1:3), head_direction_second_calib(i,1:3), plane_coef_second));
        end
        
        %% 타겟과 머리 방향벡터 좌표계 변경(웹캠 좌표계 -> 부모니터 좌표계)
        d2_target_mm_d2 = []; % 부모니터 타겟 위치표현 변환
        head_second_intersection_mm_d2 = []; % 머리 방향벡터(고도각 보정 전) - 부모니터 교점 변환
        head_second_calib_intersection_mm_d2 = []; % 머리 방향벡터(고도각 보정 후) - 부모니터 교점 변환
        
        for i=1:length(d2_target)
            d2_target_mm_d2 = vertcat(d2_target_mm_d2, transpose(inv(htrans_plane_coord)*d2_target(i,:)'));
            head_second_intersection_mm_d2 = vertcat(head_second_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection(i,:), 1]'));
            head_second_calib_intersection_mm_d2 = vertcat(head_second_calib_intersection_mm_d2, transpose(inv(htrans_plane_coord)*[head_second_intersection_calib(i,:), 1]'));
        end
        
        %% Likelihood Calculation(타겟 위치를 평균으로 하는 2차원 정규분포)
        error_head_second_x = (head_second_intersection_mm_d2(:,1) - d2_target_mm_d2(:,1)); 
        error_head_second_y = (head_second_intersection_mm_d2(:,2) - d2_target_mm_d2(:,2));
%         mu_head = [mean(error_head_second_x), mean(error_head_second_y)]; 
        Sigma_head = cov(error_head_second_x, error_head_second_y);
        
        head_likelihood = mvnpdf([head_second_calib_intersection_mm_d2(:,1), head_second_calib_intersection_mm_d2(:,2)], [d2_target_mm_d2(:,1), d2_target_mm_d2(:,2)], [Sigma_head(1,1), 0; 0, Sigma_head(1,1)]);
        head_log_likelihood = log(head_likelihood);
        
        Cost = -sum(head_log_likelihood);
        
        %% 시각화
        hold on
        
        % 머리 방향벡터 보정 전/후
        for i=1:length(second_idx)
            plot3([head_origin_second(i,1), head_direction_second(i,1)], [head_origin_second(i,2), head_direction_second(i,2)], [head_origin_second(i,3), head_direction_second(i,3)],'Color', [0 0.4470 0.7410 0.25], 'LineWidth', 1.4);
            plot3([head_origin_second(i,1) head_direction_second_calib(i,1)], [head_origin_second(i,2) head_direction_second_calib(i,2)], [head_origin_second(i,3) head_direction_second_calib(i,3)],'Color',[0.9290 0.6940 0.1250 0.25], 'LineWidth', 1.4);
        end
                
        % 머리 방향벡터 - 주/부모니터 교점
        scatter3(head_second_intersection(:,1),head_second_intersection(:,2),head_second_intersection(:,3),'filled','c');
        scatter3(head_second_intersection_calib(:,1),head_second_intersection_calib(:,2),head_second_intersection_calib(:,3),'filled','k');
        scatter3(d1_target_x,d1_target_y,zeros(length(d1_target_x),1),120,'filled','k','pentagram');
        scatter3(d2_target(:,1),d2_target(:,2),d2_target(:,3),120,'filled','k','pentagram');
        
        grid on
                        
        % 거리오차
        plot3([ref_display_position(1), second_display_position(1)], [ref_display_position(2), second_display_position(2)], [ref_display_position(3), second_display_position(3)],'k:','LineWidth',3);
        % 주모니터 프레임
        plot3([-615/2 -615/2 615/2 615/2 -615/2], [0 -365 -365 0 0], [0 0 0 0 0], 'k', 'LineWidth',4.16);
        est_c1 = htrans_plane_coord*[-615/2 365/2 0 1]'; est_c2 = htrans_plane_coord*[-615/2 -365/2 0 1]'; est_c3 = htrans_plane_coord*[615/2 -365/2 0 1]'; est_c4 = htrans_plane_coord*[615/2 365/2 0 1]';
        % 추정 부모니터 프레임
        plot3([est_c1(1) est_c2(1) est_c3(1) est_c4(1) est_c1(1)], [est_c1(2) est_c2(2) est_c3(2) est_c4(2) est_c1(2)], [est_c1(3) est_c2(3) est_c3(3) est_c4(3) est_c1(3)], 'b', 'LineWidth',4.16);

        
       %% 레퍼런스 부모니터 프레임 시각화
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
        % 레퍼런스 부모니터 프레임 시각화
        plot3([ref_c1(1) ref_c2(1) ref_c3(1) ref_c4(1) ref_c1(1)], [ref_c1(2) ref_c2(2) ref_c3(2) ref_c4(2) ref_c1(2)], [ref_c1(3) ref_c2(3) ref_c3(3) ref_c4(3) ref_c1(3)], 'k', 'LineWidth',4.16);        
        hold off
        saveas(gcf, strcat('..\..\dataset\',path,ss(s),sub_file(n),'.fig'));
       %% 결과 저장

        P1 = ref_display_position - sphere_center';
        P2 = second_display_position - sphere_center';
        fprintf('Distance Error(cm): %f \n',norm(ref_display_position - second_display_position))
        fprintf('Direction Error(deg): %f \n',atan2d(norm(cross(P1,P2)),dot(P1,P2)))
        
        headers = {'Distance_Error(cm)','Direction_Error(deg)','ref_display_position_x','ref_display_position_y','ref_display_position_z','second_display_position_x','second_display_position_y','second_display_position_z','elevation_coef','azimuth_coef'};

        A = [norm(ref_display_position - second_display_position), atan2d(norm(cross(P1,P2)),dot(P1,P2)), ref_display_position(1), ref_display_position(2), ref_display_position(3), second_display_position(1), second_display_position(2), second_display_position(3), ele_coef, azi_coef];
        title = convertStringsToChars(strcat('..\..\dataset\',path,ss(s),sub_file(n),'_result_AE40_2'));
        csvwrite_with_headers(title,A,headers);
    end
end
