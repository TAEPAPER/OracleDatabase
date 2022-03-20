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
    
    --[2022-01-13-02] 
    
    ��뿹) ������̺��� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ� ����� ��ȸ�Ͻÿ�.
    ALIAS �� �����ȣ, �����,�μ��ڵ�,���������ڵ�
SELECT EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID,COMMISSION_PCT
FROM HR.EMPLOYESS
WHERE COMMISSION_PCT IS NOT NULL;

��뿹)��ǰ���̺��� ��������(PROD_COLOR)�� �ڷᰡ �������� �ʴ�
            ������ ��ȸ�Ͻÿ�
 ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ��������
SELECT PROD_ID, PROD_NAME, PROD_COST, PROD_COLOR
FROM PROD
WHERE PROD_COLOR IS NOT NULL;

 ��뿹) 2005�� 6�� **���** ��ǰ�� ���� ��ǰ�� ������Ȳ�� ��ȸ
        ALIAS�� ��ǰ��, ���� �������� , ���Աݾ����� --�ܺ� ���� (�ƿ��� ����)

        (2005�� 6�� ���� ��ǰ)
        SELECT DISTINCT BUY_PROD
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050601') AND
           LAST_DAY(TO_DATE('20050601'))
           ORDER BY 1; 
          
           (�ƿ������� ���)
    SELECT B.PROD_NAME, NVL(SUM(A.BUY_QTY),0) AS ���Լ�������, NVL(SUM(A.BUY_QTY*B.PROD_COST),0) AS ���Աݾ�����
    FROM BUYPROD A 
         LEFT OUTER JOIN PROD B ON (A.BUY_PROD = B.PROD_ID)
         AND A.BUY_DATE BETWEEN TO_DATE('20050601') AND
           LAST_DAY(TO_DATE('20050601'))
    GROUP BY B.PROD_NAME;
    
    --[2022-01-14-01]
��뿹)������̺��� �� �μ�**'��'**('�׷����'��� ��) �޿��հ踦 ���ϵ� �޿��հ谡 100000�̻��� �μ��� ��ȸ�Ͻÿ� --�׷�ȿ� �׷�
        ALIAS�� �μ��ڵ�, �޿��հ�
   SELECT  DEPARTMENT_ID AS �μ��ڵ�, SUM(SALARY) AS �޿��հ�
   FROM HR.EMPLOYEES 
   GROUP BY DEPARTMENT_ID
   HAVING SUM(SALARY)>= 10000
   ORDERY BY 1;
   
  ��뿹) ������̺��� �� �μ���**GROUP BY ����� ��!! ��ձ޿��� ���Ͻÿ�
        alias�� �μ��ڵ�, �μ���, ��ձ޿�
        --�̳� ����?
    SELECT  B.DEPARTMENT_ID , B.DEPARTMENT_NAME, ROUND(AVG(A.SALARY)) AS ��ձ޿�
    FROM HR.EMPLOYEES A , HR.DEPARTMENTS B 
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
    GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1;
    
    ��뿹)��ǰ���̺��� �з��� ��� ���԰��� ��ȸ�Ͻÿ�
    �˸��ƽ��� ��ǰ�з�, ��ո��԰�
    SELECT PROD_LGU , ROUND(AVG(PROD_COST),0)
    FROM PROD
    GROUP BY PROD_LGU 
    ORDER BY 1;
    
     ����) ��ٱ������̺��� 2005�� 4�� **��ǰ��** �Ǹż������踦 ���Ͻÿ�
     
     SELECT CART_PROD, SUM(CART_QTY)
     FROM CART
     WHERE CART_NO LIKE '200504%'
     GROUP BY CART_PROD
     ORDER BY 1;

����)��ٱ������̺��� 2005�� 4�� **��ǰ��** �Ǹ� �����հ谡 10�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�      
  SELECT CART_PROD ,SUM(CART_QTY)
  FROM CART
  WHERE CART_NO LIKE '200504%'
  GROUP BY CART_PROD
  HAVING SUM(CART_QTY) >=10
  ORDER BY 1;
 
 ����) �������̺��� 2005�� 1�� ~6�� ���� �������踦 ���Ͻÿ�
 SELECT  EXTRACT(MONTH FROM BUY_DATE) AS �� , SUM(BUY_QTY)
 FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050601'))
 GROUP BY EXTRACT(MONTH FROM BUY_DATE) 
 ORDER BY 1;

