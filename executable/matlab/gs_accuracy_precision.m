clear; clc; close all;

sub_file = ["data_robot_1_trials_final","data_robot_2_trials_final","data_robot_3_trials_final","data_robot_4_trials_final","data_robot_5_trials_final"];
path = ["C:\Users\sok78\Downloads\display_estimation-main\display_estimation-main\dataset\user_test_case1_gs\",...
    "C:\Users\sok78\Downloads\display_estimation-main\display_estimation-main\dataset\user_test_case2_gs\",...
    "C:\Users\sok78\Downloads\display_estimation-main\display_estimation-main\dataset\user_test_case3_gs\"];
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];

raw_answer = [];
for p = 1:3 % instruction case
    for s = 1:10 % subject number
        for n = 1:5 % display position
            raw_answer = vertcat(raw_answer,readtable(strcat(path(p),ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0));
        end
    end
end

trials = [4:2:100];
data_dist = []; data_angle = [];
mean_dist = []; mean_angle = [];
std_dist = []; std_angle = [];

for i = 4:2:100
    temp_dist = raw_answer(find(raw_answer.trials == i),2);
    temp_angle = raw_answer(find(raw_answer.trials == i),3);
            
    data_dist = horzcat(data_dist, temp_dist.Distance_Error_mm_);
    data_angle = horzcat(data_angle, temp_angle.Direction_Error_deg_);
    
    mean_dist = vertcat(mean_dist,mean(temp_dist.Distance_Error_mm_));
    mean_angle = vertcat(mean_angle, mean(temp_angle.Direction_Error_deg_));
    
    std_dist = vertcat(std_dist,std(temp_dist.Distance_Error_mm_));
    std_angle = vertcat(std_angle, std(temp_angle.Direction_Error_deg_));
end

%% plot accuracy
% plot(trials',mean_dist,'k','LineWidth',3);
% title('Accuracy Plot - Distance', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Mean Distance Error(mm)', 'FontSize', 16);
% xlim([0 102]);
% ylim([250 400]);
% grid on;

figure;
plot(trials',mean_angle,'k','LineWidth',3);
title('Accuracy Plot - Direction', 'FontSize', 24);
xlabel('Trials', 'FontSize', 16);
ylabel('Mean Direction Error(deg)', 'FontSize', 16);
xlim([0 102]);
ylim([13 22]);
grid on;

%% plot precision
% figure;
% plot(trials',std_dist,'k','LineWidth',3);
% title('Precision Plot(Std) - Distance', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Std of Distance Error(mm)', 'FontSize', 16);
% xlim([0 102]);
% ylim([100 170]);
% grid on;

figure;
plot(trials',std_angle,'k','LineWidth',3);
title('Precision Plot(Std) - Direction', 'FontSize', 24);
xlabel('Trials', 'FontSize', 16);
ylabel('Std of Direction Error(deg)', 'FontSize', 16);
xlim([0 102]);
ylim([5 11]);
grid on;