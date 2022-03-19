SELECT * FROM MEMBER WHERE SUBSTR(MEM_REGNO2,1,1) = '2';
SELECT MEM_ADD1||' '||MEM_ADD2 AS 주소,
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS 나이 
FROM MEMBER
WHERE SUBSTR(MEM_REGNO2,1,1) = '2';

SELECT EMPLOYEE_ID AS 사원번호,FIRST_NAME||' '||LAST_NAME AS 사원이름 ,
        SALARY AS 기본급 , NVL(SALARY*COMMISSION_PCT,0) AS 보너스 , SALARY+SALARY*COMMISSION_PCT AS 지급액
FROM EMPLOYEES;

SELECT MEM_ID , MEM_NAME,MEM_MILEAGE,MEM_JOB
FROM MEMBER
WHERE MEM_MILEAGE >= 3000
ORDER BY MEM_MILEAGE DESC;

SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,MEM_JOB,
       CASE WHEN SUBSTR(MEM_BIR,1,1) = '1' THEN '남성회원'
       ELSE '여성회원' END AS 성별
 FROM MEMBER
 WHERE MEM_MILEAGE >=3000 AND MEM_ADD1 LIKE '대전%';

SELECT EMPLOYEE_ID,FIRST_NAME||' '||LAST_NAME AS 이름,DEPARTMENT_ID,SALARY
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (20,50,90,110);

SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
FROM MEMBER
WHERE MEM_MILEAGE >= ANY(SELECT MEM_MILEAGE FROM MEMBER WHERE MEM_JOB ='공무원');

SELECT PROD_ID, PROD_NAME, PROD_LGU,PROD_PRICE
FROM PROD
WHERE PROD_PRICE BETWEEN 100000 AND 200000;


사용예)장바구니테이블(CART)에서 2005년 7월에 판매된 제품을 조회하시오         
ALIAS는 날짜,상품코드,판매수량이다.

SELECT SUBSTR(CART_NO,1,8) AS 날짜, CART_PROD, CART_QTY
FROM CART
WHERE  CART_NO LIKE '200507%';

사용예)매입테이블(BUYPROD)에서 2005년 2월에 매입된 제품을 조회하시오         
ALIAS는 날짜,상품코드,매입수량,매입금액이다.
SELECT BUY_DATE , BUY_PROD, BUY_QTY, BUY_QTY*BUY_COST AS 매입금액
FROM  BUYPROD
WHERE BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201');

사용예) HR 계정의 사원테이블(EMPLOYEES)에서 2006년 이전 에 입사한 사원정보를 조회하시오
단, 출력은 입사일 순으로 출력할 것!
**사원이름을 합쳐 새로운 칼럼에 저장

ALTER TABLE HR.EMPLOYEES ADD (EMP_NAME VARCHAR2(50));
UPDATE HR.EMPLOYEES
    SET EMP_NAME = FIRST_NAME||' '||LAST_NAME;
COMMIT; 

ALIAS는 사원번호, 사원명, 입사일,부서코드
SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE , DEPARTMENT_ID
FROM HR.EMPLOYEES
WHERE EXTRACT(YEAR FROM HIRE_DATE) < 2007
ORDER BY 3;

사용예)회원테이블(MEMBER)에서 '김'씨~'박'씨 성을 가진 회원 중 마일리지가 2000이상인 회원을 조회하시오
 ALIAS는 회원번호,회원명,주소,마일리지 단,성씨순으로 출력하시오

SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2 AS 주소, MEM_MILEAGE 
FROM MEMBER
WHERE MEM_MILEAGE >=2000
      AND SUBSTR(MEM_NAME,1,1) BETWEEN '김' AND '박'
ORDER BY MEM_NAME;

사용예)장바구니테이블(CART)에서 2005년 7월에 판매된 제품을 조회하시오        (LIKE 연산자를 쓰세요) 
ALIAS는 날짜,상품코드,판매수량이다. 
SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜 , CART_PROD , CART_QTY
FROM CART
WHERE CART_NO LIKE '200507%';

