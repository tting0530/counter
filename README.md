gameUI
gameUI [1] = 포장 마차 이미지
gameUI [2] = 수준 바
gameUI [3] = 정신력 바
gameUI [4] = 원형 시계 (?)
gameUI [5] = 레시피 북
gameUI [6] = 달력
gameUI [7] = 설정
gameUI [8] = 전환 화살표

고객
customer [0] = 손님 이미지
customer [1] = 손님 1
customer [2] = 손님 2
customer [3] = 손님 3

메뉴 (menu.name을 메뉴 이름으로 설정)
menu [1] = 꼬마 김밥
menu [2] = 일반 김밥

finish1, finish2, finish3
완성 된 김밥을 담는 변수 (cook에서 넘겨 받아야 함)
메뉴와 동일

거품
Bubble [1] = 첫번째 위치 말풍선
Bubble [2] = 두번째 위치 말풍선
Bubble [3] = 세번째 위치 말풍선
================================================ =
hpDown () : 감소 함수
hpDownNum = 갓 길이
hpXDownNum = x 축에서 가장 거리 (hpDownNum / 2)

mentalityDown ()과 mentalityUP () : 정신력 증가 / 감소 함수
mentalityDownNum = 정신력 력 길이
mentalitXyDownNum = x 축에서 가장 거리 (mentalityDown / 2)

customerOrder () : 랜덤 손님이 랜덤 메뉴 주문하는 함수
customer_num = '손님'선택하는 랜덤 변수
customer_order = 손님이 '주문'선택하는 랜덤 구매

moneySum () : 매출 계산 함수
가격 [i] = 메뉴 [i]의 가격을 지정 [같은 등급 == 같은 메뉴]
매출 = 하루 총 매출

touch (event) : 드래그하고 메뉴 위치에 가져 가면 투명 해지게하는 함수
