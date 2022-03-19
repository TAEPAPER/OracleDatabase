    2022-01-25-02) ����Ŭ ��ü
    -����Ŭ���� �����ϴ� OBJECT�� VIEW,INDEX,PROCEDURE,FUNCTION,PACKAGE,TRIGGER,SYNONYM,SEQUENCE,DIRECTORY,
    ���� ����
    -���� �� CREATE, ���Ž� DROP ��� ���
    
    1.VIEW--FROM ���� VIEW ���� �� ����!//���̺���� ���������� ����(���� �ʿ��� ������ �������̺� ������ ���� �� ���)
    -������ ���̺�
    -������ ���̺��̳� �並 ���Ͽ� ���ο� SELECT���� �����
     ���̺�ó�� ���
    -���̺�� ������
    -�ʿ��� ������ ���� ���̺� �л�� ��� 
    -���̺��� ��� �ڷῡ ���� ������ �����ϰ� �ʿ��� �ڷḸ�� �����ϴ� ���
    (�������)
    CREATE [OR REPLACE-] VIEW ���̸�[(�÷�LIST)] --1(�÷���)
    AS 
        SELECT �� --2--3   
        [WITH CHECK OPTION]--�信�� �ش������� �����ϴ� ������ �ٲ� �� ���� --������ ���
        [WITH READ ONLY]; --�б� ���� (������ �� ���ٴ� �̾߱�) ������ : �並 ��ġ�� ������ ���� //
                          --�ΰ��� ���ÿ� �� �� ����
                          
    ��뿹)ȸ�����̺��� ���ϸ����� 2000�̻��� ȸ���� ȸ����ȣ,�̸�,����,���ϸ����� ������ �並 �����Ͻÿ�
    
    CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
    AS
    SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS �̸�,
            MEM_JOB AS ����,
            MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000;
 ---------------------------------
    CREATE OR REPLACE VIEW V_MEM
    AS
    SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS �̸�,
            MEM_JOB AS ����,
            MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000;
 ----------------------------------
    CREATE OR REPLACE VIEW V_MEM
    AS
    SELECT MEM_ID,
            MEM_NAME,
            MEM_JOB,
            MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000; 
    SELECT * FROM V_MEM; --�並 ���̺�ó��
     
    ��뿹) ������ �� V_MEM���� 'r001'ȸ���� ���ϸ����� 500���� �����Ͻÿ�
    --�亯��
    
    UPDATE V_MEM
    SET MEM_MILEAGE = 500
    WHERE MEM_ID = 'r001';
    
    SELECT * FROM V_MEM;
    
    SELECT MEM_ID,MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_ID = 'r001';   --�並 �ٲٸ� �������̺� �ٲ��
   ------------------------------------ 
    
     CREATE OR REPLACE VIEW V_MEM
    AS
    SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS �̸�,
            MEM_JOB AS ����,
            MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000
   WITH CHECK OPTION; 
    
    ��뿹)�� V_MAX�� 'r001'ȸ���� ���ϸ����� 1500���� �����Ͻÿ�.
     UPDATE V_MEM
    SET ���ϸ��� = 1500
    WHERE ȸ����ȣ = 'r001';  --���� ���� �ؼ� ������Ʈ ���� �� �� ����!
    
    **ȸ�����̺��� 'n001' ȸ���� ���ϸ����� 2500���� �����Ͻÿ�
    UPDATE MEMBER
    SET MEM_MILEAGE = 2500
    WHERE MEM_ID = 'n001';
    
       **ȸ�����̺��� 'f001' ȸ���� ���ϸ����� 1500���� �����Ͻÿ�
    UPDATE MEMBER
    SET MEM_MILEAGE = 1500 --�������̺� ���ص� �������!
    WHERE MEM_ID = 'f001';
    
    SELECT * FROM V_MEM; --����Ǿ��� ���� �信 �ݿ�
    COMMIT;
   -------------------------------------------- 
    CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
    AS
    SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS �̸�,
            MEM_JOB AS ����,
            MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000
    WITH READ ONLY;
    
    **������ �� V_MEM�� ��� �ڷḦ �����Ͻÿ�
    DELETE FROM V_MEM;
    
    **VIEW ���� ������ ��
    (1) VIEW ������ WITH���� ����� ���������� �ο��� ��� ORDER BY�� ���Ұ�
    (2) VIEW ������ �����Լ��� ���� ���  �信 INSERT,UPDATE,DELETE�� ����� �� ����
    (3) VIEW �÷���  ǥ����(CASE~WHEN)�̳� �Լ��� ���� ��� �÷��߰� �Ǵ� ������ �Ұ�
    (4) Pseudo COLUMN(CURVAL, NEXTVAL�� ) ��� �Ұ�--������ ��ü���� �����Ǿ����� ��
    
    ��뿹)
        CREATE OR REPLACE VIEW V_CART
        AS
        SELECT CART_PROD AS CID,
               COUNT(*) AS CNT
        FROM CART
        WHERE CART_NO LIKE '200505%'
        GROUP BY CART_PROD
        ORDER BY 1;
        
        SELECT * FROM V_CART
        
        UPDATE V_CART  --�����Լ��� ���� ��� INSERT DELETE UPDATE�� ����� �� ����
        SET CNT = 10
        WHERE CID = 'P101000001' 
    
    ��뿹)
        CREATE OR REPLACE V_MEM02
        AS
        SELECT MEM_ID  AS MID,
               MEM_NAME AS MNAME,
               CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1'  OR 
                         SUBSTR(MEM_REGNO2,1,1) = '3' THEN
                         '����'
                ELSE  '����'
                END AS GUBUN
        FROM MEMBER;
        
SELECT * FROM V_MEM02;

        UPDATE V_MEM02
           SET GUBUN = '����ȸ��'
           WHERE GUBUN = '����';
        
    
    