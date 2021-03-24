clear; clc; close all;
syms phi theta real
Pi = pi;

r = 1;
X = r*sin(phi)*cos(theta);  % From spherical coordinates to Cartesian
Y = r*sin(phi)*sin(theta);
Z = r*cos(phi);

R = [X,Y,Z];
Rphi = diff(R,phi);         % partial derivative with respect to phi
Rtheta = diff(R,theta);     % partial derivative with respect to theta

% Now plug in phi=pi/4, theta=pi/4:
R0 = double(subs(R,{phi,theta},{Pi/4,Pi/4}))            % point on surface
Rphi0 = double(subs(Rphi,{phi,theta},{Pi/4,Pi/4}))      % first tangent vector
Rtheta0 = double(subs(Rtheta,{phi,theta},{Pi/4,Pi/4}))  % second tangent vector
N = double(cross(Rphi0,Rtheta0))                        % normal vector is cross product of tangent vectors

ezsurfpar(X,Y,Z,0,2*Pi,0,Pi,theta,phi); hold on % plot surface for theta in [0,2*pi], phi in [0,Pi]
alpha 0.2;
plane(R0,N)                                     % plot tangent plane
hold off; view(70,20)