    2022-02-04-02) �Լ�(**USER DEFINED** FUNCTION : FUNCTION)

    -Ư¡�� PROCEDURE�� �����ϳ� ��ȯ���� ������(������� ���� �ϳ�)
    -SELECT ���� SELECT��, WHERE��, UPDATE���� � ���
    (�������)
    CREATE [OR REPLACE] FUNCTION �Լ���[(
    ������ [���] Ÿ�Ը� [:=[DEFAULT] ��][,]
                    :
    ������ [���] Ÿ�Ը� [:=[DEFAULT] ��])    
    ** RETURN Ÿ�Ը� ** 
    AS | IS
     �����;
    BEGIN
     �����;
     RETURN EXPR; --�ݵ�� ������ �ϳ��̻� �����ؾ���!
     [EXCEPTION
       ����ó����;
     ]
    END;
                    
                    
    ��뿹) �ŷ�ó�ڵ带 �Է¹޾� �ش� �ŷ�ó���� ��ǰ�ϴ� ��ǰ������ ��ȸ�Ͻÿ�(�Լ����)
        
        ALIAS�� �ŷ�ó�ڵ�,�ŷ�ó��,��ǰ�ڵ�,��ǰ��,���Դܰ� (�Լ����)
        CREATE OR REPLACE FUNCTION FN_PROD_INFO(
          P_BID IN BUYER.BUYER_ID%TYPE)
          RETURN VARCHAR2
        IS
          V_RES VARCHAR2(100);
        BEGIN
          SELECT PROD_ID||' '||RPAD(PROD_NAME,20)||
                 LPAD(PROD_COST,8,' ')
        INTO V_RES
        FROM PROD
        WHERE PROD_BUYER =  P_BID
              AND ROWNUM = 1;
        RETURN V_RES;
         EXCEPTION 
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('�����߻�'||SQLERRM);
            RETURN NULL;
        END;
        
        (����)
      SELECT BUYER_ID ,BUYER_NAME,FN_PROD_INFO(BUYER_ID)
          FROM BUYER;
          
       (��뿹)ȸ����ȣ�� �Է¹޾� ȸ������ ����ϴ� �Լ� �ۼ�
        SELECT MEM_ID, MEM_NAME 
        FROM MEMBER ;
        
        CREATE OR REPLACE FUNCTION FN_MEM_NAME(
        P_MID IN MEMBER.MEM_ID%TYPE)
        RETURN MEMBER.MEM_NAME%TYPE
        IS
          V_NAME MEMBER.MEM_NAME%TYPE;
        BEGIN
          SELECT MEM_NAME INTO V_NAME
          FROM MEMBER
          WHERE MEM_ID = P_MID;
          RETURN V_NAME;
        END;
        
    (����)
    SELECT MEM_ID AS ȸ����ȣ, --���� ���� A001 �о�! 
    FN_MEM_NAME(MEM_ID) AS ȸ����--�Լ� ȣ��(�Լ��� �ݺ��ؼ� ó���ؾ��� ��� ���๮���� �ݺ�ó����)
    FROM MEMBER;
    
    
    ��뿹)�Ⱓ(��,��)�� �Է� �޾� **��ǰ��** ����ݾ����踦 ��ȸ�Ͻÿ�
    
    CREATE OR REPLACE FUNCTION FN_SUM_CART(
      P_PERIOD IN VARCHAR2,
      P_PID PROD.PROD_ID%TYPE)--���� ũ�� ���� ��
    RETURN NUMBER  --����ݾ�����ϱ�
    AS 
    V_PERIOD CHAR(7) := P_PERIOD||' '||'%';
    V_SUM NUMBER :=0; --��ǰ�� ����ݾ�����
    BEGIN
    SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM
       FROM CART A , PROD B
    WHERE A.CART_PROD = P_PID --�Ѱܹ��� ��ǰ�ڵ�� ���ƾ���
      AND A.CART_PROD = B.PROD_ID --����
      AND A.CART_NO LIKE V_PERIOD;
    RETURN V_SUM;
    
    EXCEPTION WHEN OTHERS THEN  --���� �߻��Ǹ�
    DBMS_OUTPUT.PUT_LINE('���ܹ߻�:'||SQLERRM);
    RETURN NULL;
    END;
    
    ����)
    SELECT PROD_ID AS ��ǰ�ڵ�,
          NVL(FN_SUM_CART('200505',PROD_ID),0) AS ���������
        FROM PROD
        ORDER BY 1;
        
    ����)
    
    ACCEPT P_PERIOD PROMPT '�Ⱓ�Է�(��/��)'
    DECLARE
   
    V_AMT NUMBER:=0;--�� ��ǰ�� �Ǹűݾ��� ������ ��
    V_RES VARCHAR2(100); 
    CURSOR CUR_PROD01 
    IS
        SELECT PROD_ID,PROD_NAME FROM PROD; --74���� ��ǰ�ڵ�, ��ǰ�� 
    BEGIN
    FOR REC IN CUR_PROD01 LOOP
     V_AMT := NVL(FN_SUM_CART('&P_PERIOD',REC.PROD_ID),0);
     V_RES := REC.PROD_ID||' '||RPAD(REC.PROD_NAME,25,' ')||LPAD(V_AMT,9,' ');
     DBMS_OUTPUT.PUT_LINE(V_RES);
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    END LOOP;
    END;     
          
     ��뿹) �����ȣ�� �Է¹޾� �ش� ����� ���� �μ���� �ּҸ� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
     
     CREATE OR REPLACE FUNCTION FN_EMP_ADDR(
     P_EID  IN  HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
     RETURN VARCHAR2
     IS
     V_RES VARCHAR2(200); --�μ���
     V_ADDR VARCHAR2(100);
     BEGIN
      SELECT A.DEPARTMENT_NAME, 
             'ZIP CODE : '||B.POSTAL_CODE||
             ' '||STREET_ADDRESS||', '||CITY||
             ' '||STATE_PROVINCE
             INTO V_RES, V_ADDR
            FROM HR.DEPARTMENTS A, HR.LOCATIONS B , HR.EMPLOYEES C
      WHERE C.EMPLOYEE_ID = P_EID
           AND C.DEPARTMENT_ID =A.DEPARTMENT_ID --�μ��� ��������
           AND A.LOCATION_ID = B.LOCATION_ID; --�ּ� ��������
           V_RES := V_RES||'  '||V_ADDR;
    RETURN V_RES;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('���ܹ߻� :'||SQLERRM); --���ܰ� �߻����� �ʾ��� ���� V_RES�� ��ȯ!���� �߻��� '���ܹ߻�'
      RETURN NULL;
     END;
     
     ����)
     SELECT EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            FN_EMP_ADDR(EMPLOYEE_ID) AS "�μ��� �� �ּ�" --�Ű������� EMPLOYEE_ID
        FROM HR.EMPLOYEES;
        
    ��뿹)�⵵�� �Է¹޾� �ش�⵵�� ��ǰ�� ���Լ����հ�� ���Աݾ��հ踦 ���ϴ� �Լ����� ����� 
    ���Աݾ� ���� ����5���� �������踦 ����Ͻÿ�.
    ALIAS�� ��ǰ�ڵ�, ��ǰ��,���Լ���,���Աݾ�
    

                 
         --�⵵ �Է¹ް� ���Լ��� �����Լ�
         CREATE OR REPLACE FUNCTION FN_AMT_BUYQTY(
        P_YEAR CHAR, P_PID PROD.PROD_ID%TYPE)
         RETURN NUMBER
         IS
         V_SQTY NUMBER :=0;

         BEGIN
         SELECT SUM(BUY_QTY) INTO V_SQTY
         FROM BUYPROD
         WHERE EXTRACT(YEAR FROM BUY_DATE)= P_YEAR
               AND BUY_PROD = P_PID;
        RETURN V_SQTY;
        END;
        
        --�ݾ� �����Լ�
         CREATE OR REPLACE FUNCTION FN_SUM_BUYAMT(
        P_YEAR CHAR, P_PID PROD.PROD_ID%TYPE)
         RETURN NUMBER
         IS
         V_SAMT NUMBER :=0;
         BEGIN
         SELECT SUM(BUY_QTY*BUY_COST) INTO V_SAMT
         FROM BUYPROD
         WHERE EXTRACT(YEAR FROM BUY_DATE)= P_YEAR
             AND BUY_PROD = P_PID;
        RETURN V_SAMT;
        END;
        
        ����)
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            A.FAB AS ���Լ���,
            TO_CHAR(A.FSB,'99,999,999') AS ���Աݾ�
        FROM (SELECT PROD_ID, PROD_NAME,
                    FN_AMT_BUYQTY('2005',PROD_ID) AS FAB,
                    FN_SUM_BUYAMT('2005',PROD_ID) AS FSB
                    FROM PROD
                    ORDER BY 3 DESC) A
        WHERE ROWNUM <=5;
        
        
        
     
    

          