2022-01-07-02) ������ �˻���� (SELECT)

** ��ü���� (DROP)
.���̺� ����
DROP TABLE ���̺��;

��뿹)���θ� ���̺�(BUYER,BUYPROD,CART,LPROD,PROD,MEMBER)�� ������ ��� ���̺����

DROP TABLE ORDER_GOODS;          --��Ʈ�� ���� (�ٽ���)
DROP TABLE ORDERS;
DROP TABLE CUSTOMERS;
DROP TABLE GOODS;

DROP TABLE TEMP_01;
DROP TABLE TEMP_02;
DROP TABLE TEMP_03;
DROP TABLE TEMP_04;

** HR����Ȱ��ȭ
1.HR������ �������
    ALTER USER HR ACCOUNT UNLOCK; 
    
2.HR���� ��ȣ����
    ALTER USER HR IDENTIFIED BY java; 
    
**������ �˻� ���
    -SELECT ���� ���� 
    -SQL��� �� ���� ���� ���Ǵ� ���
    (�������)
SELECT *|[DISTINCT]�÷��� [AS �÷���Ī] [,]   ---DISTINCT �� �ߺ������� ��~
    �÷��� [AS �÷���Ī] [,]
                .
                .
    �÷��� [AS �÷���Ī]]
    FROM ���̺��
    [WHERE ����     ---������ �� �����ϴ°� --�����Ǿ����� ��� ���� ����
     [AND ����,...]]
   [GROUP BY �÷��� [,�÷���,....]] ---Ư���÷��� ���� �𳢸� ����             
    [HAVING ����]--- GROUP BY���� ���� ���Ǿ���       
    [ORDER BY �÷���|�÷�index [ASC|DESC] [,  ---����ȭ ��Ű�� �� (���Ľ�Ű�� ��)--��������/��������
                  �÷���|�÷�index [ASC|DESC],,,,,]];
        
        ---SELECT ��== FROM WHERE SELECT ������ ����ȴ�--���!   
        
        'DISTINCT' : �ߺ�����
        'AS �÷���Ī' : �÷��� �ο��� �� �ٸ� �̸�. �÷��� ���� ���
        'AS �÷���Ī'�� Ư������(�����)�� ����� ���� ���Ե� ��� �ݵ�� ""�� �����־�� ��
        .Ư�� ���̺��� ���ų� ���ʿ��� ��� �ý����� �����ϴ� ����(DUMMY)���̺��� 
        DUAL�� ���
        
��뿹)ȸ�����̺�(MEMBER)���� ����ȸ������ ������ ��ȸ�Ͻÿ� ---����ȸ���̶�� �� ����
    Alias�� ȸ����ȣ, ȸ����, �ּ�, ����,���ϸ�����.
    
    SELECT  MEM_ID AS ȸ����ȣ, 
            MEM_NAME AS ȸ����, 
            MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
            EXTRACT(YEAR FROM SYSDATE)-      ---SYSDATE���� �⵵�� ����
            EXTRACT(YEAR FROM MEM_BIR) AS ����,       ----�����ؼ� ������ ������
            MEM_MILEAGE AS ���ϸ���    --����Ŭ������ ||�� �ص��̴�
        FROM MEMBER
        WHERE SUBSTR (MEM_REGNO2,1,1) = '2';          --ù��° ���ڿ��� 1���� ���� = �����̶��
        
 
 ��뿹) 26363630*24242 ���� ���
 SELECT 26363630*24242 FROM DUAL;  --CART���̺��� ���� ����� ���´�  �׷��� DUAL�� ���ش�
 
 SELECT SYSDATE FROM DUAL;
 
 1)������
 -���������(+,-,/,*)  --������ �����ڴ� ���� (�Լ��� ��������)
 -��(����)������(>,<,=,>=,<=,!=(<>)) --'ũ��'�� �ݴ�� '�۰ų� ����'
 -��������(NOT , AND, OR)  ---������� ���� ����  NOT�� ������ // NOT�� ���� ���� ����ȴ�
 
