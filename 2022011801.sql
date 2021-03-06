2022-0118-01 ) TABLE JOIN
    -데이터베이스 설계에 정규화 과정을 수행하면 테이블이 분활되고 필요한 자료를 조회하기 위해 복수개의 테이블이 공통의 컬럼을 기준으로 연산에 참여해야함
     => 조인 연산   --정규화란 해당테이블이 가지고 있으면 안되는 컬럼이 있을 때 테이블을 분할한다! (6개의 과정)
                  --그러면 정보들이 분산됨.. 조회를 하려면 조인연산을 이용해야해! 두개의 테이블에는 반드시 관계형성되어있어야해(기본키,외래키)
                  --반드시 조인 조건을 기술해야 조인 연산이 실행된다!
     -관계형 데이터 베이스의 기본연산
     -종류
      .내부조인(INNER JOIN)-(부족한 쪽(데이터종류의 많고 적음)을 기준으로 조인 남는 자료는 무시)과 
       외부조인(OUTER JOIN)- 사용자제.. 많은쪽 테이블 기준 , 나머지는 NULL값을 채운다
      .일반조인과 - 특정 DBMS에 맞춰서 기능에 최적화되어진 조인문 형식
       ANSI JOIN - 모든 DBMS가 수용해야해(DBMS에 상관없이 다 실행가능)
      .동등조인(EQUI JOIN)과 -동등 연산자(=) 사용되어 질 때
       비동등조인(NON EQUI JOIN) 조인문에 = 이외의 연산자가 사용되어질 때
      
      
      1.Cartesian product 
        -**조인조건이 생략되었거나 잘못 기술된 경우** 
        -ANSI JOIN에서는 Cross Join이라고 함
        -조인의 결과는 최악의 경우 행의 수를 곱의 결과와 열의 수를 더한 결과 반환
        -불가피하게 필요한 경우가 아니면 사용하지 말아야함
      (사용형식)
      SELECT 칼럼LIST
        FROM 테이블명1[별칭1],테이블명2 [별칭2] 테이블명3 [별칭4],....] --테이블 별칭  
      WHERE 조인조건1     --사용된 테이블 개수 N개에서 최소 N-1개의 조인조건이 필요하다(그 이상도 괜춘) 
      [AND 조인조건2,...] --두 테이블 사이의 공통 컬럼을 연산자에 의해 비교하는 것
      [AND 일반조건]      --이제껏 사용한 조건
      
      (CROSS JOIN문 형식)-ANSI
      SELECT 칼럼LIST
        FROM 테이블명1[별칭1] --딱 하나 나옴
        CROSS JOIN 테이블명2[별칭2]  
        [CROSS JOIN 테이블명3[별칭3]--테이블명1 테이블명2 결과와 조인된다
                    .
                    .
        [WHERE 일반조건];

        사용예)
        SELECT COUNT(*) FROM CART;
        SELECT COUNT(*) FROM PROD;
        SELECT 207*74 FROM DUAL;
        
        SELECT COUNT(*)
        FROM CART ,PROD , BUYPROD; --최악의 경우 행의수는 서로 곱한값만큼, 열의수는 더한값만큼
      --  WHERE CART_QTY != PROD_QTYSALE; --(조인 조건)
        
        (ANSI형식)
        SELECT COUNT(*)
        FROM CART 
        CROSS JOIN PROD 
        CROSS JOIN BUYPROD;
        
        2.EQUI JOIN (거의 우리가 쓰는 것 다 EQUI 조인)
        -조인조건문에 동등연산자--**('=')**가 사용
        -사용된**테이블의 수가 N개일 때 조인조건은 적어도 N-1개 이상**이어야 함
        -ANSI에서는 INNER JOIN 사용을 권고함 --부족한 쪽을 기준
        
        (기술형식-일반 조인문)
        SELECT [테이블명.|테이블별칭.] 컬럼명 [AS 컬럼별칭][,]
                                :
               [테이블명.|테이블별칭.] 컬럼명 [AS 컬럼별칭]
            FROM 테이블명[별칭],테이블명[별칭][,테이블명[별칭],...]
            WHERE 조인조건    
            [AND 조인조건]
                   :
            [AND 일반조건];
            
            
            (ANSI)
             SELECT [테이블명.|테이블별칭.] 컬럼명 [AS 컬럼별칭][,]
                                :
               [테이블명.|테이블별칭.] 컬럼명 [AS 컬럼별칭]
            FROM 테이블명1[별칭]
            INNER JOIN 테이블명2[별칭] ON (조인조건 [AND 일반조건])
            [INNER JOIN 테이블명3[별칭] ON (조인조건 [AND 일반조건])
            [WHERE 일반조건]; -- 전체 테이블에 관련한 일반조건
            -테이블명1과 테이블명2는 반드시 조인 가능해야함 - 공통 컬럼이 반드시 존재해야한다는 뜻
            
            (일반조인문형식)
        사용예)상품테이블과 분류테이블 테이블을 이용하여 **판매가가 10만원 이상인 상품**을 조회하시오.
            ALIAS는 상품코드, 상품명, 분류코드 (LPROD_GU), (분류명- LPROD_NM ),판매가
            SELECT A.PROD_ID AS 상품코드,
                    A.PROD_NAME AS 상품명,
                    A.PROD_LGU AS 분류코드,
                    B.LPROD_NM AS 분류명,
                    A.PROD_PRICE AS 판매가
            FROM PROD A, LPROD B
            WHERE A.PROD_PRICE >= 100000 --일반조건
                  AND  A.PROD_LGU = B.LPROD_GU   --두 테이블 사이의 공통된 컬럼을 동등연산자로 연결해주세요 --조인조건 
            ORDER BY 5;    
                                    --공통의 컬럼은 이름을 바꾸면 안된다! (지금 잘못 설계되어있다)
           
           (ANSI 조인문)
           SELECT A.PROD_ID AS 상품코드,
                    A.PROD_NAME AS 상품명,
                    A.PROD_LGU AS 분류코드,
                    B.LPROD_NM AS 분류명,
                    A.PROD_PRICE AS 판매가
            FROM PROD A 
            INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU AND
                        A.PROD_PRICE >= 100000)
            ORDER BY 5 DESC;
             
           
        사용예)2005년 6월 회원**별**집계함수 써야해 구매현황을 조회하시오 --CART TABLE /MEMBER/ PROD 
        ALIAS는 회원번호, 회원명, 구매금액합계
        SELECT CART_MEMBER  AS 회원번호 ,
        
       (일반 조인)
         SELECT A.CART_MEMBER AS 회원번호,
                B.MEM_NAME  AS  회원명,
                SUM(C.PROD_PRICE*A.CART_QTY) AS 구매금액합계
        FROM CART A, MEMBER B, PROD C
        WHERE A.CART_MEMBER = B.MEM_ID --조인조건 : 회원명 추출을 위한
            AND A.CART_PROD = C.PROD_ID --조인조건 : 판매단가를 추출하기 위한
            AND A.CART_NO LIKE '200506%' --일반조건
        GROUP BY A.CART_MEMBER ,B.MEM_NAME;
        
        (ANSI 조인)
         SELECT A.CART_MEMBER AS 회원번호,
                B.MEM_NAME  AS  회원명,
                SUM(C.PROD_PRICE*A.CART_QTY) AS 구매금액합계
        FROM CART A 
        INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID)--반드시 FROM의 테이블과 조인이 가능한것이여야한다
        INNER JOIN PROD C ON(C.PROD_ID = A.CART_PROD)
        WHERE A.CART_NO LIKE '200506%'--일반조건
        GROUP BY A.CART_MEMBER ,B.MEM_NAME;
        
        사용예) **부서별** 인원수와 평균임금을 조회하시오.
        ALIAS 부서코드, 부서명, 인원수, 평균임금
        
        (일반형식)
        SELECT A.DEPARTMENT_ID AS 부서코드,
                B.DEPARTMENT_NAME AS 부서명,
                     COUNT(*) AS 인원수,
               ROUND(AVG(A.SALARY))  AS 평균임금
        FROM  HR.EMPLOYEES A , HR.DEPARTMENTS B         
        WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_ID  
        GROUP BY A.DEPARTMENT_ID,  B.DEPARTMENT_NAME
        ORDER BY 1; 
        
        (ANSI 형식)
        SELECT A.DEPARTMENT_ID AS 부서코드,
                B.DEPARTMENT_NAME AS 부서명,
                     COUNT(*) AS 인원수,
               ROUND(AVG(A.SALARY))  AS 평균임금
        FROM  HR.EMPLOYEES A 
        INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
        문제)2005년 1월 ~ 6월 각 거래처별 매입현황을 조회하시오. --공통의 컬럼이 없기 때문에 조인을 할 수 없다--중매쟁이가 있어야해(여기서는 **PROD**)
        ALISAS 거래처코드, 거래처명, 매입금액합계
        SELECT   C.PROD_BUYER  AS  거래처코드, 
                 B.BUYER_NAME AS  거래처명,
                SUM(A.BUY_QTY*A.BUY_COST)  AS 매입금액합계
        FROM  BUYPROD A, BUYER B , PROD C --PROD가 중매해줌!!!!
        WHERE  A.BUY_PROD = C.PROD_ID
                AND C.PROD_BUYER = B.BUYER_ID
               AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
        GROUP BY  C.PROD_BUYER  ,B.BUYER_NAME
        ORDER BY 1;
        
        (ANSI 형식)
        SELECT   C.PROD_BUYER  AS  거래처코드, 
                 B.BUYER_NAME AS  거래처명,
                SUM(A.BUY_QTY*A.BUY_COST)  AS 매입금액합계
        FROM  BUYPROD A
        INNER JOIN PROD C ON(A.BUY_PROD = C.PROD_ID
                            AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630'))
        INNER JOIN BUYER B ON(C.PROD_BUYER = B.BUYER_ID)
        GROUP BY C.PROD_BUYER, B.BUYER_NAME
        ORDER BY 1;
              
                        
      문제)2005년 4월 ~ 6월 각 상품별 매춯현황을 조회하시오. 
        ALIAS는 상품코드,상품명, 매출수량합계, 매출금액합계이다
        SELECT A.PROD_ID AS 상품코드,
               A.PROD_NAME AS 상품명,
                SUM(B.CART_QTY) AS 매출수량합계,
                SUM(B.CART_QTY*A.PROD_PRICE) AS  매출금액합계
        FROM PROD  A, CART B
        WHERE A.PROD_ID = B.CART_PROD
             AND SUBSTR(B.CART_NO,1,8) BETWEEN TO_DATE('20050401')    AND TO_DATE('20050630')
        GROUP BY A.PROD_ID , A.PROD_NAME
        ORDER BY 1;
        
         문제)2005년 4월 ~ 6월 각 상품별 매입현황을 조회하시오. 
        ALIAS는 상품코드,상품명,매입수량입계,매입금액합계이다
        
        SELECT A.PROD_ID AS 상품코드,
               A.PROD_NAME AS 상품명,
                SUM(B.BUY_QTY) AS 매입수량합계,
                SUM(B.BUY_QTY*B.BUY_COST)매입금액합계
        FROM   PROD A, BUYPROD B
        WHERE  A.PROD_ID = B.BUY_PROD
              AND BUY_DATE BETWEEN '20050401' AND '20050630'    
        GROUP BY  A.PROD_ID , A.PROD_NAME
        ORDER BY 1;

        
        문제)2005년 4월 ~ 6월 각 상품별 매입/매출현황을 조회하시오. 
        ALIAS는 상품코드,상품명,매입금액입계,매출금액합계이다
        
        SELECT A.PROD_ID AS 상품코드,A.PROD_NAME AS 상품명,SUM(B.BUY_QTY*A.PROD_COST) AS 매입금액합계,SUM(A.PROD_PRICE*C.CART_QTY) AS
        매출금액합계
        FROM  PROD A, BUYPROD B, CART C
        WHERE B.BUY_PROD = A.PROD_ID
            AND A.PROD_ID =C.CART_PROD
            AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
            AND SUBSTR(C.CART_NO,1,6) BETWEEN '20050401' AND '20050630'
        GROUP BY A.PROD_ID ,A.PROD_NAME 
        ORDER BY 1;
        
        
        
        
        
        
            
            
        
            
        
        
        