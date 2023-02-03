-- 테이블 삭제 (생성의 역순으로 삭제할 것)
DROP TABLE ENROLL_TBL;   -- ** 두 테이블의 중간(매개역할)인 수강신청 테이블
DROP TABLE SUBJECT_TBL;  -- ** 과목 테이블
DROP TABLE STUDENT_TBL;  -- ** 학생 테이블

-- 학생 테이블 생성
CREATE TABLE STUDENT_TBL (
    STU_NO      VARCHAR2(5 BYTE)     NOT NULL,    -- ** 숫자 5자리 넣어야 하니까 5바이트
    STU_NAME    VARCHAR2(15 BYTE)    NULL,        -- ** 한글 세글자 (한 글자당 5바이트) 5X3 = 15바이트
    STU_AGE     NUMBER(3)           NULL,         -- ** 정수 숫자가 최대 3자리까지
    CONSTRAINT  PK_STUDENT  PRIMARY KEY(STU_NO)   -- ** [제약조건]  스튜던트테이블을! 기본키는(스튜던트N0)
    );
    
-- 과목 테이블 생성
CREATE TABLE SUBJECT_TBL (
    SJT_CODE     VARCHAR2(1 BYTE)       NOT NULL,
    SJT_NAME     VARCHAR2(10 BYTE)      NULL,
    PROFESSOR    VARCHAR2(15 )      NULL,
    CONSTRAINT   PK_SUBJECT PRIMARY KEY(SJT_CODE)
    );
    
-- 수강신청 테이블 생성
CREATE TABLE ENROLL_TBL (
    ENR_NO      NUMBER                 NOT NULL,     -- ** NOT NULL은 굳이 안 써도 됨
    STU_NO      VARCHAR2(5 BYTE)       NOT NULL,
    SJT_CODE    VARCHAR2(1 BYTE)       NOT NULL,
    
    CONSTRAINT  PK_ENROLL         PRIMARY KEY(ENR_NO),
    -- ** [제약조건- 기본] 기본키_수강신청테이블명   [기본키] ENR_NO
    
    CONSTRAINT  FK_ENROLL_STUDENT FOREIGN KEY(STU_NO) REFERENCES STUDENT_TBL(STU_NO),
    -- ** [제약조건] 참조키_수강신청_학생(학번)  [참조키] 학생테이블  [리퍼런스] 학생테이블(학번)
    CONSTRAINT  FK_ENROLL_SUBJECT FOREIGN KEY(SJT_CODE) REFERENCES SUBJECT_TBL(SJT_CODE)
    -- ** [제약조건] 참조키_수강신청_과목(과목코드)  [참조키] 과목테이블  [리퍼런스] 과목테이블(과목코드)
    
    );