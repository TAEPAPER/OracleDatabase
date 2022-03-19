2022-0120-01)외부조인(OUTER JOIN)
    -조인에 참여하는 테이블 중 자료의 종류가 많은 쪽을 기준으로 적은 테이블에 NULL행을 첨가하여 조인을 수행
    -일반외부조인은 조인조건 기술시 **부족한 테이블의 컬럼명 뒤에 외부조인 연산자'(+)'를 추가** --(NULL을 집어넣어서 행을 맞추세요라는 뜻)
    -외부조인 조건이 복수개인 경우 모두 '(+)' 연산자를 추가해야함
    -하나의 테이블이 동시에 다수개의 외부조인에 참여할 수 없다.
    즉,A,B,C 테이블이 외부 조인에 참여하는 경우  A를 기준으로 B테이블이, C를 기준으로 B테이블이 동시에 외부조인 될 수 없다
   ** (A = B(+) AND C=B(+)는 허용되지 않음) - **
    -일반조건과 외부조인조건이 동시에 사용되면 정확한 결과를 얻을 수 없다 => **서브쿼리로 해결** -서브쿼리안에서 일반조건 처리, 그것을 가지고 외부조인을 시킴
    
    (사용형식-일반외부조인)
        SELECT 컬럼LIST
         FROM 테이블명[별칭] ,테이블명[별칭],...
         WHERE 컬럼명 = 컬럼명(+) --조인조건--부족한 곳에 (+)를 쓴다
            [AND 일반조건]
                    :
                    
    (사용형식- ANSI외부조인)
        SELECT 컬럼LIST
         FROM 테이블명1[별칭1] 
         LEFT | RIGHT |FULL OUTER JOIN 테이블명2[별칭2] ON(조인조건[AND 일반조건])
                    :
        LEFT | RIGHT |FULL OUTER JOIN 테이블명N[별칭N] ON(조인조건[AND 일반조건])
       [WHERE 일반조건]
         
       .FROM 다음에 기술된 '테이블명1'의 자료가 '테이블명2'보다 많으면 LEFT, 적으면 RIGHT , 양쪽 모두 부족하면 FULL 기술
       .'테이블명1'과 '테이블명2'는 반드시 조인 가능할 것
       .기타 조인 프로세스는 내부조인과 동일
         
     사용예)상품테이블에서 모든 (모든, 전부는 OUTER JOIN 하라는 뜻) 분류별( GROUP BY) 상품의 수를 조회하시오
       ALIAS는 분류코드, 분류명, 상품의 수
       (상품테이블에서 사용된 분류코드의 수)
       SELECT COUNT(DISTINCT PROD_LGU)   --줄수가 많고 적음이 아니라 이렇게 따짐
        FROM PROD;
        
        SELECT DISTINCT PROD_LGU  --음반시디 도서 문구류는 상품코드도 없어
        FROM PROD;
       
       (일반 외부조인)
       SELECT A.LPROD_GU AS 분류코드,
              A.LPROD_NM AS 분류명, 
              COUNT(B.PROD_ID) AS "상품의 수"
       FROM LPROD A, PROD B 
       WHERE B.PROD_LGU(+) = A.LPROD_GU --LPROD의 분류코드가 더 많으니까 LPROD를 써야해
      GROUP BY A.LPROD_GU ,A.LPROD_NM
      ORDER BY 1;
      
      (ANSI 외부조인)
        SELECT A.LPROD_GU AS 분류코드,
              A.LPROD_NM AS 분류명, 
              COUNT(B.PROD_ID) AS "상품의 수"
       FROM LPROD A
       LEFT OUTER JOIN PROD B ON(B.PROD_LGU = A.LPROD_GU)
       GROUP BY A.LPROD_GU ,A.LPROD_NM
       ORDER BY 1;
      
      사용예) 2005년 7월 **모든**  **제품별** 판매현황을 조회하시오   -
      ALIAS는 상품코드. 상품명,판매수량,판매금액
      (일반외부조인)
       SELECT B.PROD_ID AS 상품코드, --SELECT 절에서 두 테이블에 있는 것을 쓸때는 많은쪽걸 기준으로 하세요(PROD)
              B.PROD_NAME AS 상품명,
              SUM(A.CART_QTY) AS 판매수량,
              SUM(A.CART_QTY*B.PROD_PRICE) AS 판매금액   
       FROM CART A , PROD B
       WHERE B.PROD_ID = A.CART_PROD(+)   --카트에 있는게 부족 --일반조건과 외부조인 조건이 같이 있으면 정확한 결과를 얻을 수 없다 => 서브쿼리를 써라
         AND A.CART_NO LIKE '200507%'  
       GROUP BY B.PROD_ID,B.PROD_NAME
       ORDER BY 1;
        
       ( ANSI)
       SELECT B.PROD_ID AS 상품코드, 
              B.PROD_NAME AS 상품명,
              NVL(SUM(A.CART_QTY),0) AS 판매수량,
              NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS 판매금액  
       FROM CART A  
       RIGHT OUTER JOIN PROD B ON( B.PROD_ID = A.CART_PROD  --PROD가 더 많으니까 RIGHT OUTER JOIN
                                AND A.CART_NO LIKE '200507%')
       GROUP BY B.PROD_ID,B.PROD_NAME
       ORDER BY 1;     
       
       **다음 조건에 맞는 재고 수불테이블을 생성하고 기초자료를 입력하시오
       1)테이블명 : REMAIN
       2)컬럼
    -------------------------------------------------------------------
        컬럼명        데이터타입(크기)      NULLABLE      PK/FK    DAFAULE
    -------------------------------------------------------------------
    REMAIN_YEAR          CHAR(4)           N.N         PK   
    PROD_ID             VARCHAR(10)        N.N         PK&FK
    REMAIN_J_00          NUMBER(5)                                 0   --기초재고
    REMAIN_O             NUMBER(5)                                 0   --출고수량
     REMAIN_I            NUMBER(5)                                 0   --입고수량
    REMAIN_J_99          NUMBER(5)                                 0   --기말재고
   REMAIN_DATE             DATE                                SYSDATE  --날짜
  --------------------------------------------------------------------------------     
  
  CREATE TABLE REMAIN (
  REMAIN_YEAR          CHAR(4) ,          
    PROD_ID             VARCHAR(10),       
    REMAIN_J_00          NUMBER(5) DEFAULT 0,                                
    REMAIN_O             NUMBER(5) DEFAULT 0,                                
     REMAIN_I            NUMBER(5) DEFAULT 0,                        
    REMAIN_J_99          NUMBER(5) DEFAULT 0,                                  
   REMAIN_DATE             DATE    DEFAULT SYSDATE,
    CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR,PROD_ID),
    CONSTRAINT fk_remain_prod FOREIGN KEY(PROD_ID)
    REFERENCES PROD(PROD_ID));
     
     (기초자료 입력)
     => 상품테이블의 상품코드와 적정재고를 재고수불테이블(REMAIN)의 상품코드와 기초재고에 삽입
        1)년도 : '2005'
        2)상품코드 : 상품테이블의 상품코드
        3)기초,기말재고 : 상품테이블의 적정재고(PROD_PROPERSTOCK)
        
        INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
        SELECT '2005',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,
                            TO_DATE('20041231')
                            FROM PROD;
                            
        COMMIT;
        SELECT * FROM REMAIN;
        
        
      사용예)2005년 1월-**모든** **상품별** 매입수량을 조회하여 재고수불테이블을 갱신하시오.--이벤트 발생뒤에 재고가 변경(트리거)
      
      (2005년 1월 모든 상품별 매입수량 조회)
      SELECT PROD_ID, 
           NVL(SUM(BUY_QTY),0)--NULL값을 무엇으로
            FROM BUYPROD A
            RIGHT OUTER JOIN PROD B ON(B.PROD_ID = A.BUY_PROD
            AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
        GROUP BY PROD_ID;
        
     (재고수불테이블 갱신)
        UPDATE REMAIN R
         SET (R.REMAIN_I,R.REMAIN_J_99,R.REMAIN_DATE) = 
         (SELECT R.REMAIN_I + C.ISUM ,                  --SET들의 값과 개수가 일치해야해(반드시 1 : 1로 )
                 R.REMAIN_J_99 +C.ISUM,
                 TO_DATE('20050201')
                FROM (SELECT BUY_PROD AS PID,
                            SUM(BUY_QTY) AS ISUM
                                FROM BUYPROD 
                            WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
                    GROUP BY BUY_PROD) C   --제품별 매입수량 집계 
                    WHERE R.PROD_ID = C.PID)
            WHERE R.PROD_ID IN (SELECT DISTINCT BUY_PROD
                                    FROM BUYPROD
                                    WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'));
                                    
                                    
        REMAIN_J_99 = (SELECT REMAIN_J_99 + A.ISUM
                          FROM (SELECT B.PROD_ID AS PID,
                            NVL(SUM(BUY_QTY),0) AS ISUM
                                FROM BUYPROD A
                            RIGHT OUTER JOIN PROD B ON(B.PROD_ID = A.BUY_PROD
                                AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
                    GROUP BY B.PROD_ID)A
                    WHERE R.PROD_ID = A.PID),
        REMAIN_DATE = TO_DATE('20050201');
        
        SELECT * FROM REMAIN;
        
        COMMIT;
        
        ROLLBACK;
        
        
   **상품테이블에 상품별 마일리지를 상품판매가의 0.01%로 조정하여 갱신하시오.
        UPDATE PROD 
        SET PROD_MILEAGE = ROUND(PROD_PRICE*0.0001);
        SELECT PROD_ID, PROD_PRICE, PROD_MILEAGE
        FROM PROD;
        
        COMMIT;    
        
   **회원테이블의 회원마일리지를 2005년 매출자료를 집계하여 갱신하시오.
        (2005년 회원별, 상품별 매출수량집계
        SELECT  MEM_ID, CART_PROD,  -- 회원별 구매수량을 알고 
                NVL(SUM(CART_QTY),0)
            FROM CART A
          RIGHT OUTER JOIN MEMBER B ON(B.MEM_ID = A.CART_MEMBER   AND A.CART_NO LIKE '2005%') 
         GROUP BY  MEM_ID, CART_PROD
         ORDER BY 1; --N001이 구매활동 안했어(NULL)        
         
         
         
         (2005년 회원별 구매에 따른 마일리지)
           SELECT B.MEM_ID,
           SUM(B.CSUM*C.PROD_MILEAGE) 
           FROM (SELECT MEM_ID, CART_PROD,
                NVL(SUM(CART_QTY),0) AS CSUM --구매수량 집계를 CSUM으로 놓고
          FROM CART A
         RIGHT OUTER JOIN MEMBER B ON(B.MEM_ID = A.CART_MEMBER   AND A.CART_NO LIKE '2005%') 
         GROUP BY  MEM_ID, CART_PROD
         ORDER BY 1) B ,
         PROD C
        WHERE B.CART_PROD = C.PROD_ID
        GROUP BY B.MEM_ID ;
        
        
        (회원테이블의 마일리지 UPDATE)
        UPDATE MEMBER 
        SET MEM_MILEAGE = 
        (SELECT NVL(D.BSUM,0)
          
           FROM (SELECT B.MEM_ID AS BMID, 
                  SUM(B.CSUM*C.PROD_MILEAGE) AS BSUM
                FROM (SELECT MEM_ID
          FROM CART A
         RIGHT OUTER JOIN MEMBER B ON(B.MEM_ID = A.CART_MEMBER   AND A.CART_NO LIKE '2005%') 
         GROUP BY  MEM_ID, CART_PROD
         ORDER BY 1) B ,
         PROD C
        WHERE B.CART_PROD = C.PROD_ID
        GROUP BY B.MEM_ID ;
     
     WHERE M.MEM_ID = D.BMID)
     WHERE M.MEM_ID = (SELECT DISTINCT CART_MEMBER
                        FROM CART
                        WHERE CART_NO LIKE '2005%');
                        
    
        
        
        
         