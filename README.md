--변수--
--------------


gameUI

gameUI[1] = 포장마차 이미지

gameUI[2] = 체력바

gameUI[3] = 정신력바

gameUI[4] = 원형시계(?)

gameUI[5] = 레시피북

gameUI[6] = 달력

gameUI[7] = 설정

gameUI[8] = 전환화살표

----------------
customer

customer[0] = 손님 이미지

customer[1] = 손님1

customer[2] = 손님2

customer[3] = 손님3

----------------------------
menu(menu.name을 메뉴 이름으로 설정)

menu[1] = 꼬마김밥

menu[2] = 일반김밥

---------------------------

finish1, finish2, finish3

완성된 김밥을 담는 변수(cook에서 넘겨받아야함)

Menu와 동일

-----------------------
Bubble

Bubble[1] = 첫번째 위치 말풍선

Bubble[2] = 두번째 위치 말풍선

Bubble[3] = 세번째 위치 말풍선


===================================================
--함수--
------------
hpDown() : 체력 감소함수

hpDownNum = 줄어들 길이

hpXDownNum = x축에서 이동할 거리 (hpDownNum / 2)

-----------------------------

mentalityDown() 과 mentalityUP() : 정신력 증가/감소함수

mentalityDownNum = 정신력 줄어들 길이

mentalitXyDownNum = x축에서 이동할 거리(mentalityDown / 2)

------------------------
customerOrder() : 랜덤 손님이 랜덤 메뉴 주문하는 함수

customer_num = ‘손님’ 선택하는 랜덤 변수

customer_order = 손님이 ‘주문’ 선택하는 랜덤변수

---------------------------
moneySum() : 매출 계산 함수

price[i] = menu[i]의 가격을 지정 [같은 인덱스 == 같은 메뉴]

sales = 하루 총 매출

-----------------------------
touch( event ) : 드래그하고 메뉴 위치에 가져가면 투명해지게하는 함수

