clear; clc; close all;

%% 데이터 경로 (다른 instruction case로 변경할 경우, ref, path에서 user_test_case*_gs 숫자만 변경)
ref = readtable('../../dataset/user_test_case4_bo/ref_coord');
% ref = 레퍼런스 부모니터 중심점 위치가 담긴 파일의 경로
path = "user_test_case4_bo\";
% path = 인스트럭션 케이스(user_test_case1_gs: 가능한 정확하게, user_test_case2_gs: 가능한 빠르게, user_test_case3_gs; 가능한 빠르고 정확하게)
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];
% ss = 피험자 번호
sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
% sub_file = 피험자 데이터 로그 파일 (data_robot_1: 부모니터가 사용자 기준 우측에 위치한 경우, data_robot_2: 중앙, data_robot_3: 좌측, data_robot_4: 좌측, data_robot_5: 우측)

%% 분석 시작
for s = 8:8 % 1번 피험자 ~ 10번 피험자 데이터
    for n = 4:5 % 1번 부모니터 위치 ~ 5번 부모니터 레퍼런스 위치 (우축, 중앙, 좌측, 좌측, 우측)
        ref_new = ref(s*5 - (5-n),:); % ref = 모든 피험자의 레퍼런스 부모니터 위치가 스택 -> ref_new = s번 피험자의 n번 부모니터 레퍼런스 위치
        % 주모니터 좌표계(원점: 주모니터 중심, x축: 주모니터 우측+, y축: 주모니터 상단+, z축: 사용자 방향+)
        ref_display_position = table2array(ref_new(:,:)); % 주모니터 좌표계 기준 부모니터 중심 위치
        % 웹캠 좌표계(원점: 웹캠, x축: 웹캠 좌측+, y축: 웹캠 하단+, z축: 사용자 방향+)
        ref_display_position(1) = -ref_display_position(1); % 주모니터 좌표계 x축 -> 웹캠 좌표계로 변환
        ref_display_position(2) = -ref_display_position(2); % 주모니터 좌표계 y축 -> 웹캠 좌표계로 변환
        ref_display_position(2) = ref_display_position(2) - 365/2 - 20; % 주모니터 좌표계 y축 -> 웹캠 좌표계로 변환
        
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        
        %% Low-pass Filtering
        raw_data.pose_Tx = lowpass(raw_data.pose_Tx,1,60,'ImpulseResponse','auto');
        raw_data.pose_Ty = lowpass(raw_data.pose_Ty,1,60,'ImpulseResponse','auto');
        raw_data.pose_Tz = lowpass(raw_data.pose_Tz,1,60,'ImpulseResponse','auto');
        raw_data.pose_Rx = lowpass(raw_data.pose_Rx,1,60,'ImpulseResponse','auto');
        raw_data.pose_Ry = lowpass(raw_data.pose_Ry,1,60,'ImpulseResponse','auto');
        raw_data.pose_Rz = lowpass(raw_data.pose_Rz,1,60,'ImpulseResponse','auto');
                
        raw_data = raw_data(raw_data.click==1,:); % 전체 기록 중 클릭한 시점의 데이터만 추출
        raw_data_calib_points = raw_data(raw_data.Success==1,:); % 105회 클릭 중 최초 5회 calibration point 식별. (calibration은 클릭 성공만 카운트, 나머지 100회는 성공/실패 모두 카운트)
        last_calib_idx = find(raw_data.Success==1 & raw_data.target_x==960 & raw_data.target_y==540); %  마지막 calibration point 식별
        raw_data_true = raw_data(last_calib_idx+1:end,:); % calibration point 제외한 데이터 추출 -> 얘네만 추정에 활용
        
        trial_fileID = fopen(strcat('..\..\dataset\',path,ss(s),sub_file(n),"_trials_bayes.txt"),'w'); % 포함시키는 트라이얼의 갯수에 따라 정확도 정밀도가 어떻게 변하는지 확인용 파일
        fprintf(trial_fileID,"trials,ref_x,ref_y,ref_z,best_x,best_y,best_z,best_w,best_s,best_distance_error,best_direction_error,t1_x,t1_y,t1_z,t1_w,t1_s,t1_distance_error,t1_direction_error,t2_x,t2_y,t2_z,t2_w,t2_s,t2_distance_error,t2_direction_error,t3_x,t3_y,t3_z,t3_w,t3_s,t3_distance_error,t3_direction_error,t4_x,t4_y,t4_z,t4_w,t4_s,t4_distance_error,t4_direction_error\n");
        %% 위치 추정에 사용할 클릭 trial 개수 조정
        
        for t = 2:2:100 % 40 trial로 고정하려면 40:2:40 으로 대체, 각 모니터 최소 1회 필요하므로 최소값은 2, 최대값은 100
            tic
           %% 초기 5번 calibration 클릭 제외한 데이터 추리기
            raw_data_true_trial = raw_data_true(1:t,:); %raw_data_true_trial = 1~t개 클릭 데이터 (calibration point 제외)
            first_idx = find(raw_data_true_trial{:,4}<=1920); % 타겟 위치를 기준으로 주모니터 데이터의 인덱스 선별(1920 = 주모니터 가로축 해상도)
            second_idx = find(raw_data_true_trial{:,4}>1920); % 타겟 위치를 기준으로 부모니터 데이터의 인덱스 선별
            
            raw_data_true_first = raw_data_true_trial(first_idx,:); % 주모니터 데이터만 추출
            raw_data_true_second = raw_data_true_trial(second_idx,:); % 부모니터 데이터만 추출
            sphere_center = [mean(raw_data_true_first.pose_Tx), mean(raw_data_true_first.pose_Ty), mean(raw_data_true_first.pose_Tz)]'; % 머리 벡터 ray가 시작되는 원점 계산
            %% Bayesian Optimization
                        
            if mean(raw_data_true_second.pose_Ry) > 0 % Right
                xvar = optimizableVariable('xvar',[-800,-1],'Type','integer');
                [aa,bb,cc,dd] = plane_3p(sphere_center', [-615,-365/2,0], [-615/2, -365,0]); % FoV 제약조건 평면 생성
                A = [-aa,-bb,-cc,0,0];
                b = [dd];
                yvar = optimizableVariable('yvar',[-800,round(-365/2)],'Type','integer');
                zvar = optimizableVariable('zvar',[-300,300],'Type','integer');
                wvar = optimizableVariable('wvar',[0.9999999,1.0000001]);
                svar = optimizableVariable('svar',[0,2]);
                vars = [xvar, yvar, zvar, wvar, svar];
                                               
            else % Left
                xvar = optimizableVariable('xvar',[1,800],'Type','integer');
                [aa,bb,cc,dd] = plane_3p(sphere_center', [615/2, -365,0], [615,-365/2,0]); % FoV 제약조건 평면 생성
                A = [-aa,-bb,-cc,0,0];
                b = [dd];
                yvar = optimizableVariable('yvar',[-800,round(-365/2)],'Type','integer');
                zvar = optimizableVariable('zvar',[-300,300],'Type','integer');
                wvar = optimizableVariable('wvar',[0.9999999,1.0000001]);
                svar = optimizableVariable('svar',[0,2]);
                vars = [xvar, yvar, zvar, wvar, svar];
            end
                                               
            fun  = @(x)bayesopt_mle(x, raw_data_true, sphere_center);
            
            bayes_results = [];
            for i = 1:4
                results = bayesopt(fun,vars,'XConstraintFcn',@(x)xconstraint(x,sphere_center, A,b),'UseParallel',true, 'NumSeedPoints',128, 'MaxObjectiveEvaluations',56, 'AcquisitionFunctionName','expected-improvement-per-second-plus', 'ExplorationRatio',0.5,'PlotFcn',[],'Verbose',0);
                
                if isempty(results.XAtMinObjective)
                    c_second_display_position = table2array(results.XAtMinEstimatedObjective(:,1:3));
                    c_head_gazecoef = table2array(results.XAtMinEstimatedObjective(:,4));
                    c_sigma = table2array(results.XAtMinEstimatedObjective(:,5));
                else
                    c_second_display_position = table2array(results.XAtMinObjective(:,1:3));
                    c_head_gazecoef = table2array(results.XAtMinObjective(:,4));
                    c_sigma = table2array(results.XAtMinObjective(:,5));
                end

                c_P1 = ref_display_position - sphere_center';
                c_P2 = c_second_display_position - sphere_center';
                bayes_results = vertcat(bayes_results,[c_second_display_position, c_head_gazecoef, c_sigma, norm(ref_display_position - c_second_display_position), atan2d(norm(cross(c_P1,c_P2)),dot(c_P1,c_P2))]);
            end
            
            [M,min_idx] = min(bayes_results(:,6));
            best_performance = bayes_results(min_idx, :); % 최고 성능

          %% 결과 저장
            
            %_trial = 위치 추정에 사용할 클릭 trial 개수 조정해가며 추정한 최종 결과
            A_trial = [t, ref_display_position, best_performance, bayes_results(1,:), bayes_results(2,:), bayes_results(3,:), bayes_results(4,:)];
            fprintf(trial_fileID,'%d, %f,%f,%f, %f,%f,%f,%f,%f,%f,%f,  %f,%f,%f,%f,%f,%f,%f,  %f,%f,%f,%f,%f,%f,%f,  %f,%f,%f,%f,%f,%f,%f,  %f,%f,%f,%f,%f,%f,%f, \n',A_trial);
            
            toc
        end
        
        fclose(trial_fileID);

    end
end
