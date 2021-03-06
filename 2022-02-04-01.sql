2022-02-04-01)저장프로시져(Stored procedure : procedure)

    - 서버에 저장된 실행 가능한 프로그램 모듈 
    - 모든 응용프로그램에서 사용할 수 있도록 기능을 캡슐화
    - 보안성 확보
      -> 원본을 사용자들에게 open하지 않고 사용자가 요구한 결과만 전달 
      -> 데이터 접근을 제한할 수 있다.
    - 실행가능한 이름과 매개변수만 전달하기에 데이터 양이 작다.
        그렇기에 처리 속도가 빠르다. 
    - 반환 값이 없음
      -> 자바로 치면... void 메서드.
      
   (사용형식)   
    CREATE [OR REPLACE] PROCEDURE 프로시져명
     [(매개변수 [모드] 데이터타입 [:=[DEFAULT] 값][,]
                            :
     [(매개변수 [모드] 데이터타입 [:=[DEFAULT] 값])]
     AS|IS
        선언부;
     BEGIN
        실행부; 
         [EXCEPTION 
            예외처리;
         ]
      END;
    . '모드' : 매개변수의 역할 => 
              IN(입력용): 프로시져 생성때 '모드'가 생략되면 IN(입력용)으로 자동 처리 
              OUT(출력용): 매개변수의 값을 반환 
              INOUT(입출력용: 사용자제)

    . '데이터타입' : 크기를 지정하면 안됨 

    (실행문 형식) 
  EXECUTE|EXEC 프로시져명(매개변수list);
   -- 단독 실행 
  OR
  프로시져명(매개변수list);
   -- 다른 프로시져 또는 함수 및 익명블록 등에서 실행 

사용예)상품코드를 입력받아 2005년 매출수량과 매출금액 및 
       상품명을 출력하는 프로시져 작성 
     
    CREATE OR REPLACE PROCEDURE PROC_CART01
       (P_PID IN PROD.PROD_ID%TYPE)-- 또는 VARCHAR2   
       IS 
       V_NAME PROD.PROD_NAME%TYPE;
       V_QTY NUMBER:=0;
       V_AMT NUMBER:=0;
       BEGIN
        SELECT A.PROD_NAME, SUM(B.CART_QTY), SUM(B.CART_QTY * A.PROD_PRICE)
          INTO V_NAME, V_QTY, V_AMT
          FROM PROD A, CART B
         WHERE B.CART_PROD = P_PID 
           AND A.PROD_ID = B.CART_PROD 
           AND B.CART_NO LIKE '2005%'
      GROUP BY A.PROD_NAME;     
        DBMS_OUTPUT.PUT_LINE('상품코드 : ' ||P_PID);
        DBMS_OUTPUT.PUT_LINE('상품명 : ' ||V_NAME);
        DBMS_OUTPUT.PUT_LINE('매출수량 : ' ||V_QTY);
        DBMS_OUTPUT.PUT_LINE('매출액 : ' ||V_AMT);
        DBMS_OUTPUT.PUT_LINE('--------------------------');
       END;
     
     (호출문)
     
    EXECUTE PROC_CART01('P202000001');
 
 사용예) 부서번호를 입력받아 부서명, 인원수, 주소를 반환하는 프로시져 작성 
 
        CREATE OR REPLACE PROCEDURE PROC_EMP01(
        P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE,
        P_DNAME OUT VARCHAR2,
        P_CNT OUT NUMBER,
        P_ADDR OUT VARCHAR2)
        IS 
        BEGIN
            SELECT A.DEPARTMENT_NAME, 
                   B.POSTAL_CODE|| ' '||B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE
              INTO P_DNAME, P_ADDR
              FROM HR.DEPARTMENTS A, HR.LOCATIONS B
             WHERE A.LOCATION_ID = B.LOCATION_ID
               AND A.DEPARTMENT_ID = P_DID;
            SELECT COUNT(*) 
              INTO P_CNT
              FROM HR.EMPLOYEES
             WHERE DEPARTMENT_ID = P_DID;
         END;
        --HR계정으로 변경해야 실행 가능 
        
 (실행) 
  ACCEPT P_ID PROMPT '부서코드 입력(10~110) : '
  DECLARE 
    V_DNAME VARCHAR2(200);
    V_CNT NUMBER:=0;
    V_ADDR VARCHAR2(200);
  BEGIN 
    PROC_EMP01(TO_NUMBER('&P_ID'), V_DNAME, V_CNT, V_ADDR);
    
    DBMS_OUTPUT.PUT_LINE('부서코드 : '|| '&P_ID');
    DBMS_OUTPUT.PUT_LINE('부서명 : '|| V_DNAME);
    DBMS_OUTPUT.PUT_LINE('인원수 : '|| V_CNT);
    DBMS_OUTPUT.PUT_LINE('주소 : '|| V_ADDR);
    DBMS_OUTPUT.PUT_LINE('-------------------------');
  END;

