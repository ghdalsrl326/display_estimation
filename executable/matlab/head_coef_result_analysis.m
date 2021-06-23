clear;clc;close all;
g1_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\user_test_case1_gs_result",'ReadVariableNames',true,'HeaderLines',0);
g1_add_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\user_test_case1_gs_add_result",'ReadVariableNames',true,'HeaderLines',0);
g1_40_add_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\user_test_case1_gs_40_add_result",'ReadVariableNames',true,'HeaderLines',0);

g2_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\user_test_case2_gs_result",'ReadVariableNames',true,'HeaderLines',0);
g2_add_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\user_test_case2_gs_add_result",'ReadVariableNames',true,'HeaderLines',0);
g2_40_add_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\user_test_case2_gs_40_add_result",'ReadVariableNames',true,'HeaderLines',0);

g3_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\user_test_case3_gs_result",'ReadVariableNames',true,'HeaderLines',0);
g3_add_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\user_test_case3_gs_add_result",'ReadVariableNames',true,'HeaderLines',0);
g3_40_add_result = readtable("C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\user_test_case3_gs_40_add_result",'ReadVariableNames',true,'HeaderLines',0);

g123_result = vertcat(g1_result, g2_result, g3_result);
g123_add_result = vertcat(g1_add_result, g2_add_result, g3_add_result);
g123_40_add_result = vertcat(g1_40_add_result, g2_40_add_result, g3_40_add_result);

edges = linspace(1,3,8);
edges_lb = edges-0.05; edges_ub = edges+0.05;
edges = sort([edges_lb, edges_ub]);

edges_add = linspace(1,4,12);
edges_add_lb = edges_add-0.05; edges_add_ub = edges_add+0.05;
edges_add = sort([edges_add_lb, edges_add_ub]);

edges_40_add = linspace(1,8,24);
edges_40_add_lb = edges_40_add-0.05; edges_40_add_ub = edges_40_add+0.05;
edges_40_add = sort([edges_40_add_lb, edges_40_add_ub]);


figure;
histogram(g123_40_add_result.elevation_coef,edges_40_add);
grid on
ylim([0, 60]);
title('Head Elevation Angle Coefficients - Group 1,2,3', 'FontSize', 12);

figure;
histogram(g1_40_add_result.elevation_coef,edges_40_add);
grid on
ylim([0, 60]);
title('Head Elevation Angle Coefficients - Group 1', 'FontSize', 12);

figure;
histogram(g2_40_add_result.elevation_coef,edges_40_add);
grid on
ylim([0, 60]);
title('Head Elevation Angle Coefficients - Group 2', 'FontSize', 12);

figure;
histogram(g3_40_add_result.elevation_coef,edges_40_add);
grid on
ylim([0, 60]);
title('Head Elevation Angle Coefficients - Group 3', 'FontSize', 12);