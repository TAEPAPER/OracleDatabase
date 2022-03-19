SELECT * FROM MEMBER WHERE SUBSTR(MEM_REGNO2,1,1) = '2';
SELECT MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS ���� 
FROM MEMBER
WHERE SUBSTR(MEM_REGNO2,1,1) = '2';

SELECT EMPLOYEE_ID AS �����ȣ,FIRST_NAME||' '||LAST_NAME AS ����̸� ,
        SALARY AS �⺻�� , NVL(SALARY*COMMISSION_PCT,0) AS ���ʽ� , SALARY+SALARY*COMMISSION_PCT AS ���޾�
FROM EMPLOYEES;

SELECT MEM_ID , MEM_NAME,MEM_MILEAGE,MEM_JOB
FROM MEMBER
WHERE MEM_MILEAGE >= 3000
ORDER BY MEM_MILEAGE DESC;

SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,MEM_JOB,
       CASE WHEN SUBSTR(MEM_BIR,1,1) = '1' THEN '����ȸ��'
       ELSE '����ȸ��' END AS ����
 FROM MEMBER
 WHERE MEM_MILEAGE >=3000 AND MEM_ADD1 LIKE '����%';

SELECT EMPLOYEE_ID,FIRST_NAME||' '||LAST_NAME AS �̸�,DEPARTMENT_ID,SALARY
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (20,50,90,110);

SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
FROM MEMBER
WHERE MEM_MILEAGE >= ANY(SELECT MEM_MILEAGE FROM MEMBER WHERE MEM_JOB ='������');

SELECT PROD_ID, PROD_NAME, PROD_LGU,PROD_PRICE
FROM PROD
WHERE PROD_PRICE BETWEEN 100000 AND 200000;


��뿹)��ٱ������̺�(CART)���� 2005�� 7���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�         
ALIAS�� ��¥,��ǰ�ڵ�,�Ǹż����̴�.

SELECT SUBSTR(CART_NO,1,8) AS ��¥, CART_PROD, CART_QTY
FROM CART
WHERE  CART_NO LIKE '200507%';

��뿹)�������̺�(BUYPROD)���� 2005�� 2���� ���Ե� ��ǰ�� ��ȸ�Ͻÿ�         
ALIAS�� ��¥,��ǰ�ڵ�,���Լ���,���Աݾ��̴�.
SELECT BUY_DATE , BUY_PROD, BUY_QTY, BUY_QTY*BUY_COST AS ���Աݾ�
FROM  BUYPROD
WHERE BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201');

��뿹) HR ������ ������̺�(EMPLOYEES)���� 2006�� ���� �� �Ի��� ��������� ��ȸ�Ͻÿ�
��, ����� �Ի��� ������ ����� ��!
**����̸��� ���� ���ο� Į���� ����

ALTER TABLE HR.EMPLOYEES ADD (EMP_NAME VARCHAR2(50));
UPDATE HR.EMPLOYEES
    SET EMP_NAME = FIRST_NAME||' '||LAST_NAME;
COMMIT; 

ALIAS�� �����ȣ, �����, �Ի���,�μ��ڵ�
SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE , DEPARTMENT_ID
FROM HR.EMPLOYEES
WHERE EXTRACT(YEAR FROM HIRE_DATE) < 2007
ORDER BY 3;

��뿹)ȸ�����̺�(MEMBER)���� '��'��~'��'�� ���� ���� ȸ�� �� ���ϸ����� 2000�̻��� ȸ���� ��ȸ�Ͻÿ�
 ALIAS�� ȸ����ȣ,ȸ����,�ּ�,���ϸ��� ��,���������� ����Ͻÿ�

SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2 AS �ּ�, MEM_MILEAGE 
FROM MEMBER
WHERE MEM_MILEAGE >=2000
      AND SUBSTR(MEM_NAME,1,1) BETWEEN '��' AND '��'
ORDER BY MEM_NAME;

��뿹)��ٱ������̺�(CART)���� 2005�� 7���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�        (LIKE �����ڸ� ������) 
ALIAS�� ��¥,��ǰ�ڵ�,�Ǹż����̴�. 
SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥ , CART_PROD , CART_QTY
FROM CART
WHERE CART_NO LIKE '200507%';

