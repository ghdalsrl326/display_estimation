clc; clear; close all;

case1 = readtable('../../dataset/user_test_case1_gs/user_test_case1_gs_lowpass_result'); % 가능한 정확하게
case2 = readtable('../../dataset/user_test_case2_gs/user_test_case2_gs_lowpass_result'); % 가능한 빠르게
case3 = readtable('../../dataset/user_test_case3_gs/user_test_case3_gs_lowpass_result'); % 가능한 빠르고 정확하게

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

%% 피험자 별 에러 분포
subject_err_1 = table2array(case1(1:5,1)); %n번 피험자의 에러 데이터
subject_err_2 = table2array(case1(6:10,1));
subject_err_3 = table2array(case1(11:15,1));
subject_err_4 = table2array(case1(16:20,1));
subject_err_5 = table2array(case1(21:25,1));
subject_err_6 = table2array(case1(26:30,1));
subject_err_7 = table2array(case1(31:35,1));
subject_err_8 = table2array(case1(36:40,1));
subject_err_9 = table2array(case1(41:45,1));
subject_err_10 = table2array(case1(46:50,1));

subject_err_11 = table2array(case2(1:5,1)); %n번 피험자의 에러 데이터
subject_err_12 = table2array(case2(6:10,1));
subject_err_13 = table2array(case2(11:15,1));
subject_err_14 = table2array(case2(16:20,1));
subject_err_15 = table2array(case2(21:25,1));
subject_err_16 = table2array(case2(26:30,1));
subject_err_17 = table2array(case2(31:35,1));
subject_err_18 = table2array(case2(36:40,1));
subject_err_19 = table2array(case2(41:45,1));
subject_err_20 = table2array(case2(46:50,1));

subject_err_21 = table2array(case3(1:5,1)); %n번 피험자의 에러 데이터
subject_err_22 = table2array(case3(6:10,1));
subject_err_23 = table2array(case3(11:15,1));
subject_err_24 = table2array(case3(16:20,1));
subject_err_25 = table2array(case3(21:25,1));
subject_err_26 = table2array(case3(26:30,1));
subject_err_27 = table2array(case3(31:35,1));
subject_err_28 = table2array(case3(36:40,1));
subject_err_29 = table2array(case3(41:45,1));
subject_err_30 = table2array(case3(46:50,1));

pd_subject_1 = fitdist(subject_err_1, 'Normal');
pd_subject_2 = fitdist(subject_err_2, 'Normal');
pd_subject_3 = fitdist(subject_err_3, 'Normal');
pd_subject_4 = fitdist(subject_err_4, 'Normal');
pd_subject_5 = fitdist(subject_err_5, 'Normal');
pd_subject_6 = fitdist(subject_err_6, 'Normal');
pd_subject_7 = fitdist(subject_err_7, 'Normal');
pd_subject_8 = fitdist(subject_err_8, 'Normal');
pd_subject_9 = fitdist(subject_err_9, 'Normal');
pd_subject_10 = fitdist(subject_err_10, 'Normal');

pd_subject_11 = fitdist(subject_err_11, 'Normal');
pd_subject_12 = fitdist(subject_err_12, 'Normal');
pd_subject_13 = fitdist(subject_err_13, 'Normal');
pd_subject_14 = fitdist(subject_err_14, 'Normal');
pd_subject_15 = fitdist(subject_err_15, 'Normal');
pd_subject_16 = fitdist(subject_err_16, 'Normal');
pd_subject_17 = fitdist(subject_err_17, 'Normal');
pd_subject_18 = fitdist(subject_err_18, 'Normal');
pd_subject_19 = fitdist(subject_err_19, 'Normal');
pd_subject_20 = fitdist(subject_err_20, 'Normal');

pd_subject_21 = fitdist(subject_err_21, 'Normal');
pd_subject_22 = fitdist(subject_err_22, 'Normal');
pd_subject_23 = fitdist(subject_err_23, 'Normal');
pd_subject_24 = fitdist(subject_err_24, 'Normal');
pd_subject_25 = fitdist(subject_err_25, 'Normal');
pd_subject_26 = fitdist(subject_err_26, 'Normal');
pd_subject_27 = fitdist(subject_err_27, 'Normal');
pd_subject_28 = fitdist(subject_err_28, 'Normal');
pd_subject_29 = fitdist(subject_err_29, 'Normal');
pd_subject_30 = fitdist(subject_err_30, 'Normal');

