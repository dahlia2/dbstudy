/*
    DML = 데이터를 삽입INSERT, 업데이트UPDATE, 삭제DELETE  
    1. Data Manipulation Language
    2. 데이터 조작어
    3. 데이터(행, ROW)를 삽입, 수정, 삭제할 때 사용하는 언어이다.
    4. DML 사용 후에는 COMMIT(저장) 또는 ROLLBACK(취소) 처리를 해야 한다. 즉 일부 저장하진 못 한다.
         -> 작업하거나 취소하는 것을 TRANSTION
    5. 종류
        1) 삽입 : INSERT INTO VALUES
        2) 수정 : UPDATE SET WHERE
        3) 삭제 : DELETE FROM WHERE
 */       

-- 참고) 자격증에서는 DML을 INSERT, UPDATE, DELETE 그리고 SELECT도 포함해서 보는 경우도 있다.
                          -- >> SELECT은 조회니까 저장과 취소할 필요가 없기 때문


CREATE TABLE DEPARTMENT_TBL (
    DEPT_NO      NUMBER,
    DEPT_NAME    VARCHAR2(15 BYTE)  NOT NULL,
    LOCATION     VARCHAR2(15 BYTE)  NOT NULL
);

CREATE TABLE EMPLOYEE_TBL (
    EMP_NO      NUMBER,
    NAME        VARCHAR(20 BYTE)    NOT NULL,
    DEPART      NUMBER              NULL,
    POSITION    VARCHAR2(20 BYTE)   NULL,
    GENDER      CHAR(2 BYTE)        NULL,
    HIRE_DATE   DATE                NULL,
    SALARY      NUMBER              NULL,
    CONSTRAINT PK_EMP PRIMARY KEY(EMP_NO)
    CONSTRAINT FK_EMP FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_TBL (DEPTNO)
);

-- 기본키
ALTER TABLE DEPARTMENT_TBL
    ADD CONSTRAINT PK_DEPT PRIMARY KEY(DEPT_NO);
ALTER TABLE EMPLOYEE_TBL
    ADD CONSTRAINT PK_EMP PRIMARY KEY(EMP_NO);

-- 외래키
ALTER TABLE EMPLOYEE_TBL
    ADD CONSTRAINT FK_EMP_DEPT FOREIGN KEY(DEPART) 
        REFERENCES DEPARTMENT_TBL(DEPT_NO)
            ON DELETE SET NULL;

-- 시퀀스(번호 생성기) 삭제하기
DROP SEQUENCE DEPARTMENT_SEQ;

-- 시퀀스(번호 생성기) 만들기  -- PK값을 만들 때 사용
CREATE SEQUENCE DEPARTMENT_SEQ -- (다음 번호)   -- 임의로 아무거나 지정.NEXTVAL
        INCREMENT BY 1 -- 1씩 증가하는 번호를 만든다. (생략 가능)
        START WITH 1   -- 1부터 번호를 만든다. (생략 가능)
        NOMAXVALUE     -- 번호의 상한선이 없다. (생략 가능)  MAXVALUE 100 : 번호를 100까지 생성하겠다.
        NOMINVALUE     -- 번호의 하한선이 없다. (생략 가능)  MINVALUE 100 : 번호의 최소값이 100이다.
        NOCYCLE        -- 번호 순환이 없다. (생략 가능)      CYCLE : 번호가 MAXVALUE에 도달하면 다음 번호는 MINVALUE이다.
        -- ★ N0CACHE 중요!
        NOCACHE        -- 메모리 캐시를 사용하지 않는다.     CACHE : 메모리 캐시를 사용한다. (미리 번호 뽑았을 때.. 저장할 공간?)
        ORDER          -- 번호 건너뛰기가 없다.              NOORDER : 번호 건너뛰기가 가능하다.
;

-- 시퀀스에서 번호 뽑는 함수 : NEXTVAL (넥스트밸류, 다음 번호)
-- SELECT DEPARTMENT_SEQ.NEXTVAL FROM DUAL; -- 테이블에 없는 데이터를 조회하려면 DAUL 테이블을 사용한다.

-- 데이터 입력하기(Parent Key를 먼저 입력해야 한다.)
-- >> 딱히 칼럼을 지정하지 않고 칼럼 순서대로 입력되기 때문에 순서 맞춰서 입력할 것! 

-- INSERT INTO DEPARTMENT_TBL VALUES(1, '영업부', '대구');
-- INSERT INTO DEPARTMENT_TBL(DEPT_NAME, LOCATION) VALUES('총무부', '대구');  -- 기본키 생략은 권장하지 않음!

-- 수업 시간에 사용할 방식
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL, '영업부', '대구');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL, '인사부', '서울');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL, '총무부', '대구');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL, '기획부', '서울');
COMMIT;


-- 시퀀스 삭제하기
DROP SEQUENCE EMPLOYEE_SEQ;

-- 시퀀스 만들기
CREATE SEQUENCE EMPLOYEE_SEQ
    START WITH 1001
    NOCACHE;

-- 데이터 입력하기
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90/09/01', 5500000);
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93/04/01', 5000000);
COMMIT;

-- 데이터 수정하기
-- 1. 부서번호(DEPT_NO)가 1인 부서인 지역(LOCATION)을 '경기'로 수정하시오.
UPDATE DEPARTMENT_TBL
   SET LOCATION = '경기' -- 수정할 내용(여기서 등호는 대입 연산자) 자바처럼 경기를 LOCATION으로 보내시오
 WHERE DEPT_NO = 1;      -- 조건문 (여기서 등호는 비교 연산자이다.) 확연하게 구분되어 있지 않으므로 절에 따라 다르게 쓰인 다는 것을 암기해야 함.
COMMIT;

-- 2. 부서번호(DEPART)가 1인 부서에 근무하는 사원들의 급여(SALARY)을 500000원 증가시키시오.
UPDATE EMPLOYEE_TBL
   SET SALARY = SALARY + 500000
 WHERE DEPT_NO = 1;
COMMIT;

-- 데이터 삭제하기
-- 1. 지역(LOCATION)이 '대구'인 부서를 삭제하시오.
DELETE FROM DEPARTMENT_TBL WHERE LOCATION = '대구';
COMMIT;

-- 2. 지역(LOCATION)이 '서울'인 부서를 삭제하시오. ('서울'에서 근무하는 사원 부서번호(DEPART)가 ON DELETE SET NULL 외래키 옵션에 의해서 NULL로 처리된다.)
DELETE FROM DEPARTMENT_TBL WHERE LOCATION = '서울';
COMMIT;



