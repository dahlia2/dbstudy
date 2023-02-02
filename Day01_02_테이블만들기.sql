/*
    테이블
    1. 데이터베이스의 가장 대표적인 객체이다.
    2. 데이터를 보관하는 객체이다.
    3. 표 형식으로 데이터를 보관한다.
    4. 테이블 기본 용어
        1) 열: calumn, 속성(arttibute), 필드(field)
        2. 행: row,    개체(entity),    레코드(record)
*/

/*
    오라클의 데이터 타입
    1. CHAR(size)    : 고정 길이 문자 타입(size : 1 ~ 2000바이트)  -> 한 글자이던, 여러 글자이던 오라클은 char으로 통일.
    2. VARCHAR2(size) : 가변 길이 문자 타입(size : 1 ~ 4000바이트)
    3. DATE          : 날짜/시간 타입
    4. TIMESTAMP     : 날짜/시간 타입(좀 더 정밀)
    5. NUMBER(p,s)   : 정밀도(p), 스케일(s)로 표현하는 숫자 타입
        1) 정밀도 : 정수부와 소수부를 모두 포함하는 전체 유효 숫자가 몇 개인가?
        2) 스케일 : 소수부의 전체 유효 숫자가 몇 개인가?
        예시)
            (1) NUMBER      : 최대 38자리 숫자
            (2) NUMBER(3)   : 정수부가 최대 3자리인 숫자(0~999)
            (3) NUMBER(5,2) : 최대 전체 5자리, 소수부 2자리인 숫자(123.45)
            (4) NUMBER(2,2) : 1미만의 소수부 2자리 실수(0.15) - 정수부의 0은 유효 자리가 아님
*/

/*
    제약조건(Constraint) 5개 중 3개
    1. 널
        1) NULL 또는 생략
        2) NOT NULL
    2. 중복 데이터 방지
        UNIQUE
    3. 값의 제한
        CHECK
    
 */


-- 예시 테이블  -- 자바와 반대로 필드명 타입으로 구성
DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(  -- 보기 좋게 한 줄에 하나씩, 띄어쓰기로 맞추는 걸 권장
    CODE         VARCHAR2(2 BYTE)  NOT NULL UNIQUE,
    MODEL        VARCHAR2(10 BYTE),  -- NOT NULL이면 모델명 안 적어도 된다는 뜻
    CATEGORY     VARCHAR2(5 BYTE), CHECK(CATEGORY = 'MAIN' OR CATEGORY = 'SUB'),
    -- [대체문법 학습★] CHECK(CATEGORY IN('MAIN, 'SUB')) 카테고리가 메인가 서브 중 하나다
    PRICE        NUMBER,        CHECK(PRICE >= 0),
    AMOUNT       NUMBER(2),     CHECK(AMOUNT > 0 AND AMOUNT <= 100),
    -- [대체문법 학습*] CHECK(AMOUNT BETWEEN 0 AND 100)
    MANUFACTURED DATE
    );
                         

