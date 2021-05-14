clear; clc; close all;

sub_file = ["data_robot_1_trials","data_robot_2_trials","data_robot_3_trials","data_robot_4_trials","data_robot_5_trials"];
path = ["C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\"];
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];

raw_answer = [];
for p = 1:3
    for s = 1:10
        for n = 1:5
            raw_answer = vertcat(raw_answer,readtable(strcat(path(p),ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0));
        end
    end
end

trials = [2:1:50];
data_dist = []; data_angle = [];
mean_dist = []; mean_angle = [];
std_dist = []; std_angle = [];

for i = 2:50
    temp_dist = raw_answer(find(raw_answer.trials == i),2);
    temp_angle = raw_answer(find(raw_answer.trials == i),3);
            
    data_dist = horzcat(data_dist, temp_dist.Distance_Error_cm_);
    data_angle = horzcat(data_angle, temp_angle.Direction_Error_deg_);
    
    mean_dist = vertcat(mean_dist,mean(temp_dist.Distance_Error_cm_));
    mean_angle = vertcat(mean_angle, mean(temp_angle.Direction_Error_deg_));
    
    std_dist = vertcat(std_dist,std(temp_dist.Distance_Error_cm_));
    std_angle = vertcat(std_angle, std(temp_angle.Direction_Error_deg_));
end

%% plot accuracy
% plot(trials',mean_dist,'k','LineWidth',3);
% title('Accuracy Plot - Distance', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Mean Distance Error(mm)', 'FontSize', 16);
% xlim([0 52]);
% ylim([250 400]);

% figure;
% plot(trials',mean_angle,'b','LineWidth',3);
% title('Accuracy Plot - Direction', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Mean Direction Error(deg)', 'FontSize', 16);
% xlim([0 52]);
% ylim([13 22]);

%% plot precision

% plot(trials',std_dist,'k','LineWidth',3);
% title('Precision Plot(std) - Distance', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Std of Distance Error(mm)', 'FontSize', 16);
% xlim([0 52]);
% ylim([100 170]);

% figure;
% plot(trials',std_angle,'k','LineWidth',3);
% title('Precision Plot(std) - Direction', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Std of Direction Error(deg)', 'FontSize', 16);
% xlim([0 52]);
% ylim([5 11]);

%%