����)�������̺��� 2005�� 1~6�� ����, ��ǰ�� ���Աݾ� �հ谡 1000���� �̻��� ������ ��ȸ�Ͻÿ� 
ALIAS�� ���Կ�, ��ǰ�ڵ�, ��������
SELECT EXTRACT(MONTH FROM BUY_DATE) AS ���Կ�, BUY_PROD AS ��ǰ��, SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
FROM BUYPROD 
WHERE   BUY_DATE  BETWEEN ('20050101') AND ('20050701')
GROUP BY EXTRACT(MONTH FROM BUY_DATE),BUY_PROD
HAVING SUM(BUY_QTY*BUY_COST) >= 10000000
ORDER BY 1;
         
    ����)ȸ�����̺��� ���� ���ϸ��� �հ踦 ���Ͻÿ�
 ALIAS�� ����,���ϸ��� �հ��̸�, ���п��� '����ȸ��'�� '����ȸ��'�� ����Ͻÿ�  
SELECT  
      CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                SUBSTR(MEM_REGNO2,1,1) = '3'      
                                 THEN  '����ȸ��' ELSE '����ȸ��' 
                                 END AS ����,
     SUM(MEM_MILEAGE) AS ���ϸ����հ�
FROM MEMBER
GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                SUBSTR(MEM_REGNO2,1,1) = '3'      
                                 THEN  '����ȸ��' ELSE '����ȸ��' 
                                 END
ORDER BY 1;

����) ȸ�����̺��� **���ɴ뺰** �ش� ���ɴ��� ���ϸ��� �հ踦 ��ȸ�Ͻÿ�
        ALIAS�� ����, ���ϸ��� �հ��̸� ���г����� '10��',..;'70'�� ������ ���ɴ븦 ���

SELECT  CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                  SUBSTR(MEM_REGNO2,1,1) = '2' THEN
         TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
              (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900),-1)                 ELSE
         ELSE
         TRUNC(EXTRACT(YEAR FROM SYSDATE) -
              (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000),-1)
                  END ||'��'  AS ����,
          SUM(MEM_MILEAGE) AS ���ϸ����հ�
  FROM MEMBER
  GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                  SUBSTR(MEM_REGNO2,1,1) = '2' 
                  THEN
         TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
               (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900),-1)                 ELSE
         ELSE
         TRUNC(EXTRACT(YEAR FROM SYSDATE) -
           (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000),-1)
                  END ||'��'
  GROUP BY 1;

  ��뿹) ��ü����� ��ձ޿��� ���  --��ü�� �׷��̴ϱ� GROUP BY�� �Ƚ�  
ALIAS�� ��ձ޿�, �޿��հ�, �����
SELECT  AVG(SALARY), SUM(SALARY), COUNT(*)
FROM HR.EMPLOYEES ;

��뿹) ������� �޿��� ��ձ޿����� ������� ������ ��ȸ
    ALIAS�� �����ȣ(GROUP BY �ǹ̾���) ,�����, �μ��ڵ�,�����ڵ�,�޿�,��ձ޿�

----WHERE������ �����Լ��� �� �� ����!!!
SELECT A.EMPLOYEE_ID , A.EMP_NAME, A.DEPARTMENT_ID, A.JOB_ID, B.ASAL 
FROM  HR.EMPLOYEES A , (SELECT AVG(SALARY) AS ASAL FROM HR.EMPLOYEES )B
WHERE SALARY < B.ASAL

--[2022-0117-01] 
��뿹) ��ǰ���̺��� ��ǰ�з��� ����ǸŰ�,��ո��԰��� ��ȸ�Ͻÿ�
SELECT PROD_LGU AS ��ǰ�з�, ROUND(AVG(PROD_PRICE)) AS ����ǸŰ� , ROUND(AVG(PROD_COST)) AS ��ո��԰�
FROM PROD
GROUP BY PROD_LGU
ORDER BY 1;
   
   ��뿹) ������̺��� **�ٹ����� �̱� �̿��� �μ��� �ٹ��ϴ� �����**�� ��ձ޿��� ��ձټӳ���� ���Ͻÿ� 
   
   