��뿹)HR ������ ������̺�(EMPLOYEES)���� ���ʽ��� ���ϰ� 
�� ����� �޿� ���޾��� ���Ͻÿ�.
    ���ʽ� = �⺻��(SALARY)*��������(COMMISSION_PCT)
    ���޾� = �⺻�� +���ʽ�
    Alias�� �����ȣ, �����, �⺻��, ���ʽ�, ���޾��̴�
    
    SELECT EMPLOYEE_ID AS �����ȣ, 
    FIRST_NAME||' '||LAST_NAME AS �����, 
    SALARY AS �⺻��, 
    COMMISSION_PCT AS ��������,            ---NULL ���� ���Ǿ����� ������� ������  NULL�̴� (� ������ �ϵ�)
    NVL(SALARY * COMMISSION_PCT,0) AS ���ʽ�, ---NVL�Լ�
    SALARY + NVL(SALARY * COMMISSION_PCT,0) AS ���޾� 
        FROM HR.EMPLOYEES;              --��� ����� ���� ���̴� WHERE������ �ʿ䰡 ����  --  .�� �Ҽ��� ��Ÿ���ִ� ������(�ٸ������� ���ԵǾ��ִ� ���̺��϶� ���)
                                        --NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�.
                                        --- �Լ�  :  NVL("��", "������") 

           
                                                    
                                                    
                                                    
                                                    
 
 ��뿹)ȸ�� ���̺��� ���ϸ����� 3000�̻��� ȸ���� ��ȸ�Ͻÿ�---3000�̻��ΰ� WHERE�� �������� �ο��Ǿ���Ѵ�
        Alias�� ȸ����ȣ,ȸ����,���ϸ���,����
    
    SELECT MEM_ID AS ȸ����ȣ,
    
       MEM_NAME AS ȸ����,
       MEM_MILEAGE AS ���ϸ���,
        MEM_JOB AS ����  
    FROM MEMBER
        WHERE MEM_MILEAGE>= 3000 ---(����)������� �о ���ϸ��� ���� ���ؼ� 3000���� ū�� ������ Ȯ���ϰ� SELECT���� ����Ѵ�
                                                        ---��������                         ---FROM WHERE SELECT ������ ����ȴ�.
        ORDER BY 3 DESC;
     
     
     ��뿹)ȸ�� ���̺��� ���ϸ����� 3000�̸鼭    --���ӻ�� �������� or, and --
     �������� '����'�� ȸ���� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ,ȸ����,���ϸ���,����,����
    ���������� '����ȸ��','����ȸ��', �� �ϳ��� ���
    
    SELECT MEM_ID AS ȸ����ȣ,
    MEM_NAME AS ȸ����,
    MEM_MILEAGE AS ���ϸ���,
    MEM_JOB AS ����,
    CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' THEN        
            '����ȸ��'
    ELSE
            '����ȸ��'
    END AS ����
    FROM MEMBER
    WHERE MEM_MILEAGE >=3000 
    AND MEM_ADD1 LIKE '����%'; ---�⺻�ּҰ� �������� �����ϸ� ���Ǹ��� (%�� �ڿ� � ���ڰ� �͵� ����� ���ٴ� ��)
    
    
    
    
��뿹) �⵵�� �Է¹޾� ����� ����� �����Ͻÿ�

ACCEPT P_YEAR PROMPT '�⵵�Է�:'
DECLARE
V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
V_RES VARCHAR2(100);
BEGIN
IF (MOD(V_YEAR,4)=0 AND  MOD(V_YEAR,100)!=0)  OR
    (MOD(v_YEAR,400)=0) THEN
    V_RES:=V_YEAR||'�⵵�� �����Դϴ�.';
ELSE
    V_RES:=V_YEAR||'�⵵�� ����Դϴ�.';
    
END IF;
DBMS_OUTPUT.PUT_LINE(V_RES);
END;

