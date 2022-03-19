 2022011401) 집계함수(그룹함수)
      -주어진 자료를 특정 컬럼(들)을 기준으로 그룹화하고 각 그룹에서 --**합계(sum), 평균(avg), 빈돗수(count)-각 그룹의 행의 수를 보여줌
      --,최대값(MAX), 최소값(MIN)**--을 반환하는 함수 **특정 컬럼에서 같은 값을 갖는 것끼리 모아!**
      -SELECT절에 집계함수를 제외한 일반 컬럼과 같이 사용되면 반드시 GROUP BY 절이 사용되어야 함
      -집계함수가 사용된 컬럼(수식)에 조건이 부여된 경우  HAVING절로 처리
      -집계함수들은 다른 집계함수를 포함할 수 없다
      
      (사용형식)
      SELECT [컬럼list,]
             그룹함수
        FROM 테이블명
        [WHERE 조건]  **출력되는 것을 제한해줌**
        [GROUP BY 컬럼명1][컬럼명2,....]
        [HAVING 조건] --**집계합수 자체에 조건에 부여될 때**
        [ORDER BY 컬럼명][컬럼인덱스 [ASC|DESC][,.....]]
        .GROUP BY 컬럼명1[,컬럼명2,...] : 컬럼명1을 기준으로 그룹화하고 각 그룹에서 다시 '컬럼명2'로 그룹화
        .SELECT절에 사용된 --**일반컬럼은 반드시 GROUP BY절에 기술** 해야하며,SELECT절에 사용하지 않은 컬럼도 GROUP BY 절에 기술 가능
        .SELECT절에 그룹함수만 사용된 경우 GROUP BY 절 생략(테이블 전체를 하나의 그룹으로 간주)
        -그룹안에 그룹이 만들어질 수 있음!
        .SUM(EXPR) AVG(EXPR), COUNT(*EXPR),MIN(EXPR),MAX(EXPR)
        
        사용예)사원테이블에서 각 부서**'별'**('그룹바이'라는 뜻) 급여합계를 구하되 급여합계가 100000이상이 부서만 조회하시오 --그룹안에 그룹
        ALIAS는 부서코드, 급여합계
        SELECT  DEPARTMENT_ID AS 부서코드,
                SUM(SALARY) AS 급여합계    
        FROM   HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        **HAVING SUM(SALARY)>= 100000**
        ORDER BY 1;
        
        --LIKE 는 패턴비교할 때 (%_와 함께 사용) 
        사용예) 사원테이블에서 각 부서별 평균급여를 구하시오
        alias는 부서코드, 부서명, 평균급여
        SELECT A.DEPARTMENT_ID AS 부서코드, 
        B.DEPARTMENT_NAME AS 부서명, 
        ROUND(AVG(A.SALARY),1) AS 평균급여
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B --별칭 반드시 써줘!
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID , B.DEPARTMENT_NAME   --일반 컬럼을 그룹핑해줘
        ORDER BY 1;
        
        사용예)상품테이블에서 분류별 평균 매입가를 조회하시오
        SELECT PROD_LGU AS 상품분류 , 
               ROUND(AVG(PROD_COST),0) AS 평균매입가 
        FROM   PROD
        GROUP BY PROD_LGU;
        
        문제) 장바구니테이블에서 2005년 4월 제품별 판매수량집계를 구하시오
        SELECT  CART_PROD AS 제품코드,
                SUM(CART_QTY) AS 판매수량집계
        FROM CART 
        WHERE  SUBSTR(CART_NO,1,6) = '200504'
        --CART_NO  LIKE  '200504%' 
        GROUP BY CART_PROD 
        ORDER BY 1;
        
         문제)장바구니테이블에서 2005년 4월 제품별 판매 수량합계가 10개 이상인 제품을 조회하시오 
      SELECT  CART_PROD AS 제품코드,
              SUM(CART_QTY) AS 판매수량합계
        FROM   CART 
        WHERE  SUBSTR(CART_NO,1,6) = '200504'
        GROUP BY CART_PROD
        HAVING SUM(CART_QTY)>= 10
        ORDER BY 1;
        
        문제) 매입테이블에서 2005년 1월 ~6월 월별 매입집계를 구하시오
        SELECT  EXTRACT (MONTH FROM BUY_DATE) AS 매입월,
                SUM(BUY_COST*BUY_QTY) AS 매입집계,
                SUM(BUY_QTY)AS 매입수량합계
        FROM    BUYPROD
        WHERE   BUY_DATE  BETWEEN  TO DATE ('20050101') AND TO_DATE('20050630')
        GROUP BY  EXTRACT (MONTH FROM BUY_DATE)
        ORDER BY 1;
        
        문제)매입테이블에서 2005년 1~6월 월별, 제품별 매입금액 합계가 1000만원 이상인 정보만 조회하시오 
           SELECT  EXTRACT (MONTH FROM BUY_DATE) AS 매입월,
                    BUY_PROD  AS 제품코드,
                SUM(BUY_COST*BUY_QTY) AS 매입집계
        FROM    BUYPROD
        WHERE   BUY_DATE  BETWEEN ('20050101') AND ('20050701')
        GROUP BY  EXTRACT (MONTH FROM BUY_DATE), BUY_PROD 
        HAVING SUM(BUY_COST*BUY_QTY) >= 10000000
        ORDER BY 1;
        
        
        문제)회원테이블에서 성별 마일리지 합계를 구하시오
        ALIAS는 구분,마일리지 합계이며, 구분에는 '여성회원'과 '남성회원'을 출력하시오 
        SELECT  CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR   
                SUBSTR(MEM_REGNO2,1,1)='3' THEN
                '남성회원'
                ELSE '여성회원'
                END AS 구분,
                SUM(MEM_MILEAGE) AS 마일리지합계 
        FROM MEMBER
        GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR   
                 SUBSTR(MEM_REGNO2,1,1)='3' THEN
                '남성회원'
                ELSE '여성회원'
                END;
        
         문제) 회원테이블에서 연령대별 해당 연령대의 마일리지 합계를 조회하시오
        ALIAS는 구분, 마일리지 합계이며 구분난에는 '10대',..;'70'대 등으로 연령대를 출력
    SELECT  TRUNC((EXTRACT(YEAR FROM SYSDATE)  
          - EXTRACT(YEAR FROM MEM_BIR)),-1)||'대'  AS 구분,  
            SUM(MEM_MILEAGE) AS 마일리지합계
    FROM MEMBER
    GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)  
          - EXTRACT(YEAR FROM MEM_BIR)),-1)||'대' 
    ORDER BY 1;
    
    
    
    
        SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                        SUBSTR(MEM_REGNO2,1,1) = '2' THEN
         TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900),-1)
          ELSE
          TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000),-1)
          END  ||'대'  AS 구분,  
        SUM(MEM_MILEAGE) AS 마일리지합계
    FROM MEMBER
    GROUP BY ASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                        SUBSTR(MEM_REGNO2,1,1) = '2' THEN
         TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900) ,-1)
          ELSE
          TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000),-1)
          END ||'대' 
    ORDER BY 1;
    
 
    사용예) 전체사원의 평균급여를 출력  --전체가 그룹이니까 GROUP BY절 안써 
    SELECT  ROUND(AVG(SALARY)) AS 평균급여,
            SUM(SALARY) AS 급여합계,
            COUNT(*) 사원수
    FROM HR.EMPLOYEES;
    
    사용예) 사원들의 급여가 평균급여보다 적은사원 정보를 조회
     ALIAS는 사원번호(GROUP BY 의미없음) ,사원명, 부서코드,직무코드,급여,평균급여
     
     SELECT A.EMPLOYEE_ID AS 사원번호 ,
            A.EMP_NAME AS 사원명, 
            A.DEPARTMENT_ID AS 부서코드,
            A.JOB_ID AS 직무코드,
            A.SALARY AS 급여,
            B.ASAL AS 평균급여      
     FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES) B  --괄호 묶인 것 서브쿼리얏
     WHERE A.SALARY < B.ASAL
     ORDER BY 3;
    
    
    
     사용예) 사원테이블에서 각 부서별 최대급여와 최소급여를 구하시오
        ALIAS는 부서코드, 부서명, 최대급여, 최소급여
        SELECT  부서코드, 부서명, 최대급여, 최소급여
        
        
        
        