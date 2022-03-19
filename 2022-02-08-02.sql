    2022-02-08-02) 
    
   
    
    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
      P_DATE DATE)
      RETURN VARCHAR2
    IS
     V_CNO VARCHAR2(20):=TO_CHAR(P_DATE,'YYYYMMDD');
     V_FLAG NUMBER:=0;
     
    BEGIN
     SELECT COUNT(*) INTO V_FLAG                  --주어진 날짜에 카트노가 없으면 1번 있으면 +1;
        FROM CART
        WHERE SUBSTR(CART_NO,1,8) = V_CNO;
        
        IF V_FLAG = 0 THEN      --판매자료가 하나도 없다는 뜻
           V_CNO := V_CNO||TRIM('00001');
        ELSE
           SELECT MAX(CART_NO)+1 INTO V_CNO
           FROM CART
           WHERE SUBSTR(CART_NO,1,8) = V_CNO;
        END IF;
        RETURN V_CNO;
    END;
    
    (실행)
    SELECT FN_CREATE_CARTNO(SYSDATE)
        FROM DUAL;
  
    SELECT FN_CREATE_CARTNO(TO_DATE('20050505')),
            FN_CREATE_CARTNO(TO_DATE('20050513'))
        FROM DUAL; 
    
     **CART테이블에 다음자료를 저장하시오
      구매일자 : 오늘
      구매회원 : d001
      구매상품 
     ---------------------------
    상품번호          수량  
    -----------------------------
    P201000003      3
    P201000015      2
  
    --오늘이 20050728  이라고 가정해보자
    --재고(리메인테이블) 변경해주고 마일리지(멤버테이블) 올려줘야한다 (트리거로 해)
    
    사용예) 
    --트리거 본문에서 처리해야할 내용 : 재고 UPDATE, 마일리지 UPDATE
    
   CREATE OR REPLACE TRIGGER TG_CART_CHANGE
   AFTER INSERT OR UPDATE OR DELETE ON CART --INSERT or UPDATE or DELECT이벤트가 실행된 다음!
   FOR EACH ROW
  DECLARE
    V_QTY NUMBER := 0; --재고를 변경할 수량
    V_PID PROD.PROD_ID%TYPE;
    V_MILE NUMBER :=0;
    V_DATE DATE;
    V_MID MEMBER.MEM_ID%TYPE;
  BEGIN
    IF INSERTING THEN --신규판매자료
      V_QTY := :NEW.CART_QTY;
      V_PID := :NEW.CART_PROD;
      V_DATE := TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
      V_MID := :NEW.CART_MEMBER;
      SELECT V_QTY * PROD_MILEAGE INTO V_MILE
        FROM PROD
       WHERE PROD_ID = V_PID;
    ELSIF UPDATING THEN --판매수량변경
      V_QTY := :NEW.CART_QTY - :OLD.CART_QTY;
      V_PID := :NEW.CART_PROD;
      V_DATE := TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
      V_MID := :NEW.CART_MEMBER;
      SELECT V_QTY * PROD_MILEAGE INTO V_MILE
        FROM PROD
       WHERE PROD_ID = V_PID;
    ELSIF DELETING THEN --판매취소
      V_QTY := -(:OLD.CART_QTY);
      V_PID := :OLD.CART_PROD;
      V_DATE := TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
      V_MID := :OLD.CART_MEMBER;
      SELECT V_QTY * PROD_MILEAGE INTO V_MILE
        FROM PROD
       WHERE PROD_ID = V_PID;
    END IF;
     UPDATE MEMBER 
         SET MEM_MILEAGE = MEM_MILEAGE + V_MILE
         WHERE MEM_ID = V_MID;   
      
          
        UPDATE REMAIN
        SET REMAIN_O = REMAIN_O +V_QTY,  
                 REMAIN_J_99 = REMAIN_J_99 - V_QTY, --현재 재고 - V_QTY
                 REMAIN_DATE = V_DATE
        WHERE PROD_ID = V_PID
        AND REMAIN_YEAR = EXTRACT(YEAR FROM V_DATE);
            
    END;    
       
  
   (재고조회)
    SELECT * FROM REMAIN
     WHERE PROD_ID =  'P201000003';
    
    SELECT MEM_MILEAGE 
            FROM MEMBER
            WHERE MEM_ID = 'd001';
    
    
    INSERT INTO CART
    VALUES('d001',FN_CREATE_CARTNO(TO_DATE('20050728')),
            'P201000003',3);
    
    
    UPDATE CART
      SET CART_QTY = 30  --이게 :NEW.CART_QTY가 된다
    WHERE CART_NO = '2005072800005'
            AND CART_PROD = 'P201000003'; --같은 장바구니안에 제품이 여러개 있을 수 있으니까 제품번호도 같아야해
    
   --몽땅 반품
   DELETE FROM CART 
    WHERE CART_NO = '2005072800005'
          AND CART_PROD = 'P201000003';
          
      --금부터 프로젝트 시작!~!    
    
            
            
    

    
    
    
