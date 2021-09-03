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

%% APPEND VARIABLE average_distance_error, std_distance_error
for s = 1:10
    inst_1(s).R1.average_distance_error = (inst_1(s).R1.t1_distance_error + inst_1(s).R1.t2_distance_error + inst_1(s).R1.t3_distance_error + inst_1(s).R1.t4_distance_error)./4;
    inst_1(s).C.average_distance_error = (inst_1(s).C.t1_distance_error + inst_1(s).C.t2_distance_error + inst_1(s).C.t3_distance_error + inst_1(s).C.t4_distance_error)./4;
    inst_1(s).L1.average_distance_error = (inst_1(s).L1.t1_distance_error + inst_1(s).L1.t2_distance_error + inst_1(s).L1.t3_distance_error + inst_1(s).L1.t4_distance_error)./4;
    inst_1(s).L2.average_distance_error = (inst_1(s).L2.t1_distance_error + inst_1(s).L2.t2_distance_error + inst_1(s).L2.t3_distance_error + inst_1(s).L2.t4_distance_error)./4;
    inst_1(s).R2.average_distance_error = (inst_1(s).R2.t1_distance_error + inst_1(s).R2.t2_distance_error + inst_1(s).R2.t3_distance_error + inst_1(s).R2.t4_distance_error)./4;    

    inst_1(s).R1.std_distance_error = std([inst_1(s).R1.t1_distance_error, inst_1(s).R1.t2_distance_error, inst_1(s).R1.t3_distance_error, inst_1(s).R1.t4_distance_error],0,2);
    inst_1(s).C.std_distance_error = std([inst_1(s).C.t1_distance_error, inst_1(s).C.t2_distance_error, inst_1(s).C.t3_distance_error, inst_1(s).C.t4_distance_error],0,2);
    inst_1(s).L1.std_distance_error = std([inst_1(s).L1.t1_distance_error, inst_1(s).L1.t2_distance_error, inst_1(s).L1.t3_distance_error, inst_1(s).L1.t4_distance_error],0,2);
    inst_1(s).L2.std_distance_error = std([inst_1(s).L2.t1_distance_error, inst_1(s).L2.t2_distance_error, inst_1(s).L2.t3_distance_error, inst_1(s).L2.t4_distance_error],0,2);
    inst_1(s).R2.std_distance_error = std([inst_1(s).R2.t1_distance_error, inst_1(s).R2.t2_distance_error, inst_1(s).R2.t3_distance_error, inst_1(s).R2.t4_distance_error],0,2);        
    
    inst_2(s).R1.average_distance_error = (inst_2(s).R1.t1_distance_error + inst_2(s).R1.t2_distance_error + inst_2(s).R1.t3_distance_error + inst_2(s).R1.t4_distance_error)./4;
    inst_2(s).C.average_distance_error = (inst_2(s).C.t1_distance_error + inst_2(s).C.t2_distance_error + inst_2(s).C.t3_distance_error + inst_2(s).C.t4_distance_error)./4;
    inst_2(s).L1.average_distance_error = (inst_2(s).L1.t1_distance_error + inst_2(s).L1.t2_distance_error + inst_2(s).L1.t3_distance_error + inst_2(s).L1.t4_distance_error)./4;
    inst_2(s).L2.average_distance_error = (inst_2(s).L2.t1_distance_error + inst_2(s).L2.t2_distance_error + inst_2(s).L2.t3_distance_error + inst_2(s).L2.t4_distance_error)./4;
    inst_2(s).R2.average_distance_error = (inst_2(s).R2.t1_distance_error + inst_2(s).R2.t2_distance_error + inst_2(s).R2.t3_distance_error + inst_2(s).R2.t4_distance_error)./4;    

    inst_2(s).R1.std_distance_error = std([inst_2(s).R1.t1_distance_error, inst_2(s).R1.t2_distance_error, inst_2(s).R1.t3_distance_error, inst_2(s).R1.t4_distance_error],0,2);
    inst_2(s).C.std_distance_error = std([inst_2(s).C.t1_distance_error, inst_2(s).C.t2_distance_error, inst_2(s).C.t3_distance_error, inst_2(s).C.t4_distance_error],0,2);
    inst_2(s).L1.std_distance_error = std([inst_2(s).L1.t1_distance_error, inst_2(s).L1.t2_distance_error, inst_2(s).L1.t3_distance_error, inst_2(s).L1.t4_distance_error],0,2);
    inst_2(s).L2.std_distance_error = std([inst_2(s).L2.t1_distance_error, inst_2(s).L2.t2_distance_error, inst_2(s).L2.t3_distance_error, inst_2(s).L2.t4_distance_error],0,2);
    inst_2(s).R2.std_distance_error = std([inst_2(s).R2.t1_distance_error, inst_2(s).R2.t2_distance_error, inst_2(s).R2.t3_distance_error, inst_2(s).R2.t4_distance_error],0,2);    
        
    inst_3(s).R1.average_distance_error = (inst_3(s).R1.t1_distance_error + inst_3(s).R1.t2_distance_error + inst_3(s).R1.t3_distance_error + inst_3(s).R1.t4_distance_error)./4;
    inst_3(s).C.average_distance_error = (inst_3(s).C.t1_distance_error + inst_3(s).C.t2_distance_error + inst_3(s).C.t3_distance_error + inst_3(s).C.t4_distance_error)./4;
    inst_3(s).L1.average_distance_error = (inst_3(s).L1.t1_distance_error + inst_3(s).L1.t2_distance_error + inst_3(s).L1.t3_distance_error + inst_3(s).L1.t4_distance_error)./4;
    inst_3(s).L2.average_distance_error = (inst_3(s).L2.t1_distance_error + inst_3(s).L2.t2_distance_error + inst_3(s).L2.t3_distance_error + inst_3(s).L2.t4_distance_error)./4;
    inst_3(s).R2.average_distance_error = (inst_3(s).R2.t1_distance_error + inst_3(s).R2.t2_distance_error + inst_3(s).R2.t3_distance_error + inst_3(s).R2.t4_distance_error)./4;        

    inst_3(s).R1.std_distance_error = std([inst_3(s).R1.t1_distance_error, inst_3(s).R1.t2_distance_error, inst_3(s).R1.t3_distance_error, inst_3(s).R1.t4_distance_error],0,2);
    inst_3(s).C.std_distance_error = std([inst_3(s).C.t1_distance_error, inst_3(s).C.t2_distance_error, inst_3(s).C.t3_distance_error, inst_3(s).C.t4_distance_error],0,2);
    inst_3(s).L1.std_distance_error = std([inst_3(s).L1.t1_distance_error, inst_3(s).L1.t2_distance_error, inst_3(s).L1.t3_distance_error, inst_3(s).L1.t4_distance_error],0,2);
    inst_3(s).L2.std_distance_error = std([inst_3(s).L2.t1_distance_error, inst_3(s).L2.t2_distance_error, inst_3(s).L2.t3_distance_error, inst_3(s).L2.t4_distance_error],0,2);
    inst_3(s).R2.std_distance_error = std([inst_3(s).R2.t1_distance_error, inst_3(s).R2.t2_distance_error, inst_3(s).R2.t3_distance_error, inst_3(s).R2.t4_distance_error],0,2);            

    inst_4(s).R1.average_distance_error = (inst_4(s).R1.t1_distance_error + inst_4(s).R1.t2_distance_error + inst_4(s).R1.t3_distance_error + inst_4(s).R1.t4_distance_error)./4;
    inst_4(s).C.average_distance_error = (inst_4(s).C.t1_distance_error + inst_4(s).C.t2_distance_error + inst_4(s).C.t3_distance_error + inst_4(s).C.t4_distance_error)./4;
    inst_4(s).L1.average_distance_error = (inst_4(s).L1.t1_distance_error + inst_4(s).L1.t2_distance_error + inst_4(s).L1.t3_distance_error + inst_4(s).L1.t4_distance_error)./4;
    inst_4(s).L2.average_distance_error = (inst_4(s).L2.t1_distance_error + inst_4(s).L2.t2_distance_error + inst_4(s).L2.t3_distance_error + inst_4(s).L2.t4_distance_error)./4;
    inst_4(s).R2.average_distance_error = (inst_4(s).R2.t1_distance_error + inst_4(s).R2.t2_distance_error + inst_4(s).R2.t3_distance_error + inst_4(s).R2.t4_distance_error)./4;        
 
    inst_4(s).R1.std_distance_error = std([inst_4(s).R1.t1_distance_error, inst_4(s).R1.t2_distance_error, inst_4(s).R1.t3_distance_error, inst_4(s).R1.t4_distance_error],0,2);
    inst_4(s).C.std_distance_error = std([inst_4(s).C.t1_distance_error, inst_4(s).C.t2_distance_error, inst_4(s).C.t3_distance_error, inst_4(s).C.t4_distance_error],0,2);
    inst_4(s).L1.std_distance_error = std([inst_4(s).L1.t1_distance_error, inst_4(s).L1.t2_distance_error, inst_4(s).L1.t3_distance_error, inst_4(s).L1.t4_distance_error],0,2);
    inst_4(s).L2.std_distance_error = std([inst_4(s).L2.t1_distance_error, inst_4(s).L2.t2_distance_error, inst_4(s).L2.t3_distance_error, inst_4(s).L2.t4_distance_error],0,2);
    inst_4(s).R2.std_distance_error = std([inst_4(s).R2.t1_distance_error, inst_4(s).R2.t2_distance_error, inst_4(s).R2.t3_distance_error, inst_4(s).R2.t4_distance_error],0,2);            
    