y_subject_1 = pdf(pd_subject_1,x_values);
y_subject_2 = pdf(pd_subject_2,x_values);
y_subject_3 = pdf(pd_subject_3,x_values);
y_subject_4 = pdf(pd_subject_4,x_values);
y_subject_5 = pdf(pd_subject_5,x_values);
y_subject_6 = pdf(pd_subject_6,x_values);
y_subject_7 = pdf(pd_subject_7,x_values);
y_subject_8 = pdf(pd_subject_8,x_values);
y_subject_9 = pdf(pd_subject_9,x_values);
y_subject_10 = pdf(pd_subject_10,x_values);

y_subject_11 = pdf(pd_subject_11,x_values);
y_subject_12 = pdf(pd_subject_12,x_values);
y_subject_13 = pdf(pd_subject_13,x_values);
y_subject_14 = pdf(pd_subject_14,x_values);
y_subject_15 = pdf(pd_subject_15,x_values);
y_subject_16 = pdf(pd_subject_16,x_values);
y_subject_17 = pdf(pd_subject_17,x_values);
y_subject_18 = pdf(pd_subject_18,x_values);
y_subject_19 = pdf(pd_subject_19,x_values);
y_subject_20 = pdf(pd_subject_20,x_values);

y_subject_21 = pdf(pd_subject_21,x_values);
y_subject_22 = pdf(pd_subject_22,x_values);
y_subject_23 = pdf(pd_subject_23,x_values);
y_subject_24 = pdf(pd_subject_24,x_values);
y_subject_25 = pdf(pd_subject_25,x_values);
y_subject_26 = pdf(pd_subject_26,x_values);
y_subject_27 = pdf(pd_subject_27,x_values);
y_subject_28 = pdf(pd_subject_28,x_values);
y_subject_29 = pdf(pd_subject_29,x_values);
y_subject_30 = pdf(pd_subject_30,x_values);

%% 피험자별 에러 분포 그래프

figure;
hold on
grid on
xlim([0 700]);

tiledlayout(30,1);
s1 = nexttile;
scatter(subject_err_1, zeros(5,1),'filled');
% plot(x_values,y_subject_1,'LineWidth',2,'Color','k','LineStyle',':');
s2 = nexttile;
scatter(subject_err_2, zeros(5,1),'filled');
s3 = nexttile;
scatter(subject_err_3, zeros(5,1),'filled');
s4 = nexttile;
scatter(subject_err_4, zeros(5,1),'filled');
s5 = nexttile;
scatter(subject_err_5, zeros(5,1),'filled');
s6 = nexttile;
scatter(subject_err_6, zeros(5,1),'filled');
s7 = nexttile;
scatter(subject_err_7, zeros(5,1),'filled');
s8 = nexttile;
scatter(subject_err_8, zeros(5,1),'filled');
s9 = nexttile;
scatter(subject_err_9, zeros(5,1),'filled');
s10 = nexttile;
scatter(subject_err_10, zeros(5,1),'filled');

s11 = nexttile;
scatter(subject_err_11, zeros(5,1),'filled');
s12 = nexttile;
scatter(subject_err_12, zeros(5,1),'filled');
s13 = nexttile;
scatter(subject_err_13, zeros(5,1),'filled');
s14 = nexttile;
scatter(subject_err_14, zeros(5,1),'filled');
s15 = nexttile;
scatter(subject_err_15, zeros(5,1),'filled');
s16 = nexttile;
scatter(subject_err_16, zeros(5,1),'filled');
s17 = nexttile;
scatter(subject_err_17, zeros(5,1),'filled');
s18 = nexttile;
scatter(subject_err_18, zeros(5,1),'filled');
s19 = nexttile;
scatter(subject_err_19, zeros(5,1),'filled');
s20 = nexttile;
scatter(subject_err_20, zeros(5,1),'filled');

s21 = nexttile;
scatter(subject_err_21, zeros(5,1),'filled');
s22 = nexttile;
scatter(subject_err_22, zeros(5,1),'filled');
s23 = nexttile;
scatter(subject_err_23, zeros(5,1),'filled');
s24 = nexttile;
scatter(subject_err_24, zeros(5,1),'filled');
s25 = nexttile;
scatter(subject_err_25, zeros(5,1),'filled');
s26 = nexttile;
scatter(subject_err_26, zeros(5,1),'filled');
s27 = nexttile;
scatter(subject_err_27, zeros(5,1),'filled');
s28 = nexttile;
scatter(subject_err_28, zeros(5,1),'filled');
s29 = nexttile;
scatter(subject_err_29, zeros(5,1),'filled');
s30 = nexttile;
scatter(subject_err_30, zeros(5,1),'filled');

linkaxes([s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20 s21 s22 s23 s24 s25 s26 s27 s28 s29 s30],'xy')
s1.XLim = [0 700];
s2.YLim = [0 0.002];
% xlabel('Distance Error (mm)','FontSize',20);
% ylabel('Subject','FontSize',20);