function [c,ceq] = min_radius(x)
c(1) = sqrt(x(1)^2 + (-x(2)-365/2)^2 + (x(3)-500)^2) - 550;
ceq = [];
end