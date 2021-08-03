clear all; clc; close all

%% 데이터 경로 (다른 instruction case로 변경할 경우, ref, path에서 user_test_case*_gs 숫자만 변경)
ref = readtable('../../dataset/user_test_case1_gs/ref_coord');
% ref = 레퍼런스 부모니터 중심점 위치가 담긴 파일의 경로
path = "user_test_case1_gs\";
% path = 인스트럭션 케이스(user_test_case1_gs: 가능한 정확하게, user_test_case2_gs: 가능한 빠르게, user_test_case3_gs; 가능한 빠르고 정확하게)
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];
% ss = 피험자 번호
sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
% sub_file = 피험자 데이터 로그 파일 (data_robot_1: 부모니터가 사용자 기준 우측에 위치한 경우, data_robot_2: 중앙, data_robot_3: 좌측, data_robot_4: 좌측, data_robot_5: 우측)

%% LOCATION1(RIGHT)
figure;
hold on
grid on
for s = 1:10
    for n = 1:1
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off
    end
end
sgt = sgtitle('Instruction Case 1: Location 1(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Position: X','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 1:1
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ty);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ty,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 1(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Position: Y','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 1:1
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 1(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Position: Z','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 1:1
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 1(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Rotation: X','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 1:1
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ry);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ry,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 1(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Y','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 1:1
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 1(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Z','FontSize',20);

% LOCATION2(CENTER)

figure;
hold on
grid on
for s = 1:10
    for n = 2:2
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 2(CENTER)');
sgt.FontSize = 20;
xlabel('Head Position: X','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 2:2
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ty);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ty,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 2(CENTER)');
sgt.FontSize = 20;
xlabel('Head Position: Y','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 2:2
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 2(CENTER)');
sgt.FontSize = 20;
xlabel('Head Position: Z','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 2:2
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 2(CENTER)');
sgt.FontSize = 20;
xlabel('Head Rotation: X','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 2:2
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ry);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ry,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 2(CENTER)');
sgt.FontSize = 20;
xlabel('Head Rotation: Y','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 2:2
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off
    end
end
sgt = sgtitle('Instruction Case 1: Location 2(CENTER)');
sgt.FontSize = 20;
xlabel('Head Rotation: Z','FontSize',20);

%% LOCATION3(LEFT)

figure;
hold on
grid on
for s = 1:10
    for n = 3:3
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Position: X','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 3:3
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ty);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ty,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Position: Y','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 3:3
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Position: Z','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 3:3
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Rotation: X','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 3:3
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ry);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ry,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Y','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 3:3
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Z','FontSize',20);

%% LOCATION4(LEFT)

figure;
hold on
grid on
for s = 1:10
    for n = 4:4
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Position: X','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 4:4
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ty);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ty,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Position: Y','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 4:4
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Position: Z','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 4:4
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Rotation: X','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 4:4
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ry);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ry,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Y','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 4:4
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off
    end
end
sgt = sgtitle('Instruction Case 1: Location 3(LEFT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Z','FontSize',20);

%% LOCATION5(RIGHT)
figure;
hold on
grid on
for s = 1:10
    for n = 5:5
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 5(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Position: X','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 5:5
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ty);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ty,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 5(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Position: Y','FontSize',20);


figure;
hold on
grid on
for s = 1:10
    for n = 5:5
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Tz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Tz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 5(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Position: Z','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 5:5
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rx);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);      
        [y1,d1] = lowpass(raw_data.pose_Rx,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 5(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Rotation: X','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 5:5
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Ry);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Ry,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off        
    end
end
sgt = sgtitle('Instruction Case 1: Location 5(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Y','FontSize',20);

figure;
hold on
grid on
for s = 1:10
    for n = 5:5
        subplot (10,1,s)
        raw_data = readtable(strcat('..\..\dataset\',path,ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0); % 피험자 데이터 로그 불러오기
        plot(raw_data.pose_Rz);
        ylabel(strcat('Subject-',num2str(1),num2str(s)),'FontSize',10);
        [y1,d1] = lowpass(raw_data.pose_Rz,10,50,'ImpulseResponse','auto');
        hold on
        plot(y1)
        hold off         
    end
end
sgt = sgtitle('Instruction Case 1: Location 5(RIGHT)');
sgt.FontSize = 20;
xlabel('Head Rotation: Z','FontSize',20);
