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
        
/*
    외래키 제약 조건의 옵션
    1. ON DELETE CASCADE
        1) 참조 중인 PARENT KEY가 삭제되면 해당 PARENT KEY를 가진 행 전체를(참조하고 있는 행을) 함께 삭제한다.
        2) 예시) '회원 탈퇴 시 작성한 모든 게시글이 함께 삭제됩니다.'
                  게시글 삭제 시 해당 게시글에 달린 모든 댓글이 함께 삭제됩니다.
                    ㄴ [게시글테이블] [댓글테이블] 일대다관계로 하나의 게시글에 여러 댓글이 있음
    
    2. ON DELETE SET NULL
        1) 참조 중인 PARENT KEY가 삭제되면 해당 PARENT KEY를 가진 칼럼 값만 NULL로 처리한다.
        2) 예시) 어떤 상품을 제거하였으나(판매 중지) 해당 상품의 주문 내역은 남아 있는 경우
        문제가 되는 데이터 하나만 지우면 되니까 사용하면 편리함.
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
    CONSTRAINT PK_PROD PRIMARY KEY(PROD_NO) SET NULL -- ** [제약조건] / PROD를 기본키로 할게 / [기본키 지정](부모테이블의 PROD_NO 칼럼)
);
    
-- 주문 테이블(자식 테이블)
CREATE TABLE ORDER_TBL (  -- ** ORDER 테이블 생성 (자식의 개념)
    ORDER_NO NUMBER NOT NULL,  -- ** 칼럼명과 데이터타입(최대 38자리 숫자인 형태로 할 거고, NULL은 있을 수가 없어)
    USER_ID  VARCHAR2(10 BYTE), -- ** 칼럼명과 데이터타입(가변 길이 문자 타입으로 할게)
    PROD_NO  NUMBER,
    ORDER_DATE DATE,
    CONSTRAINT PK_ORDER PRIMARY KEY(ORDER_NO),
    -- ** [제약조건] 기본키_자식테이블 [기본키](ORDER_NO 칼럼)
    CONSTRAINT FK_ORDER_PROD FOREIGN KEY(PROD_NO) REFERENCES PRODUCT_TBL(PROD_NO) ON DELETE CASCADE
    -- ** [제약조건] 참조키_자식테이블_부모테이블의 '전체필드' [참조키](부모테이블의_PRODNO) [참조할게]부모테이블(부모테이블_PROCNO필드)
);