end

%% BIND R1<->R2, L1<->L2
for s = 1:10
    inst_1(s).R = array2table([(inst_1(s).R1.average_distance_error + inst_1(s).R2.average_distance_error)./2, (inst_1(s).R1.std_distance_error + inst_1(s).R2.std_distance_error)./2, ...
        (inst_1(s).R1.best_distance_error + inst_1(s).R2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});
    inst_2(s).R = array2table([(inst_2(s).R1.average_distance_error + inst_2(s).R2.average_distance_error)./2, (inst_2(s).R1.std_distance_error + inst_2(s).R2.std_distance_error)./2, ...
        (inst_2(s).R1.best_distance_error + inst_2(s).R2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});
    inst_3(s).R = array2table([(inst_3(s).R1.average_distance_error + inst_3(s).R2.average_distance_error)./2, (inst_3(s).R1.std_distance_error + inst_3(s).R2.std_distance_error)./2, ...
        (inst_3(s).R1.best_distance_error + inst_3(s).R2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});
    inst_4(s).R = array2table([(inst_4(s).R1.average_distance_error + inst_4(s).R2.average_distance_error)./2, (inst_4(s).R1.std_distance_error + inst_4(s).R2.std_distance_error)./2, ...
        (inst_4(s).R1.best_distance_error + inst_4(s).R2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});

    
    inst_1(s).L = array2table([(inst_1(s).L1.average_distance_error + inst_1(s).L2.average_distance_error)./2, (inst_1(s).L1.std_distance_error + inst_1(s).L2.std_distance_error)./2, ...
        (inst_1(s).L1.best_distance_error + inst_1(s).L2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});
    inst_2(s).L = array2table([(inst_2(s).L1.average_distance_error + inst_2(s).L2.average_distance_error)./2, (inst_2(s).L1.std_distance_error + inst_2(s).L2.std_distance_error)./2, ...
        (inst_2(s).L1.best_distance_error + inst_2(s).L2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});
    inst_3(s).L = array2table([(inst_3(s).L1.average_distance_error + inst_3(s).L2.average_distance_error)./2, (inst_3(s).L1.std_distance_error + inst_3(s).L2.std_distance_error)./2, ...
        (inst_3(s).L1.best_distance_error + inst_3(s).L2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});
    inst_4(s).L = array2table([(inst_4(s).L1.average_distance_error + inst_4(s).L2.average_distance_error)./2, (inst_4(s).L1.std_distance_error + inst_4(s).L2.std_distance_error)./2, ...
        (inst_4(s).L1.best_distance_error + inst_4(s).L2.best_distance_error)./2], 'VariableNames',{'average_distance_error', 'std_distance_error', 'best_distance_error'});

end

%% inst_1 참가자 필드 R,L,C 별로 압축
inst_1_R = [inst_1(1).R.average_distance_error, inst_1(2).R.average_distance_error, inst_1(3).R.average_distance_error, inst_1(4).R.average_distance_error, inst_1(5).R.average_distance_error,...
    inst_1(6).R.average_distance_error, inst_1(7).R.average_distance_error, inst_1(8).R.average_distance_error, inst_1(9).R.average_distance_error, inst_1(10).R.average_distance_error];
inst_1_L = [inst_1(1).L.average_distance_error, inst_1(2).L.average_distance_error, inst_1(3).L.average_distance_error, inst_1(4).L.average_distance_error, inst_1(5).L.average_distance_error,...
    inst_1(6).L.average_distance_error, inst_1(7).L.average_distance_error, inst_1(8).L.average_distance_error, inst_1(9).L.average_distance_error, inst_1(10).L.average_distance_error];
inst_1_C = [inst_1(1).C.average_distance_error, inst_1(2).C.average_distance_error, inst_1(3).C.average_distance_error, inst_1(4).C.average_distance_error, inst_1(5).C.average_distance_error,...
    inst_1(6).C.average_distance_error, inst_1(7).C.average_distance_error, inst_1(8).C.average_distance_error, inst_1(9).C.average_distance_error, inst_1(10).C.average_distance_error];

% inst_1_Rb = [inst_1(1).R.best_distance_error, inst_1(2).R.best_distance_error, inst_1(3).R.best_distance_error, inst_1(4).R.best_distance_error, inst_1(5).R.best_distance_error,...
%     inst_1(6).R.best_distance_error, inst_1(7).R.best_distance_error, inst_1(8).R.best_distance_error, inst_1(9).R.best_distance_error, inst_1(10).R.best_distance_error];
% inst_1_Lb = [inst_1(1).L.best_distance_error, inst_1(2).L.best_distance_error, inst_1(3).L.best_distance_error, inst_1(4).L.best_distance_error, inst_1(5).L.best_distance_error,...
%     inst_1(6).L.best_distance_error, inst_1(7).L.best_distance_error, inst_1(8).L.best_distance_error, inst_1(9).L.best_distance_error, inst_1(10).L.best_distance_error];
% inst_1_Cb = [inst_1(1).C.best_distance_error, inst_1(2).C.best_distance_error, inst_1(3).C.best_distance_error, inst_1(4).C.best_distance_error, inst_1(5).C.best_distance_error,...
%     inst_1(6).C.best_distance_error, inst_1(7).C.best_distance_error, inst_1(8).C.best_distance_error, inst_1(9).C.best_distance_error, inst_1(10).C.best_distance_error];

inst_1_R_average_distance_error = mean(inst_1_R,2);
inst_1_R_std_distance_error = std(inst_1_R,0,2);
inst_1_L_average_distance_error = mean(inst_1_L,2);
inst_1_L_std_distance_error = std(inst_1_L,0,2);
inst_1_C_average_distance_error = mean(inst_1_C,2);
inst_1_C_std_distance_error = std(inst_1_C,0,2);

% inst_1_Rb_average_distance_error = mean(inst_1_Rb,2);
% inst_1_Rb_std_distance_error = std(inst_1_Rb,0,2);
% inst_1_Lb_average_distance_error = mean(inst_1_Lb,2);
% inst_1_Lb_std_distance_error = std(inst_1_Lb,0,2);
% inst_1_Cb_average_distance_error = mean(inst_1_Cb,2);
% inst_1_Cb_std_distance_error = std(inst_1_Cb,0,2);

%% inst_1 참가자 필드 R,L,C 모두 함께 압축
inst_1_RLC = [inst_1_R, inst_1_L, inst_1_C];
inst_1_RLC_average_distance_error = mean(inst_1_RLC,2);
inst_1_RLC_std_distance_error = std(inst_1_RLC,0,2);

% inst_1_RLCb = [inst_1_Rb, inst_1_Lb, inst_1_Cb];
% inst_1_RLCb_average_distance_error = mean(inst_1_RLCb,2);
% inst_1_RLCb_std_distance_error = std(inst_1_RLCb,0,2);

%% inst_2 참가자 필드 R,L,C 별로 압축
inst_2_R = [inst_2(1).R.average_distance_error, inst_2(2).R.average_distance_error, inst_2(3).R.average_distance_error, inst_2(4).R.average_distance_error, inst_2(5).R.average_distance_error,...
    inst_2(6).R.average_distance_error, inst_2(7).R.average_distance_error, inst_2(8).R.average_distance_error, inst_2(9).R.average_distance_error, inst_2(10).R.average_distance_error];
inst_2_L = [inst_2(1).L.average_distance_error, inst_2(2).L.average_distance_error, inst_2(3).L.average_distance_error, inst_2(4).L.average_distance_error, inst_2(5).L.average_distance_error,...
    inst_2(6).L.average_distance_error, inst_2(7).L.average_distance_error, inst_2(8).L.average_distance_error, inst_2(9).L.average_distance_error, inst_2(10).L.average_distance_error];
inst_2_C = [inst_2(1).C.average_distance_error, inst_2(2).C.average_distance_error, inst_2(3).C.average_distance_error, inst_2(4).C.average_distance_error, inst_2(5).C.average_distance_error,...
    inst_2(6).C.average_distance_error, inst_2(7).C.average_distance_error, inst_2(8).C.average_distance_error, inst_2(9).C.average_distance_error, inst_2(10).C.average_distance_error];

% inst_2_Rb = [inst_2(1).R.best_distance_error, inst_2(2).R.best_distance_error, inst_2(3).R.best_distance_error, inst_2(4).R.best_distance_error, inst_2(5).R.best_distance_error,...
%     inst_2(6).R.best_distance_error, inst_2(7).R.best_distance_error, inst_2(8).R.best_distance_error, inst_2(9).R.best_distance_error, inst_2(10).R.best_distance_error];
% inst_2_Lb = [inst_2(1).L.best_distance_error, inst_2(2).L.best_distance_error, inst_2(3).L.best_distance_error, inst_2(4).L.best_distance_error, inst_2(5).L.best_distance_error,...
%     inst_2(6).L.best_distance_error, inst_2(7).L.best_distance_error, inst_2(8).L.best_distance_error, inst_2(9).L.best_distance_error, inst_2(10).L.best_distance_error];
% inst_2_Cb = [inst_2(1).C.best_distance_error, inst_2(2).C.best_distance_error, inst_2(3).C.best_distance_error, inst_2(4).C.best_distance_error, inst_2(5).C.best_distance_error,...
%     inst_2(6).C.best_distance_error, inst_2(7).C.best_distance_error, inst_2(8).C.best_distance_error, inst_2(9).C.best_distance_error, inst_2(10).C.best_distance_error];

inst_2_R_average_distance_error = mean(inst_2_R,2);
inst_2_R_std_distance_error = std(inst_2_R,0,2);
inst_2_L_average_distance_error = mean(inst_2_L,2);
inst_2_L_std_distance_error = std(inst_2_L,0,2);
inst_2_C_average_distance_error = mean(inst_2_C,2);
inst_2_C_std_distance_error = std(inst_2_C,0,2);

% inst_2_Rb_average_distance_error = mean(inst_2_Rb,2);
% inst_2_Rb_std_distance_error = std(inst_2_Rb,0,2);
% inst_2_Lb_average_distance_error = mean(inst_2_Lb,2);
% inst_2_Lb_std_distance_error = std(inst_2_Lb,0,2);
% inst_2_Cb_average_distance_error = mean(inst_2_Cb,2);
% inst_2_Cb_std_distance_error = std(inst_2_Cb,0,2);

%% inst_2 참가자 필드 R,L,C 모두 함께 압축
inst_2_RLC = [inst_2_R, inst_2_L, inst_2_C];
inst_2_RLC_average_distance_error = mean(inst_2_RLC,2);
inst_2_RLC_std_distance_error = std(inst_2_RLC,0,2);

% inst_2_RLCb = [inst_2_Rb, inst_2_Lb, inst_2_Cb];
% inst_2_RLCb_average_distance_error = mean(inst_2_RLCb,2);
% inst_2_RLCb_std_distance_error = std(inst_2_RLCb,0,2);

%% inst_3 참가자 필드 R,L,C 별로 압축
inst_3_R = [inst_3(1).R.average_distance_error, inst_3(2).R.average_distance_error, inst_3(3).R.average_distance_error, inst_3(4).R.average_distance_error, inst_3(5).R.average_distance_error,...
    inst_3(6).R.average_distance_error, inst_3(7).R.average_distance_error, inst_3(8).R.average_distance_error, inst_3(9).R.average_distance_error, inst_3(10).R.average_distance_error];
inst_3_L = [inst_3(1).L.average_distance_error, inst_3(2).L.average_distance_error, inst_3(3).L.average_distance_error, inst_3(4).L.average_distance_error, inst_3(5).L.average_distance_error,...
    inst_3(6).L.average_distance_error, inst_3(7).L.average_distance_error, inst_3(8).L.average_distance_error, inst_3(9).L.average_distance_error, inst_3(10).L.average_distance_error];
inst_3_C = [inst_3(1).C.average_distance_error, inst_3(2).C.average_distance_error, inst_3(3).C.average_distance_error, inst_3(4).C.average_distance_error, inst_3(5).C.average_distance_error,...
    inst_3(6).C.average_distance_error, inst_3(7).C.average_distance_error, inst_3(8).C.average_distance_error, inst_3(9).C.average_distance_error, inst_3(10).C.average_distance_error];

% inst_3_Rb = [inst_3(1).R.best_distance_error, inst_3(2).R.best_distance_error, inst_3(3).R.best_distance_error, inst_3(4).R.best_distance_error, inst_3(5).R.best_distance_error,...
%     inst_3(6).R.best_distance_error, inst_3(7).R.best_distance_error, inst_3(8).R.best_distance_error, inst_3(9).R.best_distance_error, inst_3(10).R.best_distance_error];
% inst_3_Lb = [inst_3(1).L.best_distance_error, inst_3(2).L.best_distance_error, inst_3(3).L.best_distance_error, inst_3(4).L.best_distance_error, inst_3(5).L.best_distance_error,...
%     inst_3(6).L.best_distance_error, inst_3(7).L.best_distance_error, inst_3(8).L.best_distance_error, inst_3(9).L.best_distance_error, inst_3(10).L.best_distance_error];
% inst_3_Cb = [inst_3(1).C.best_distance_error, inst_3(2).C.best_distance_error, inst_3(3).C.best_distance_error, inst_3(4).C.best_distance_error, inst_3(5).C.best_distance_error,...
%     inst_3(6).C.best_distance_error, inst_3(7).C.best_distance_error, inst_3(8).C.best_distance_error, inst_3(9).C.best_distance_error, inst_3(10).C.best_distance_error];

inst_3_R_average_distance_error = mean(inst_3_R,2);
inst_3_R_std_distance_error = std(inst_3_R,0,2);
inst_3_L_average_distance_error = mean(inst_3_L,2);
inst_3_L_std_distance_error = std(inst_3_L,0,2);
inst_3_C_average_distance_error = mean(inst_3_C,2);
inst_3_C_std_distance_error = std(inst_3_C,0,2);

% inst_3_Rb_average_distance_error = mean(inst_3_Rb,2);
% inst_3_Rb_std_distance_error = std(inst_3_Rb,0,2);
% inst_3_Lb_average_distance_error = mean(inst_3_Lb,2);
% inst_3_Lb_std_distance_error = std(inst_3_Lb,0,2);
% inst_3_Cb_average_distance_error = mean(inst_3_Cb,2);
% inst_3_Cb_std_distance_error = std(inst_3_Cb,0,2);

%% inst_3 참가자 필드 R,L,C 모두 함께 압축
inst_3_RLC = [inst_3_R, inst_3_L, inst_3_C];
inst_3_RLC_average_distance_error = mean(inst_3_RLC,2);
inst_3_RLC_std_distance_error = std(inst_3_RLC,0,2);

% inst_3_RLCb = [inst_3_Rb, inst_3_Lb, inst_3_Cb];
% inst_3_RLCb_average_distance_error = mean(inst_3_RLCb,2);
% inst_3_RLCb_std_distance_error = std(inst_3_RLCb,0,2);

%% inst_4 참가자 필드 R,L,C 별로 압축
inst_4_R = [inst_4(1).R.average_distance_error, inst_4(2).R.average_distance_error, inst_4(3).R.average_distance_error, inst_4(4).R.average_distance_error, inst_4(5).R.average_distance_error,...
    inst_4(6).R.average_distance_error, inst_4(7).R.average_distance_error, inst_4(8).R.average_distance_error, inst_4(9).R.average_distance_error, inst_4(10).R.average_distance_error];
inst_4_L = [inst_4(1).L.average_distance_error, inst_4(2).L.average_distance_error, inst_4(3).L.average_distance_error, inst_4(4).L.average_distance_error, inst_4(5).L.average_distance_error,...
    inst_4(6).L.average_distance_error, inst_4(7).L.average_distance_error, inst_4(8).L.average_distance_error, inst_4(9).L.average_distance_error, inst_4(10).L.average_distance_error];
inst_4_C = [inst_4(1).C.average_distance_error, inst_4(2).C.average_distance_error, inst_4(3).C.average_distance_error, inst_4(4).C.average_distance_error, inst_4(5).C.average_distance_error,...
    inst_4(6).C.average_distance_error, inst_4(7).C.average_distance_error, inst_4(8).C.average_distance_error, inst_4(9).C.average_distance_error, inst_4(10).C.average_distance_error];
 
inst_4_R_average_distance_error = mean(inst_4_R,2);
inst_4_R_std_distance_error = std(inst_4_R,0,2);
inst_4_L_average_distance_error = mean(inst_4_L,2);
inst_4_L_std_distance_error = std(inst_4_L,0,2);
inst_4_C_average_distance_error = mean(inst_4_C,2);
inst_4_C_std_distance_error = std(inst_4_C,0,2);

%% inst_4 참가자 필드 R,L,C 모두 함께 압축
inst_4_RLC = [inst_4_R, inst_4_L, inst_4_C];
inst_4_RLC_average_distance_error = mean(inst_4_RLC,2);
inst_4_RLC_std_distance_error = std(inst_4_RLC,0,2);

%% inst_123 참가자 필드 R,L,C 별로 압축
inst_123_R = [inst_1_R, inst_2_R, inst_3_R];
inst_123_L = [inst_1_L, inst_2_L, inst_3_L];
inst_123_C = [inst_1_C, inst_2_C, inst_3_C];

% inst_123_Rb = [inst_1_Rb, inst_2_Rb, inst_3_Rb];
% inst_123_Lb = [inst_1_Lb, inst_2_Lb, inst_3_Lb];
% inst_123_Cb = [inst_1_Cb, inst_2_Cb, inst_3_Cb];

inst_123_R_average_distance_error = mean(inst_123_R,2);
inst_123_R_std_distance_error = std(inst_123_R,0,2);
% inst_123_Rb_average_distance_error = mean(inst_123_Rb,2);
% inst_123_Rb_std_distance_error = std(inst_123_Rb,0,2);

inst_123_L_average_distance_error = mean(inst_123_L,2);
inst_123_L_std_distance_error = std(inst_123_L,0,2);
% inst_123_Lb_average_distance_error = mean(inst_123_Lb,2);
% inst_123_Lb_std_distance_error = std(inst_123_Lb,0,2);

inst_123_C_average_distance_error = mean(inst_123_C,2);
inst_123_C_std_distance_error = std(inst_123_C,0,2);
% inst_123_Cb_average_distance_error = mean(inst_123_Cb,2);
% inst_123_Cb_std_distance_error = std(inst_123_Cb,0,2);

%% inst_123 참가자 필드 R,L,C 모두 압축
inst_123_RLC = [inst_123_R, inst_123_L, inst_123_C];
inst_123_RLC_average_distance_error = mean(inst_123_RLC,2);
inst_123_RLC_std_distance_error = std(inst_123_RLC,0,2);

% inst_123_RLCb = [inst_123_Rb, inst_123_Lb, inst_123_Cb];
% inst_123_RLCb_average_distance_error = mean(inst_123_RLCb,2);
% inst_123_RLCb_std_distance_error = std(inst_123_RLCb,0,2);

%% inst_1234 참가자 필드 R,L,C 별로 압축
inst_1234_R = [inst_1_R, inst_2_R, inst_3_R, inst_4_R];
inst_1234_L = [inst_1_L, inst_2_L, inst_3_L, inst_4_L];
inst_1234_C = [inst_1_C, inst_2_C, inst_3_C, inst_4_C];

inst_1234_R_average_distance_error = mean(inst_1234_R,2);
inst_1234_R_std_distance_error = std(inst_1234_R,0,2);

inst_1234_L_average_distance_error = mean(inst_1234_L,2);
inst_1234_L_std_distance_error = std(inst_1234_L,0,2);

inst_1234_C_average_distance_error = mean(inst_1234_C,2);
inst_1234_C_std_distance_error = std(inst_1234_C,0,2);

%% inst_1234 참가자 필드 R,L,C 모두 압축
inst_1234_RLC = [inst_1234_R, inst_1234_L, inst_1234_C];
inst_1234_RLC_average_distance_error = mean(inst_1234_RLC,2);
inst_1234_RLC_std_distance_error = std(inst_1234_RLC,0,2);

%% ACC and PRC for all conditions (𝑀=90, 3 Locations×3 Instructions×10 participants)
figure;
hold on;
grid on;
xlabel('Click Trials');
ylabel('ACC');
ylim([0,350]);
x = [2:2:100];
yacc1 = plot(x, inst_1_RLC_average_distance_error,'r','LineWidth',2);
yacc2 = plot(x, inst_2_RLC_average_distance_error,'g','LineWidth',2);
yacc3 = plot(x, inst_3_RLC_average_distance_error,'b','LineWidth',2);
yacc4 = plot(x, inst_123_RLC_average_distance_error,'k','LineWidth',2);
yacc5 = plot(x, inst_1234_RLC_average_distance_error,'c','LineWidth',2);
hold off;
legend({'Instruction 1 - Mean','Instruction 2 - Mean','Instruction 3 - Mean','Instruction 1,2,3 - Mean', 'Instruction 1,2,3,4 - Mean'},'Location','best','NumColumns',2)

figure;
hold on;
grid on;
xlabel('Click Trials');
ylabel('PRC');
ylim([0,150]);
yprc1 = plot(x, inst_1_RLC_std_distance_error,'r','LineWidth',2);
yprc2 = plot(x, inst_2_RLC_std_distance_error,'g','LineWidth',2);
yprc3 = plot(x, inst_3_RLC_std_distance_error,'b','LineWidth',2);
yprc4 = plot(x, inst_123_RLC_std_distance_error,'k','LineWidth',2);
yprc5 = plot(x, inst_1234_RLC_std_distance_error,'c','LineWidth',2);

hold off;
legend({'Instruction 1 - Mean','Instruction 2 - Mean','Instruction 3 - Mean','Instruction 1,2,3 - Mean','Instruction 1,2,3,4 - Mean'},'Location','southeast','NumColumns',2)