clear;clc;close all;
mu = [0 0];
Sigma = [0.3 0; 0 0.3];

p = mvncdf([0 0],[1 1],mu,Sigma)

x1 = -5:.01:5;
x2 = -5:.01:5;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));

[C,h] = contour(x1,x2,y,[0.0001 0.001 0.01 0.05 0.15 0.25 0.35]);
w = h.LineWidth;
h.LineWidth = 2;
xlabel('x')
ylabel('y')
axis square