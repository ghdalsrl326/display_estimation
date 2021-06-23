clear; clc; close all;

sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
path = ["C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\"];
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];

raw_answer = [];
millis = [];
error = [];
for p = 1:3
    for s = 1:10
        for n = 1:5
            
            raw_data = readtable(strcat(path(p),ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0);
            raw_data = raw_data(:,1:71);
            raw_data = raw_data(raw_data.click==1,:);
            raw_data_calib_points = raw_data(raw_data.Success==1,:);
            last_calib_idx = find(raw_data.Success==1 & raw_data.target_x==960 & raw_data.target_y==540);
            
            raw_data_true = raw_data(last_calib_idx+1:end,:); % calibration point 제외한 데이터 추출
            
            raw_answer = vertcat(raw_answer, raw_data_true);
            millis_temp = raw_data_true.millis;
            millis_temp(end:500,1) = 0;
            millis = horzcat(millis,millis_temp);
            
            error_rate = raw_data_true.Success;
            error_rate(end:500,1) = 0;
            error = horzcat(error,error_rate);

        end
    end
end

diff_millis = diff(millis,1,1);
mean_diff_millis = [];
for i = 1:98
    mean_diff_millis = vertcat(mean_diff_millis, mean(diff_millis(i,:)));
end

error_rate = [];
for i = 1:99
    error_rate = vertcat(error_rate, 100 - sum(error(i,:))*100/size(error,2));
end

%% Plot Learning Curve
plot(mean_diff_millis,'k','LineWidth',3);
title('Learning Curve', 'FontSize', 24);
xlabel('Trials', 'FontSize', 16);
ylabel('Trial Completion Time(ms)', 'FontSize', 16);
ylim([1000 2500]);
grid on

%% Plot Error Rate Curve
% figure;
% plot(error_rate,'k','LineWidth',3);
% title('Error Rate', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Error Rate(%)', 'FontSize', 16);
% ylim([0, 50]);
% grid on