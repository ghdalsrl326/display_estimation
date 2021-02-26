function [N, R0] = tangent_plane(sphere_center,r,phi_input,theta_input)

syms phi theta real;
% From spherical coordinates to Cartesian
X = r*sin(phi)*cos(theta) + sphere_center(1); % cam coordinates
Y = r*sin(phi)*sin(theta) + sphere_center(2); % cam coordinates
Z = r*cos(phi) + sphere_center(3); % cam coordinates

R = [X,Y,Z];
Rphi = diff(R,phi);         % partial derivative with respect to phi
Rtheta = diff(R,theta);     % partial derivative with respect to theta

% Now plug in phi=phi_input, theta=theta_input:
R0 = double(subs(R,{phi,theta},{phi_input,theta_input}));            % point on surface
Rphi0 = double(subs(Rphi,{phi,theta},{phi_input,theta_input}));      % first tangent vector
Rtheta0 = double(subs(Rtheta,{phi,theta},{phi_input,theta_input}));  % second tangent vector
N = double(cross(Rphi0,Rtheta0));                        % normal vector is cross product of tangent vectors

ezsurfpar(X,Y,Z,0,2*pi,0,pi,theta,phi); hold on % plot surface for theta in [0,2*pi], phi in [0,pi]
alpha 0.2;
plane(R0,N,615/2,365/2);                                     % plot tangent plane
hold off; view(70,20);