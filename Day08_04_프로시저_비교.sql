-- BUY_PROC 프로시저 정의
CREATE OR REPLACE PROCEDURE BUY_PROC
(
    /* 고객번호 */  CNO IN CUST_TBL.C_NO%TYPE, 
    /* 제품코드 */  PCODE IN PROD_TBL.P_CODE%TYPE,
    /* 구매수량 */  BUY_AMOUNT IN BUY_TBL.B_AMOUNT%TYPE
)
IS
BEGIN

    -- 1) 구매내역 테이블에 구매 내역을 추가(INSERT)한다.
    INSERT INTO BUY_TBL(B_NO, C_NO, P_CODE, B_AMOUNT) VALUES(BUY_SEQ.NEXTVAL, CNO, PCODE, BUY_AMOUNT);
    
    -- 2) 제품 테이블의 재고 내역을 수정(UPDATE)한다.
    UPDATE PROD_TBL SET P_STOCK = P_STOCK - BUY_AMOUNT WHERE P_CODE = PCODE;
    
    -- 3) 고객 테이블의 포인트를 수정(UPDATE)한다.
    --    총 구매액의 10%를 정수로 올림처리해서 포인트로 준다.
    UPDATE CUST_TBL SET C_POINT = C_POINT + CEIL((SELECT P_PRICE FROM PROD_TBL WHERE P_CODE = PCODE) * BUY_AMOUNT * 0.1) WHERE C_NO = CNO;
    
    -- 4) 커밋
    COMMIT;
    
EXCEPTION

    WHEN OTHERS THEN  -- 모든 예외를 처리
    
        -- 예외 사유 확인
        DBMS_OUTPUT.PUT_LINE(SQLCODE || '(' || SQLERRM || ')');
        
        -- 롤백
        ROLLBACK;
    
END;


-- BUY_PROC 프로시저 호출

EXECUTE BUY_PROC(1, 1000, 10);  -- 고객번호 1, 제품코드 1000, 구매수량 10

BEGIN
    BUY_PROC(2, 1001, 5);  -- 고객번호 2, 제품코드 1001, 구매수량 5
END;