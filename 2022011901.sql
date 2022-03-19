    2022-01-19)
    
    문제) 사원테이블 등을 이용하여 **미국내에 위치한** 부서별 사원수와 평균이믐을 조회하시오.
          alias는 부서번호, 부서명, 사원수, 평균임금이다.
          SELECT A.DEPARTMENT_ID AS 부서번호, 
                    B.DEPARTMENT_NAME AS 부서명, 
                    COUNT(*) AS 사원수, -- 그룹 묶은 거의 행의 수
                ROUND(AVG(A.SALARY)) AS  평균임금
           FROM HR.EMPLOYEES A , HR.DEPARTMENTS B, HR.LOCATIONS C,
                HR.COUNTRIES D
            WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_ID
                   AND B.LOCATION_ID = C.LOCATION_ID
                   AND C.COUNTRY_ID = D.COUNTRY_ID
                   AND LOWER(D.COUNTRY_NAME) LIKE '%america%'
            GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME 
            ORDER BY 1;
            
    문제) 2005 4-6월 매입현황조회
    ALIAS는 상품코드, 상품명, 매입수량합계, 매입금액합계
    
    문제) 2005 4-6월 매출현황조회
    ALIAS는 상품코드, 상품명, 매출수량합계, 매출금액합계
    
    문제) 2005 4-6월 매입/매출현황조회
    ALIAS는 상품코드, 상품명, 매입금액합계, 매출금액합계
      SELECT A.PROD_ID AS 상품코드, 
      A.PROD_NAME AS 상품명, 
      SUM(C.BUY_QTY*A.PROD_COST) AS 매입금액합계,
      SUM(A.PROD_PRICE*B.CART_QTY) AS 매출금액합계
      FROM PROD A, CART B, BUYPROD C
      WHERE A.PROD_ID = B.CART_PROD
            AND C.BUY_PROD = A.PROD_ID
            AND SUBSTR(B.CART_NO,1,6 )  BETWEEN   '200504'    AND '200506'
            AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE( '20050630') --이 두 조건을 둘 다 만족해야하기 때문에 조인이 잘못되었다고 판단.
                                                                                --카티션 프로덕트 실행  (논리적 모순 발생)    
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1;
        
        ( ANSI 형식)
      SELECT A.PROD_ID AS 상품코드, 
             A.PROD_NAME AS 상품명, 
             SUM(C.BUY_QTY*A.PROD_COST) AS 매입금액합계,
             SUM(A.PROD_PRICE*B.CART_QTY) AS 매출금액합계
      FROM PROD A
      INNER JOIN  CART B ON(A.PROD_ID = B.CART_PROD AND SUBSTR(B.CART_NO,1,6 )  BETWEEN   '200504'    AND '200506')
      INNER JOIN BUYPROD C ON( C.BUY_PROD = A.PROD_ID AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE( '20050630'))
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;  
      --둘다 해결이 안된다
      
      (서브 쿼리로 구한 형식)
      74개의 행이 나온다 --둘다 따로 따로 구하기 때문에 서로 개입될 여지가 없다
      //온라인 프로젝트
      
     문제)장바구니테이블(CART)에서 2005년 매출자료를 분석하여 거래처별. 상품별 매출현황을 조회하시오
        ALIAS는 거래처 코드, 거래처명,상품명,매출수량,매출금액
        SELECT  A.BUYER_ID AS 거래처코드, 
                A.BUYER_NAME AS 거래처명,
                C.PROD_NAME AS 상품명,
                SUM(B.CART_QTY) AS 매출수량,
                SUM(B.CART_QTY * C.PROD_PRICE) AS 매출금액
        FROM BUYER A, CART B , PROD C
        WHERE  A.BUYER_ID = C.PROD_BUYER
               AND C.PROD_ID =B.CART_PROD --조인조건 기술
               AND SUBSTR(B.CART_NO, 1, 4) = '2005'
                --  B.CART_NO LIKE '2005%' 써도 된다!
      GROUP BY A.BUYER_ID , A.BUYER_NAME ,C.PROD_NAME 
      ORDER BY 1;
      
       (ANSI 형식)
       SELECT A.BUYER_ID AS 거래처코드, 
                A.BUYER_NAME AS 거래처명,
                C.PROD_NAME AS 상품명,
                SUM(B.CART_QTY) AS 매출수량,
                SUM(B.CART_QTY * C.PROD_PRICE) AS 매출금액
        FROM BUYER A
        INNER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER)
        INNER JOIN CART B ON(C.PROD_ID =B.CART_PROD AND SUBSTR(B.CART_NO, 1, 4) = '2005' )
        GROUP BY  A.BUYER_ID , A.BUYER_NAME ,C.PROD_NAME
        ORDER BY 1;
        
        
        
        
        
        
      
      
      
        
          
          
