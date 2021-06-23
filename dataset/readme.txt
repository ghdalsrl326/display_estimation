작성자: 홍민기
작성일: 2021.06.23

[display_estimation\dataset]
user_test_case1_gs: 가능한 정확하게
user_test_case2_gs: 가능한 빠르게
user_test_case3_gs: 가능한 정확하고 빠르게

[display_estimation\dataset\user_test_case1_gs]
1~10: 피험자 번호
ref_coord: 로봇팔에서 추출한 레퍼런스 디스플레이 위치 -> 1~5행: 1번 피험자 레퍼런스, 6~10행: 2번 피험자 레퍼런스 ... 
user_test_case1_gs_result: 100개 클릭 데이터로 추정한 결과
user_test_case1_gs_add_result: grid 범위 넓힌 후(m1 = 8; m2 = 8; m3 = 7; m4 = 8 -> 12;)
user_test_case1_gs_40_add_result: grid 범위 넓히고, 40개 클릭 데이터로 추정한 결과

[display_estimation\dataset\user_test_case1_gs\1~10]
data_robot_1~5.csv: 프로세싱으로 기록한 피험자 로그

data_robot_1~5_cand.csv: 모든 그리드 포인트에 대해 계산한 추정 결과 및 오차. 사용한 데이터 개수 및 그리드 세팅은 파일명 끝부분을 따름
data_robot_1~5_cand_add.csv: 모든 그리드 포인트에 대해 계산한 추정 결과 및 오차
data_robot_1~5_cand_40_add.csv: 모든 그리드 포인트에 대해 계산한 추정 결과 및 오차

data_robot_1~5_result.csv: cand 파일에서 최대 가능도 케이스. 사용한 데이터 개수 및 그리드 세팅은 파일명 끝부분을 따름
data_robot_1~5_result_add.csv: cand 파일에서 최대 가능도 케이스. 사용한 데이터 개수 및 그리드 세팅은 파일명 끝부분을 따름
data_robot_1~5_result_40_add.csv: cand 파일에서 최대 가능도 케이스. 사용한 데이터 개수 및 그리드 세팅은 파일명 끝부분을 따름

data_robot_1~5_trials.txt: 위치 추정에 사용할 클릭 trial 개수 조정해가며 추정한 결과 및 오차. 사용한 데이터 개수 및 그리드 세팅은 파일명 끝부분을 따름
data_robot_1~5_trials_add.txt: 위치 추정에 사용할 클릭 trial 개수 조정해가며 추정한 결과 및 오차. 사용한 데이터 개수 및 그리드 세팅은 파일명 끝부분을 따름
data_robot_1~5_trials_40_add.txt: 40개 trial 데이터로 추정한 결과 및 오차.

