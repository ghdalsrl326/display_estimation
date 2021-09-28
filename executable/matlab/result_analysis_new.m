clear; clc; close all;

%% IMOPORT RESULTS AS STRUCT: INSTRUCTION CASE 1
for s = 1:10
    inst_1(s).R1 = readtable(strcat('../../dataset/user_test_case1_bo/',string(s),'/data_robot_1_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_1(s).C = readtable(strcat('../../dataset/user_test_case1_bo/',string(s),'/data_robot_2_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_1(s).L1 = readtable(strcat('../../dataset/user_test_case1_bo/',string(s),'/data_robot_3_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_1(s).L2 = readtable(strcat('../../dataset/user_test_case1_bo/',string(s),'/data_robot_4_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_1(s).R2 = readtable(strcat('../../dataset/user_test_case1_bo/',string(s),'/data_robot_5_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
end
inst_1;

%% IMOPORT RESULTS AS STRUCT: INSTRUCTION CASE 2
for s = 1:10
    inst_2(s).R1 = readtable(strcat('../../dataset/user_test_case2_bo/',string(s),'/data_robot_1_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_2(s).C = readtable(strcat('../../dataset/user_test_case2_bo/',string(s),'/data_robot_2_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_2(s).L1 = readtable(strcat('../../dataset/user_test_case2_bo/',string(s),'/data_robot_3_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_2(s).L2 = readtable(strcat('../../dataset/user_test_case2_bo/',string(s),'/data_robot_4_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_2(s).R2 = readtable(strcat('../../dataset/user_test_case2_bo/',string(s),'/data_robot_5_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
end
inst_2;

%% IMOPORT RESULTS AS STRUCT: INSTRUCTION CASE 3
for s = 1:10
    inst_3(s).R1 = readtable(strcat('../../dataset/user_test_case3_bo/',string(s),'/data_robot_1_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_3(s).C = readtable(strcat('../../dataset/user_test_case3_bo/',string(s),'/data_robot_2_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_3(s).L1 = readtable(strcat('../../dataset/user_test_case3_bo/',string(s),'/data_robot_3_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_3(s).L2 = readtable(strcat('../../dataset/user_test_case3_bo/',string(s),'/data_robot_4_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_3(s).R2 = readtable(strcat('../../dataset/user_test_case3_bo/',string(s),'/data_robot_5_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
end
inst_3;

%% IMOPORT RESULTS AS STRUCT: INSTRUCTION CASE 4
for s = 1:10
    inst_4(s).R1 = readtable(strcat('../../dataset/user_test_case4_bo/',string(s),'/data_robot_1_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_4(s).C = readtable(strcat('../../dataset/user_test_case4_bo/',string(s),'/data_robot_2_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_4(s).L1 = readtable(strcat('../../dataset/user_test_case4_bo/',string(s),'/data_robot_3_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_4(s).L2 = readtable(strcat('../../dataset/user_test_case4_bo/',string(s),'/data_robot_4_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
    inst_4(s).R2 = readtable(strcat('../../dataset/user_test_case4_bo/',string(s),'/data_robot_5_trials_bayes'),'ReadVariableNames',true,'HeaderLines',0);
end
inst_4;

%% APPEND VARIABLE: average_distance_error, average_w, average_s, std_distance_error, std_w, std_w
for s = 1:10
% inst1 - average_distance_error
    inst_1(s).R1.average_distance_error = (inst_1(s).R1.t1_distance_error + inst_1(s).R1.t2_distance_error + inst_1(s).R1.t3_distance_error + inst_1(s).R1.t4_distance_error)./4;
    inst_1(s).C.average_distance_error = (inst_1(s).C.t1_distance_error + inst_1(s).C.t2_distance_error + inst_1(s).C.t3_distance_error + inst_1(s).C.t4_distance_error)./4;
    inst_1(s).L1.average_distance_error = (inst_1(s).L1.t1_distance_error + inst_1(s).L1.t2_distance_error + inst_1(s).L1.t3_distance_error + inst_1(s).L1.t4_distance_error)./4;
    inst_1(s).L2.average_distance_error = (inst_1(s).L2.t1_distance_error + inst_1(s).L2.t2_distance_error + inst_1(s).L2.t3_distance_error + inst_1(s).L2.t4_distance_error)./4;
    inst_1(s).R2.average_distance_error = (inst_1(s).R2.t1_distance_error + inst_1(s).R2.t2_distance_error + inst_1(s).R2.t3_distance_error + inst_1(s).R2.t4_distance_error)./4;    
    % inst1 - average_w
    inst_1(s).R1.average_w = (inst_1(s).R1.t1_w + inst_1(s).R1.t2_w + inst_1(s).R1.t3_w + inst_1(s).R1.t4_w)./4;
    inst_1(s).C.average_w = (inst_1(s).C.t1_w + inst_1(s).C.t2_w + inst_1(s).C.t3_w + inst_1(s).C.t4_w)./4;
    inst_1(s).L1.average_w = (inst_1(s).L1.t1_w + inst_1(s).L1.t2_w + inst_1(s).L1.t3_w + inst_1(s).L1.t4_w)./4;
    inst_1(s).L2.average_w = (inst_1(s).L2.t1_w + inst_1(s).L2.t2_w + inst_1(s).L2.t3_w + inst_1(s).L2.t4_w)./4;
    inst_1(s).R2.average_w = (inst_1(s).R2.t1_w + inst_1(s).R2.t2_w + inst_1(s).R2.t3_w + inst_1(s).R2.t4_w)./4;        
    % inst1 - average_s
    inst_1(s).R1.average_s = (inst_1(s).R1.t1_s + inst_1(s).R1.t2_s + inst_1(s).R1.t3_s + inst_1(s).R1.t4_s)./4;
    inst_1(s).C.average_s = (inst_1(s).C.t1_s + inst_1(s).C.t2_s + inst_1(s).C.t3_s + inst_1(s).C.t4_s)./4;
    inst_1(s).L1.average_s = (inst_1(s).L1.t1_s + inst_1(s).L1.t2_s + inst_1(s).L1.t3_s + inst_1(s).L1.t4_s)./4;
    inst_1(s).L2.average_s = (inst_1(s).L2.t1_s + inst_1(s).L2.t2_s + inst_1(s).L2.t3_s + inst_1(s).L2.t4_s)./4;
    inst_1(s).R2.average_s = (inst_1(s).R2.t1_s + inst_1(s).R2.t2_s + inst_1(s).R2.t3_s + inst_1(s).R2.t4_s)./4;        
    % inst1 - std_distance_error
    inst_1(s).R1.std_distance_error = std([inst_1(s).R1.t1_distance_error, inst_1(s).R1.t2_distance_error, inst_1(s).R1.t3_distance_error, inst_1(s).R1.t4_distance_error],0,2);
    inst_1(s).C.std_distance_error = std([inst_1(s).C.t1_distance_error, inst_1(s).C.t2_distance_error, inst_1(s).C.t3_distance_error, inst_1(s).C.t4_distance_error],0,2);
    inst_1(s).L1.std_distance_error = std([inst_1(s).L1.t1_distance_error, inst_1(s).L1.t2_distance_error, inst_1(s).L1.t3_distance_error, inst_1(s).L1.t4_distance_error],0,2);
    inst_1(s).L2.std_distance_error = std([inst_1(s).L2.t1_distance_error, inst_1(s).L2.t2_distance_error, inst_1(s).L2.t3_distance_error, inst_1(s).L2.t4_distance_error],0,2);
    inst_1(s).R2.std_distance_error = std([inst_1(s).R2.t1_distance_error, inst_1(s).R2.t2_distance_error, inst_1(s).R2.t3_distance_error, inst_1(s).R2.t4_distance_error],0,2);        
    % inst1 - std_w
    inst_1(s).R1.std_w = std([inst_1(s).R1.t1_w, inst_1(s).R1.t2_w, inst_1(s).R1.t3_w, inst_1(s).R1.t4_w],0,2);
    inst_1(s).C.std_w = std([inst_1(s).C.t1_w, inst_1(s).C.t2_w, inst_1(s).C.t3_w, inst_1(s).C.t4_w],0,2);
    inst_1(s).L1.std_w = std([inst_1(s).L1.t1_w, inst_1(s).L1.t2_w, inst_1(s).L1.t3_w, inst_1(s).L1.t4_w],0,2);
    inst_1(s).L2.std_w = std([inst_1(s).L2.t1_w, inst_1(s).L2.t2_w, inst_1(s).L2.t3_w, inst_1(s).L2.t4_w],0,2);
    inst_1(s).R2.std_w = std([inst_1(s).R2.t1_w, inst_1(s).R2.t2_w, inst_1(s).R2.t3_w, inst_1(s).R2.t4_w],0,2);        
    % inst1 - std_s
    inst_1(s).R1.std_s = std([inst_1(s).R1.t1_s, inst_1(s).R1.t2_s, inst_1(s).R1.t3_s, inst_1(s).R1.t4_s],0,2);
    inst_1(s).C.std_s = std([inst_1(s).C.t1_s, inst_1(s).C.t2_s, inst_1(s).C.t3_s, inst_1(s).C.t4_s],0,2);
    inst_1(s).L1.std_s = std([inst_1(s).L1.t1_s, inst_1(s).L1.t2_s, inst_1(s).L1.t3_s, inst_1(s).L1.t4_s],0,2);
    inst_1(s).L2.std_s = std([inst_1(s).L2.t1_s, inst_1(s).L2.t2_s, inst_1(s).L2.t3_s, inst_1(s).L2.t4_s],0,2);
    inst_1(s).R2.std_s = std([inst_1(s).R2.t1_s, inst_1(s).R2.t2_s, inst_1(s).R2.t3_s, inst_1(s).R2.t4_s],0,2);        
    
% inst2 - average_distance_error
    inst_2(s).R1.average_distance_error = (inst_2(s).R1.t1_distance_error + inst_2(s).R1.t2_distance_error + inst_2(s).R1.t3_distance_error + inst_2(s).R1.t4_distance_error)./4;
    inst_2(s).C.average_distance_error = (inst_2(s).C.t1_distance_error + inst_2(s).C.t2_distance_error + inst_2(s).C.t3_distance_error + inst_2(s).C.t4_distance_error)./4;
    inst_2(s).L1.average_distance_error = (inst_2(s).L1.t1_distance_error + inst_2(s).L1.t2_distance_error + inst_2(s).L1.t3_distance_error + inst_2(s).L1.t4_distance_error)./4;
    inst_2(s).L2.average_distance_error = (inst_2(s).L2.t1_distance_error + inst_2(s).L2.t2_distance_error + inst_2(s).L2.t3_distance_error + inst_2(s).L2.t4_distance_error)./4;
    inst_2(s).R2.average_distance_error = (inst_2(s).R2.t1_distance_error + inst_2(s).R2.t2_distance_error + inst_2(s).R2.t3_distance_error + inst_2(s).R2.t4_distance_error)./4;    
    % inst2 - average_w
    inst_2(s).R1.average_w = (inst_2(s).R1.t1_w + inst_2(s).R1.t2_w + inst_2(s).R1.t3_w + inst_2(s).R1.t4_w)./4;
    inst_2(s).C.average_w = (inst_2(s).C.t1_w + inst_2(s).C.t2_w + inst_2(s).C.t3_w + inst_2(s).C.t4_w)./4;
    inst_2(s).L1.average_w = (inst_2(s).L1.t1_w + inst_2(s).L1.t2_w + inst_2(s).L1.t3_w + inst_2(s).L1.t4_w)./4;
    inst_2(s).L2.average_w = (inst_2(s).L2.t1_w + inst_2(s).L2.t2_w + inst_2(s).L2.t3_w + inst_2(s).L2.t4_w)./4;
    inst_2(s).R2.average_w = (inst_2(s).R2.t1_w + inst_2(s).R2.t2_w + inst_2(s).R2.t3_w + inst_2(s).R2.t4_w)./4;        
    % inst2 - average_s
    inst_2(s).R1.average_s = (inst_2(s).R1.t1_s + inst_2(s).R1.t2_s + inst_2(s).R1.t3_s + inst_2(s).R1.t4_s)./4;
    inst_2(s).C.average_s = (inst_2(s).C.t1_s + inst_2(s).C.t2_s + inst_2(s).C.t3_s + inst_2(s).C.t4_s)./4;
    inst_2(s).L1.average_s = (inst_2(s).L1.t1_s + inst_2(s).L1.t2_s + inst_2(s).L1.t3_s + inst_2(s).L1.t4_s)./4;
    inst_2(s).L2.average_s = (inst_2(s).L2.t1_s + inst_2(s).L2.t2_s + inst_2(s).L2.t3_s + inst_2(s).L2.t4_s)./4;
    inst_2(s).R2.average_s = (inst_2(s).R2.t1_s + inst_2(s).R2.t2_s + inst_2(s).R2.t3_s + inst_2(s).R2.t4_s)./4;        
    % inst2 - std_distance_error
    inst_2(s).R1.std_distance_error = std([inst_2(s).R1.t1_distance_error, inst_2(s).R1.t2_distance_error, inst_2(s).R1.t3_distance_error, inst_2(s).R1.t4_distance_error],0,2);
    inst_2(s).C.std_distance_error = std([inst_2(s).C.t1_distance_error, inst_2(s).C.t2_distance_error, inst_2(s).C.t3_distance_error, inst_2(s).C.t4_distance_error],0,2);
    inst_2(s).L1.std_distance_error = std([inst_2(s).L1.t1_distance_error, inst_2(s).L1.t2_distance_error, inst_2(s).L1.t3_distance_error, inst_2(s).L1.t4_distance_error],0,2);
    inst_2(s).L2.std_distance_error = std([inst_2(s).L2.t1_distance_error, inst_2(s).L2.t2_distance_error, inst_2(s).L2.t3_distance_error, inst_2(s).L2.t4_distance_error],0,2);
    inst_2(s).R2.std_distance_error = std([inst_2(s).R2.t1_distance_error, inst_2(s).R2.t2_distance_error, inst_2(s).R2.t3_distance_error, inst_2(s).R2.t4_distance_error],0,2);        
    % inst2 - std_w
    inst_2(s).R1.std_w = std([inst_2(s).R1.t1_w, inst_2(s).R1.t2_w, inst_2(s).R1.t3_w, inst_2(s).R1.t4_w],0,2);
    inst_2(s).C.std_w = std([inst_2(s).C.t1_w, inst_2(s).C.t2_w, inst_2(s).C.t3_w, inst_2(s).C.t4_w],0,2);
    inst_2(s).L1.std_w = std([inst_2(s).L1.t1_w, inst_2(s).L1.t2_w, inst_2(s).L1.t3_w, inst_2(s).L1.t4_w],0,2);
    inst_2(s).L2.std_w = std([inst_2(s).L2.t1_w, inst_2(s).L2.t2_w, inst_2(s).L2.t3_w, inst_2(s).L2.t4_w],0,2);
    inst_2(s).R2.std_w = std([inst_2(s).R2.t1_w, inst_2(s).R2.t2_w, inst_2(s).R2.t3_w, inst_2(s).R2.t4_w],0,2);        
    % inst2 - std_s
    inst_2(s).R1.std_s = std([inst_2(s).R1.t1_s, inst_2(s).R1.t2_s, inst_2(s).R1.t3_s, inst_2(s).R1.t4_s],0,2);
    inst_2(s).C.std_s = std([inst_2(s).C.t1_s, inst_2(s).C.t2_s, inst_2(s).C.t3_s, inst_2(s).C.t4_s],0,2);
    inst_2(s).L1.std_s = std([inst_2(s).L1.t1_s, inst_2(s).L1.t2_s, inst_2(s).L1.t3_s, inst_2(s).L1.t4_s],0,2);
    inst_2(s).L2.std_s = std([inst_2(s).L2.t1_s, inst_2(s).L2.t2_s, inst_2(s).L2.t3_s, inst_2(s).L2.t4_s],0,2);
    inst_2(s).R2.std_s = std([inst_2(s).R2.t1_s, inst_2(s).R2.t2_s, inst_2(s).R2.t3_s, inst_2(s).R2.t4_s],0,2);        

% inst3 - average_distance_error
    inst_3(s).R1.average_distance_error = (inst_3(s).R1.t1_distance_error + inst_3(s).R1.t2_distance_error + inst_3(s).R1.t3_distance_error + inst_3(s).R1.t4_distance_error)./4;
    inst_3(s).C.average_distance_error = (inst_3(s).C.t1_distance_error + inst_3(s).C.t2_distance_error + inst_3(s).C.t3_distance_error + inst_3(s).C.t4_distance_error)./4;
    inst_3(s).L1.average_distance_error = (inst_3(s).L1.t1_distance_error + inst_3(s).L1.t2_distance_error + inst_3(s).L1.t3_distance_error + inst_3(s).L1.t4_distance_error)./4;
    inst_3(s).L2.average_distance_error = (inst_3(s).L2.t1_distance_error + inst_3(s).L2.t2_distance_error + inst_3(s).L2.t3_distance_error + inst_3(s).L2.t4_distance_error)./4;
    inst_3(s).R2.average_distance_error = (inst_3(s).R2.t1_distance_error + inst_3(s).R2.t2_distance_error + inst_3(s).R2.t3_distance_error + inst_3(s).R2.t4_distance_error)./4;    
    % inst3 - average_w
    inst_3(s).R1.average_w = (inst_3(s).R1.t1_w + inst_3(s).R1.t2_w + inst_3(s).R1.t3_w + inst_3(s).R1.t4_w)./4;
    inst_3(s).C.average_w = (inst_3(s).C.t1_w + inst_3(s).C.t2_w + inst_3(s).C.t3_w + inst_3(s).C.t4_w)./4;
    inst_3(s).L1.average_w = (inst_3(s).L1.t1_w + inst_3(s).L1.t2_w + inst_3(s).L1.t3_w + inst_3(s).L1.t4_w)./4;
    inst_3(s).L2.average_w = (inst_3(s).L2.t1_w + inst_3(s).L2.t2_w + inst_3(s).L2.t3_w + inst_3(s).L2.t4_w)./4;
    inst_3(s).R2.average_w = (inst_3(s).R2.t1_w + inst_3(s).R2.t2_w + inst_3(s).R2.t3_w + inst_3(s).R2.t4_w)./4;        
    % inst3 - average_s
    inst_3(s).R1.average_s = (inst_3(s).R1.t1_s + inst_3(s).R1.t2_s + inst_3(s).R1.t3_s + inst_3(s).R1.t4_s)./4;
    inst_3(s).C.average_s = (inst_3(s).C.t1_s + inst_3(s).C.t2_s + inst_3(s).C.t3_s + inst_3(s).C.t4_s)./4;
    inst_3(s).L1.average_s = (inst_3(s).L1.t1_s + inst_3(s).L1.t2_s + inst_3(s).L1.t3_s + inst_3(s).L1.t4_s)./4;
    inst_3(s).L2.average_s = (inst_3(s).L2.t1_s + inst_3(s).L2.t2_s + inst_3(s).L2.t3_s + inst_3(s).L2.t4_s)./4;
    inst_3(s).R2.average_s = (inst_3(s).R2.t1_s + inst_3(s).R2.t2_s + inst_3(s).R2.t3_s + inst_3(s).R2.t4_s)./4;        
    % inst3 - std_distance_error
    inst_3(s).R1.std_distance_error = std([inst_3(s).R1.t1_distance_error, inst_3(s).R1.t2_distance_error, inst_3(s).R1.t3_distance_error, inst_3(s).R1.t4_distance_error],0,2);
    inst_3(s).C.std_distance_error = std([inst_3(s).C.t1_distance_error, inst_3(s).C.t2_distance_error, inst_3(s).C.t3_distance_error, inst_3(s).C.t4_distance_error],0,2);
    inst_3(s).L1.std_distance_error = std([inst_3(s).L1.t1_distance_error, inst_3(s).L1.t2_distance_error, inst_3(s).L1.t3_distance_error, inst_3(s).L1.t4_distance_error],0,2);
    inst_3(s).L2.std_distance_error = std([inst_3(s).L2.t1_distance_error, inst_3(s).L2.t2_distance_error, inst_3(s).L2.t3_distance_error, inst_3(s).L2.t4_distance_error],0,2);
    inst_3(s).R2.std_distance_error = std([inst_3(s).R2.t1_distance_error, inst_3(s).R2.t2_distance_error, inst_3(s).R2.t3_distance_error, inst_3(s).R2.t4_distance_error],0,2);        
    % inst3 - std_w
    inst_3(s).R1.std_w = std([inst_3(s).R1.t1_w, inst_3(s).R1.t2_w, inst_3(s).R1.t3_w, inst_3(s).R1.t4_w],0,2);
    inst_3(s).C.std_w = std([inst_3(s).C.t1_w, inst_3(s).C.t2_w, inst_3(s).C.t3_w, inst_3(s).C.t4_w],0,2);
    inst_3(s).L1.std_w = std([inst_3(s).L1.t1_w, inst_3(s).L1.t2_w, inst_3(s).L1.t3_w, inst_3(s).L1.t4_w],0,2);
    inst_3(s).L2.std_w = std([inst_3(s).L2.t1_w, inst_3(s).L2.t2_w, inst_3(s).L2.t3_w, inst_3(s).L2.t4_w],0,2);
    inst_3(s).R2.std_w = std([inst_3(s).R2.t1_w, inst_3(s).R2.t2_w, inst_3(s).R2.t3_w, inst_3(s).R2.t4_w],0,2);        
    % inst3 - std_s
    inst_3(s).R1.std_s = std([inst_3(s).R1.t1_s, inst_3(s).R1.t2_s, inst_3(s).R1.t3_s, inst_3(s).R1.t4_s],0,2);
    inst_3(s).C.std_s = std([inst_3(s).C.t1_s, inst_3(s).C.t2_s, inst_3(s).C.t3_s, inst_3(s).C.t4_s],0,2);
    inst_3(s).L1.std_s = std([inst_3(s).L1.t1_s, inst_3(s).L1.t2_s, inst_3(s).L1.t3_s, inst_3(s).L1.t4_s],0,2);
    inst_3(s).L2.std_s = std([inst_3(s).L2.t1_s, inst_3(s).L2.t2_s, inst_3(s).L2.t3_s, inst_3(s).L2.t4_s],0,2);
    inst_3(s).R2.std_s = std([inst_3(s).R2.t1_s, inst_3(s).R2.t2_s, inst_3(s).R2.t3_s, inst_3(s).R2.t4_s],0,2);        

% inst4 - average_distance_error
    inst_4(s).R1.average_distance_error = (inst_4(s).R1.t1_distance_error + inst_4(s).R1.t2_distance_error + inst_4(s).R1.t3_distance_error + inst_4(s).R1.t4_distance_error)./4;
    inst_4(s).C.average_distance_error = (inst_4(s).C.t1_distance_error + inst_4(s).C.t2_distance_error + inst_4(s).C.t3_distance_error + inst_4(s).C.t4_distance_error)./4;
    inst_4(s).L1.average_distance_error = (inst_4(s).L1.t1_distance_error + inst_4(s).L1.t2_distance_error + inst_4(s).L1.t3_distance_error + inst_4(s).L1.t4_distance_error)./4;
    inst_4(s).L2.average_distance_error = (inst_4(s).L2.t1_distance_error + inst_4(s).L2.t2_distance_error + inst_4(s).L2.t3_distance_error + inst_4(s).L2.t4_distance_error)./4;
    inst_4(s).R2.average_distance_error = (inst_4(s).R2.t1_distance_error + inst_4(s).R2.t2_distance_error + inst_4(s).R2.t3_distance_error + inst_4(s).R2.t4_distance_error)./4;    
    % inst4 - average_w
    inst_4(s).R1.average_w = (inst_4(s).R1.t1_w + inst_4(s).R1.t2_w + inst_4(s).R1.t3_w + inst_4(s).R1.t4_w)./4;
    inst_4(s).C.average_w = (inst_4(s).C.t1_w + inst_4(s).C.t2_w + inst_4(s).C.t3_w + inst_4(s).C.t4_w)./4;
    inst_4(s).L1.average_w = (inst_4(s).L1.t1_w + inst_4(s).L1.t2_w + inst_4(s).L1.t3_w + inst_4(s).L1.t4_w)./4;
    inst_4(s).L2.average_w = (inst_4(s).L2.t1_w + inst_4(s).L2.t2_w + inst_4(s).L2.t3_w + inst_4(s).L2.t4_w)./4;
    inst_4(s).R2.average_w = (inst_4(s).R2.t1_w + inst_4(s).R2.t2_w + inst_4(s).R2.t3_w + inst_4(s).R2.t4_w)./4;        
    % inst4 - average_s
    inst_4(s).R1.average_s = (inst_4(s).R1.t1_s + inst_4(s).R1.t2_s + inst_4(s).R1.t3_s + inst_4(s).R1.t4_s)./4;
    inst_4(s).C.average_s = (inst_4(s).C.t1_s + inst_4(s).C.t2_s + inst_4(s).C.t3_s + inst_4(s).C.t4_s)./4;
    inst_4(s).L1.average_s = (inst_4(s).L1.t1_s + inst_4(s).L1.t2_s + inst_4(s).L1.t3_s + inst_4(s).L1.t4_s)./4;
    inst_4(s).L2.average_s = (inst_4(s).L2.t1_s + inst_4(s).L2.t2_s + inst_4(s).L2.t3_s + inst_4(s).L2.t4_s)./4;
    inst_4(s).R2.average_s = (inst_4(s).R2.t1_s + inst_4(s).R2.t2_s + inst_4(s).R2.t3_s + inst_4(s).R2.t4_s)./4;        
    % inst4 - std_distance_error
    inst_4(s).R1.std_distance_error = std([inst_4(s).R1.t1_distance_error, inst_4(s).R1.t2_distance_error, inst_4(s).R1.t3_distance_error, inst_4(s).R1.t4_distance_error],0,2);
    inst_4(s).C.std_distance_error = std([inst_4(s).C.t1_distance_error, inst_4(s).C.t2_distance_error, inst_4(s).C.t3_distance_error, inst_4(s).C.t4_distance_error],0,2);
    inst_4(s).L1.std_distance_error = std([inst_4(s).L1.t1_distance_error, inst_4(s).L1.t2_distance_error, inst_4(s).L1.t3_distance_error, inst_4(s).L1.t4_distance_error],0,2);
    inst_4(s).L2.std_distance_error = std([inst_4(s).L2.t1_distance_error, inst_4(s).L2.t2_distance_error, inst_4(s).L2.t3_distance_error, inst_4(s).L2.t4_distance_error],0,2);
    inst_4(s).R2.std_distance_error = std([inst_4(s).R2.t1_distance_error, inst_4(s).R2.t2_distance_error, inst_4(s).R2.t3_distance_error, inst_4(s).R2.t4_distance_error],0,2);        
    % inst4 - std_w
    inst_4(s).R1.std_w = std([inst_4(s).R1.t1_w, inst_4(s).R1.t2_w, inst_4(s).R1.t3_w, inst_4(s).R1.t4_w],0,2);
    inst_4(s).C.std_w = std([inst_4(s).C.t1_w, inst_4(s).C.t2_w, inst_4(s).C.t3_w, inst_4(s).C.t4_w],0,2);
    inst_4(s).L1.std_w = std([inst_4(s).L1.t1_w, inst_4(s).L1.t2_w, inst_4(s).L1.t3_w, inst_4(s).L1.t4_w],0,2);
    inst_4(s).L2.std_w = std([inst_4(s).L2.t1_w, inst_4(s).L2.t2_w, inst_4(s).L2.t3_w, inst_4(s).L2.t4_w],0,2);
    inst_4(s).R2.std_w = std([inst_4(s).R2.t1_w, inst_4(s).R2.t2_w, inst_4(s).R2.t3_w, inst_4(s).R2.t4_w],0,2);        
    % inst4 - std_s
    inst_4(s).R1.std_s = std([inst_4(s).R1.t1_s, inst_4(s).R1.t2_s, inst_4(s).R1.t3_s, inst_4(s).R1.t4_s],0,2);
    inst_4(s).C.std_s = std([inst_4(s).C.t1_s, inst_4(s).C.t2_s, inst_4(s).C.t3_s, inst_4(s).C.t4_s],0,2);
    inst_4(s).L1.std_s = std([inst_4(s).L1.t1_s, inst_4(s).L1.t2_s, inst_4(s).L1.t3_s, inst_4(s).L1.t4_s],0,2);
    inst_4(s).L2.std_s = std([inst_4(s).L2.t1_s, inst_4(s).L2.t2_s, inst_4(s).L2.t3_s, inst_4(s).L2.t4_s],0,2);
    inst_4(s).R2.std_s = std([inst_4(s).R2.t1_s, inst_4(s).R2.t2_s, inst_4(s).R2.t3_s, inst_4(s).R2.t4_s],0,2);        

end

%% BIND R1<->R2, L1<->L2
for s = 1:10
    inst_1(s).R = array2table([(inst_1(s).R1.average_distance_error + inst_1(s).R2.average_distance_error)./2, (inst_1(s).R1.std_distance_error + inst_1(s).R2.std_distance_error)./2, ...
        (inst_1(s).R1.average_w + inst_1(s).R2.average_w)./2, (inst_1(s).R1.std_w + inst_1(s).R2.std_w)./2, (inst_1(s).R1.average_s + inst_1(s).R2.average_s)./2, (inst_1(s).R1.std_s + inst_1(s).R2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});
    inst_2(s).R = array2table([(inst_2(s).R1.average_distance_error + inst_2(s).R2.average_distance_error)./2, (inst_2(s).R1.std_distance_error + inst_2(s).R2.std_distance_error)./2, ...
        (inst_2(s).R1.average_w + inst_2(s).R2.average_w)./2, (inst_2(s).R1.std_w + inst_2(s).R2.std_w)./2, (inst_2(s).R1.average_s + inst_2(s).R2.average_s)./2, (inst_2(s).R1.std_s + inst_2(s).R2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});
    inst_3(s).R = array2table([(inst_3(s).R1.average_distance_error + inst_3(s).R2.average_distance_error)./2, (inst_3(s).R1.std_distance_error + inst_3(s).R2.std_distance_error)./2, ...
        (inst_3(s).R1.average_w + inst_3(s).R2.average_w)./2, (inst_3(s).R1.std_w + inst_3(s).R2.std_w)./2, (inst_3(s).R1.average_s + inst_3(s).R2.average_s)./2, (inst_3(s).R1.std_s + inst_3(s).R2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});
    inst_4(s).R = array2table([(inst_4(s).R1.average_distance_error + inst_4(s).R2.average_distance_error)./2, (inst_4(s).R1.std_distance_error + inst_4(s).R2.std_distance_error)./2, ...
        (inst_4(s).R1.average_w + inst_4(s).R2.average_w)./2, (inst_4(s).R1.std_w + inst_4(s).R2.std_w)./2, (inst_4(s).R1.average_s + inst_4(s).R2.average_s)./2, (inst_4(s).R1.std_s + inst_4(s).R2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});

    inst_1(s).L = array2table([(inst_1(s).L1.average_distance_error + inst_1(s).L2.average_distance_error)./2, (inst_1(s).L1.std_distance_error + inst_1(s).L2.std_distance_error)./2, ...
        (inst_1(s).L1.average_w + inst_1(s).L2.average_w)./2, (inst_1(s).L1.std_w + inst_1(s).L2.std_w)./2, (inst_1(s).L1.average_s + inst_1(s).L2.average_s)./2, (inst_1(s).L1.std_s + inst_1(s).L2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});
    inst_2(s).L = array2table([(inst_2(s).L1.average_distance_error + inst_2(s).L2.average_distance_error)./2, (inst_2(s).L1.std_distance_error + inst_2(s).L2.std_distance_error)./2, ...
        (inst_2(s).L1.average_w + inst_2(s).L2.average_w)./2, (inst_2(s).L1.std_w + inst_2(s).L2.std_w)./2, (inst_2(s).L1.average_s + inst_2(s).L2.average_s)./2, (inst_2(s).L1.std_s + inst_2(s).L2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});
    inst_3(s).L = array2table([(inst_3(s).L1.average_distance_error + inst_3(s).L2.average_distance_error)./2, (inst_3(s).L1.std_distance_error + inst_3(s).L2.std_distance_error)./2, ...
        (inst_3(s).L1.average_w + inst_3(s).L2.average_w)./2, (inst_3(s).L1.std_w + inst_3(s).L2.std_w)./2, (inst_3(s).L1.average_s + inst_3(s).L2.average_s)./2, (inst_3(s).L1.std_s + inst_3(s).L2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});
    inst_4(s).L = array2table([(inst_4(s).L1.average_distance_error + inst_4(s).L2.average_distance_error)./2, (inst_4(s).L1.std_distance_error + inst_4(s).L2.std_distance_error)./2, ...
        (inst_4(s).L1.average_w + inst_4(s).L2.average_w)./2, (inst_4(s).L1.std_w + inst_4(s).L2.std_w)./2, (inst_4(s).L1.average_s + inst_4(s).L2.average_s)./2, (inst_4(s).L1.std_s + inst_4(s).L2.std_s)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'average_w', 'std_w', 'average_s', 'std_s'});

end

%% inst_1 참가자 필드 R,L,C 별로 압축
inst_1_R_average_distance_error_CONTAINER = [inst_1(1).R.average_distance_error, inst_1(2).R.average_distance_error, inst_1(3).R.average_distance_error, inst_1(4).R.average_distance_error, inst_1(5).R.average_distance_error,...
    inst_1(6).R.average_distance_error, inst_1(7).R.average_distance_error, inst_1(8).R.average_distance_error, inst_1(9).R.average_distance_error, inst_1(10).R.average_distance_error];
inst_1_R_average_w_CONTAINER = [inst_1(1).R.average_w, inst_1(2).R.average_w, inst_1(3).R.average_w, inst_1(4).R.average_w, inst_1(5).R.average_w,...
    inst_1(6).R.average_w, inst_1(7).R.average_w, inst_1(8).R.average_w, inst_1(9).R.average_w, inst_1(10).R.average_w];
inst_1_R_average_s_CONTAINER = [inst_1(1).R.average_s, inst_1(2).R.average_s, inst_1(3).R.average_s, inst_1(4).R.average_s, inst_1(5).R.average_s,...
    inst_1(6).R.average_s, inst_1(7).R.average_s, inst_1(8).R.average_s, inst_1(9).R.average_s, inst_1(10).R.average_s];

inst_1_L_average_distance_error_CONTAINER = [inst_1(1).L.average_distance_error, inst_1(2).L.average_distance_error, inst_1(3).L.average_distance_error, inst_1(4).L.average_distance_error, inst_1(5).L.average_distance_error,...
    inst_1(6).L.average_distance_error, inst_1(7).L.average_distance_error, inst_1(8).L.average_distance_error, inst_1(9).L.average_distance_error, inst_1(10).L.average_distance_error];
inst_1_L_average_w_CONTAINER = [inst_1(1).L.average_w, inst_1(2).L.average_w, inst_1(3).L.average_w, inst_1(4).L.average_w, inst_1(5).L.average_w,...
    inst_1(6).L.average_w, inst_1(7).L.average_w, inst_1(8).L.average_w, inst_1(9).L.average_w, inst_1(10).L.average_w];
inst_1_L_average_s_CONTAINER = [inst_1(1).L.average_s, inst_1(2).L.average_s, inst_1(3).L.average_s, inst_1(4).L.average_s, inst_1(5).L.average_s,...
    inst_1(6).L.average_s, inst_1(7).L.average_s, inst_1(8).L.average_s, inst_1(9).L.average_s, inst_1(10).L.average_s];

inst_1_C_average_distance_error_CONTAINER = [inst_1(1).C.average_distance_error, inst_1(2).C.average_distance_error, inst_1(3).C.average_distance_error, inst_1(4).C.average_distance_error, inst_1(5).C.average_distance_error,...
    inst_1(6).C.average_distance_error, inst_1(7).C.average_distance_error, inst_1(8).C.average_distance_error, inst_1(9).C.average_distance_error, inst_1(10).C.average_distance_error];
inst_1_C_average_w_CONTAINER = [inst_1(1).C.average_w, inst_1(2).C.average_w, inst_1(3).C.average_w, inst_1(4).C.average_w, inst_1(5).C.average_w,...
    inst_1(6).C.average_w, inst_1(7).C.average_w, inst_1(8).C.average_w, inst_1(9).C.average_w, inst_1(10).C.average_w];
inst_1_C_average_s_CONTAINER = [inst_1(1).C.average_s, inst_1(2).C.average_s, inst_1(3).C.average_s, inst_1(4).C.average_s, inst_1(5).C.average_s,...
    inst_1(6).C.average_s, inst_1(7).C.average_s, inst_1(8).C.average_s, inst_1(9).C.average_s, inst_1(10).C.average_s];


inst_1_R_average_distance_error = mean(inst_1_R_average_distance_error_CONTAINER,2);
inst_1_R_std_distance_error = std(inst_1_R_average_distance_error_CONTAINER,0,2);
inst_1_R_average_w = mean(inst_1_R_average_w_CONTAINER,2);
inst_1_R_std_w = std(inst_1_R_average_w_CONTAINER,0,2);
inst_1_R_average_s = mean(inst_1_R_average_s_CONTAINER,2);
inst_1_R_std_s = std(inst_1_R_average_s_CONTAINER,0,2);

inst_1_L_average_distance_error = mean(inst_1_L_average_distance_error_CONTAINER,2);
inst_1_L_std_distance_error = std(inst_1_L_average_distance_error_CONTAINER,0,2);
inst_1_L_average_w = mean(inst_1_L_average_w_CONTAINER,2);
inst_1_L_std_w = std(inst_1_L_average_w_CONTAINER,0,2);
inst_1_L_average_s = mean(inst_1_L_average_s_CONTAINER,2);
inst_1_L_std_s = std(inst_1_L_average_s_CONTAINER,0,2);

inst_1_C_average_distance_error = mean(inst_1_C_average_distance_error_CONTAINER,2);
inst_1_C_std_distance_error = std(inst_1_C_average_distance_error_CONTAINER,0,2);
inst_1_C_average_w = mean(inst_1_C_average_w_CONTAINER,2);
inst_1_C_std_w = std(inst_1_C_average_w_CONTAINER,0,2);
inst_1_C_average_s = mean(inst_1_C_average_s_CONTAINER,2);
inst_1_C_std_s = std(inst_1_C_average_s_CONTAINER,0,2);


%% inst_1 참가자 필드 R,L,C 모두 함께 압축
inst_1_RLC_average_distance_error_CONTAINER = [inst_1_R_average_distance_error_CONTAINER, inst_1_L_average_distance_error_CONTAINER, inst_1_C_average_distance_error_CONTAINER];
inst_1_RLC_average_distance_error = mean(inst_1_RLC_average_distance_error_CONTAINER,2);
inst_1_RLC_std_distance_error = std(inst_1_RLC_average_distance_error_CONTAINER,0,2);

inst_1_RLC_average_w_CONTAINER = [inst_1_R_average_w_CONTAINER, inst_1_L_average_w_CONTAINER, inst_1_C_average_w_CONTAINER];
inst_1_RLC_average_w = mean(inst_1_RLC_average_w_CONTAINER,2);
inst_1_RLC_std_w = std(inst_1_RLC_average_w_CONTAINER,0,2);

inst_1_RLC_average_s_CONTAINER = [inst_1_R_average_s_CONTAINER, inst_1_L_average_s_CONTAINER, inst_1_C_average_s_CONTAINER];
inst_1_RLC_average_s = mean(inst_1_RLC_average_s_CONTAINER,2);
inst_1_RLC_std_s = std(inst_1_RLC_average_s_CONTAINER,0,2);


%% inst_2 참가자 필드 R,L,C 별로 압축
inst_2_R_average_distance_error_CONTAINER = [inst_2(1).R.average_distance_error, inst_2(2).R.average_distance_error, inst_2(3).R.average_distance_error, inst_2(4).R.average_distance_error, inst_2(5).R.average_distance_error,...
    inst_2(6).R.average_distance_error, inst_2(7).R.average_distance_error, inst_2(8).R.average_distance_error, inst_2(9).R.average_distance_error, inst_2(10).R.average_distance_error];
inst_2_R_average_w_CONTAINER = [inst_2(1).R.average_w, inst_2(2).R.average_w, inst_2(3).R.average_w, inst_2(4).R.average_w, inst_2(5).R.average_w,...
    inst_2(6).R.average_w, inst_2(7).R.average_w, inst_2(8).R.average_w, inst_2(9).R.average_w, inst_2(10).R.average_w];
inst_2_R_average_s_CONTAINER = [inst_2(1).R.average_s, inst_2(2).R.average_s, inst_2(3).R.average_s, inst_2(4).R.average_s, inst_2(5).R.average_s,...
    inst_2(6).R.average_s, inst_2(7).R.average_s, inst_2(8).R.average_s, inst_2(9).R.average_s, inst_2(10).R.average_s];
 
inst_2_L_average_distance_error_CONTAINER = [inst_2(1).L.average_distance_error, inst_2(2).L.average_distance_error, inst_2(3).L.average_distance_error, inst_2(4).L.average_distance_error, inst_2(5).L.average_distance_error,...
    inst_2(6).L.average_distance_error, inst_2(7).L.average_distance_error, inst_2(8).L.average_distance_error, inst_2(9).L.average_distance_error, inst_2(10).L.average_distance_error];
inst_2_L_average_w_CONTAINER = [inst_2(1).L.average_w, inst_2(2).L.average_w, inst_2(3).L.average_w, inst_2(4).L.average_w, inst_2(5).L.average_w,...
    inst_2(6).L.average_w, inst_2(7).L.average_w, inst_2(8).L.average_w, inst_2(9).L.average_w, inst_2(10).L.average_w];
inst_2_L_average_s_CONTAINER = [inst_2(1).L.average_s, inst_2(2).L.average_s, inst_2(3).L.average_s, inst_2(4).L.average_s, inst_2(5).L.average_s,...
    inst_2(6).L.average_s, inst_2(7).L.average_s, inst_2(8).L.average_s, inst_2(9).L.average_s, inst_2(10).L.average_s];
 
inst_2_C_average_distance_error_CONTAINER = [inst_2(1).C.average_distance_error, inst_2(2).C.average_distance_error, inst_2(3).C.average_distance_error, inst_2(4).C.average_distance_error, inst_2(5).C.average_distance_error,...
    inst_2(6).C.average_distance_error, inst_2(7).C.average_distance_error, inst_2(8).C.average_distance_error, inst_2(9).C.average_distance_error, inst_2(10).C.average_distance_error];
inst_2_C_average_w_CONTAINER = [inst_2(1).C.average_w, inst_2(2).C.average_w, inst_2(3).C.average_w, inst_2(4).C.average_w, inst_2(5).C.average_w,...
    inst_2(6).C.average_w, inst_2(7).C.average_w, inst_2(8).C.average_w, inst_2(9).C.average_w, inst_2(10).C.average_w];
inst_2_C_average_s_CONTAINER = [inst_2(1).C.average_s, inst_2(2).C.average_s, inst_2(3).C.average_s, inst_2(4).C.average_s, inst_2(5).C.average_s,...
    inst_2(6).C.average_s, inst_2(7).C.average_s, inst_2(8).C.average_s, inst_2(9).C.average_s, inst_2(10).C.average_s];
 
 
inst_2_R_average_distance_error = mean(inst_2_R_average_distance_error_CONTAINER,2);
inst_2_R_std_distance_error = std(inst_2_R_average_distance_error_CONTAINER,0,2);
inst_2_R_average_w = mean(inst_2_R_average_w_CONTAINER,2);
inst_2_R_std_w = std(inst_2_R_average_w_CONTAINER,0,2);
inst_2_R_average_s = mean(inst_2_R_average_s_CONTAINER,2);
inst_2_R_std_s = std(inst_2_R_average_s_CONTAINER,0,2);
 
inst_2_L_average_distance_error = mean(inst_2_L_average_distance_error_CONTAINER,2);
inst_2_L_std_distance_error = std(inst_2_L_average_distance_error_CONTAINER,0,2);
inst_2_L_average_w = mean(inst_2_L_average_w_CONTAINER,2);
inst_2_L_std_w = std(inst_2_L_average_w_CONTAINER,0,2);
inst_2_L_average_s = mean(inst_2_L_average_s_CONTAINER,2);
inst_2_L_std_s = std(inst_2_L_average_s_CONTAINER,0,2);
 
inst_2_C_average_distance_error = mean(inst_2_C_average_distance_error_CONTAINER,2);
inst_2_C_std_distance_error = std(inst_2_C_average_distance_error_CONTAINER,0,2);
inst_2_C_average_w = mean(inst_2_C_average_w_CONTAINER,2);
inst_2_C_std_w = std(inst_2_C_average_w_CONTAINER,0,2);
inst_2_C_average_s = mean(inst_2_C_average_s_CONTAINER,2);
inst_2_C_std_s = std(inst_2_C_average_s_CONTAINER,0,2);
 
 
%% inst_2 참가자 필드 R,L,C 모두 함께 압축
inst_2_RLC_average_distance_error_CONTAINER = [inst_2_R_average_distance_error_CONTAINER, inst_2_L_average_distance_error_CONTAINER, inst_2_C_average_distance_error_CONTAINER];
inst_2_RLC_average_distance_error = mean(inst_2_RLC_average_distance_error_CONTAINER,2);
inst_2_RLC_std_distance_error = std(inst_2_RLC_average_distance_error_CONTAINER,0,2);
 
inst_2_RLC_average_w_CONTAINER = [inst_2_R_average_w_CONTAINER, inst_2_L_average_w_CONTAINER, inst_2_C_average_w_CONTAINER];
inst_2_RLC_average_w = mean(inst_2_RLC_average_w_CONTAINER,2);
inst_2_RLC_std_w = std(inst_2_RLC_average_w_CONTAINER,0,2);
 
inst_2_RLC_average_s_CONTAINER = [inst_2_R_average_s_CONTAINER, inst_2_L_average_s_CONTAINER, inst_2_C_average_s_CONTAINER];
inst_2_RLC_average_s = mean(inst_2_RLC_average_s_CONTAINER,2);
inst_2_RLC_std_s = std(inst_2_RLC_average_s_CONTAINER,0,2);

%% inst_3 참가자 필드 R,L,C 별로 압축
inst_3_R_average_distance_error_CONTAINER = [inst_3(1).R.average_distance_error, inst_3(2).R.average_distance_error, inst_3(3).R.average_distance_error, inst_3(4).R.average_distance_error, inst_3(5).R.average_distance_error,...
    inst_3(6).R.average_distance_error, inst_3(7).R.average_distance_error, inst_3(8).R.average_distance_error, inst_3(9).R.average_distance_error, inst_3(10).R.average_distance_error];
inst_3_R_average_w_CONTAINER = [inst_3(1).R.average_w, inst_3(2).R.average_w, inst_3(3).R.average_w, inst_3(4).R.average_w, inst_3(5).R.average_w,...
    inst_3(6).R.average_w, inst_3(7).R.average_w, inst_3(8).R.average_w, inst_3(9).R.average_w, inst_3(10).R.average_w];
inst_3_R_average_s_CONTAINER = [inst_3(1).R.average_s, inst_3(2).R.average_s, inst_3(3).R.average_s, inst_3(4).R.average_s, inst_3(5).R.average_s,...
    inst_3(6).R.average_s, inst_3(7).R.average_s, inst_3(8).R.average_s, inst_3(9).R.average_s, inst_3(10).R.average_s];
 
inst_3_L_average_distance_error_CONTAINER = [inst_3(1).L.average_distance_error, inst_3(2).L.average_distance_error, inst_3(3).L.average_distance_error, inst_3(4).L.average_distance_error, inst_3(5).L.average_distance_error,...
    inst_3(6).L.average_distance_error, inst_3(7).L.average_distance_error, inst_3(8).L.average_distance_error, inst_3(9).L.average_distance_error, inst_3(10).L.average_distance_error];
inst_3_L_average_w_CONTAINER = [inst_3(1).L.average_w, inst_3(2).L.average_w, inst_3(3).L.average_w, inst_3(4).L.average_w, inst_3(5).L.average_w,...
    inst_3(6).L.average_w, inst_3(7).L.average_w, inst_3(8).L.average_w, inst_3(9).L.average_w, inst_3(10).L.average_w];
inst_3_L_average_s_CONTAINER = [inst_3(1).L.average_s, inst_3(2).L.average_s, inst_3(3).L.average_s, inst_3(4).L.average_s, inst_3(5).L.average_s,...
    inst_3(6).L.average_s, inst_3(7).L.average_s, inst_3(8).L.average_s, inst_3(9).L.average_s, inst_3(10).L.average_s];
 
inst_3_C_average_distance_error_CONTAINER = [inst_3(1).C.average_distance_error, inst_3(2).C.average_distance_error, inst_3(3).C.average_distance_error, inst_3(4).C.average_distance_error, inst_3(5).C.average_distance_error,...
    inst_3(6).C.average_distance_error, inst_3(7).C.average_distance_error, inst_3(8).C.average_distance_error, inst_3(9).C.average_distance_error, inst_3(10).C.average_distance_error];
inst_3_C_average_w_CONTAINER = [inst_3(1).C.average_w, inst_3(2).C.average_w, inst_3(3).C.average_w, inst_3(4).C.average_w, inst_3(5).C.average_w,...
    inst_3(6).C.average_w, inst_3(7).C.average_w, inst_3(8).C.average_w, inst_3(9).C.average_w, inst_3(10).C.average_w];
inst_3_C_average_s_CONTAINER = [inst_3(1).C.average_s, inst_3(2).C.average_s, inst_3(3).C.average_s, inst_3(4).C.average_s, inst_3(5).C.average_s,...
    inst_3(6).C.average_s, inst_3(7).C.average_s, inst_3(8).C.average_s, inst_3(9).C.average_s, inst_3(10).C.average_s];
 
 
inst_3_R_average_distance_error = mean(inst_3_R_average_distance_error_CONTAINER,2);
inst_3_R_std_distance_error = std(inst_3_R_average_distance_error_CONTAINER,0,2);
inst_3_R_average_w = mean(inst_3_R_average_w_CONTAINER,2);
inst_3_R_std_w = std(inst_3_R_average_w_CONTAINER,0,2);
inst_3_R_average_s = mean(inst_3_R_average_s_CONTAINER,2);
inst_3_R_std_s = std(inst_3_R_average_s_CONTAINER,0,2);
 
inst_3_L_average_distance_error = mean(inst_3_L_average_distance_error_CONTAINER,2);
inst_3_L_std_distance_error = std(inst_3_L_average_distance_error_CONTAINER,0,2);
inst_3_L_average_w = mean(inst_3_L_average_w_CONTAINER,2);
inst_3_L_std_w = std(inst_3_L_average_w_CONTAINER,0,2);
inst_3_L_average_s = mean(inst_3_L_average_s_CONTAINER,2);
inst_3_L_std_s = std(inst_3_L_average_s_CONTAINER,0,2);
 
inst_3_C_average_distance_error = mean(inst_3_C_average_distance_error_CONTAINER,2);
inst_3_C_std_distance_error = std(inst_3_C_average_distance_error_CONTAINER,0,2);
inst_3_C_average_w = mean(inst_3_C_average_w_CONTAINER,2);
inst_3_C_std_w = std(inst_3_C_average_w_CONTAINER,0,2);
inst_3_C_average_s = mean(inst_3_C_average_s_CONTAINER,2);
inst_3_C_std_s = std(inst_3_C_average_s_CONTAINER,0,2);
 
 
%% inst_3 참가자 필드 R,L,C 모두 함께 압축
inst_3_RLC_average_distance_error_CONTAINER = [inst_3_R_average_distance_error_CONTAINER, inst_3_L_average_distance_error_CONTAINER, inst_3_C_average_distance_error_CONTAINER];
inst_3_RLC_average_distance_error = mean(inst_3_RLC_average_distance_error_CONTAINER,2);
inst_3_RLC_std_distance_error = std(inst_3_RLC_average_distance_error_CONTAINER,0,2);
 
inst_3_RLC_average_w_CONTAINER = [inst_3_R_average_w_CONTAINER, inst_3_L_average_w_CONTAINER, inst_3_C_average_w_CONTAINER];
inst_3_RLC_average_w = mean(inst_3_RLC_average_w_CONTAINER,2);
inst_3_RLC_std_w = std(inst_3_RLC_average_w_CONTAINER,0,2);
 
inst_3_RLC_average_s_CONTAINER = [inst_3_R_average_s_CONTAINER, inst_3_L_average_s_CONTAINER, inst_3_C_average_s_CONTAINER];
inst_3_RLC_average_s = mean(inst_3_RLC_average_s_CONTAINER,2);
inst_3_RLC_std_s = std(inst_3_RLC_average_s_CONTAINER,0,2);

%% inst_4 참가자 필드 R,L,C 별로 압축
inst_4_R_average_distance_error_CONTAINER = [inst_4(1).R.average_distance_error, inst_4(2).R.average_distance_error, inst_4(3).R.average_distance_error, inst_4(4).R.average_distance_error, inst_4(5).R.average_distance_error,...
    inst_4(6).R.average_distance_error, inst_4(7).R.average_distance_error, inst_4(8).R.average_distance_error, inst_4(9).R.average_distance_error, inst_4(10).R.average_distance_error];
inst_4_R_average_w_CONTAINER = [inst_4(1).R.average_w, inst_4(2).R.average_w, inst_4(3).R.average_w, inst_4(4).R.average_w, inst_4(5).R.average_w,...
    inst_4(6).R.average_w, inst_4(7).R.average_w, inst_4(8).R.average_w, inst_4(9).R.average_w, inst_4(10).R.average_w];
inst_4_R_average_s_CONTAINER = [inst_4(1).R.average_s, inst_4(2).R.average_s, inst_4(3).R.average_s, inst_4(4).R.average_s, inst_4(5).R.average_s,...
    inst_4(6).R.average_s, inst_4(7).R.average_s, inst_4(8).R.average_s, inst_4(9).R.average_s, inst_4(10).R.average_s];
 
inst_4_L_average_distance_error_CONTAINER = [inst_4(1).L.average_distance_error, inst_4(2).L.average_distance_error, inst_4(3).L.average_distance_error, inst_4(4).L.average_distance_error, inst_4(5).L.average_distance_error,...
    inst_4(6).L.average_distance_error, inst_4(7).L.average_distance_error, inst_4(8).L.average_distance_error, inst_4(9).L.average_distance_error, inst_4(10).L.average_distance_error];
inst_4_L_average_w_CONTAINER = [inst_4(1).L.average_w, inst_4(2).L.average_w, inst_4(3).L.average_w, inst_4(4).L.average_w, inst_4(5).L.average_w,...
    inst_4(6).L.average_w, inst_4(7).L.average_w, inst_4(8).L.average_w, inst_4(9).L.average_w, inst_4(10).L.average_w];
inst_4_L_average_s_CONTAINER = [inst_4(1).L.average_s, inst_4(2).L.average_s, inst_4(3).L.average_s, inst_4(4).L.average_s, inst_4(5).L.average_s,...
    inst_4(6).L.average_s, inst_4(7).L.average_s, inst_4(8).L.average_s, inst_4(9).L.average_s, inst_4(10).L.average_s];
 
inst_4_C_average_distance_error_CONTAINER = [inst_4(1).C.average_distance_error, inst_4(2).C.average_distance_error, inst_4(3).C.average_distance_error, inst_4(4).C.average_distance_error, inst_4(5).C.average_distance_error,...
    inst_4(6).C.average_distance_error, inst_4(7).C.average_distance_error, inst_4(8).C.average_distance_error, inst_4(9).C.average_distance_error, inst_4(10).C.average_distance_error];
inst_4_C_average_w_CONTAINER = [inst_4(1).C.average_w, inst_4(2).C.average_w, inst_4(3).C.average_w, inst_4(4).C.average_w, inst_4(5).C.average_w,...
    inst_4(6).C.average_w, inst_4(7).C.average_w, inst_4(8).C.average_w, inst_4(9).C.average_w, inst_4(10).C.average_w];
inst_4_C_average_s_CONTAINER = [inst_4(1).C.average_s, inst_4(2).C.average_s, inst_4(3).C.average_s, inst_4(4).C.average_s, inst_4(5).C.average_s,...
    inst_4(6).C.average_s, inst_4(7).C.average_s, inst_4(8).C.average_s, inst_4(9).C.average_s, inst_4(10).C.average_s];
 
 
inst_4_R_average_distance_error = mean(inst_4_R_average_distance_error_CONTAINER,2);
inst_4_R_std_distance_error = std(inst_4_R_average_distance_error_CONTAINER,0,2);
inst_4_R_average_w = mean(inst_4_R_average_w_CONTAINER,2);
inst_4_R_std_w = std(inst_4_R_average_w_CONTAINER,0,2);
inst_4_R_average_s = mean(inst_4_R_average_s_CONTAINER,2);
inst_4_R_std_s = std(inst_4_R_average_s_CONTAINER,0,2);
 
inst_4_L_average_distance_error = mean(inst_4_L_average_distance_error_CONTAINER,2);
inst_4_L_std_distance_error = std(inst_4_L_average_distance_error_CONTAINER,0,2);
inst_4_L_average_w = mean(inst_4_L_average_w_CONTAINER,2);
inst_4_L_std_w = std(inst_4_L_average_w_CONTAINER,0,2);
inst_4_L_average_s = mean(inst_4_L_average_s_CONTAINER,2);
inst_4_L_std_s = std(inst_4_L_average_s_CONTAINER,0,2);
 
inst_4_C_average_distance_error = mean(inst_4_C_average_distance_error_CONTAINER,2);
inst_4_C_std_distance_error = std(inst_4_C_average_distance_error_CONTAINER,0,2);
inst_4_C_average_w = mean(inst_4_C_average_w_CONTAINER,2);
inst_4_C_std_w = std(inst_4_C_average_w_CONTAINER,0,2);
inst_4_C_average_s = mean(inst_4_C_average_s_CONTAINER,2);
inst_4_C_std_s = std(inst_4_C_average_s_CONTAINER,0,2);
 
 
%% inst_4 참가자 필드 R,L,C 모두 함께 압축
inst_4_RLC_average_distance_error_CONTAINER = [inst_4_R_average_distance_error_CONTAINER, inst_4_L_average_distance_error_CONTAINER, inst_4_C_average_distance_error_CONTAINER];
inst_4_RLC_average_distance_error = mean(inst_4_RLC_average_distance_error_CONTAINER,2);
inst_4_RLC_std_distance_error = std(inst_4_RLC_average_distance_error_CONTAINER,0,2);
 
inst_4_RLC_average_w_CONTAINER = [inst_4_R_average_w_CONTAINER, inst_4_L_average_w_CONTAINER, inst_4_C_average_w_CONTAINER];
inst_4_RLC_average_w = mean(inst_4_RLC_average_w_CONTAINER,2);
inst_4_RLC_std_w = std(inst_4_RLC_average_w_CONTAINER,0,2);
 
inst_4_RLC_average_s_CONTAINER = [inst_4_R_average_s_CONTAINER, inst_4_L_average_s_CONTAINER, inst_4_C_average_s_CONTAINER];
inst_4_RLC_average_s = mean(inst_4_RLC_average_s_CONTAINER,2);
inst_4_RLC_std_s = std(inst_4_RLC_average_s_CONTAINER,0,2);

%% inst_123 참가자 필드 R,L,C 별로 압축
inst_123_R_average_distance_error_CONTAINER = [inst_1_R_average_distance_error_CONTAINER, inst_2_R_average_distance_error_CONTAINER, inst_3_R_average_distance_error_CONTAINER];
inst_123_L_average_distance_error_CONTAINER = [inst_1_L_average_distance_error_CONTAINER, inst_2_L_average_distance_error_CONTAINER, inst_3_L_average_distance_error_CONTAINER];
inst_123_C_average_distance_error_CONTAINER = [inst_1_C_average_distance_error_CONTAINER, inst_2_C_average_distance_error_CONTAINER, inst_3_C_average_distance_error_CONTAINER];
inst_123_R_average_w_CONTAINER = [inst_1_R_average_w_CONTAINER, inst_2_R_average_w_CONTAINER, inst_3_R_average_w_CONTAINER];
inst_123_L_average_w_CONTAINER = [inst_1_L_average_w_CONTAINER, inst_2_L_average_w_CONTAINER, inst_3_L_average_w_CONTAINER];
inst_123_C_average_w_CONTAINER = [inst_1_C_average_w_CONTAINER, inst_2_C_average_w_CONTAINER, inst_3_C_average_w_CONTAINER];
inst_123_R_average_s_CONTAINER = [inst_1_R_average_s_CONTAINER, inst_2_R_average_s_CONTAINER, inst_3_R_average_s_CONTAINER];
inst_123_L_average_s_CONTAINER = [inst_1_L_average_s_CONTAINER, inst_2_L_average_s_CONTAINER, inst_3_L_average_s_CONTAINER];
inst_123_C_average_s_CONTAINER = [inst_1_C_average_s_CONTAINER, inst_2_C_average_s_CONTAINER, inst_3_C_average_s_CONTAINER];

inst_123_R_average_distance_error = mean(inst_123_R_average_distance_error_CONTAINER,2);
inst_123_R_std_distance_error = std(inst_123_R_average_distance_error_CONTAINER,0,2);
inst_123_L_average_distance_error = mean(inst_123_L_average_distance_error_CONTAINER,2);
inst_123_L_std_distance_error = std(inst_123_L_average_distance_error_CONTAINER,0,2);
inst_123_C_average_distance_error = mean(inst_123_C_average_distance_error_CONTAINER,2);
inst_123_C_std_distance_error = std(inst_123_C_average_distance_error_CONTAINER,0,2);
inst_123_R_average_w = mean(inst_123_R_average_w_CONTAINER,2);
inst_123_R_std_w = std(inst_123_R_average_w_CONTAINER,0,2);
inst_123_L_average_w = mean(inst_123_L_average_w_CONTAINER,2);
inst_123_L_std_w = std(inst_123_L_average_w_CONTAINER,0,2);
inst_123_C_average_w = mean(inst_123_C_average_w_CONTAINER,2);
inst_123_C_std_w = std(inst_123_C_average_w_CONTAINER,0,2);
inst_123_R_average_s = mean(inst_123_R_average_s_CONTAINER,2);
inst_123_R_std_s = std(inst_123_R_average_s_CONTAINER,0,2);
inst_123_L_average_s = mean(inst_123_L_average_s_CONTAINER,2);
inst_123_L_std_s = std(inst_123_L_average_s_CONTAINER,0,2);
inst_123_C_average_s = mean(inst_123_C_average_s_CONTAINER,2);
inst_123_C_std_s = std(inst_123_C_average_s_CONTAINER,0,2);

%% inst_123 참가자 필드 R,L,C 모두 압축
inst_123_RLC_average_distance_error_CONTAINER = [inst_123_R_average_distance_error_CONTAINER, inst_123_L_average_distance_error_CONTAINER, inst_123_C_average_distance_error_CONTAINER];
inst_123_RLC_average_w_CONTAINER = [inst_123_R_average_w_CONTAINER, inst_123_L_average_w_CONTAINER, inst_123_C_average_w_CONTAINER];
inst_123_RLC_average_s_CONTAINER = [inst_123_R_average_s_CONTAINER, inst_123_L_average_s_CONTAINER, inst_123_C_average_s_CONTAINER];

inst_123_RLC_average_distance_error = mean(inst_123_RLC_average_distance_error_CONTAINER,2);
inst_123_RLC_std_distance_error = std(inst_123_RLC_average_distance_error_CONTAINER,0,2);
inst_123_RLC_average_w = mean(inst_123_RLC_average_w_CONTAINER,2);
inst_123_RLC_std_w = std(inst_123_RLC_average_w_CONTAINER,0,2);
inst_123_RLC_average_s = mean(inst_123_RLC_average_s_CONTAINER,2);
inst_123_RLC_std_s = std(inst_123_RLC_average_s_CONTAINER,0,2);


%% inst_1234 참가자 필드 R,L,C 별로 압축
inst_1234_R_average_distance_error_CONTAINER = [inst_1_R_average_distance_error_CONTAINER, inst_2_R_average_distance_error_CONTAINER, inst_3_R_average_distance_error_CONTAINER, inst_4_R_average_distance_error_CONTAINER];
inst_1234_L_average_distance_error_CONTAINER = [inst_1_L_average_distance_error_CONTAINER, inst_2_L_average_distance_error_CONTAINER, inst_3_L_average_distance_error_CONTAINER, inst_4_L_average_distance_error_CONTAINER];
inst_1234_C_average_distance_error_CONTAINER = [inst_1_C_average_distance_error_CONTAINER, inst_2_C_average_distance_error_CONTAINER, inst_3_C_average_distance_error_CONTAINER, inst_4_L_average_distance_error_CONTAINER];
inst_1234_R_average_w_CONTAINER = [inst_1_R_average_w_CONTAINER, inst_2_R_average_w_CONTAINER, inst_3_R_average_w_CONTAINER, inst_4_R_average_w_CONTAINER];
inst_1234_L_average_w_CONTAINER = [inst_1_L_average_w_CONTAINER, inst_2_L_average_w_CONTAINER, inst_3_L_average_w_CONTAINER, inst_4_L_average_w_CONTAINER];
inst_1234_C_average_w_CONTAINER = [inst_1_C_average_w_CONTAINER, inst_2_C_average_w_CONTAINER, inst_3_C_average_w_CONTAINER, inst_4_C_average_w_CONTAINER];
inst_1234_R_average_s_CONTAINER = [inst_1_R_average_s_CONTAINER, inst_2_R_average_s_CONTAINER, inst_3_R_average_s_CONTAINER, inst_4_R_average_s_CONTAINER];
inst_1234_L_average_s_CONTAINER = [inst_1_L_average_s_CONTAINER, inst_2_L_average_s_CONTAINER, inst_3_L_average_s_CONTAINER, inst_4_L_average_s_CONTAINER];
inst_1234_C_average_s_CONTAINER = [inst_1_C_average_s_CONTAINER, inst_2_C_average_s_CONTAINER, inst_4_C_average_s_CONTAINER, inst_3_C_average_s_CONTAINER];

inst_1234_R_average_distance_error = mean(inst_1234_R_average_distance_error_CONTAINER,2);
inst_1234_R_std_distance_error = std(inst_1234_R_average_distance_error_CONTAINER,0,2);
inst_1234_L_average_distance_error = mean(inst_1234_L_average_distance_error_CONTAINER,2);
inst_1234_L_std_distance_error = std(inst_1234_L_average_distance_error_CONTAINER,0,2);
inst_1234_C_average_distance_error = mean(inst_1234_C_average_distance_error_CONTAINER,2);
inst_1234_C_std_distance_error = std(inst_1234_C_average_distance_error_CONTAINER,0,2);
inst_1234_R_average_w = mean(inst_1234_R_average_w_CONTAINER,2);
inst_1234_R_std_w = std(inst_1234_R_average_w_CONTAINER,0,2);
inst_1234_L_average_w = mean(inst_1234_L_average_w_CONTAINER,2);
inst_1234_L_std_w = std(inst_1234_L_average_w_CONTAINER,0,2);
inst_1234_C_average_w = mean(inst_1234_C_average_w_CONTAINER,2);
inst_1234_C_std_w = std(inst_1234_C_average_w_CONTAINER,0,2);
inst_1234_R_average_s = mean(inst_1234_R_average_s_CONTAINER,2);
inst_1234_R_std_s = std(inst_1234_R_average_s_CONTAINER,0,2);
inst_1234_L_average_s = mean(inst_1234_L_average_s_CONTAINER,2);
inst_1234_L_std_s = std(inst_1234_L_average_s_CONTAINER,0,2);
inst_1234_C_average_s = mean(inst_1234_C_average_s_CONTAINER,2);
inst_1234_C_std_s = std(inst_1234_C_average_s_CONTAINER,0,2);

%% inst_1234 참가자 필드 R,L,C 모두 압축

inst_1234_RLC_average_distance_error_CONTAINER = [inst_1234_R_average_distance_error_CONTAINER, inst_1234_L_average_distance_error_CONTAINER, inst_1234_C_average_distance_error_CONTAINER];
inst_1234_RLC_average_w_CONTAINER = [inst_1234_R_average_w_CONTAINER, inst_1234_L_average_w_CONTAINER, inst_1234_C_average_w_CONTAINER];
inst_1234_RLC_average_s_CONTAINER = [inst_1234_R_average_s_CONTAINER, inst_1234_L_average_s_CONTAINER, inst_1234_C_average_s_CONTAINER];

inst_1234_RLC_average_distance_error = mean(inst_1234_RLC_average_distance_error_CONTAINER,2);
inst_1234_RLC_std_distance_error = std(inst_1234_RLC_average_distance_error_CONTAINER,0,2);
inst_1234_RLC_average_w = mean(inst_1234_RLC_average_w_CONTAINER,2);
inst_1234_RLC_std_w = std(inst_1234_RLC_average_w_CONTAINER,0,2);
inst_1234_RLC_average_s = mean(inst_1234_RLC_average_s_CONTAINER,2);
inst_1234_RLC_std_s = std(inst_1234_RLC_average_s_CONTAINER,0,2);
%% ACC and PRC for conditions (𝑀=90, 3 Locations×3 Instructions×10 participants)
% f1 = figure;
% hold on;
% grid on;
% ylim([0,400]);
% x = [2:2:100];
% yacc1 = plot(x, inst_123_RLC_average_distance_error,'k','LineWidth',2,'Marker','o');
% yacc2 = plot(x, inst_1_RLC_average_distance_error,'LineWidth',2,'Marker','^');
% yacc3 = plot(x, inst_2_RLC_average_distance_error,'LineWidth',2,'Marker','+');
% yacc4 = plot(x, inst_3_RLC_average_distance_error,'LineWidth',2,'Marker','*');
% % yacc5 = plot(x, inst_1234_RLC_average_distance_error,'c','LineWidth',2);
% yacc5 = plot(x, inst_123_R_average_distance_error,'LineWidth',2,'Marker','x');
% yacc6 = plot(x, inst_123_L_average_distance_error,'LineWidth',2,'Marker','s');
% yacc7 = plot(x, inst_123_C_average_distance_error,'LineWidth',2,'Marker','d');
% yacc = [yacc1, yacc2, yacc3, yacc4, yacc5, yacc6, yacc7];
% 
% yprc1 = plot(x, inst_123_RLC_std_distance_error,'-.k','LineWidth',2,'Marker','o');
% yprc2 = plot(x, inst_1_RLC_std_distance_error,'-.','LineWidth',2,'Marker','^');  
% yprc3 = plot(x, inst_2_RLC_std_distance_error,'-.','LineWidth',2,'Marker','+');
% yprc4 = plot(x, inst_3_RLC_std_distance_error,'-.','LineWidth',2,'Marker','*');
% % yprc5 = plot(x, inst_1234_RLC_std_distance_error,'c','LineWidth',2);
% yprc5 = plot(x, inst_123_R_std_distance_error,'-.','LineWidth',2,'Marker','x');
% yprc6 = plot(x, inst_123_L_std_distance_error,'-.','LineWidth',2,'Marker','s');
% yprc7 = plot(x, inst_123_C_std_distance_error,'-.','LineWidth',2,'Marker','d');
% yprc = [yprc1, yprc2, yprc3, yprc4, yprc5, yprc6, yprc7];
% hold off;
% xlabel('\itPoint-and-Click Trials');
% ylabel('\itEstimation Performance (mm)');
% set(gca,'FontSize',20);
% leg1=legend(yacc, 'Overall (\itM\rm = 90)', 'Instruction - 1', 'Instruction - 2', 'Instruction - 3', 'Location - Right', 'Location - Left', 'Location - Center','Location','northeastoutside');
% title(leg1,'{\itACC}');
% set(leg1,'FontSize',15);
% ah1=axes('position',get(gca,'position'),'visible','off');
% leg2=legend(ah1,yprc,'Overall (\itM\rm = 90)', 'Instruction - 1', 'Instruction - 2', 'Instruction - 3', 'Location - Right', 'Location - Left', 'Location - Center','Location','eastoutside');
% title(leg2,'{\itPRC}');
% set(leg2,'FontSize',15);
% xlabel('')
% 
% %% ACC and PRC for Follow-up study conditions (𝑀=30, 3 Locations×1 Instructions×10 participants)
% f2 = figure;
% hold on;
% grid on;
% ylim([0,400]);
% x = [2:2:100];
% yyacc1 = plot(x, inst_4_RLC_average_distance_error,'k','LineWidth',2,'Marker','o');
% yyacc2 = plot(x, inst_4_R_average_distance_error,'Color',[0.4660, 0.6740, 0.1880],'LineWidth',2,'Marker','x');
% yyacc3 = plot(x, inst_4_L_average_distance_error,'Color',[0.3010, 0.7450, 0.9330],'LineWidth',2,'Marker','s');
% yyacc4 = plot(x, inst_4_C_average_distance_error,'Color',[0.6350, 0.0780, 0.1840],'LineWidth',2,'Marker','d');
% 
% yyacc = [yyacc1, yyacc2, yyacc3, yyacc4];
% 
% yyprc1 = plot(x, inst_4_RLC_std_distance_error,'-.k','LineWidth',2,'Marker','o');
% yyprc2 = plot(x, inst_4_R_std_distance_error,'-.','Color',[0.4660, 0.6740, 0.1880],'LineWidth',2,'Marker','x');  
% yyprc3 = plot(x, inst_4_L_std_distance_error,'-.','Color',[0.3010, 0.7450, 0.9330],'LineWidth',2,'Marker','s');
% yyprc4 = plot(x, inst_4_C_std_distance_error,'-.','Color',[0.6350, 0.0780, 0.1840],'LineWidth',2,'Marker','d');
% 
% yyprc = [yyprc1, yyprc2, yyprc3, yyprc4];
% hold off;
% xlabel('\itPoint-and-Click Trials');
% ylabel('\itEstimation Performance (mm)');
% set(gca,'FontSize',20);
% 
% leg1=legend(yyacc, 'Overall (\itM\rm = 30)', 'Location - Right', 'Location - Left', 'Location - Center','Location','northeastoutside');
% title(leg1,'{\itACC}');
% set(leg1,'FontSize',15);
% ah1=axes('position',get(gca,'position'),'visible','off');
% leg2=legend(ah1,yyprc,'Overall (\itM\rm = 30)', 'Location - Right', 'Location - Left', 'Location - Center','Location','eastoutside');
% title(leg2,'{\itPRC}');
% set(leg2,'FontSize',15);