작성자: 홍민기
작성일: 2021.06.23

[display_estimation\executable\cpp]
프로세싱과 소켓 통신 코드를 추가한 OpenFace 입니다.
프로세싱 코드 실행 -> Visual Studio 2017로 OpenFace.sln 열기 -> Feature Extraction 실행하시면 실험할 수 있습니다.

[display_estimation\executable\matlab]
이 폴더의 모든 파일을 사용하진 않는데, 서로 참조하고 있는 것들이 있어서 혹시몰라 전체 파일을 첨부합니다.
메인으로 사용하는 파일에 대한 설명은 아래와 같습니다.

%위치 추정용 파일
grid_search_main: 메인 그리드 서치 파일입니다. 파일 경로 pc에 맞게 설정해주시고, 실행하시면 됩니다. 병렬 연산(parfor) 설정해두었기 때문에, 실행 환경에 따라 연산 속도 크게 차이 날 수 있습니다.
grid_search_mle: 로그 가능도 합을 계산하는 목적함수 파일입니다.

%실험 결과 분석 파일
fitts_law_individual: 피츠로 분석 파일
gs_accuracy_precision: trial 개수 증가함에 따라 정확도 정밀도 추이 분석하는 파일
gs_learning_curve_error_rate: 1회 클릭 소요 시간 변화 추이, 클릭 에러율 분석 파일

[display_estimation\executable\processing]
프로세싱 실험 코드