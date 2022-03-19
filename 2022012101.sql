     2022-0121-01)
     사용예) 모든 (외부조인)부서별 인원수를 조회하시오
     ALIAS는 부서코드, 부서명, 인원수
     SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'미배정') AS 부서코드, 
           NVL(B.DEPARTMENT_NAME,'프래랜서') AS 부서명, 
            COUNT(EMPLOYEE_ID) AS 인원수
   --  COUNT(*) AS 인원수 --(*를 쓰면 NULL이 들어가도 행은 행이니까 인원수 1로도 쳐진다)
     FROM HR.EMPLOYEES A     --양쪽이 동시에 갖고 있는 컬럼을 인쇄할 경우 많은 쪽걸 써야한다
     FULL OUTER JOIN HR.DEPARTMENTS B ON( A.DEPARTMENT_ID = B.DEPARTMENT_ID) --디파트먼트의 부서코드가 더 많으니까 B테이블의 부서코드를 써야해
     GROUP BY B.DEPARTMENT_ID,B.DEPARTMENT_NAME
     ORDER BY B.DEPARTMENT_ID;
     
     
     (EMPLOYEES  테이블에 사용된 부서)
     SELECT DISTINCT DEPARTMENT_ID 
     FROM HR.EMPLOYEES
     ORDER BY 1;
     
     사용예)2005년 **모든**상품별** 매입/매출수량을 집계하시오
     ALIAS는 상품코드 , 상품명, 매입수량, 매출수량 --정확한 결과를 내보내려면 반드시 서브쿼리를 써야한다 (일반외부조인이나 안시조인으로도 해결이 안된다)
     (2005년 모든 상품별 매입수량 집계)
     SELECT B.PROD_ID AS 상품코드, 
     B.PROD_NAME AS 상품명,
     SUM(A.BUY_QTY) AS 매입수량
     FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON( A.BUY_PROD = B.PROD_ID AND A.BUY_DATE BETWEEN  TO_DATE('20020101') AND TO_DATE('20051230'))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
     
     (2005년 모든 상품별 매출수량 집계)
     SELECT B.PROD_ID AS 상품코드, 
     B.PROD_NAME AS 상품명,
     SUM(A.CART_QTY) AS 매출수량
     FROM CART A
     RIGHT OUTER JOIN PROD B ON( A.CART_PROD = B.PROD_ID AND A.CART_NO LIKE '2005%')
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
     
     
     (한 문장으로 구성)
      SELECT B.PROD_ID AS 상품코드, 
     B.PROD_NAME AS 상품명,
     SUM(A.BUY_QTY) AS 매입수량,
     SUM(C.CART_QTY) AS 매출수량
     FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON( A.BUY_PROD = B.PROD_ID AND A.BUY_DATE BETWEEN  TO_DATE('20020101') AND TO_DATE('20051230'))
     LEFT OUTER JOIN  CART C ON( C.CART_PROD = B.PROD_ID AND C.CART_NO LIKE '2005%')
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;  --왜 안맞을까? 동시에 두개가 걸려있기때문에 이럴때에는 어쩔 수 없이 서브쿼리를 써야해
     
     (SUBQUERY 사용)
     SELECT A.PROD_ID AS 상품코드, 
            A.PROD_NAME AS 상품명,
            NVL(BSUM,0)  AS 매입수량,
            NVL(CSUM,0) AS 매출수량
      FROM PROD A,
            (SELECT BUY_PROD AS BID, 
            SUM(BUY_QTY)AS BSUM
            FROM BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20050101')AND TO_DATE('20051231')
            GROUP BY BUY_PROD) B, 
            (SELECT CART_PROD AS CID, 
            SUM(CART_QTY) AS CSUM
            FROM CART
            WHERE CART_NO LIKE '2005%'
            GROUP BY CART_PROD) C
    WHERE A.PROD_ID = B.BID(+)   --아우터 조인이 되어진다  A 테이블 기준으로 B,C테이블 늘림
    AND A.PROD_ID = C.CID(+)
    ORDER BY 1;
    
    
    
    
    
     
     
     