회원테이블에서 거주지가 '충남'인 회원을 조회하시오
ALIAS는 회원번호, 회원명, 주소,직업,마일리지
SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2 AS 주소, MEM_JOB,
        MEM_MILEAGE
FROM MEMBER
--WHERE MEM_ADD1||' '||MEM_ADD2 LIKE '충남%' OR
   --     MEM_ADD1||' '||MEM_ADD2 LIKE '서울%';
WHERE SUBSTR(MEM_ADD1,1,2) IN ('충남','서울');

사용예)2005년 4월 매입상품별 판매정보를 조회하시오
 ALIAS는 상품코드,상품명,수량합계,금액합계 

SELECT A.BUY_PROD, B.PROD_NAME, SUM(A.BUY_QTY) AS 수량합계, SUM(A.BUY_QTY*BUY_COST) AS 금액합계
FROM BUYPROD A, PROD B
WHERE 
        A.BUY_PROD = B.PROD_ID
       AND  BUY_DATE BETWEEN '20050401' AND LAST_DAY('20050401')
GROUP BY A.BUY_PROD, B.PROD_NAME
ORDER BY 1;

상품테이블에서 분류코드가 'p102'에 속한 상품을 조회하시오
ALIAS는 상품코드,상품명,매입가격,매출가격
SELECT PROD_ID, PROD_NAME, PROD_COST, PROD_COST
FROM PROD
WHERE LOWER(PROD_ID) LIKE 'p102%';

사용예) 사원테이블의 FIRST_NAME과 LAST_NAME을 결합하되 중간에 공백을 삽입하고 
단어 첫글자를 대문자로 변환하여 출력하시오.
SELECT  
CONCAT(CONCAT(INITCAB(FIST_NAME),' '),INITCAB(LAST_NAME)) AS 결합
FROM HR.EMPLOYEES;

--[2022-01-11-01]
상품 테이블에서 상품명을 출력하되 왼쪽 남는 공간에 '*'를 채워 출력하시오
SELECT RPAD(PROD_NAME,40,'*')
FROM PROD;

회원테이블에서 20대이하의 회원정보를 조회하시오
ALIAS는 회원번호, 회원명,성별,나이,마일리지
성별에는 '여성회원' ,'남성회원' 중 하나 출력
나이는 주민번호를 이용하여 구하시오

SELECT MEM_ID, MEM_NAME, 
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' THEN '남성회원' 
       ELSE '여성회원'
       END AS 성별,
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,
       MEM_MILEAGE
FROM MEMBER
WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)  <30;

--[2022-01-11-02]

  회원테이블에서 각 회원들의 마일리지를 입력받아 마일리지를 1000~9000사이를 9개 구간으로 구분할 때 
               그 값이 어느구간에 속하는지 판별하시오

  ALIAS는 회원번호,회원명,마일리지,구간값
  SELECT MEM_ID, MEM_NAME, MEM_MILEAGE, WIDTH_BUCKET(MEM_MILEAGE, 1000,9000,9) AS 구간값
  FROM MEMBER;
  
  사용예) 회원테이블에서 각 회원들의 마일리지를 입력받아 마일리지를 1000~9000사이를 9개 구간으로 구분할 때 
               그 값이 어느구간에 속하는지 판별하여 등급을 나타내시오. 단, 가장 많은 마일리지 가지고 있는 회원이 1등급임    
               ALIAS는 회원번호,회원명,마일리지,등급
 SELECT MEM_ID AS 회원번호,
                     MEM_NAME AS  회원명,
                     MEM_MILEAGE AS 마일리지,
                  -- 10- WIDTH_BUCKET(MEM_MILEAGE,1000,9000,9) AS 구간값    이 방법 이거나 밑에 방법
                  WIDTH_BUCKET(MEM_MILEAGE,9000,1000,9) AS 구간값  
              FROM MEMBER;
     사용예)사원테이블에서 사원들의 급여가 
                2000-5000사이에 속하면 '저임금 사원'
                5001-10000사이에 속하면 '평균임금 사원'
                10001-20000  사이에 속하면 '고임금 사원'
                을 비고난에 출력
                alias는 사원번호,사원명,부서코드,급여         
      
      SELECT EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY,
        CASE WHEN SALARY BETWEEN 2000 AND 5000 THEN '저임금사원'
             WHEN SALARY BETWEEN 5001 AND 10000 THEN '평균사원'
             WHEN SALARY BETWEEN 10001 AND 20000 THEN '고임금사원'
             END AS 급여구간
      FROM HR.EMPLOYEES;
      
