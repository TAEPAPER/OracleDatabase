 2022-01-21-02 )SUBQUERY
    -SQL구문 안에 또 다른 SELECT문이 존재하는 경우
    -JOIN이나  복잡도를 개선하기 위해 사용
    -모든 SUBQUERY문은 ()안에 기술해야함, 단, INSERT문에 사용되는 SUBQUERY는 제외
    -서브쿼리가 WHERE절 등에서 연산과 같이 사용될 때 반드시 연산자 오른쪽에 위치
    -서브쿼리의 분류
      .사용 위치에 따라 : 일반서브쿼리(SELECT절), **중첩서브쿼리(WHERE절),In-line서브쿼리(FROM절--독립실행되어야한다)**
      .메인쿼리와 관계에 따라 : 관령성 없는 서브쿼리 (메인쿼리에 사용된 테이블과 JOIN으로 연결된 서브쿼리) --join되었냐 join되지 않았느냐
      .반환되는 행/열에 따라 : 단일열|다중열/ 단일행|다중행 서브쿼리 => 사용되는 연산자에 위한 구별
     
      
    -알려지지 않은 조건에 근거한 값들을 검색하는 SELECT문 등에 활용 --ex)평균근속연수를 구하시오 
    -메인쿼리가 실행되기 전에 한번  실행된다.
     -FROM(FROM 안에 서브쿼리가 있으면 실행된 서브쿼리를 이용해서 메인 쿼리 작성) WHERE SELECT
     
     사용예) 사원테이블에서 사원들의 평균임금(평균임금을 구하는게 서브쿼리) 보다 많은 급여를 받는 사원들의 사원번호,사원명,부서코드,급여를 조회하시오
     (IN-LINE-VIEW 서브쿼리)
     (메인쿼리 -최종적으로 출력하는 것 : 사원들의 사원번호,사원명,부서코드,급여
     
     SELECT A.EMPLOYEE_ID AS A.사원번호,EMP_NAME AS 사원명,A.DEPARTMENT_ID AS 부서코드,A.SALARY AS 급여
     FROM HR.EMPLOYEES A, (평균임금) B
     WHERE A.SALARY > B.평균임금
     ORDER BY 3;
            
    (서브쿼리 :평균임금) 
    SELECT AVG(SALARY) AS ASAL 
    FROM HR.EMPLOYEES
    
    (결합)
    SELECT A.EMPLOYEE_ID AS 사원번호,
           A.EMP_NAME AS 사원명,
           A.DEPARTMENT_ID AS 부서코드,
           A.SALARY AS 급여
    FROM HR.EMPLOYEES A,
            (SELECT AVG(SALARY) AS ASAL 
             FROM HR.EMPLOYEES) B --B.ASAL 이렇게 되어야한다!!! 
    WHERE A.SALARY > B.ASAL  --참조되어진다
    ORDER BY 3;
   
    (중첩 서브쿼리)-where절에 사용
    
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서코드,
           SALARY AS 급여
    FROM HR.EMPLOYEES 
    WHERE  SALARY > (SELECT AVG(SALARY) 
             FROM HR.EMPLOYEES)  --107번이 수행되어져 (전체 실행속도가 느려짐)
    ORDER BY 3;
    
    
    사용예)회원테이블에서 회원의 직업별 최대마일리지를 갖고 있는 회원정보를 조회하시오
          ALIAS는 회원번호,회원명,직업, 마일리지 
        (메인쿼리 : 회원번호,회원명,직업, 마일리지)
        SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                 MEM_JOB AS 직업, 
                MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE (MEM_JOB,MEM_MILEAGE) =  (서브쿼리)--각 직업결 최대 마일리지
        
        (서브쿼리 : 각 직업별 최대마일리지)
        SELECT   MEM_JOB , 
                MAX(MEM_MILEAGE) 
                FROM MEMBER 
                GROUP BY MEM_JOB
                
        (결합)
       SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                 MEM_JOB AS 직업, 
                MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE (MEM_JOB,MEM_MILEAGE) IN (SELECT  MEM_JOB , 
                                                MAX(MEM_MILEAGE)     --다중행연산자는 IN =SUM =ANY EXIST 사용되어져야한다
                                                FROM MEMBER                 --'중첩서브쿼리'
                                                GROUP BY MEM_JOB);  --다중행 서브쿼리!! --조인으로 연결안됐으니까 '관련성없는 서브쿼리'
                                                
         (EXIST 연산자 사용)
         SELECT A.MEM_ID AS 회원번호,
                A.MEM_NAME AS 회원명,
                A.MEM_JOB AS 직업, 
                A.MEM_MILEAGE AS 마일리지
        FROM MEMBER A   --전체를 다 비교해줘 (어느 순간에 직업도 같고 마일리지도 같은 사람이 왔어 그러면  WHERE이 참이 되고 메인쿼리가 실행된다)
                      WHERE EXISTS (SELECT 1 --의미가 없어          --같으냐?
                      FROM(SELECT MEM_JOB,
                            MAX(MEM_MILEAGE)  AS BMILE  
                            FROM MEMBER 
                            GROUP BY MEM_JOB)B
        WHERE A.MEM_JOB = B.MEM_JOB 
             AND A.MEM_MILEAGE = B.BMILE);
       
     사용예)상품테이블에서 상품의 판매가가 평균판매가보다 큰 상품을 조회하시오
     
     ALIAS는 상품번호, 상품명, 판매가, 평균판매가
    SELECT  A.PROD_ID AS 상품번호, 
            A.PROD_NAME AS 상품명, 
            A.PROD_PRICE AS 판매가, 
            B.BAV  AS  평균판매가
    FROM PROD A,(SELECT ROUND(AVG(PROD_PRICE)) AS BAV
                        FROM PROD)B               
    WHERE A.PROD_PRICE > B.BAV
    ORDER BY 1;
    
     
     
     
     
     
     
     
     
     장바구니 테이블에서 회원별 최대 구매수량을 기록한 상품을 조회하시오
     ALIAS는 회원번호, 회원명, 상품명, 구매수량
     SELECT C.CART_MEMBER AS 회원번호, 
           A.MEM_NAME AS  회원명,
           B.PROD_NAME AS 상품명, 
           C.CART_QTY AS 구매수량
     FROM MEMBER A, PROD B, CART C
     WHERE C.CART_MEMBER = A.MEM_ID
          AND C.CART_PROD = B.PROD_ID
          AND C.CART_QTY =(서브쿼리)
               
    (서브쿼리 : 회원별 최대구매 수량)
    SELECT CART_MEMBER ,
    MAX(CART_QTY)
    FROM CART
    GROUP BY CART_MEMBER;
    
    (결합)
    SELECT C.CART_MEMBER AS 회원번호, 
           A.MEM_NAME AS  회원명,
           B.PROD_NAME AS 상품명, 
           C.CART_QTY AS 구매수량
     FROM MEMBER A, PROD B, CART C
     WHERE C.CART_MEMBER = A.MEM_ID
          AND C.CART_PROD = B.PROD_ID
          AND (C.CART_MEMBER, C.CART_QTY) IN (SELECT CART_MEMBER ,
                            MAX(CART_QTY)            -- 1개와 23개 
                            FROM CART                --IN을 쓰고 (,)해줘서 페어로 비교한다
                            GROUP BY CART_MEMBER);
    (두번째 방법)
    SELECT C.CART_MEMBER AS 회원번호, 
           A.MEM_NAME AS  회원명,
           B.PROD_NAME AS 상품명, 
           C.CART_QTY AS 구매수량
     FROM MEMBER A, PROD B, CART C
     WHERE C.CART_MEMBER = A.MEM_ID
          AND C.CART_PROD = B.PROD_ID
          AND  C.CART_QTY = (SELECT  MAX(D.CART_QTY)            -- 1개와 23개 
                            FROM CART D
                            WHERE D.CART_MEMBER = C.CART_MEMBER)  --IN을 쓰고 (,)해줘서 페어로 비교한다 
        ORDER BY 1;
        
    
    
    
    
    
    
    
    
    
    
    
    
    SELECT CART_MEMBER , CART_PROD, CART_QTY
    FROM CART
    WHERE CART_MEMBER = 'b001'
    ORDER BY 3 DESC;
    
 
                
                                                       
                
    
    
    
    