2022-01-10-01)
--like �����ڴ� ���ڿ��� ���� ��¥�� between
(3)BETWEEN ������
-������ �����Ͽ� �����͸� ���� �� ��� --���ڵ� ��¥�� ���ڵ� �� �������(����� ��� ������ Ÿ��)
-AND �����ڷ� ��ȯ ����

(�������)
�÷�|���� BETWEEN  ��1 AND ��2 --�̾ȿ� ���� ���̸�~

��뿹)��ǰ���̺�(PROD)���� �ǸŰ���(PROD_PRICE)�� 10����
    ���� 20���� ���̿� ���� ��ǰ������ ��ȸ�Ͻÿ�
ALIAS�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�,�ǸŰ����̴�.

(AND ������ ���)
SELECT PROD_ID AS ��ǰ�ڵ�, 
PROD_NAME AS ��ǰ��,
PROD_LGU AS �з��ڵ�,
PROD_PRICE AS �ǸŰ���
FROM PROD
WHERE PROD_PRICE>=100000 AND PROD_PRICE <= 200000 --���ǽ��� ���ε��� �ϼ��� �������

(BETWEEN ������ ���)
SELECT PROD_ID AS ��ǰ�ڵ�, 
PROD_NAME AS ��ǰ��,
PROD_LGU AS �з��ڵ�,
PROD_PRICE AS �ǸŰ���
FROM PROD
WHERE PROD_PRICE BETWEEN 100000 AND PROD_PRICE 200000; 

��뿹)��ٱ������̺�(CART)���� 2005�� 7���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�         
ALIAS�� ��¥,��ǰ�ڵ�,�Ǹż����̴�.
SELECT SUBSTR(CART_NO,1,8) AS ��¥,
CART_PROD AS ��ǰ�ڵ�,
CART_QTY AS �Ǹż���
FROM CART
WHERE SUBSTR(CART_NO,1,6) = '200507';  --���ڿ����� ��������ϱ� ������ ���ڿ�
--CHAR MEMBER(8�ڸ� ��¥���� 5�ڸ� ��������)= 13�ڸ��� ���ڿ�
--īƮ �ѹ� : ��¥ ���ϱ� ����
--��ǰ�ڵ�
--��ǰ���ż���
��뿹)�������̺�(BUYPROD)���� 2005�� 2���� ���Ե� ��ǰ�� ��ȸ�Ͻÿ�         
ALIAS�� ��¥,��ǰ�ڵ�,���Լ���,���Աݾ��̴�.

SELECT BUY_DATE AS ��¥,
BUY_PROD AS ��ǰ�ڵ�,
BUY_QTY AS ���Լ���,
BUY_QTY *BUY_COST AS ���Աݾ�  --���� ���ϱ� ���� �ܰ�
FROM BUYPROD  
WHERE BUY_DATE BETWEEN '20050201' AND '20050228'; --BUY_DATE �� ��¥ Ÿ���̴ϱ� ''���� ������ �ڵ����� ��¥Ÿ������ �ٲ��!
                                        --AND LAST_DAY('20050201') ���ָ� �� ���� �� ������ ��¥�� ��ȯ����!-100%Ȯ��X!
                                        --Ÿ�Կ� �´� ���� ������!
                                        
SELECT LAST_DAY('20050201') FROM DUAL;          


��뿹) HR ������ ������̺�(EMPLOYEES)���� 2006�� ���� �� �Ի��� ��������� ��ȸ�Ͻÿ�
��, ����� �Ի��� ������ ����� ��!
**����̸��� ���� ���ο� Į���� ����
    �÷��� : EMP_NAME VARCHAR2(50) FIRST_NAME ,' ',LAST_NAME ����
ALTER TABLE HR.EMPLOYEES ADD (EMP_NAME VARCHAR2(50));
UPDATE HR.EMPLOYEES
    SET EMP_NAME = FIRST_NAME||' '||LAST_NAME;
COMMIT; 

