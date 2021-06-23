clear; clc; close all;

sub_file = ["data_robot_1.csv","data_robot_2.csv","data_robot_3.csv","data_robot_4.csv","data_robot_5.csv"];
path = ["C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case1_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case2_gs\",...
    "C:\MinkiHong\processing-3.5.4-windows64\processing_storage\multi_display\user_test_case3_gs\"];
ss = ["1\","2\","3\","4\","5\","6\","7\","8\","9\","10\"];

raw_answer = [];
for p = 1:1
    for s = 1:1
        for n = 5:5
            
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
            
            modelfun = @(b,IDe)b(1)*IDe(:,1)+b(2);  % b: parameters, x: independent variable
            beta0 = [0,0];
            mdl = fitnlm(ID,TCT,modelfun,beta0);
            y_prediction=mdl.Coefficients.Estimate(1)*ID+mdl.Coefficients.Estimate(2);
                        
            figure;
            hold on;
            plot(ID,y_prediction,'.r');
            scatter(ID, TCT, 'filled','k');
            
            xlabel('ID_e','FontSize',12);
            ylabel('TCT', 'FontSize',12);
            grid on
            xlim([0 10]);
            
            % Obtain R2

            SStot=sum((TCT-mean(TCT)).^2);
            SSres=sum((TCT-y_prediction).^2);
            
            R2 = 1-SSres/SStot
            
            % adjusted R2
            
            n=size(ID,1);
            p=1;
            R2_adj = 1-((1-R2)*(n-1)/(n-p-1))

        end
    end
end
