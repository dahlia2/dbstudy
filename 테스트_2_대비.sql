-- 테스트-2 대비

-- 상품명을 입력하면(IN), 해당 상품의 카테고리가 출력되고(OUT) 파라미터 PROD_NAME에 저장되도록 작성
-- 없는 상품명이 전달되면 출력 파라미터 PRNAME에 'Noname'이 저장되도록 작성
CREATE OR REPLACE PROCEDURE CATEGORYY (PRNAME IN PRODUCTS.PROD_NAME%TYPE, PRCATE OUT PRODUCTS.PROD_CATEGORY%TYPE)
IS
BEGIN
    SELECT PROD_CATEGORY
    INTO PRCATE
    FROM PRODUCTS
    WHERE PROD_NAME = PRNAME;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    PRCATE := 'NoCate';
END;

DECLARE
    PRNAME PRODUCTS.PROD_NAME%TYPE;
BEGIN
    CATEGORYY('청바지', PRNAME);
    DBMS_OUTPUT.PUT_LINE(PRNAME);
END;

-- 수학 함수

-- 1. 제곱
--    POWER(A, B) : A의 B제곱
SELECT POWER(2, 3)  -- 2의 3제곱
  FROM DUAL;


-- 2. 절대값
--    ABS(A) : A의 절대값
SELECT ABS(-5)
  FROM DUAL;


-- 3. 나머지 값
--    MOD(A, B) : A를 B로 나눈 나머지 값
SELECT MOD(7, 3)
  FROM DUAL;




    