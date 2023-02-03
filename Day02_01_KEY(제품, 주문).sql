/*
    KEY 제약조건
    1. 기본키(PK : Primary Key)
        1) 개체무결성
        2) PK는 NOT NULL + UNIQUE 해야 한다.
    2. 외래키(FK : Foreign Key)
        1) 참조무결성
        2) FK는 참조하는 값만 가질 수 있다.
*/

/*
    일대다(1:M) 관계
    1. PK와 FK를 가진 테이블 간의 관계이다.
        1) 부모 테이블 : 1, PK를 가진 테이블
        2) 자식 테이블 : M, FK를 가진 테이블
    2. 생성과 삭제 규칙
        1) 생성 규칙 : "반드시" 부모 테이블을 먼저 생성한다.
        2) 삭제 규칙 : "반드시" 자식 테이블을 먼저 삭제한다.
*/
-- **표시는 다시 개념 잡기 위한 주석!

-- 테이블 삭제 ( ** 삭제하고 다시 만드는 개념이라 생각하면 됨!
DROP TABLE ORDER_TBL;
DROP TABLE PRODUCT_TBL;

-- 제품 테이블 (부모 테이블)
CREATE TABLE PRODUCT_TBL (    -- ** PRODUCT 테이블을 생성 (부모의 개념)
    PROD_NO NUMBER NOT NULL,     -- ** 칼럼명과 데이터타입(10바이트)
    PROD_NAME VARCHAR2(10 BYTE), 
    PROD_PRICE NUMBER,
    PROD_STOCK NUMBER,
    CONSTRAINT PK_PROD PRIMARY KEY(PROD_NO) -- ** [제약조건] / PROD를 기본키로 할게 / [기본키 지정](부모테이블의 PROD_NO 칼럼)
);
    
-- 주문 테이블(자식 테이블)
CREATE TABLE ORDER_TBL (  -- ** ORDER 테이블 생성 (자식의 개념)
    ORDER_NO NUMBER NOT NULL,  -- ** 칼럼명과 데이터타입(최대 38자리 숫자인 형태로 할 거고, NULL은 있을 수가 없어)
    USER_ID  VARCHAR2(10 BYTE), -- ** 칼럼명과 데이터타입(가변 길이 문자 타입으로 할게)
    PROD_NO  NUMBER,
    ORDER_DATE DATE,
    CONSTRAINT PK_ORDER PRIMARY KEY(ORDER_NO),
    -- ** [제약조건] 기본키_자식테이블 [기본키](ORDER_NO 칼럼)
    CONSTRAINT FK_ORDER_PROD FOREIGN KEY(PROD_NO) REFERENCES PRODUCT_TBL(PROD_NO)
    -- ** [제약조건] 참조키_자식테이블_부모테이블의 '전체필드' [참조키](부모테이블의_PRODNO) [참조할게]부모테이블(부모테이블_PROCNO필드)
);

/*
    제약조건 테이블
    1. SYS, SYSTEM 관리 
    2. 종류
        1) ALL_CONSTRAINTS
        2) USER_CONSTRAINTS
        3) DBA_CONSTRAINT
*/

-- 테이블의 구조를 확인하는 쿼리문 (설명)
-- BDESCRIBE ALL_CONSTRAINTS;
-- SELECT * FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'PK%';































