DROP TABLE DEPARTMENT_TBL;
DROP TABLE EMPLOYEE_TBL;
DROP TABLE PROJECT_TBL;
DROP TABLE PROCEEDING_TBL;

CREATE TABLE DEPARTMENT_TBL (
             DEPT_NO            VARCHAR2(15 CHAR)        NOT NULL, 
             DEPT_NAME          VARCHAR2(15 CHAR)        NOT NULL,
             DEPT_LOCATION      VARCHAR2(50 CHAR),       NULL
             CONSTRAINT         PK_DEPT PRIMARY KEY(DROP_NO)             
             );
    
CREATE TABLE EMPLOYEE_TBL (
             EMP_NO          NUMBER                 NOT NULL,
             DEPT_NO         VARCHAR2(15 CHAR),     NULL
             POSITION        CHAR(10CHAR),          NULL
             NAME            VARCHAR(15 CHAR),      NULL
             HIRE_DATE       DATE,                  NULL
             SALARY          NUMBER                 NULL
             );
             
CREATE TABLE PROJECT_TBL (
             프로젝트번호            NUMBER NOTNULL,
               프로젝트명         VARCHAR2(30 CHAR),
                 시작일자                     DATE,
                 종료일자                     DATE,
             PJT_NO        
             PJT_NAME      
             BEGIN_DATE   
             END_DATE      
             );
             
CREATE TABLE PROCEEDING_TBL (


               진행번호             NUMBER NOTNULL,
               사원번호                     NUMBER,
            프로젝트번호                    NUMBER,
        프로젝트진행상태                    NUMBER,
        );



             PCD_NO         NUMBER NOTNULL,
             EMP_NO       VARCHAR2(30 CHAR),
             PJT_NO     DATE
             PJT_STATE       DATE
             );

             