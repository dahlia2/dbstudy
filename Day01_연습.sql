DROP USER GDJ61 CASCADE;
CREATE USER GDJ61 IDENTIFIED BY 1111;
GRANT DBA TO GDJ61;

DROP TABLE PRACTICE;
CREATE TABLE PRACTICE(
  CODE          VARCHAR2(2 BYTE)    NOT NULL UNIQUE,
  MODEL         VARCHAR2(10 BYTE),
  CATEGORY      VARCHAR2(5 BYTE),   CHECK(CATEGORY IN ('MAIN','SUB'),
  PRICE         NUMBER,             CHECK(PRICE >= 0),
  CHECK         (AMOUNT BETWEEN 0 AND 100),
  MANUFACTURED  DATE
  );
  
  SELECT ENAME
  