2)��Ÿ������  --���� ���Ǿ���
-���������̳� �������� ǥ������ ������ �� ���� ǥ��
-IN , ANY, SOME, ALL, BETWEEN, LIKE, EXISTS ���� ����
(1)IN ������--�ٸ� �����ڿ� ��� �Ұ� (in�ȿ� =�� ���ԵǾ��ֱ⶧����)
.���� Ž���� ���� ���� �� �̻��� ǥ������ ����
.���õ� �������� �ڷ� �� ����ϳ��� ��ġ�ϸ� ��ü ����� ���� ��ȯ
(�������)
�÷��� IN (��1[,��2,....])
-'�÷���'�� ����� ���� '��1[,��2,....]' �� ����ϳ��� ��ġ�ϸ�
����� ��(true)�� ��ȯ
- =ANY,  =SOME  ���� �ٲپ� ��� ������--�ٸ� �����ڿ� ��밡��
-���ӵ� ���� BETWEEN����, �ҿ������� ���� �񱳴� IN���� ����
-OR �����ڷ� ġȯ ���� 

��뿹)������̺��� �μ���ȣ 20,50,90,110�� ���� ���������
��ȸ�Ͻÿ�. 
Alias�� �����ȣ,�����,�μ���ȣ,�޿�
(OR ������ ���)
SELECT EMPLOYEE_ID AS �����ȣ,
FIRST_NAME||' '||LAST_NAME AS �����,
DEPARTMENT_ID AS �μ���ȣ,
SALARY AS �޿�
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID =20
    OR DEPARTMENT_ID = 50
    OR DEPARTMENT_ID = 90
   OR DEPARTMENT_ID = 110
  ORDER BY 3; 

SELECT EMPLOYEE_ID AS �����ȣ,
FIRST_NAME||' '||LAST_NAME AS �����,
DEPARTMENT_ID AS �μ���ȣ,
SALARY AS �޿�
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN(20,50,90,110)   ----���� ��� �ϳ��� ���̸� ��ü�� �� ( WHERE  ������ SELECT ���)
    ORDER BY 3; 
    
    
    
(2) ANY(SOME)������
.IN �����ڿ� ������ ������� 
.�־��� ������ �� ����ϳ��� ���� ANY(SOME)�տ�
����� ���迬���ڸ� �����ϸ� ��(true)�� ����� ��ȯ
(�������)
�÷��� ���迬����ANY|SOME (��1,[,��2,...])   ---����Ŭ���� ������  �ϳ��� �ϳ��� �����ϴ� �����ھ�

��뿹)������̺��� �μ���ȣ 20,50,90,110�� ���� ���������
��ȸ�Ͻÿ�. 
Alias�� �����ȣ,�����,�μ���ȣ,�޿�
SELECT EMPLOYEE_ID AS �����ȣ,
FIRST_NAME||' '||LAST_NAME AS �����,
DEPARTMENT_ID AS �μ���ȣ,
SALARY AS �޿�
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID =ANY(20,50,90,110)  
    ORDER BY 3; 
    
    
��뿹) ȸ�����̺��� ȸ������ ������ ���ϸ����� ������ �������� ȸ������ ������ ���ϸ������� ���� ���ϸ����� ������ ȸ������ ��ȸ�Ͻÿ�
ALIAS�� ȸ����ȣ,ȸ����,����,���ϸ���

SELECT MEM_ID AS ȸ����ȣ,
    MEM_NAME AS ȸ����,
    MEM_JOB AS ����,
    MEM_MILEAGE AS ���ϸ���
FROM MEMBER 
WHERE MEM_MILEAGE >=ANY (SELECT MEM_MILEAGE             --SUBCALL �����ں��� ���� ����Ǽ� �� ������ ���� �� �� ������ ����
                        FROM MEMBER 
                        WHERE MEM_JOB = '������');      --�ϳ��� �ϳ��� ���ؾ��ϴµ� (SELECT)�� 4������ ���� �� ��� ����; �׷��� ANY�� ����

                        
 
 
 

 
 
 
 
        
        
        
        
        
                    
            