clc; clear; close all;

case1 = readtable('../../dataset/user_test_case1_gs/user_test_case1_gs_new_calib_result'); % 가능한 정확하게
case2 = readtable('../../dataset/user_test_case2_gs/user_test_case2_gs_new_calib_result'); % 가능한 빠르게
case3 = readtable('../../dataset/user_test_case3_gs/user_test_case3_gs_new_calib_result'); % 가능한 빠르고 정확하게

err_1 = table2array(vertcat(case1(1:5:end,1),case2(1:5:end,1),case3(1:5:end,1))); %모든 케이스의 1번 위치에서 에러 - 우측
err_2 = table2array(vertcat(case1(2:5:end,1),case2(2:5:end,1),case3(2:5:end,1))); %모든 케이스의 2번 위치에서 에러 - 중앙
err_3 = table2array(vertcat(case1(3:5:end,1),case2(3:5:end,1),case3(3:5:end,1))); %모든 케이스의 3번 위치에서 에러 - 좌측
err_4 = table2array(vertcat(case1(4:5:end,1),case2(4:5:end,1),case3(4:5:end,1))); %모든 케이스의 4번 위치에서 에러 - 좌측
err_5 = table2array(vertcat(case1(5:5:end,1),case2(5:5:end,1),case3(5:5:end,1))); %모든 케이스의 5번 위치에서 에러 - 우측

case_labels_C = [ones([1,10]) ones([1,10]).*2 ones([1,10]).*3]'; %instruction case1,2,3인지 구분하는 라벨
case_labels_RL = [case_labels_C; case_labels_C]; %instruction case1,2,3인지 구분하는 라벨
case_labels_ALL = [case_labels_C; case_labels_C; case_labels_C; case_labels_C; case_labels_C];

err_LEFT = [err_1; err_5];
err_CENTER = [err_3];
err_RIGHT = [err_2; err_4];
err_ALL = [err_1; err_2; err_3; err_4; err_5];

pd_LEFT = fitdist(err_LEFT, 'Normal');
pd_CENTER = fitdist(err_CENTER, 'Normal');
pd_RIGHT = fitdist(err_RIGHT, 'Normal');
pd_ALL = fitdist(err_ALL, 'Normal');

x_values = 0:1:700;
y_LEFT = pdf(pd_LEFT,x_values) + 1.02;
y_CENTER = pdf(pd_CENTER,x_values) + 1.01;
y_RIGHT = pdf(pd_RIGHT,x_values) + 1;
y_ALL = pdf(pd_ALL,x_values) + 0.99;

%%
% err_*를 case별로 분리
err_LEFT_1 = err_LEFT(find(case_labels_RL == 1));
err_LEFT_2 = err_LEFT(find(case_labels_RL == 2));
err_LEFT_3 = err_LEFT(find(case_labels_RL == 3));

err_CENTER_1 = err_CENTER(find(case_labels_C == 1));
err_CENTER_2 = err_CENTER(find(case_labels_C == 2));
err_CENTER_3 = err_CENTER(find(case_labels_C == 3));

err_RIGHT_1 = err_RIGHT(find(case_labels_RL == 1));
err_RIGHT_2 = err_RIGHT(find(case_labels_RL == 2));
err_RIGHT_3 = err_RIGHT(find(case_labels_RL == 3));

err_ALL_1 = err_ALL(find(case_labels_ALL == 1));
err_ALL_2 = err_ALL(find(case_labels_ALL == 2));
err_ALL_3 = err_ALL(find(case_labels_ALL == 3));

% fitdist
pd_LEFT_1 = fitdist(err_LEFT_1, 'Normal');
pd_LEFT_2 = fitdist(err_LEFT_2, 'Normal');
pd_LEFT_3 = fitdist(err_LEFT_3, 'Normal');

pd_CENTER_1 = fitdist(err_CENTER_1, 'Normal');
pd_CENTER_2 = fitdist(err_CENTER_2, 'Normal');
pd_CENTER_3 = fitdist(err_CENTER_3, 'Normal');