--[2022-01-12-01]
매입테이블(BUYPROD)에서 2005년 2월 일자별 매입집계를 조회하시오
ALIAS는 일자, 수량합계 매입금액합계
SELECT BUY_DATE, 
        SUM(BUY_QTY) AS 수량합계 , 
        SUM(BUY_COST*BUY_QTY) AS 매입금액합계
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
GROUP BY BUY_DATE;
 
 사용예) 회원테이블에서 연령을 구하고 각 년령대별 회원수를 조회하시오
    ALIAS는 연령대, 회원수
    SELECT  
    SUBSTR(TO_CHAR(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)),1,1)||'0대' AS 연령대,
    COUNT(SUBSTR(TO_CHAR(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)),1,1)) AS 회원수
    FROM MEMBER
    GROUP BY  SUBSTR(TO_CHAR(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)),1,1)||'0대'
    ORDER BY 1;
     
     --[2022-01-13-01]
      사용예) 장바구니테이블에서 2005년 5월 판매정보를 조회하시오                                                          --로그인 되어진 순번                      
    ALIAS는 일자, 상품명, 수량 , 금액 이며 일자순으로 출력하시오
    
    SELECT CAST(SUBSTR(A.CART_NO,1,8) AS DATE) AS 일자 ,
            B.PROD_NAME , A.CART_QTY AS 수량 , A.CART_QTY*B.PROD_PRICE AS 금액
    FROM CART A ,PROD B 
    WHERE   A.CART_PROD = B.PROD_ID             --조인조건을 꼭해줘야해!!
            AND A.CART_NO LIKE '200505%';

 사용예) 오늘이 2005년 7월 31일이고 쇼핑몰 페이지에 처음 로그인한 경우  장바구니번호를 생성하시오
   SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
                 TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000')) --무효의 0을 추가시키기 위해'00000'! 
            FROM CART
           WHERE SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE,'YYYYMMDD');
           
     사용예)상품테이블(GOODS)에 다음자료를 추가로 등록하시오
    상품코드 
    
     상품명 : 삼성 노트북 15인치 
     거래처 코드 : P101
     판매가격 : 1200000원
     
      (상품코드 생성)
     SELECT 'P101'||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS CODE
     FROM GOODS
     WHERE PROD_LGU = 'P101';
    
    (추가등록)
    INSERT INTO GOODS
     SELECT A.P_CODE, '애플맥북프로13인치레티나','P101',460000 
     FROM( 
     SELECT 'P101'||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS P_CODE
     FROM GOODS
     WHERE PROD_LGU = 'P101'
     )A;
     
     SELECT * FROM GOODS;
        
    SELECT MEM_ID, MEM_NAME,
            CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                 SUBSTR(MEM_REGNO2,1,1) ='2' THEN
                 TO_CHAR(TO_DATE('19'||MEM_REGNO1),'YYYY"년" MM"월" DD"일"')
            ELSE 
                 TO_CHAR(TO_DATE('20'||MEM_REGNO1),'YYYY"년" MM"월" DD"일"')
            END AS 생년월일,
            MEM_JOB,MEM_MILEAGE
    FROM MEMBER;
    
               

