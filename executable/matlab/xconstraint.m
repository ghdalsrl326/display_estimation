function tf = xconstraint(X, sphere_center, A, b)

x = [X.xvar, X.yvar, X.zvar, X.wvar, X.svar];

n = size(x,1);
tf = false(n,1);
for i = 1:n
    tf(i,1) = (norm([-615/2-sphere_center(1), -365/2-sphere_center(2), 0-sphere_center(3)]) < norm([X.xvar(i)-sphere_center(1), X.yvar(i)-sphere_center(2), X.zvar(i)-sphere_center(3)]));  % 최소 거리 제약조건(추정이 과도하게 사용자와 가깝게 되지 않도록)
    tf(i,1) = all(A*[X.xvar(i); X.yvar(i); X.zvar(i); X.wvar(i); X.svar(i)] < b) & tf(i,1); %Fov 제약조건
end

end