clear; clc; close all;

sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
path = ["C:\Users\msi\Downloads\display_estimation-main (2)\display_estimation-main\dataset\user_test_case1_bo\",...
    "C:\Users\msi\Downloads\display_estimation-main (2)\display_estimation-main\dataset\user_test_case2_bo\",...
    "C:\Users\msi\Downloads\display_estimation-main (2)\display_estimation-main\dataset\user_test_case3_bo\",...
    "C:\Users\msi\Downloads\display_estimation-main (2)\display_estimation-main\dataset\user_test_case4_bo\"];
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];

raw_answer = [];
millis = [];
error = [];
for p = 1:4 % instruction case
    for s = 1:10 % subject number
        for n = 1:5 % display position
            
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
            error_rate(end+1:500,1) = 0;
            error = horzcat(error,error_rate);

        end
    end
end

diff_millis = diff(millis,1,1);
mean_diff_millis = [];
mean_diff_millis_inst1 = []; mean_diff_millis_inst2 = []; mean_diff_millis_inst3 = []; mean_diff_millis_inst4 = [];
for i = 1:98
    mean_diff_millis = vertcat(mean_diff_millis, mean(diff_millis(i,:)));
    mean_diff_millis_inst1 = vertcat(mean_diff_millis_inst1, mean(diff_millis(i,1:50)));
    mean_diff_millis_inst2 = vertcat(mean_diff_millis_inst2, mean(diff_millis(i,51:100)));
    mean_diff_millis_inst3 = vertcat(mean_diff_millis_inst3, mean(diff_millis(i,101:150)));
    mean_diff_millis_inst4 = vertcat(mean_diff_millis_inst4, mean(diff_millis(i,151:200)));
end

% mean_diff_millis_R = mean([diff_millis(98,1:5:150), diff_millis(98,5:5:150)]);
% std_diff_millis_R = std([diff_millis(98,1:5:150), diff_millis(98,5:5:150)]);
% 
% mean_diff_millis_C = mean([diff_millis(98,2:5:150)]);
% std_diff_millis_C = std([diff_millis(98,2:5:150)]);
% 
% mean_diff_millis_L = mean([diff_millis(98,3:5:150), diff_millis(98,4:5:150)]);
% std_diff_millis_L = std([diff_millis(98,3:5:150), diff_millis(98,4:5:150)]);

% error_rate_RLC = 100 - sum(error(1:100,:),'all')*100/(150*100);
% error_rate_R = 100 - sum([error(1:100,1:5:150), error(1:100,5:5:150)],'all')*100/(60*100);
% error_rate_L = 100 - sum([error(1:100,3:5:150), error(1:100,4:5:150)],'all')*100/(60*100);
% error_rate_C = 100 - sum(error(1:100,2:5:150),'all')*100/(30*100);
% 
% error_rate_inst1 = 100 - sum(error(1:100,1:1:50),'all')*100/(50*100);
% error_rate_inst2 = 100 - sum(error(1:100,51:1:100),'all')*100/(50*100);
% error_rate_inst3 = 100 - sum(error(1:100,101:1:150),'all')*100/(50*100);

%% Plot Learning Curve
figure;
hold on;
grid on;
x = [2:2:100];
TCT_0 = plot(mean_diff_millis,'k','LineWidth',2,'Marker','o');
TCT_1 = plot(mean_diff_millis_inst1,'LineWidth',2,'Marker','^');
TCT_2 = plot(mean_diff_millis_inst2,'LineWidth',2,'Marker','+');
TCT_3 = plot(mean_diff_millis_inst3,'LineWidth',2,'Marker','*');
TCT_4 = plot(mean_diff_millis_inst4,'LineWidth',2,'Marker','x');

TCT = [TCT_0, TCT_1, TCT_2, TCT_3, TCT_4];
ylim([1000 2500]);

xlabel('\itPoint-and-Click Trials');
ylabel('\itTrial Completion Time (ms)');
set(gca,'FontSize',20);

leg1=legend(TCT, 'Overall (\itM\rm = 120)', 'Instruction - 1', 'Instruction - 2', 'Instruction - 3', 'Instruction - 4','Location','northeastoutside');
title(leg1,'{\itTrial Completion Time\rm}');
set(leg1,'FontSize',15);

% 
% %% Plot Error Rate Curve
% % figure;
% plot(error_rate,'k','LineWidth',3);
% title('Error Rate', 'FontSize', 24);
% xlabel('Trials', 'FontSize', 16);
% ylabel('Error Rate(%)', 'FontSize', 16);
% ylim([0, 50]);
% grid on