ALIAS�� �����ȣ, �����, �Ի���,�μ��ڵ�
SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       HIRE_DATE AS �Ի���,
       DEPARTMENT_ID AS �μ��ڵ�
  FROM HR.EMPLOYEES --�ٸ� �����̴ϱ� .������ ǥ���������!
 WHERE HIRE_DATE <'20060101' --HIRE DATE�� ��¥ Ÿ��! �׷��� SUBSTR �� �� ����! Ư�����ڴ� /�� - �� ���ȴ� (������ �����ڸ� �Ⱦ���)
 ORDER BY 3;        
 
 ��뿹)ȸ�����̺�(MEMBER)���� '��'��~'��'�� ���� ���� ȸ�� �� ���ϸ����� 2000�̻��� ȸ���� ��ȸ�Ͻÿ�
 ALIAS�� ȸ����ȣ,ȸ����,�ּ�,���ϸ��� ��,���������� ����Ͻÿ�
 
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
        MEM_MILEAGE AS ���ϸ���
 FROM   MEMBER
 WHERE  MEM_MILEAGE>=2000
        AND SUBSTR(MEM_NAME,1,1) BETWEEN '��' AND '��'  --������ ������ �Ǿ����   
 ORDER BY  2;
 
    (4)LIKE ������ ----****���ڿ� ������**** ��¥�� ���� �� �Ұ�!! 
    -���ڿ��� ������ ���� �� ���
    -���Ϲ��ڿ�(����Ʈ ī��): %,_ ���
    -'%':'%'�� ���� ��ġ���� �ڿ� �����ϴ� ��� ���ڿ��� ����
    EX) 
         '��%': '��'���� �����ϴ� ��� ���ڿ��� ����
        '%��' : '��'���� ������ ��� ���ڿ��� ����
        '%��%': ���ڿ� ���ο� '��'�̶�� ���ڿ��� ������ ����� ��(TRUE)
        
    '_' : '_'�� ���� ��ġ���� �ѱ��ڿ� ����
   EX)     
        '��_' : '��'���� �����ϰ� 2������ ���ڿ��� ����
        '_��' : 2���ڷ� �����ǰ� '��'���� ������ ��� ���ڿ��� ����       
        '_��_' :3�����̸鼭 �߰��� ���ڰ� '��'�� ���ڿ��� ����
        
��뿹)��ٱ������̺�(CART)���� 2005�� 7���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�        (LIKE �����ڸ� ������) 
ALIAS�� ��¥,��ǰ�ڵ�,�Ǹż����̴�. 
 --MEMEBER ����ȸ�� ��ȣ
 --NO ��¥ +  ==���ڿ�
 --PROD  ��ǰ�ڵ�
 SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥,
 CART_PROD AS ��ǰ�ڵ�,
 CART_QTY AS �Ǹż���
 FROM CART
 WHERE CART_NO LIKE '200507%'; 
--�Լ��� �Լ��� �����ϴ� !

��뿹)
ȸ�����̺��� �������� '�泲'�� ȸ���� ��ȸ�Ͻÿ�
ALIAS�� ȸ����ȣ, ȸ����, �ּ�,����,���ϸ���
SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
       MEM_JOB AS ����,
        MEM_MILEAGE AS ���ϸ���
FROM MEMBER
WHERE MEM_ADD1 LIKE '�泲%';


ȸ�����̺��� �������� '�泲'�̰ų� '����'�� ȸ���� ��ȸ�Ͻÿ�
ALIAS�� ȸ����ȣ, ȸ����, �ּ�,����,���ϸ���
SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
       MEM_JOB AS ����,
       MEM_MILEAGE AS ���ϸ���
FROM MEMBER
--WHERE MEM_ADD1 LIKE '�泲%' 
--OR MEM_ADD1 LIKE '����%'   ---���� ����� �ƴϾ� (�ð��� ���� �ɷ�)
WHERE SUBSTR(MEM_ADD1,1,2) IN ('�泲','����');

��뿹)2005�� 4�� ���Ի�ǰ�� �Ǹ������� ��ȸ�Ͻÿ�
 ALIAS�� ��ǰ�ڵ�,��ǰ��,�����հ�,�ݾ��հ� 
 SELECT A.BUY_PROD AS ��ǰ�ڵ�,
        B.PROD_NAME AS ��ǰ��,
        SUM(A.BUY_QTY) AS �����հ�,
SUM(A.BUY_QTY*B.PROD_COST) AS �ݾ��հ� 
 FROM BUYPROD A, PROD B --���̺� ��Ī �ο�
 WHERE A.BUY_PROD=B.PROD_ID --�̰��� �����̶�� �Ѵ� -������ �����ͺ��̽� --��������
       -- AND A.BUY_DATE LIKE '200504%'--- ���� ��¥ �Լ��� LIKE�Լ� ���� ���ÿ�
 AND A.BUY_DATE BETWEEN '20050401' AND '20050430'
 GROUP BY A.BUY_PROD,B.PROD_NAME           
 ORDER BY 1;
 
 
 
 
 
 
 




    
 
 
 
 






