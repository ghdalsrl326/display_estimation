function ezsurfpar(f1,f2,f3,a,b,g1,g2,U,V)
% ezsurfpar(f1,f2,f3,a,b,g1,g2)
% ezsurfpar(f1,f2,f3,a,b,g1,g2,u,v)
%
% plot surface parametrized by x=f1, y=f2, z=f3
%   a <= u <= b
%  g1 <= v <= g2
% where f1,f2,f3 are symbolic expression of u,v
% g1,g2 are symbolic expressions of u
% 
% Example: cylinder y^2+z^2=1 with -2 <= x <= z
%   syms u v
%   f1 = v
%   f2 = cos(u)
%   f3 = sin(u)
%   ezsurfpar(f1,f2,f3,0,2*pi,-2,sin(u),u,v)
%   nice3d

f1 = sym(f1); f2 = sym(f2); f3 = sym(f3);
g1 = sym(g1); g2 = sym(g2);
a = double(a); b = double(b);

if nargin==7
  s = findsym([f1,f2,f3],2);
  k = strfind(s,',');
  V = sym(s(1:k-1));
  U = sym(s(k+1:end));
end

syms UT VT
VV = (1-VT)*g1+VT*g2;
F1T = subs(subs(f1,V,VV),U,UT);
F2T = subs(subs(f2,V,VV),U,UT);
F3T = subs(subs(f3,V,VV),U,UT);
ezsurf(F1T+0*UT+0*VT,F2T+0*UT+0*VT,F3T+0*UT+0*VT,[a,b,0,1])
p = findobj(gca,'type','surface'); p = p(1);
set(p,'MeshStyle','column');
title('')