pd_RIGHT_1 = fitdist(err_CENTER_1, 'Normal');
pd_RIGHT_2 = fitdist(err_CENTER_2, 'Normal');
pd_RIGHT_3 = fitdist(err_CENTER_3, 'Normal');

pd_ALL_1 = fitdist(err_ALL_1, 'Normal');
pd_ALL_2 = fitdist(err_ALL_2, 'Normal');
pd_ALL_3 = fitdist(err_ALL_3, 'Normal');

% build pdf
y_LEFT_1 = pdf(pd_LEFT_1,x_values) + 1.02;
y_LEFT_2 = pdf(pd_LEFT_2,x_values) + 1.02;
y_LEFT_3 = pdf(pd_LEFT_3,x_values) + 1.02;

y_CENTER_1 = pdf(pd_CENTER_1,x_values) + 1.01;
y_CENTER_2 = pdf(pd_CENTER_2,x_values) + 1.01;
y_CENTER_3 = pdf(pd_CENTER_3,x_values) + 1.01;

y_RIGHT_1 = pdf(pd_RIGHT_1,x_values) + 1;
y_RIGHT_2 = pdf(pd_RIGHT_2,x_values) + 1;
y_RIGHT_3 = pdf(pd_RIGHT_3,x_values) + 1;

y_ALL_1 = pdf(pd_ALL_1,x_values) + 0.99;
y_ALL_2 = pdf(pd_ALL_2,x_values) + 0.99;
y_ALL_3 = pdf(pd_ALL_3,x_values) + 0.99;

%% 위치별 에러 분포 그래프

figure;
hold on
grid on
gscatter(err_LEFT,ones(length(case_labels_RL),1).*1,case_labels_RL);
gscatter(err_CENTER,ones(length(case_labels_C),1).*1.01,case_labels_C);
gscatter(err_RIGHT,ones(length(case_labels_RL),1).*1.02,case_labels_RL);
gscatter(err_ALL,ones(length(case_labels_ALL),1).*0.99,case_labels_ALL);
xlabel('Distance Error (mm)','FontSize',20);
ylim([0.99 1.03]);
text(-50,1.02,'Left','FontSize',20);
text(-50,1.01,'Center','FontSize',20);
text(-50,1,'Right','FontSize',20);
text(-100,0.99,sprintf('Include All\nMonitor Location'),'FontSize',20);
title('Include Instruction Case - 1,2,3','FontSize',20);

plot(x_values,y_LEFT,'LineWidth',2,'Color','k');
plot(x_values,y_CENTER,'LineWidth',2,'Color','k');
plot(x_values,y_RIGHT,'LineWidth',2,'Color','k');
plot(x_values,y_ALL,'LineWidth',2,'Color','k');

%%
plot(x_values,y_LEFT_1,'LineWidth',2,'Color','r','LineStyle',':');
plot(x_values,y_LEFT_2,'LineWidth',2,'Color','g','LineStyle',':');
plot(x_values,y_LEFT_3,'LineWidth',2,'Color','b','LineStyle',':');

plot(x_values,y_CENTER_1,'LineWidth',2,'Color','r','LineStyle',':');
plot(x_values,y_CENTER_2,'LineWidth',2,'Color','g','LineStyle',':');
plot(x_values,y_CENTER_3,'LineWidth',2,'Color','b','LineStyle',':');

plot(x_values,y_RIGHT_1,'LineWidth',2,'Color','r','LineStyle',':');
plot(x_values,y_RIGHT_2,'LineWidth',2,'Color','g','LineStyle',':');
plot(x_values,y_RIGHT_3,'LineWidth',2,'Color','b','LineStyle',':');

plot(x_values,y_ALL_1,'LineWidth',2,'Color','r','LineStyle',':');
plot(x_values,y_ALL_2,'LineWidth',2,'Color','g','LineStyle',':');
plot(x_values,y_ALL_3,'LineWidth',2,'Color','b','LineStyle',':');
%%