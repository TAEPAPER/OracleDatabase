2022-0124-01)
    사용예) 2005년-일반조건 **모든-OUTER JOIN** **거래처별GROUP BY;** 매입금액합계를 조회하시오  
    ALIAS는 거래처 코드, 거래처명, 매입금액합계
    
    (일반적 외부조인을 이용하면--결국은 내부조인처리 된다)
    SELECT A.BUYER_ID AS 거래처코드, 
             A.BUYER_NAME AS 거래처명, 
            SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계
    FROM BUYER A, BUYPROD B , PROD C  --서로 공통적인것을 가지고있지않으니까 별도의 중개자가 필요하다  //거래처에 관련되서 가장 정화한 테이블은 BUYER 테이블이다
    --종류로는 BUYER테이블이 더 많다
    WHERE  B.BUY_PROD(+) = C.PROD_ID
           AND  A.BUYER_ID = C.PROD_BUYER(+)
       --    AND B.BUY_DATE BETWEEN TO_DATE ('20050101')  AND TO_DATE('20051231')
    GROUP BY A.BUYER_ID , A.BUYER_NAME
    ORDER BY 1;                         --**이렇게 하면 정확한 자료가 나오지 않아!
    
    **그래서 ANSI조인을 써보자
    (ANSI)
     SELECT A.BUYER_ID AS 거래처코드, 
             A.BUYER_NAME AS 거래처명, 
            SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계
    FROM BUYER A
    LEFT OUTER JOIN PROD C ON( A.BUYER_ID = C.PROD_BUYER)
    LEFT OUTER JOIN BUYPROD B ON (B.BUY_PROD = C.PROD_ID AND B.BUY_DATE BETWEEN TO_DATE ('20050101')  AND TO_DATE('20051231')) --AND이후 조건은-BUYPROD에만 적용되는 조건
    GROUP BY A.BUYER_ID , A.BUYER_NAME
    ORDER BY 1;
    
    
    
    --(서브쿼리를 이용 외부조인 해보자)--
     SELECT A.BUYER_ID AS 거래처코드, 
             A.BUYER_NAME AS 거래처명, 
            SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계
    FROM BUYER A , (2005년도 거래처별 매입 금액계산) B
    
     (SUBQUERY : 2005년도 거래처별 매입 금액계산)
     SELECT A.BUYER_ID AS BID,
      SUM(B.BUY_QTY * C.PROD_COST) AS BSUM
      FROM BUYER A, PROD C , BUYPROD B
      WHERE C.PROD_ID = B.BUY_PROD 
      AND A.BUYER_ID = C.PROD_BUYER
      AND EXTRACT(YEAR FROM B.BUY_DATE) = 2005
      GROUP BY A.BUYER_ID ,A.BUYER_NAME;
      
      (결합) 
    SELECT D.BUYER_ID AS 거래처코드, 
           D.BUYER_NAME AS 거래처명, 
           NVL(E.BSUM,0) AS 매입금액합계
    FROM BUYER D ,(SELECT A.BUYER_ID AS BID,
                   SUM(B.BUY_QTY * C.PROD_COST) AS BSUM
                    FROM BUYER A, PROD C , BUYPROD B
                    WHERE C.PROD_ID = B.BUY_PROD 
                          AND A.BUYER_ID = C.PROD_BUYER
                          AND EXTRACT(YEAR FROM B.BUY_DATE) = 2005
                   GROUP BY A.BUYER_ID )E             
      WHERE D.BUYER_ID = E.BID(+)
      ORDER BY 1;
    
    사용예) 회원테이블에서 **직업이 자영업인 회원들의 마일리지**서브쿼리 보다 더 많은 마일리지를 보유하고 있는 회원정보를 조회하시오.
    ALIAS는 회원번호, 회원명, 직업, 마일리지
    (메인쿼리)
    회원번호, 회원명, 직업, 마일리지
    SELECT MEM_ID AS 회원번호, MEM_ NAME AS 회원명, MEM_JOB AS 직업, MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_MILEAGE > (직업이 주부인 회원들의 마일리지)
    ORDER BY 1;
    
    
    (서브쿼리)-(직업이 주부인 회원들의 마일리지)
    
    SELECT MEM_MILEAGE 
    FROM MEMBER
    WHERE MEM_JOB = '자영업'
    
    (결합)
     SELECT MEM_ID AS 회원번호,
             MEM_NAME AS 회원명,
            MEM_JOB AS 직업,
            MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_MILEAGE > ALL(SELECT MEM_MILEAGE 
                        FROM MEMBER                  --서브 결과로 하나 이상이 나왔는데 MEM_MILEAGE는 하나니까 비교불가
                        WHERE MEM_JOB = '자영업')    
    ORDER BY 1;
    
    
    
    
    
    
