clc; clear; close all;

files = dir('C:\MinkiHong\M1013\OpenFace-master\OpenFace-master\exe\FeatureExtraction\processed\*.csv');
num_files = length(files);
results = cell(length(files), 1);

parfor i = 1:num_files
  results{i} = xlsread(files(i).name);
end

figure;
hold on
grid on
for i = 6:10
    plot(results{i,1}(:,3),results{i,1}(:,4));
end