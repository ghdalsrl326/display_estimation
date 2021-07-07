function [v_tran] = rodrigues_rotn_formula(v,O,K,coef,base_angle)

% Rodrigues' formula (Axis-angle rotation)
% Rotating a vector about an axis in 3D space
% Axis of rotation and the rotation vector have common origin
% Reference: https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula
% https://kr.mathworks.com/matlabcentral/fileexchange/73828-rodrigues-axis-angle-rotation?s_tid=srchtitle

%% Rotation about an arbitrary axis:
% v = vector to be rotated
% O = initial point of rotation axis
% K = distal point for rotation axis

ov = (v-O); % vector to be rotated
ok = (K-O); % ok is the rotation axis vector
k = ok/norm(ok); % k is the normalized rotation axis vector

theta = base_angle*coef - base_angle; % define the angle of rotation (right-handed CS)
v_rot = ov*cosd(theta)+cross(k,ov)*sind(theta)+k*(dot(k,ov))*(1-cosd(theta)); % rotated vector about an axis through global origin(0,0,0)
v_tran = [O(1)+v_rot(1),O(2)+v_rot(2),O(3)+v_rot(3)]; % transformed vector (translate rotated vector back to initial point)