사용예) 년도와 월을 입력받아 해당 월에 가장 많이 구매한 회원의 회원번호,이름,주소,마일리지를 반환하는 프로시져 작성
       프로시져명은 'PROC_MEM01'이다
       
       CREATE OR REPLACE PROCEDURE PROC_MEM01(
       P_PERIOD IN VARCHAR2,
       P_MID OUT MEMBER.MEM_ID%TYPE,
       P_NAME OUT MEMBER.MEM_NAME%TYPE,
       P_ADDR OUT VARCHAR2,
       P_MILE OUT MEMBER.MEM_MILEAGE%TYPE)
       IS
       V_PERIOD VARCHAR2(7) := P_PERIOD||'%';
       BEGIN
        SELECT TBL.AID INTO P_MID
          FROM (SELECT A.CART_MEMBER AS AID,
                SUM(A.CART_QTY*B.PROD_PRICE)
                FROM CART A, PROD B
                WHERE CART_NO LIKE V_PERIOD
                  AND A.CART_PROD = B.PROD_ID
                  GROUP BY A.CART_MEMBER
                  ORDER BY 2 DESC) TBL
        WHERE ROWNUM =1;
        
        SELECT MEM_NAME, MEM_ADD1||' '||MEM_ADD2,MEM_MILEAGE
        INTO P_NAME, P_ADDR,P_MILE
        FROM MEMBER
        WHERE MEM_ID = P_MID;
        END;
         

    (실행)
    DECLARE
    V_MID MEMBER.MEM_ID%TYPE;
    V_NAME VARCHAR2(50);
    V_ADDR VARCHAR2(100);
    V_MILE NUMBER :=0;
    BEGIN
     PROC_MEM01('200505',V_MID, V_NAME, V_ADDR, V_MILE);
     DBMS_OUTPUT.PUT_LINE('회원번호:'||V_MID);
     DBMS_OUTPUT.PUT_LINE('회원번호:'||V_NAME);

     DBMS_OUTPUT.PUT_LINE('회원주소:'||V_ADDR);
     DBMS_OUTPUT.PUT_LINE('마일리지:'||V_MILE);
     DBMS_OUTPUT.PUT_LINE('-------------------');
    END;

    사용예)년도와 월을 입력받아 제품별** 매입수량을 구한뒤 재고수불테이블을 갱신하시오
    
   CREATE OR REPLACE PROCEDURE PROC_REMAIN01(
       P_PERIOD IN VARCHAR2)
       IS 
       V_SDATE DATE :=TO_DATE(P_PERIOD||'01');
       V_EDATE DATE :=LAST_DAY(V_SDATE);
       V_QTY NUMBER :=0;
       CURSOR CUR_BUY02
       IS
         SELECT  BUY_PROD AS BID,
                SUM(BUY_QTY) AS BAMT
           FROM BUYPROD
           WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
           GROUP BY BUY_PROD;
    BEGIN 
        FOR REC IN CUR_BUY02 LOOP
          UPDATE REMAIN 
             SET REMAIN_I=REMAIN_I + REC.BAMT,
              REMAIN_J_99= REMAIN_J_99 +REC.BAMT,
              REMAIN_DATE = V_EDATE
              WHERE REMAIN_YEAR = SUBSTR(P_PERIOD,1,4)
                    AND PROD_ID = REC.BID;
                COMMIT;
        END LOOP;
    END;
  
    EXECUTE PROC_REMAIN01('200503');
    SELECT * FROM REMAIN;
  
    
  
  

      
      
      
      
   
         
      
       

