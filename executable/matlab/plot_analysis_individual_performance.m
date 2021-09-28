clear; clc; close all;
individual_performance = readmatrix('../../dataset/individual_performance.csv');

ACC_inst1 = individual_performance(1:10,2);
ACC_inst2 = individual_performance(11:20,2);
ACC_inst3 = individual_performance(21:30,2);
ACC_inst4 = individual_performance(31:40,2);

PRC_inst1 = individual_performance(1:10,3);
PRC_inst2 = individual_performance(11:20,3);
PRC_inst3 = individual_performance(21:30,3);
PRC_inst4 = individual_performance(31:40,3);

figure;
grid on
hold on
xlim([200 450]);
ylim([0 200]);
xlabel('\it\bfACC\rm (mm)','FontSize',20);
ylabel('\it\bfPRC\rm (mm)','FontSize',20);
scatter(ACC_inst1, PRC_inst1, 100, '+', 'LineWidth', 2);
scatter(ACC_inst2, PRC_inst2, 100, '+', 'LineWidth', 2);
scatter(ACC_inst3, PRC_inst3, 100, '+', 'LineWidth', 2);
% scatter(ACC_inst4, PRC_inst4, 100, '+', 'LineWidth', 2);

leg1 = legend('Instruction - 1', 'Instruction - 2', 'Instruction - 3', 'Instruction - 4', 'Location','northwest');
set(leg1,'FontSize',15);

text(ACC_inst1(1)+5,PRC_inst1(1),'P1','FontSize',16);
text(ACC_inst1(2)+5,PRC_inst1(2),'P2','FontSize',16);
text(ACC_inst1(3)+5,PRC_inst1(3),'P3','FontSize',16);
text(ACC_inst1(4)+5,PRC_inst1(4),'P4','FontSize',16);
text(ACC_inst1(5)+5,PRC_inst1(5),'P5','FontSize',16);
text(ACC_inst1(6)+5,PRC_inst1(6),'P6','FontSize',16);
text(ACC_inst1(7)+5,PRC_inst1(7),'P7','FontSize',16);
text(ACC_inst1(8)+5,PRC_inst1(8),'P8','FontSize',16);
text(ACC_inst1(9)+5,PRC_inst1(9),'P9','FontSize',16);
text(ACC_inst1(10)+5,PRC_inst1(10),'P10','FontSize',16);

text(ACC_inst2(1)+5,PRC_inst2(1),'P11','FontSize',16);
text(ACC_inst2(2)+5,PRC_inst2(2),'P12','FontSize',16);
text(ACC_inst2(3)+5,PRC_inst2(3),'P13','FontSize',16);
text(ACC_inst2(4)+5,PRC_inst2(4),'P14','FontSize',16);
text(ACC_inst2(5)+5,PRC_inst2(5),'P15','FontSize',16);
text(ACC_inst2(6)+5,PRC_inst2(6),'P16','FontSize',16);
text(ACC_inst2(7)+5,PRC_inst2(7),'P17','FontSize',16);
text(ACC_inst2(8)+5,PRC_inst2(8),'P18','FontSize',16);
text(ACC_inst2(9)+5,PRC_inst2(9),'P19','FontSize',16);
text(ACC_inst2(10)+5,PRC_inst2(10),'P20','FontSize',16);

text(ACC_inst3(1)+5,PRC_inst3(1),'P21','FontSize',16);
text(ACC_inst3(2)+5,PRC_inst3(2),'P22','FontSize',16);
text(ACC_inst3(3)+5,PRC_inst3(3),'P23','FontSize',16);
text(ACC_inst3(4)+5,PRC_inst3(4),'P24','FontSize',16);
text(ACC_inst3(5)+5,PRC_inst3(5),'P25','FontSize',16);
text(ACC_inst3(6)+5,PRC_inst3(6),'P26','FontSize',16);
text(ACC_inst3(7)+5,PRC_inst3(7),'P27','FontSize',16);
text(ACC_inst3(8)+5,PRC_inst3(8),'P28','FontSize',16);
text(ACC_inst3(9)+5,PRC_inst3(9),'P29','FontSize',16);
text(ACC_inst3(10)+5,PRC_inst3(10),'P30','FontSize',16);

% text(ACC_inst4(1)+5,PRC_inst4(1),'P31','FontSize',16);
% text(ACC_inst4(2)+5,PRC_inst4(2),'P32','FontSize',16);
% text(ACC_inst4(3)+5,PRC_inst4(3),'P33','FontSize',16);
% text(ACC_inst4(4)+5,PRC_inst4(4),'P34','FontSize',16);
% text(ACC_inst4(5)+5,PRC_inst4(5),'P35','FontSize',16);
% text(ACC_inst4(6)+5,PRC_inst4(6),'P36','FontSize',16);
% text(ACC_inst4(7)+5,PRC_inst4(7),'P37','FontSize',16);
% text(ACC_inst4(8)+5,PRC_inst4(8),'P38','FontSize',16);
% text(ACC_inst4(9)+5,PRC_inst4(9),'P39','FontSize',16);
% text(ACC_inst4(10)+5,PRC_inst4(10),'P40','FontSize',16);