-- 문자열 함수



-- 1. 대소문자 변환 함수
SELECT
    UPPER(EMAIL) -- 대문자
    ,LOWER(EMAIL) -- 소문자
    ,INITCAP(EMAIL) -- 첫 글자는 대문자, 나머지는 소문자
 FROM
   EMPLOYEES; -- 잠을 깨야해 현주야 일어나 wake up 밤샘 금지 !
   
-- 2. 글자 수 반환 함수
-- 글자 수(바이트 수) 반환 함수
SELECT
     , (('HELLO')
    , LENGTH('안녕')
    , LENGTHB('HELLO') -- 바이트 수 : 5
    
-- 3. 문자열 연결 함수/ 연산자
-- 1) 함수 : CONCAT(A,B) 주의! 인수가 2개만 전달 가능하다. (CONCAT(A, B, C) 같은 형태는 불가능하다.)
-- 2) 연산자 : || 주의! OR 연산 아닙니다! 오라클 전용입니다!
둘다할수있다면 .. 디비에서 설계
SELECT
    CONCAT(CONCAT(FIRST_NAME, ' ') LAST_NAME)
    , FIRST_NAME || '' || LAST_NAME
