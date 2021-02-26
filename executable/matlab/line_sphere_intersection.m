function [p1,p2] = line_sphere_intersection(origin, direction, sphere_center)

% http://www.ambrsoft.com/TrigoCalc/Sphere/SpherLineIntersection_.htm
x1 = origin(1); y1 = origin(2); z1 = origin(3); % cam coordinate system
x2 = direction(1); y2 = direction(2); z2 = direction(3);
xc = sphere_center(1); yc = sphere_center(2); zc = sphere_center(3);

a = (x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2;
b = -2*((x2-x1)*(xc-x1) + (y2-y1)*(yc-y1) + (zc-z1)*(z2-z1));
c = (xc-x1)^2 + (yc-y1)^2 + (zc-z1)^2 - 600^2;

discriminant = (b^2) - 4*a*c;

if discriminant > 0
    t1 = (-b + sqrt(discriminant))/(2*a);
    t2 = (-b - sqrt(discriminant))/(2*a);
    xt1 = x1 + (x2-x1)*t1; yt1 = y1 + (y2-y1)*t1; zt1 = z1 + (z2-z1)*t1;
    xt2 = x1 + (x2-x1)*t2; yt2 = y1 + (y2-y1)*t2; zt2 = z1 + (z2-z1)*t2;
    
    p1 = [xt1, yt1, zt1]; %intersection point 1
    p2 = [xt2, yt2, zt2]; %intersection point 2
else
    disp("check input again");
end