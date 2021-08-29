function [a, b, c, d] = plane_3p(p1, p2, p3)
% This function returns a plane coeff from three points. 
% normal: it contains a,b,c coeff , normal = [a b c]
% d : coeff 
% If the eq of plane is assumed to be: ax + by + cz = d;
normal = cross(p1 - p2, p1 - p3);
a = normal(1); b = normal(2); c = normal(3);

d = p1(1)*normal(1) + p1(2)*normal(2) + p1(3)*normal(3);
d = -d;

% x = -1000:10:1000; y = -1000:10:1000;
% [X,Y] = meshgrid(x,y);
% Z = (-d - (normal(1)*X) - (normal(2)*Y))/normal(3);
% mesh(X,Y,Z)
% alpha 0.5