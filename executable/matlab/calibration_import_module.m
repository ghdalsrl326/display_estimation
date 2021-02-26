function [head_origin, head_direction, eye_origin, gaze_vector] = calibration_import_module(raw_data)

head_pose = [raw_data.pose_Tx, raw_data.pose_Ty, raw_data.pose_Tz]; % cam coordinate system
head_eul = [raw_data.pose_Rx, raw_data.pose_Ry, raw_data.pose_Rz]; % Left-handed positive

R = eul2rotm(head_eul,"XYZ"); % world coordinate system
% R = eul2rotm(head_eul,"ZYX"); % world coordinate system
T = head_pose'; % unit: mm
htrans = [R, T; 0, 0, 0, 1]; % head to cam coord

% cam 좌표계에서 line sphere intersection 계산
head_origin = (htrans)*[0,0,0,1]'; % H matrix * head 좌표계 기준 좌표 = cam 좌표계 기준 좌표
head_direction = (htrans)*[0,0,-1000,1]'; % cam coordinate

eyeR_lmk_X = (raw_data.eye_lmk_X_0 + raw_data.eye_lmk_X_1 + raw_data.eye_lmk_X_2 + raw_data.eye_lmk_X_3 + raw_data.eye_lmk_X_4 + raw_data.eye_lmk_X_5 + raw_data.eye_lmk_X_6 + raw_data.eye_lmk_X_7)/8;
eyeR_lmk_Y = (raw_data.eye_lmk_Y_0 + raw_data.eye_lmk_Y_1 + raw_data.eye_lmk_Y_2 + raw_data.eye_lmk_Y_3 + raw_data.eye_lmk_Y_4 + raw_data.eye_lmk_Y_5 + raw_data.eye_lmk_Y_6 + raw_data.eye_lmk_Y_7)/8;
eyeR_lmk_Z = (raw_data.eye_lmk_Z_0 + raw_data.eye_lmk_Z_1 + raw_data.eye_lmk_Z_2 + raw_data.eye_lmk_Z_3 + raw_data.eye_lmk_Z_4 + raw_data.eye_lmk_Z_5 + raw_data.eye_lmk_Z_6 + raw_data.eye_lmk_Z_7)/8;

eyeL_lmk_X = (raw_data.eye_lmk_X_28 + raw_data.eye_lmk_X_29 + raw_data.eye_lmk_X_30 + raw_data.eye_lmk_X_31 + raw_data.eye_lmk_X_32 + raw_data.eye_lmk_X_33 + raw_data.eye_lmk_X_34 + raw_data.eye_lmk_X_35)/8;
eyeL_lmk_Y = (raw_data.eye_lmk_Y_28 + raw_data.eye_lmk_Y_29 + raw_data.eye_lmk_Y_30 + raw_data.eye_lmk_Y_31 + raw_data.eye_lmk_Y_32 + raw_data.eye_lmk_Y_33 + raw_data.eye_lmk_Y_34 + raw_data.eye_lmk_Y_35)/8;
eyeL_lmk_Z = (raw_data.eye_lmk_X_28 + raw_data.eye_lmk_Z_29 + raw_data.eye_lmk_Z_30 + raw_data.eye_lmk_Z_31 + raw_data.eye_lmk_Z_32 + raw_data.eye_lmk_Z_33 + raw_data.eye_lmk_Z_34 + raw_data.eye_lmk_Z_35)/8;

eye_origin = [eyeR_lmk_X + eyeL_lmk_X, eyeR_lmk_Y + eyeL_lmk_Y, eyeR_lmk_Z + eyeL_lmk_Z]./2; % cam coord(pupil location)
% htrans_eye = [R, eye_origin'; 0, 0, 0, 1];
gaze_vector = [(raw_data.gaze_0_x + raw_data.gaze_1_x), (raw_data.gaze_0_y + raw_data.gaze_1_y), (raw_data.gaze_0_z + raw_data.gaze_1_z)]*inv(R).*(350); % cam coord

end