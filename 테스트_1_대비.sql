----- [ 테이블 생성 ]

CREATE TABLE PRODUCT_TBL (
    PROD_NO NUMBER NOT NULL,
    PROD_NAME VARCHAR2(10 BYTE),
    PROD_PRICE NUMBER,
    PROD_STOCK NUMBER,
    CONSTRAINT PK_PROD PRIMARY KEY(PROD_NO)
);

CREATE TABLE ORDER_TBL (
    ORDER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(10 BYTE),
    PROD_NO NUMBER,
    ORDER_DATE DATE,
    CONSTRAINT PK_ORDER PRIMARY KEY(ORDER_NO),
    CONSTRAINT FK_ORDER_PROD FOREIGN KEY(PROD_NO) REFERENCES PRODUCT_TBL(PROD_NO) ON DELETE SET NULL
);

----- 테이블의 구조를 확인하는 쿼리문 (설명 : DESCRIBE)
DESCRIBE ALL_CONSTRAINTS;
  SELECT *
    FROM ALL_CONSTRAINTS
   WHERE CONSTRAINT_NAME LIKE 'PK%';  PK로 시작하는 문자열

-- CUSTOMER_TBL 테이블에 GRADE 칼럼을 추가하시오.
-- GRADE 칼럼은 'VIP', 'GOLD', 'SILVER', 'BRONZE' 중 하나의 값만 가질 수 있도록 CHECK 제약조건을 지정하시오.
ALTER TABLE CUSTOMER_TBL
    ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE IN('VIP', 'GOLD', 'SILVER', 'BRONZE'));



----- [ 데이터 수정 ]

-- 부서번호(DEPT_NO)가 1인 부서의 지역(LOCATION)을 '경기'로 수정하시오.
UPDATE DEPARTMENT_TBL
   SET LOCATION = '경기'  -- 수정할 내용(여기서 등호는 대입 연산자이다.)
 WHERE DEPT_NO = 1;       -- 조건문(여기서 등호는 비교 연산자이다.)
COMMIT;

-- 부서번호(DEPART)가 1인 부서에 근무하는 사원들의 급여(SALARY)를 500000원 증가시키시오.
UPDATE EMPLOYEE_TBL
   SET SALARY = SALARY + 500000
 WHERE DEPART = 1;
COMMIT;

-- 지역(LOCATION)이 '서울'인 부서를 삭제하시오. ('서울'에서 근무하는 사원의 부서번호(DEPART)가 ON DELETE SET NULL 외래키 옵션에 의해서 NULL로 처리된다.)
DELETE FROM DEPARTMENT_TBL
WHERE LOCATION = '서울';
COMMIT;



----- [ 데이터 조회 ]

-- EMPLOYEES 테이블의 사원들을 DEPARTMENT_ID순으로 조회하고, 동일한 DEPARTMENT_ID를 가진 사원들은 높은 SALARY순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID ASC, SALARY DESC;
 
 -- EMPLOYEES 테이블에서 PHONE_NUMBER가 '515'로 시작하는 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515%';  -- PHONE_NUMBER NOT LIKE '515%'
 
 -- EMPLOYEES 테이블에서 SALARY가 10000 ~ 20000 사이인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 10000 AND 20000;

-- EMPLOYEES 테이블에서 DEPARTMENT_ID가 30, 40, 50인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN(30, 40, 50);
 
 -- EMPLOYEES 테이블에서 2000/01/01 ~ 2005/12/31 사이에 입사한 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE
  FROM EMPLOYEES
 WHERE TO_DATE(HIRE_DATE, 'YY/MM/DD') BETWEEN TO_DATE('00/01/01', 'YY/MM/DD') AND TO_DATE('05/12/31', 'YY/MM/DD');
 
 -- 원하는 형식으로 현재 날짜와 시간 확인하기
SELECT
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
     , TO_CHAR(SYSDATE, 'AM HH:MI:SS')
  FROM
       DUAL;
    
-- 날짜 지정해서 조회
SELECT
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
     , TO_CHAR(SYSDATE, 'YYYY')
  FROM
        DUAL;
        
-- 테이블에 포함된 데이터(행, ROW)의 개수는 COUNT(*)로 구한다.

-- 평균(응시 결과가 없으면 0으로 처리하기)
SELECT
       AVG(NVL(KOR, 0))
  FROM
       SAMPLE_TBL;
       
-- N개월 전후 날짜 구하기
SELECT
       ADD_MONTHS(SYSDATE, 1)  -- 1개월 후 날짜
     , ADD_MONTHS(SYSDATE, -1) -- 1개월 전 날짜
     , ADD_MONTHS(SYSDATE, 12) -- 1년 후 날짜
  FROM
       DUAL;

-- 경과한 개월 수 구하기
SELECT
       MONTHS_BETWEEN(SYSDATE, TO_DATE('22/10/07', 'YY/MM/DD'))
  FROM
       DUAL;


-- 문자열 연결 함수/연산자
--    1) 함수   : CONCAT(A, B)  주의! 인수가 2개만 전달 가능
--    2) 연산자 : ||

-- 문자열 일부 반환하기
--    SUBSTR(칼럼, BEGIN, LENGTH) : BEGIN부터 LENGTH개를 반환
--    주의! BEGIN은 1에서 시작한다.


