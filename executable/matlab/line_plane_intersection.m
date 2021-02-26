function [p] = line_plane_intersection(origin, direction, plane_coef)

% line plane intersection reference:
% http://www.ambrsoft.com/TrigoCalc/Plan3D/PlaneLineIntersection_.htm
x1 = origin(1); y1 = origin(2); z1 = origin(3); % cam coordinate system
x2 = direction(1); y2 = direction(2); z2 = direction(3);
a = x2-x1; b = y2-y1; c = z2-z1;

t = -(plane_coef(1)*x1 +  plane_coef(2)*y1 + plane_coef(3)*z1 + plane_coef(4)) / (plane_coef(1)*a +  plane_coef(2)*b + plane_coef(3)*c);
xt = x1 + a*t;
yt = y1 + b*t;
zt = z1 + c*t;

p = [xt, yt, zt]; %intersection point

end