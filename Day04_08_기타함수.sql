-- 기타 함수


-- 1. 순위 구하기 (높은 게 1순위일 수도, 낮은 게 1순위일 수도 있다는 점 참고 -> 즉 오름차순 내림차순 설정)
--    1) RANK() OVER(ORDER BY 순위구할칼럼 ASC)  : 오름차순
--    2) RANK() OVER(ORDER BY 순위구할칼럼 DESC) : 내림차순
--    3) 동점자는 같은 등수로 처리  -> 예) 3등이 2명이라면 그 다음은 5등
--    4) 순위 순으로 정렬된 상태로 조회
--   실사용) 인기 게시글, 후기 리뷰 많은 순 등등 .. 

SELECT 
    EMPLOYEE_ID
    , FIRST_NAME || ' ' || LAST_NAME AS NAME
    , SALARY
    , RANK() OVER(ORDER BY SALARY DESC) AS 연봉순위
 FROM
    EMPLOYEES;
    

-- 2. 분기 처리하기
-- 1) DECODE(표현식      // DECODE = IF 느낌으로 보면 됨.
--      , 값1, 결과1
--      , 값2, 결과2
--      , ...)
--  표현식=값1이면 결과1을 반환, 표현식=값2이면 결과2를 반환, ...
--  표현식과 값의 동등 비교(=)만 가능하다.
SELECT
      EMPLOYEE_ID
    , FIRST_NAME
    , LAST_NAME
    , DEPARTMENT_ID
    , DECODE(DEPARTMENT_ID
        , 10, 'Administraion'
        , 20, 'Marketing'
        , 30, 'Purchasing'
        , 40, 'Human Resources'
        , 50, 'Shipping'
        , 60, 'IT') AS DEPARTMENT_NAME
    FROM
        EMPLOYEES
   WHERE
        DEPARTMENT_ID IN(10, 20, 30, 40, 50, 60);
        
-- 2) 분기 표현식
-- CASE
-- WHEN 조건식1 THEN 결과값1
-- WHEN 조건식2 THEN 결과값2
-- ...
-- ELSE 결과값
-- END
SELECT
      EMPLOYEE_ID
    , FIRST_NAME
    , LAST_NAME
    , SALARY
    , CASE
        WHEN SALARY >= 15000 THEN 'A'
        WHEN SALARY >= 10000 THEN 'B'
        WHEN SALARY >= 5000 THEN 'C'
        ELSE 'D'
        END AS GRADE
    FROM
        EMPLOYEES;
    
    
-- 3. 행 번호 반환하기   // 동점자 처리 때문에 RANK 보다는 행 번호를 더 많이 사용함.
--    ROW_NUMBER() OVER(ORDER BY  칼럼  ASC|DESC)
--    정렬 결과에 행 번호를 추가해서 반환하는 함수    // 여러 행을 페이지로 묶어서 페이지마다 보여줄 때 사용
SELECT
    ROW_NUMBER() OVER(ORDER BY SALARY DESC)
      , EMPLOYEE_ID
      , FIRST_NAME
      , LAST_NAME
      , SALARY
FROM EMPLOYEES;


        