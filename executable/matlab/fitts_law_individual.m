clear; clc; close all;

sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
path = ["C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\"];
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];

merge_TCT = [];
merge_D = [];
merge_W = [];
merge_We = [];
merge_IDe = [];
merge_ID = [];

for p = 3:3 % instruction case
    for s = 1:10 % subject number
        for n =1:5 % display position
            
            raw_data = readtable(strcat(path(p),ss(s),sub_file(n)),'ReadVariableNames',true,'HeaderLines',0);
            raw_data = raw_data(:,1:71);
            raw_data = raw_data(raw_data.click==1,:);
            raw_data_calib_points = raw_data(raw_data.Success==1,:);
            last_calib_idx = find(raw_data.Success==1 & raw_data.target_x==960 & raw_data.target_y==540);            
            raw_data_true = raw_data(last_calib_idx+1:end,:); % calibration point 제외한 데이터 추출

           %% Fitts law
            TCT = diff(raw_data_true.millis); % Task Completion Time
            D_temp = [diff(raw_data_true.mouseX), diff(raw_data_true.mouseY)];
            D = zeros(size(D_temp,1),1); 
            for i = 1:size(D_temp,1)
                D(i) = norm(D_temp(i,:)); % Click Distance
            end
                        
            dist_x = raw_data_true.target_x(2:end) - raw_data_true.mouseX(2:end);
            dist_y = raw_data_true.target_y(2:end) - raw_data_true.mouseY(2:end);
            
            mean_x = ones(size(D_temp,1),1)*mean(dist_x);
            mean_y = ones(size(D_temp,1),1)*mean(dist_y);
            
            SD_temp = sum(sqrt((dist_x - mean_x).^2 + (dist_y - mean_y).^2).^2);
            SD_xy = sqrt(SD_temp/(size(D_temp,1) - 1));
            
            W = raw_data_true.target_size(2:end); % Target Width
            We = ones(size(D_temp,1),1).*(4.133*SD_xy); % Effective Target Width
            
            IDe = log2((D./We)+1);
            ID = log2((D./W)+1);
            
            TP = sum(ID./TCT)/size(D_temp,1);
                        
            %% merge
            merge_TCT = vertcat(merge_TCT, TCT);
            merge_D = vertcat(merge_D, D);
            merge_W = vertcat(merge_W, W);
            merge_We = vertcat(merge_We, We);
            merge_IDe = vertcat(merge_IDe, IDe);
            merge_ID = vertcat(merge_ID, ID);
        end
    end
end

merge_data=[merge_TCT, merge_D, merge_W, merge_We, merge_IDe, merge_ID];
merge_data = sortrows(merge_data, 6);
merge_data( all(~merge_data(:,6),2), : ) = [];

merge_TCT = merge_data(:,1);
merge_D = merge_data(:,2);
merge_W = merge_data(:,3);
merge_We = merge_data(:,4);
merge_IDe = merge_data(:,5);
merge_ID = merge_data(:,6);

modelfun = @(b,ID)b(1)*ID(:,1)+b(2);  % b: parameters, x: independent variable
beta0 = [0,0];
mdl = fitnlm(merge_ID,merge_TCT,modelfun,beta0);
y_prediction=mdl.Coefficients.Estimate(1)*merge_ID+mdl.Coefficients.Estimate(2);

%% Equal-spaced binning
% edges = [0:0.1:8];
% subs = discretize(merge_data(:,6),edges);
% subs(any(isnan(subs), 2), :) = [];
% bin_mean_TCT = accumarray(subs,merge_data(:,1),[],@mean);
% bin_mean_TCT( all(~bin_mean_TCT,2), : ) = [];
% bin_ID = edges(unique(subs));

%% Equal-numbered binning
N_merge_data = size(merge_data,1);
% divisor_temp = 1:N_merge_data;
% divisor = divisor_temp(rem(N_merge_data,divisor_temp)==0);
% mid_divisor = divisor(1+fix(length(divisor)/2));

% v = [1:N_merge_data/mid_divisor];
% subs = transpose(repelem(v,mid_divisor));

v = [1:1000];
bin_length = 200; % 한 bin에 몇개의 데이터를 넣을 것인지 결정
subs = transpose(repelem(v,bin_length));
subs = subs(1:N_merge_data);

bin_mean_TCT = accumarray(subs,merge_data(:,1),[],@mean);
bin_mean_TCT( all(~bin_mean_TCT,2), : ) = [];
bin_ID = accumarray(subs,merge_data(:,6),[],@mean);


modelfun2 = @(b2,ID2)b2(1)*ID2(:,1)+b2(2);  % b: parameters, x: independent variable
beta1 = [0,0];
mdl2 = fitnlm(bin_ID,bin_mean_TCT,modelfun2,beta1)
y_prediction2=mdl2.Coefficients.Estimate(1)*bin_ID+mdl2.Coefficients.Estimate(2);
TP = 1000/mdl2.Coefficients.Estimate(1) % Throughput(bits/s)
y_intercept = mdl2.Coefficients.Estimate(2)
%% TCT
% figure;
% hold on;
% plot(merge_ID,y_prediction,'.r');
% scatter(merge_ID, merge_TCT, 5, 'k');
% 
% xlabel('ID','FontSize',12);
% ylabel('TCT(ms)', 'FontSize',12);
% grid on;
% xlim([0 10]);
% ylim([0 12000]);
% hold off;

%% Mean TCT
figure;
hold on;
grid on;

bin_ID_plot = vertcat(-100, bin_ID, 100);
y_prediction2_plot = vertcat(mdl2.Coefficients.Estimate(1)*(-100)+mdl2.Coefficients.Estimate(2), y_prediction2, mdl2.Coefficients.Estimate(1)*(100)+mdl2.Coefficients.Estimate(2));

plot(bin_ID_plot,y_prediction2_plot,'r');
scatter(bin_ID, bin_mean_TCT, 5, 'k');
xlim([0 10]);
ylim([0 3000]);
xlabel('ID','FontSize',12);
ylabel('Mean TCT(ms)', 'FontSize',12);



%%
% Obtain R2

% SStot=sum((merge_TCT-mean(merge_TCT)).^2);
% SSres=sum((merge_TCT-y_prediction).^2);
% 
% R2 = 1-SSres/SStot
% 
% % adjusted R2
% 
% n=size(merge_ID,1);
% p=1;
% R2_adj = 1-((1-R2)*(n-1)/(n-p-1))