ȸ�����̺��� �������� '�泲'�� ȸ���� ��ȸ�Ͻÿ�
ALIAS�� ȸ����ȣ, ȸ����, �ּ�,����,���ϸ���
SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2 AS �ּ�, MEM_JOB,
        MEM_MILEAGE
FROM MEMBER
--WHERE MEM_ADD1||' '||MEM_ADD2 LIKE '�泲%' OR
   --     MEM_ADD1||' '||MEM_ADD2 LIKE '����%';
WHERE SUBSTR(MEM_ADD1,1,2) IN ('�泲','����');

��뿹)2005�� 4�� ���Ի�ǰ�� �Ǹ������� ��ȸ�Ͻÿ�
 ALIAS�� ��ǰ�ڵ�,��ǰ��,�����հ�,�ݾ��հ� 

SELECT A.BUY_PROD, B.PROD_NAME, SUM(A.BUY_QTY) AS �����հ�, SUM(A.BUY_QTY*BUY_COST) AS �ݾ��հ�
FROM BUYPROD A, PROD B
WHERE 
        A.BUY_PROD = B.PROD_ID
       AND  BUY_DATE BETWEEN '20050401' AND LAST_DAY('20050401')
GROUP BY A.BUY_PROD, B.PROD_NAME
ORDER BY 1;

��ǰ���̺��� �з��ڵ尡 'p102'�� ���� ��ǰ�� ��ȸ�Ͻÿ�
ALIAS�� ��ǰ�ڵ�,��ǰ��,���԰���,���Ⱑ��
SELECT PROD_ID, PROD_NAME, PROD_COST, PROD_COST
FROM PROD
WHERE LOWER(PROD_ID) LIKE 'p102%';

��뿹) ������̺��� FIRST_NAME�� LAST_NAME�� �����ϵ� �߰��� ������ �����ϰ� 
�ܾ� ù���ڸ� �빮�ڷ� ��ȯ�Ͽ� ����Ͻÿ�.
SELECT  
CONCAT(CONCAT(INITCAB(FIST_NAME),' '),INITCAB(LAST_NAME)) AS ����
FROM HR.EMPLOYEES;

--[2022-01-11-01]
��ǰ ���̺��� ��ǰ���� ����ϵ� ���� ���� ������ '*'�� ä�� ����Ͻÿ�
SELECT RPAD(PROD_NAME,40,'*')
FROM PROD;

ȸ�����̺��� 20�������� ȸ�������� ��ȸ�Ͻÿ�
ALIAS�� ȸ����ȣ, ȸ����,����,����,���ϸ���
�������� '����ȸ��' ,'����ȸ��' �� �ϳ� ���
���̴� �ֹι�ȣ�� �̿��Ͽ� ���Ͻÿ�

SELECT MEM_ID, MEM_NAME, 
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' THEN '����ȸ��' 
       ELSE '����ȸ��'
       END AS ����,
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,
       MEM_MILEAGE
FROM MEMBER
WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)  <30;

--[2022-01-11-02]

  ȸ�����̺��� �� ȸ������ ���ϸ����� �Է¹޾� ���ϸ����� 1000~9000���̸� 9�� �������� ������ �� 
               �� ���� ��������� ���ϴ��� �Ǻ��Ͻÿ�

  ALIAS�� ȸ����ȣ,ȸ����,���ϸ���,������
  SELECT MEM_ID, MEM_NAME, MEM_MILEAGE, WIDTH_BUCKET(MEM_MILEAGE, 1000,9000,9) AS ������
  FROM MEMBER;
  
  ��뿹) ȸ�����̺��� �� ȸ������ ���ϸ����� �Է¹޾� ���ϸ����� 1000~9000���̸� 9�� �������� ������ �� 
               �� ���� ��������� ���ϴ��� �Ǻ��Ͽ� ����� ��Ÿ���ÿ�. ��, ���� ���� ���ϸ��� ������ �ִ� ȸ���� 1�����    
               ALIAS�� ȸ����ȣ,ȸ����,���ϸ���,���
 SELECT MEM_ID AS ȸ����ȣ,
                     MEM_NAME AS  ȸ����,
                     MEM_MILEAGE AS ���ϸ���,
                  -- 10- WIDTH_BUCKET(MEM_MILEAGE,1000,9000,9) AS ������    �� ��� �̰ų� �ؿ� ���
                  WIDTH_BUCKET(MEM_MILEAGE,9000,1000,9) AS ������  
              FROM MEMBER;
     ��뿹)������̺��� ������� �޿��� 
                2000-5000���̿� ���ϸ� '���ӱ� ���'
                5001-10000���̿� ���ϸ� '����ӱ� ���'
                10001-20000  ���̿� ���ϸ� '���ӱ� ���'
                �� ����� ���
                alias�� �����ȣ,�����,�μ��ڵ�,�޿�         
      
      SELECT EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY,
        CASE WHEN SALARY BETWEEN 2000 AND 5000 THEN '���ӱݻ��'
             WHEN SALARY BETWEEN 5001 AND 10000 THEN '��ջ��'
             WHEN SALARY BETWEEN 10001 AND 20000 THEN '���ӱݻ��'
             END AS �޿�����
      FROM HR.EMPLOYEES;
      
