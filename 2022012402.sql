    2022-0124-02)집합연산자
    -복수개의 QUERY 결과를 연산하여 결과를 반환
    -JOIN 연산을 줄일 수 있음 
    -합집합(UNION, UNION ALL),교집합(INTERSECT),차집합(MINUS) 제공
    .UNION : 두 집합의 모든 원소를 중복하지 않게 반환(정렬)
    .UNION ALL : 중복을 허용한 두 집합의 모든 원소를 반환(정렬하지 않음)
    .INTERSECT : 두 집합의 공통된 원소 반환(정렬)
    .MINUS : 피감수집합에서 감수집합결과를 차감한 결과 반환
    (사용형식)
    QUERY1
    UNION|UNION ALL|INTERSECT|MINUS
    QUERY2
    UNION|UNION ALL|INTERSECT|MINUS
    QUERY3]
        :
    UNION|UNION ALL|INTERSECT|MINUS
    QUERY_n]
    -***모든 쿼리의 SELECT절의 컬럼의 수와 타입,순서가 동일해야함*** (컬럼명은 달라도 된다)
    -출력의 기본은 첫 번째 SELECT문임
    -ORDER BY절은 맨 마지막 QUERY만 사용 가능

    
    1.UNION
    -합집합의 결과 출력
    -중복을 배제
    
    사용예)사원테이블에서 2005년도에 입사한 사원과 부서가 시에틀인 사원을 조회화시오
    ALIAS는 사원번호, 사원명,입사일, 부서명
    (2005년도에 입사한 사원)
    SELECT A.EMPLOYEE_ID AS 사원번호, A.EMP_NAME AS 사원명,A.HIRE_DATE AS 입사일, B.DEPARTMENT_NAME AS 부서명
    FROM HR.EMPLOYEES A , HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND EXTRACT(YEAR FROM HIRE_DATE) = 2005 
     UNION
   --  (부서가 시애틀인 사원)
      SELECT A.EMPLOYEE_ID AS 사원번호, 
      A.EMP_NAME AS 사원명,
      A.HIRE_DATE AS 입사일, 
      B.DEPARTMENT_NAME AS 부서명
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
      AND B.LOCATION_ID = C.LOCATION_ID
      AND C.CITY = 'Seattle';
    
     사용예)2005년 4월에 매입된 상품과 매출된 상품을 중복되지 않게 모두 조회하시오
     ALIAS는 상품코드, 상품명, 거래처명
     
     (2005년 4월에 매입된 상품)
     SELECT A.BUY_PROD AS 상품코드, C.PROD_NAME AS 상품명, B.BUYER_NAME AS 거래처명
     FROM BUYPROD A, BUYER B , PROD C
     WHERE A.BUY_PROD = C.PROD_ID
            AND B.BUYER_ID = C.PROD_BUYER
            AND A.BUY_DATE BETWEEN TO_DATE ('20050401')   AND TO_DATE('20050430')
     UNION  
     --(4월에 매출된 상품)
     SELECT DISTINCT A.CART_PROD AS 상품코드, C.PROD_NAME AS 상품명, B.BUYER_NAME AS 거래처명
     FROM CART A, BUYER B , PROD C
     WHERE A.CART_PROD = C.PROD_ID
            AND B.BUYER_ID = C.PROD_BUYER
            AND A.CART_NO LIKE  '200504%'     
     ORDER BY 1;
     
     
     사용예)2005년 6월과 7월에 상품을 구입한 회원을 조회하시오
     ALIAS는 회원번호, 회원명, 주소, 마일리지
     (6월에 구입한 회원)
    SELECT DISTINCT B.CART_MEMBER AS 회원번호, A.MEM_NAME AS 회원명, A.MEM_ADD1||' '||MEM_ADD2 AS 주소, A.MEM_MILEAGE AS 마일리지
    FROM MEMBER A, CART B 
    WHERE A.MEM_ID = B.CART_MEMBER
            AND B.CART_NO LIKE '200506%' 
    UNION ALL
   -- (7월)
   SELECT DISTINCT B.CART_MEMBER AS 회원번호, A.MEM_NAME AS 회원명, A.MEM_ADD1||' '||MEM_ADD2 AS 주소, A.MEM_MILEAGE AS 마일리지
    FROM MEMBER A, CART B 
    WHERE A.MEM_ID = B.CART_MEMBER
            AND B.CART_NO LIKE '200507%' 
   ORDER BY 1;
 
     
     
    2.INTERSECT
    -두 SQL 결과의 교집합(공통된 영역)을 반환
    
    사용예)2005년도 금액기준 매입순위 상위5개 품목과 매출순위 상위5개 품목을 조회하여
          양쪽 모두를 만족하는 상품정보를 출력 --교집합을 반환
         ALIAS는 상품코드, 상품명, 분류명
         
        (2005년도 금액기준 매입순위 상위5개 품목과 매출순위 상위5개 품목)
        SELECT C.BID AS 상품코드,
        C.BNAME AS 상품명,
        C.BSUM AS 금액,
        C.BRANK AS 순위 
        FROM( SELECT A.BUY_PROD AS BID, B.PROD_NAME AS BNAME, 
                SUM(A.BUY_QTY*B.PROD_COST) AS BSUM,
                 RANK() OVER(ORDER BY SUM(A.BUY_QTY*B.PROD_COST)DESC) AS BRANK
                 FROM BUYPROD A , PROD B  
                WHERE A.BUY_PROD = B.PROD_ID 
                AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005 
                GROUP BY A.BUY_PROD, B.PROD_NAME) C
        WHERE C.BRANK<=5
        INTERSECT
      -- ( 2005년 금액기춘 매출순위 5개)
          SELECT D.CID AS 상품코드,
                D.CNAME AS 상품명,
                D.CSUM AS 금액,
                D.CRANK AS 순위 
        FROM( SELECT A.CART_PROD AS CID, B.PROD_NAME AS CNAME, 
                SUM(A.CART_QTY*B.PROD_COST) AS CSUM,
                 RANK() OVER(ORDER BY SUM(A.CART_QTY*B.PROD_COST)DESC) AS CRANK
                 FROM CART) A , 
                 PROD B  
                WHERE A.CART_PROD = B.PROD_ID 
                AND A.CART_NO LIKE '2005%'
                GROUP BY A.CART_PROD, B.PROD_NAME) D
        WHERE D.CRANK<=5;
        
        
        
        사용예)2005년 1월과 5월에 매입된 상품정보를 조회화시오.
        ALIAS는 상품코드, 상품명, 분류명
    
    (2005년 1월에 매입된 상품)
    SELECT DISTINCT A.BUY_PROD AS 상품코드,
            B.PROD_NAME AS 상품명,
            C.LPROD_NM AS 분류명
    FROM BUYPROD A, PROD B, LPROD C
    WHERE A.BUY_PROD = B.PROD_ID
        AND B.PROD_LGU = C.LPROD_GU
        AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131') 
      
     INTERSECT   --겹치는 자료 반환
    --(2005년 5월)
     SELECT DISTINCT A.BUY_PROD AS 상품코드,
            B.PROD_NAME AS 상품명,
            C.LPROD_NM AS 분류명
    FROM BUYPROD A, PROD B, LPROD C
    WHERE A.BUY_PROD = B.PROD_ID
        AND B.PROD_LGU = C.LPROD_GU
        AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501'))
        ORDER BY 1;   
        
    3. MINUS
    -두 집합의 차집합결과를 반환
    -기술 순서가 중요
    
    사용예)2005년 6,7월 중 6월달에만 판매된 상품정보를 조회하시오
    ALIAS는 상품코드, 상품명, 판매가,매입가
    
    (2005년 6월에 판매되어진 상품)
    SELECT DISTINCT A.CART_PROD AS 상품코드,
           B.PROD_NAME AS 상품명, 
           B.PROD_PRICE AS 판매가, 
           B.PROD_COST AS 매입가
    FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
          AND A.CART_NO LIKE '200506%'
          MINUS
   -- (7월)
    SELECT DISTINCT A.CART_PROD AS 상품코드,
           B.PROD_NAME AS 상품명, 
           B.PROD_PRICE AS 판매가, 
           B.PROD_COST AS 매입가
    FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
          AND A.CART_NO LIKE '200507%'
    ORDER BY 1;
    
  (EXISTS 연산자)  
  SELECT DISTINCT A.CART_PROD AS 상품코드,
           B.PROD_NAME AS 상품명, 
           B.PROD_PRICE AS 판매가, 
           B.PROD_COST AS 매입가
    FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
          AND A.CART_NO LIKE '200506%'
          AND NOT EXISTS (SELECT 1 --NOT빼면 INTERSECT연산자와 같음
                FROM CART C
                WHERE C.CART_PROD = A.CART_PROD --참인경우 전체가 참이 되어지는데 NOT이 붙어서 거짓이 된다 그래서 건너뛰엉
                AND C.CART_NO LIKE '200507%')  --2005년 6월과 7월 상품코드가 같으면 참이되는데 
    ORDER BY 1;
    
    
    
    
    
 

    **순위함수(RANK OVER)
    -특정컬럼을 기준으로 순서화시키고 등수부여
    -RANK OVER, DENSE_RANK 등이 있다
    1) RANK 
      .순위를 부여
      .같은 값은 같은 순위를 부여하고 차 순위는 중복된 개수만큼 순위를 증분하여 부여--그룹안에서도 순위부여 가능
       (EX 1,2,2,2,5,6...)
      .SELECT 절에 사용
       (사용형식)
       RANK()OVER(ORDER BY 컬럼명 [ASC|DESC]) [AS 별칭] --많은 것부터: DESC;
       -'컬럼명'을 기준으로 등수부여
       
       
       사용예)2005년 구매금액이 많은 5명의 회원을 조회하세요 
       ALIAS는 회원번호,회원명,구매금액
        SELECT A.CART_MEMBER AS 회원번호,  
               B.MEM_NAME AS 회원명, 
               SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액   
        FROM CART A, MEMBER B , PROD C
        WHERE A.CART_MEMBER = B.MEM_ID
             AND A.CART_PROD = C.PROD_ID
            -- AND ROWNUM<=5 --FROM WHERE SELECT 순으로 진행되기 때문에 정상적X
        GROUP BY A.CART_MEMBER,B.MEM_NAME
        ORDER BY 3 DESC;  
        
    (서브쿼리 사용)
    (서브쿼리 : 2005년 회원별 구매금액 계산, 구매금액 순으로 내림차순정렬)
    SELECT A.CART_MEMBER AS CID,
            SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
    FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
          AND A.CART_NO LIKE '2005%'
    GROUP BY  A.CART_MEMBER
    ORDER BY 2 DESC;--내림차순
    
    (메인쿼리:구매금액이 많은 5명의 회원의 회원번호,회원명,구매금액)
    SELECT M.MEM_ID AS 회원번호, 
         M.MEM_NAME AS 회원명,
            C.CSUM  AS 구매금액
    FROM MEMBER M, (SELECT A.CART_MEMBER AS CID,
                    SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                    FROM CART A, PROD B
                    WHERE A.CART_PROD = B.PROD_ID
                    AND A.CART_NO LIKE '2005%'
                    GROUP BY  A.CART_MEMBER
                    ORDER BY 2 DESC) C
    WHERE M.MEM_ID = C.CID --조인
        AND ROWNUM<=5;
        
    사용예)2005년 구매금액이 많은 회원부터 등수를 부여하여 조회하세요 
       ALIAS는 회원번호,회원명,구매금액,등수
       SELECT A.CART_MEMBER AS 회원번호,
              B.MEM_NAME AS 회원명,
              SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액,
              RANK() OVER(ORDER BY SUM(A.CART_QTY*C.PROD_PRICE) DESC) AS 등수
        FROM CART A, MEMBER B, PROD C  
        WHERE A.CART_MEMBER = B.MEM_ID
              AND A.CART_PROD = C.PROD_ID
        GROUP BY A.CART_MEMBER, B.MEM_NAME;
        
    2)그룹내에서 순위
    (사용형식)
    RANK()OVER(PARTITION BY 컬럼명 [,컬럼명,...]
                ORDER BY 컬럼명 [,컬럼명,...][ASC|DESC])
    .PARTITION BY 컬럼명 : 그룹으로 묶을 컬럼명 기술 (순위를 부여하기위한 그룹핑)
    
    사용예)사원테이블에서 각 **부서별** 사원들의 급여를 기준으로 순위를 부여하여 출력하시오.
          순위는 급여가 많은 사람순으로 부여하고 같은 급여이면 입사일이 빠른 순으로 부여하시오
          --그룹내에서 순위 부여하기
        SELECT A.EMPLOYEE_ID AS 사원번호,
                A.EMP_NAME AS 사원명, 
                B.DEPARTMENT_NAME AS 부서명,
                 A.SALARY AS 급여, 
                 A.HIRE_DATE AS 입사일,
                 RANK()OVER(PARTITION BY A.DEPARTMENT_ID 
                     ORDER BY A.SALARY DESC, HIRE_DATE ASC ) AS 순위
        FROM HR.EMPLOYEES A , HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
        
    3)DENSE_RANK()
    -순위 부여 
    -같은 값이면 같은 순위 부여하며, 차순위는 같은순위 갯수와 관계없이 다음 순위부여(EX, 1,1,1,2,3,4...)
    -나머지 특징은 RANK()와 동일
    
    4) ROW_NUMBER()
    -순위 부여                      값 9 9 9 8 7 6....
    -같은 값이라도 순차적인 순위 부여 (EX, 1,2,3,4,5,6...)
    -나머지 특징은 RANK()와 동일
    
    사용예)사원테이블에서 급여가 5000이하인 사원들을 조회하고 급여에 따른 순위를 부여하시오
    
    (RANK() 함수 사용)
     SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            DEPARTMENT_ID AS 부서코드, 
            SALARY AS 급여, 
    RANK()OVER(ORDER BY SALARY DESC) AS 순위  --
    FROM HR.EMPLOYEES
    WHERE SALARY <=5000;
          
    (DENSE_RANK 사용)    
     SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            DEPARTMENT_ID AS 부서코드, 
            SALARY AS 급여, 
    DENSE_RANK()OVER(ORDER BY SALARY DESC) AS 순위  
    FROM HR.EMPLOYEES
    WHERE SALARY <=5000;
    
    (ROW_NUMBER사용)
     SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            DEPARTMENT_ID AS 부서코드, 
            SALARY AS 급여, 
   ROW_NUMBER()OVER(ORDER BY SALARY DESC) AS 순위  
    FROM HR.EMPLOYEES
    WHERE SALARY <=5000;
    

    
    
              
    
    
   
        
        
       
    
    
    