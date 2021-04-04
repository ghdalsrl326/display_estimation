clear; clc; close all;

raw_data = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\raw_data_[-666.002, 365.976, 115.018].csv",'ReadVariableNames',true,'HeaderLines',0);
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

raw_data_true_first = raw_data_true(2:2:end,:); %first display 데이터만 추출
raw_data_true_second = raw_data_true(1:2:end,:); %second display 데이터만 추출


%% Optimization
% x(1) = azimuth -> [-pi~pi]; x(2) = elevation -> [-pi/2 ~ pi/2]; x(3) = r -> [norm(sphere_center), norm(sphere_center)+1000]
fun  = @(x)Objective_function_mle(x,raw_data,raw_data_true,sphere_center);

%탐색 영역 축소
% if mean(raw_data_true_first.pose_Ry) < mean(raw_data_true_second.pose_Ry) % 오른쪽으로 고개를 돌릴 때 
%     xmin = [pi/2,-pi/2,550];
%     xmax = [pi,0,2500];
%     x0 = xmin+rand*(xmax-xmin);
%     lb = [pi/2,-pi/2,550];
%     ub = [pi,0,1500];
% end
% 
% if mean(raw_data_true_first.pose_Ry) > mean(raw_data_true_second.pose_Ry) % 왼쪽으로 고개를 돌릴 때 
%     xmin = [0,-pi/2,550];
%     xmax = [pi/2,0,2500];
%     x0 = xmin+rand*(xmax-xmin);
%     lb = [0,-pi/2,550];
%     ub = [pi/2,0,1500];
% end

xmin = [-pi,-pi/2,550];
xmax = [0,0,2000];
x0 = xmin+rand*(xmax-xmin);
lb = [-pi,-pi/2,550];
ub = [0,0,2000];

A = [];
b = [];
Aeq = [];
beq = [];

options = optimoptions(@patternsearch,'Display','iter','PollMethod', 'MADSPositiveBasis2N','MeshTolerance',1e-8,'UseCompletePoll', true,'UseCompleteSearch', true,'MeshExpansionFactor', 1.05,'MeshContractionFactor', 0.95,'StepTolerance',1e-6, 'MaxIterations',150);
x = patternsearch(fun,x0,A,b,Aeq,beq,lb,ub,options);