clear; clc; close all;

raw_data = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\raw_data_[217.999, 445.001, -135.995].csv",'ReadVariableNames',true,'HeaderLines',0);
raw_data = raw_data(raw_data.Success==1,:);
raw_data_true = raw_data(6:end,:); % calibration point 제외한 데이터 추출

raw_data_true_first = raw_data_true(2:2:end,:); %first display 데이터만 추출
raw_data_true_second = raw_data_true(1:2:end,:); %second display 데이터만 추출

%% Optimization
% x(1) = azimuth -> [-pi~pi]; x(2) = elevation -> [-pi/2 ~ pi/2]; x(3) = r -> [norm(sphere_center), norm(sphere_center)+1000]
% fun  = @(x)Objective_function_mle(x,raw_data,raw_data_true,sphere_center);
% fun  = @(x)Objective_function_mle_2disp(x,raw_data,raw_data_true);
fun_first  = @(x_first)Objective_function_mle_1disp(x_first,raw_data_true_first);
fun_second  = @(x_second)Objective_function_mle_2disp(x_second,raw_data_true_second);

xmin = [-pi,-pi/2,550,-1000,-1000,0,1];
xmax = [0,0,2000,1000,1000,1000,5];
x0 = xmin+rand*(xmax-xmin);
lb = [-pi,-pi/2,550,-1000,-1000,0,1];
ub = [0,0,2000,1000,1000,1000,5];

A = [];
b = [];
Aeq = [];
beq = [];

options = optimoptions(@patternsearch,'Display','iter','PollMethod', 'MADSPositiveBasis2N','MeshTolerance',1e-8,'UseCompletePoll', true,'UseCompleteSearch', true,'MeshExpansionFactor', 1.05,'MeshContractionFactor', 0.95,'StepTolerance',1e-6, 'MaxIterations',200);
x_first = patternsearch(fun_first,x0,A,b,Aeq,beq,lb,ub,options);
x_second = patternsearch(fun_second,x0,A,b,Aeq,beq,lb,ub,options);

%%
% hold on
% for i = 1:length(T)
%     plot3([head_origin(i,1), head_direction(i,1)], [head_origin(i,2), head_direction(i,2)], [head_origin(i,3), head_direction(i,3)],'-b');
%     plot3([head_origin(i,1) head_direction_calib(i,1)], [head_origin(i,2) head_direction_calib(i,2)], [head_origin(i,3) head_direction_calib(i,3)],'-y');    
% end
% scatter3(0,0,0,120,'filled','y','pentagram');
% scatter3(display_position(1),display_position(2),display_position(3),120,'filled','y','pentagram');
% 
% scatter3(head_intersection(:,1),head_intersection(:,2),head_intersection(:,3),'filled','c');
% scatter3(target(:,1),target(:,2),target(:,3),120,'filled','r','pentagram'); 
% scatter3(head_intersection_calib(:,1),head_intersection_calib(:,2),head_intersection_calib(:,3),'filled','k');
% hold off
% grid on