--[2022-01-12-01]
�������̺�(BUYPROD)���� 2005�� 2�� ���ں� �������踦 ��ȸ�Ͻÿ�
ALIAS�� ����, �����հ� ���Աݾ��հ�
SELECT BUY_DATE, 
        SUM(BUY_QTY) AS �����հ� , 
        SUM(BUY_COST*BUY_QTY) AS ���Աݾ��հ�
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
GROUP BY BUY_DATE;
 
 ��뿹) ȸ�����̺��� ������ ���ϰ� �� ��ɴ뺰 ȸ������ ��ȸ�Ͻÿ�
    ALIAS�� ���ɴ�, ȸ����
    SELECT  
    SUBSTR(TO_CHAR(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)),1,1)||'0��' AS ���ɴ�,
    COUNT(SUBSTR(TO_CHAR(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)),1,1)) AS ȸ����
    FROM MEMBER
    GROUP BY  SUBSTR(TO_CHAR(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)),1,1)||'0��'
    ORDER BY 1;
     
     --[2022-01-13-01]
      ��뿹) ��ٱ������̺��� 2005�� 5�� �Ǹ������� ��ȸ�Ͻÿ�                                                          --�α��� �Ǿ��� ����                      
    ALIAS�� ����, ��ǰ��, ���� , �ݾ� �̸� ���ڼ����� ����Ͻÿ�
    
    SELECT CAST(SUBSTR(A.CART_NO,1,8) AS DATE) AS ���� ,
            B.PROD_NAME , A.CART_QTY AS ���� , A.CART_QTY*B.PROD_PRICE AS �ݾ�
    FROM CART A ,PROD B 
    WHERE   A.CART_PROD = B.PROD_ID             --���������� ���������!!
            AND A.CART_NO LIKE '200505%';

 ��뿹) ������ 2005�� 7�� 31���̰� ���θ� �������� ó�� �α����� ���  ��ٱ��Ϲ�ȣ�� �����Ͻÿ�
   SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
                 TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000')) --��ȿ�� 0�� �߰���Ű�� ����'00000'! 
            FROM CART
           WHERE SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE,'YYYYMMDD');
           
     ��뿹)��ǰ���̺�(GOODS)�� �����ڷḦ �߰��� ����Ͻÿ�
    ��ǰ�ڵ� 
    
     ��ǰ�� : �Ｚ ��Ʈ�� 15��ġ 
     �ŷ�ó �ڵ� : P101
     �ǸŰ��� : 1200000��
     
      (��ǰ�ڵ� ����)
     SELECT 'P101'||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS CODE
     FROM GOODS
     WHERE PROD_LGU = 'P101';
    
    (�߰����)
    INSERT INTO GOODS
     SELECT A.P_CODE, '���øƺ�����13��ġ��Ƽ��','P101',460000 
     FROM( 
     SELECT 'P101'||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS P_CODE
     FROM GOODS
     WHERE PROD_LGU = 'P101'
     )A;
     
     SELECT * FROM GOODS;
        
    SELECT MEM_ID, MEM_NAME,
            CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                 SUBSTR(MEM_REGNO2,1,1) ='2' THEN
                 TO_CHAR(TO_DATE('19'||MEM_REGNO1),'YYYY"��" MM"��" DD"��"')
            ELSE 
                 TO_CHAR(TO_DATE('20'||MEM_REGNO1),'YYYY"��" MM"��" DD"��"')
            END AS �������,
            MEM_JOB,MEM_MILEAGE
    FROM MEMBER;
    
               

