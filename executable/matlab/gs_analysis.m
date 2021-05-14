clear; clc; close all;

sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
path = ["C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\"];
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];

raw_answer = [];
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

        end
    end
end