-- 분기 처리하기
-- 1) DECODE(표현식
--       , 값1, 결과1
--       , 값2, 결과2
--       , ...)
--    표현식=값1이면 결과1을 반환, 표현식=값2이면 결과2를 반환, ...
--    표현식과 값의 동등 비교(=)만 가능하다.
SELECT
       EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , DEPARTMENT_ID
     , DECODE(DEPARTMENT_ID
          , 10, 'Administration'
          , 20, 'Marketing'
          , 30, 'Purchasing'
          , 40, 'Human Resources'
          , 50, 'Shipping'
          , 60, 'IT') AS DEPARTMENT_NAME
  FROM
       EMPLOYEES
 WHERE
       DEPARTMENT_ID IN(10, 20, 30, 40, 50, 60);

-- --------------
SELECT
       EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , SALARY
     , CASE
            WHEN SALARY >= 15000 THEN 'A'
            WHEN SALARY >= 10000 THEN 'B'
            WHEN SALARY >= 5000  THEN 'C'
            ELSE 'D'
       END AS GRADE
  FROM
       EMPLOYEES;


-------- [ GROUP BY ]
/*
    GROUP BY절
    1. GROUP BY절에서 지정한 칼럼의 데이터는 동일한 데이터끼리 하나로 모여서 조회된다.
    2. SELECT절에서 조회하려는 칼럼은 "반드시" GROUP BY절에 있어야 한다.(필수 규칙)
*/

-- GROUP BY절을 지정하면 같은 그룹끼리 집계함수가 적용된다.
SELECT
       DEPARTMENT_ID
     , COUNT(*) AS 부서별사원수
     , SUM(SALARY) AS 부서별연봉합
     , AVG(SALARY) AS 부서별연봉평균
     , MAX(SALARY) AS 부서별연봉킹
     , MIN(SALARY) AS 부서별연봉꽝
  FROM
       EMPLOYEES
 GROUP BY
       DEPARTMENT_ID;
       
       
-- DEPARTMENT_ID가 NULL인 부서를 제외하고, 모든 부서의 부서별 사원 수를 조회하시오.
--    해설) DEPARTMENT_ID가 NULL 부서의 제외는 GROUP BY 이전에 처리할 수 있으므로 WHERE절로 처리한다.
SELECT
       DEPARTMENT_ID
     , COUNT(*) AS 부서별사원수
  FROM
       EMPLOYEES
 WHERE
       DEPARTMENT_ID IS NOT NULL
 GROUP BY
       DEPARTMENT_ID;


-- 부서별 인원 수가 5명 이하인 부서를 조회하시오.
--    해설) 부서별 인원 수는 GROUP BY 이후에 확인할 수 있으므로 HAVING절에서 조건을 처리한다.
--     -> 그룹바이가 해빙보다 먼저!
SELECT
       DEPARTMENT_ID
     , COUNT(*) AS 부서별사원수
  FROM
       EMPLOYEES
 GROUP BY
       DEPARTMENT_ID
HAVING
       COUNT(*) <= 5;
       


-- EMPLOYEES 테이블에서 DEPARTMENT_ID가 80인 사원들을 높은 SALARY순으로 조회하시오.
-- SALARY는 9,000처럼 천 단위 구분기호를 표기해서 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID
     , TO_CHAR(SALARY, '99,999') AS SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80
 ORDER BY SALARY DESC;




-- EMPLOYEES 테이블에서 PHONE_NUMBER에 따른 지역(REGION)을 조회하시오.
-- PHONE_NUMBER가 011로 시작하면 'MOBILE', 515로 시작하면 'EAST', 590으로 시작하면 'WEST', 603으로 시작하면 'SOUTH', 650으로 시작하면 'NORTH'로 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE
     , JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
     , DECODE(SUBSTR(PHONE_NUMBER, 1, 3)
     , '011', 'MOBILE'
     , '515', 'EAST'
     , '590', 'WEST'
     , '603', 'SOUTH'
     , '650', 'NORTH') AS REGION
FROM EMPLOYEES;


-- EMPLOYEES 테이블에서 근무 개월 수가 240개월 이상이면 '퇴직금정산대상', 아니면 빈 문자열('')을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT
     , MANAGER_ID, DEPARTMENT_ID
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 근무개월수
     , CASE
         WHEN MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240 THEN '정산대상'
         ELSE '해당 NO'
       END AS 퇴직금정산대상유무
  FROM EMPLOYEES;
  
  
  
  
-- '영업부'의 가장 높은 급여보다 더 높은 급여를 받는 사원을 조회하시오.
SELECT 사원정보
  FROM 사원
 WHERE 급여 > ('영업부'의 최대 급여);

SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_TBL
 WHERE SALARY; > (SELECT MAX(SALARY)
                   FROM EMPLOYEE_TBL
                  WHERE DEPART); IN (SELECT DEPT_NO
                                     FROM DEPARTMENT_TBL
                                    WHERE DEPT_NAME = '영업부'));



-- 참고. 서브쿼리를 조인으로 풀기
SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_TBL
 WHERE SALARY > (SELECT MAX(E.SALARY)
                   FROM DEPARTMENT_TBL D INNER JOIN EMPLOYEE_TBL E
                     ON D.DEPT_NO = E.DEPART
                  WHERE D.DEPT_NAME = '영업부');
  
  












