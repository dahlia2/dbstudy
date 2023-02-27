SELECT C.CUSTOMER_NAME AS 고객명
     , B.BOOK_NAME AS 책이름
     , O.ORDER_DATE AS 주문일자
  FROM CUSTOMER_TBL C INNER JOIN ORDER_TBL O
    ON C.CUSTOMER_ID = O.CUSTOMER_ID INNER JOIN BOOK_TBL B
    ON B.BOOK_ID = O.BOOK_ID
 WHERE O.ORDER_DATE = (SELECT MAX(ORDER_DATE)
                         FROM ORDER_TBL);
                         
                         
-- [ 셋 테이블의 이너조인 ]
-- [ 해당 기간 제외 ] : NOT BETWEEN TO_DATE('날짜', '바꿀 형식') AND TO_DATE('날짜, '바꿀 형식')
SELECT O.ORDER_ID AS 구매번호 
     , C.CUSTOMER_NAME AS 구매자
     , B.BOOK_NAME AS 책이름
     , B.PRICE * O.AMOUNT AS 판매가격
     , O.ORDER_DATE AS 주문일자
  FROM CUSTOMER_TBL C, ORDER_TBL O, BOOK_TBL B
 WHERE C.CUSTOMER_ID = O.CUSTOMER_ID
   AND O.BOOK_ID = B.BOOK_ID
   AND TO_DATE(O.ORDER_DATE, 'YY/MM/DD') -- 주문날짜 조회
       NOT BETWEEN TO_DATE('20/07/04', 'YY/MM/DD')
               AND TO_DATE('20/07/07', 'YY/MM/DD');
               
            
-- [ 셋 테이블의 아웃조인 ]
-- ['책'을 '구매' <<안 한>> '고객' 조회 ] 필요 -> '고객' 레프트 아웃 '주문'(둘을 이어줘야 함) 레프트 아웃 '책' 
-- 예시 필요한 책이름이 기준이니까 .. BOOK TABLE 부터 적어내보기 
 -- 책과 연결돼있지만 해당 책이 없는 주문들.. 책 LEFT OUTER JOIN 주문 ...

-- Q. 모든 서적 중에서 가장 비싼 서적을 구매한 고객의 이름과 구매내역(책이름, 가격)을 조회하시오.
-- 가장 비싼 서적을 구매한 고객이 없다면 고객 이름은 NULL로 처리하시오
    -- 고객명  책이름       책가격
    -- NULL    골프 바이블  35000

-- 기본 문법
SELECT C.CUSTOMER_NAME AS 고객명
     , B.BOOK_NAME AS 책이름
     , B.PRICE AS 책가격
  FROM BOOK_TBL B LEFT OUTER JOIN ORDER_TBL O
    ON B.BOOK_ID = O.BOOK_ID LEFT OUTER JOIN CUSTOMER_TBL C
    ON C.CUSTOMER_ID = O.CUSTOMER_ID
 WHERE B.PRICE = (SELECT MAX(PRICE)
                    FROM BOOK_TBL);        
            
-- 오라클 문법           
SELECT C.CUSTOMER_NAME AS 고객명
     , B.BOOK_NAME AS 책이름
     , B.PRICE AS 책가격
 FROM BOOK_TBL B, ORDER_TBL O, CUSTOMER_TBL C
WHERE B.BOOK_ID = O.BOOK_ID(+)
  AND O.CUSTOMER_ID = C.CUSTOMER_ID(+)
  AND B.PRICE = (SELECT MAX(PRICE)
                   FROM BOOK_TBL);
                   
            



