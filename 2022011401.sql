 2022011401) �����Լ�(�׷��Լ�)
      -�־��� �ڷḦ Ư�� �÷�(��)�� �������� �׷�ȭ�ϰ� �� �׷쿡�� --**�հ�(sum), ���(avg), �󵾼�(count)-�� �׷��� ���� ���� ������
      --,�ִ밪(MAX), �ּҰ�(MIN)**--�� ��ȯ�ϴ� �Լ� **Ư�� �÷����� ���� ���� ���� �ͳ��� ���!**
      -SELECT���� �����Լ��� ������ �Ϲ� �÷��� ���� ���Ǹ� �ݵ�� GROUP BY ���� ���Ǿ�� ��
      -�����Լ��� ���� �÷�(����)�� ������ �ο��� ���  HAVING���� ó��
      -�����Լ����� �ٸ� �����Լ��� ������ �� ����
      
      (�������)
      SELECT [�÷�list,]
             �׷��Լ�
        FROM ���̺��
        [WHERE ����]  **��µǴ� ���� ��������**
        [GROUP BY �÷���1][�÷���2,....]
        [HAVING ����] --**�����ռ� ��ü�� ���ǿ� �ο��� ��**
        [ORDER BY �÷���][�÷��ε��� [ASC|DESC][,.....]]
        .GROUP BY �÷���1[,�÷���2,...] : �÷���1�� �������� �׷�ȭ�ϰ� �� �׷쿡�� �ٽ� '�÷���2'�� �׷�ȭ
        .SELECT���� ���� --**�Ϲ��÷��� �ݵ�� GROUP BY���� ���** �ؾ��ϸ�,SELECT���� ������� ���� �÷��� GROUP BY ���� ��� ����
        .SELECT���� �׷��Լ��� ���� ��� GROUP BY �� ����(���̺� ��ü�� �ϳ��� �׷����� ����)
        -�׷�ȿ� �׷��� ������� �� ����!
        .SUM(EXPR) AVG(EXPR), COUNT(*EXPR),MIN(EXPR),MAX(EXPR)
        
        ��뿹)������̺��� �� �μ�**'��'**('�׷����'��� ��) �޿��հ踦 ���ϵ� �޿��հ谡 100000�̻��� �μ��� ��ȸ�Ͻÿ� --�׷�ȿ� �׷�
        ALIAS�� �μ��ڵ�, �޿��հ�
        SELECT  DEPARTMENT_ID AS �μ��ڵ�,
                SUM(SALARY) AS �޿��հ�    
        FROM   HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        **HAVING SUM(SALARY)>= 100000**
        ORDER BY 1;
        
        --LIKE �� ���Ϻ��� �� (%_�� �Բ� ���) 
        ��뿹) ������̺��� �� �μ��� ��ձ޿��� ���Ͻÿ�
        alias�� �μ��ڵ�, �μ���, ��ձ޿�
        SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
        B.DEPARTMENT_NAME AS �μ���, 
        ROUND(AVG(A.SALARY),1) AS ��ձ޿�
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B --��Ī �ݵ�� ����!
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID , B.DEPARTMENT_NAME   --�Ϲ� �÷��� �׷�������
        ORDER BY 1;
        
        ��뿹)��ǰ���̺��� �з��� ��� ���԰��� ��ȸ�Ͻÿ�
        SELECT PROD_LGU AS ��ǰ�з� , 
               ROUND(AVG(PROD_COST),0) AS ��ո��԰� 
        FROM   PROD
        GROUP BY PROD_LGU;
        
        ����) ��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹż������踦 ���Ͻÿ�
        SELECT  CART_PROD AS ��ǰ�ڵ�,
                SUM(CART_QTY) AS �Ǹż�������
        FROM CART 
        WHERE  SUBSTR(CART_NO,1,6) = '200504'
        --CART_NO  LIKE  '200504%' 
        GROUP BY CART_PROD 
        ORDER BY 1;
        
         ����)��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹ� �����հ谡 10�� �̻��� ��ǰ�� ��ȸ�Ͻÿ� 
      SELECT  CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS �Ǹż����հ�
        FROM   CART 
        WHERE  SUBSTR(CART_NO,1,6) = '200504'
        GROUP BY CART_PROD
        HAVING SUM(CART_QTY)>= 10
        ORDER BY 1;
        
        ����) �������̺��� 2005�� 1�� ~6�� ���� �������踦 ���Ͻÿ�
        SELECT  EXTRACT (MONTH FROM BUY_DATE) AS ���Կ�,
                SUM(BUY_COST*BUY_QTY) AS ��������,
                SUM(BUY_QTY)AS ���Լ����հ�
        FROM    BUYPROD
        WHERE   BUY_DATE  BETWEEN  TO DATE ('20050101') AND TO_DATE('20050630')
        GROUP BY  EXTRACT (MONTH FROM BUY_DATE)
        ORDER BY 1;
        
        ����)�������̺��� 2005�� 1~6�� ����, ��ǰ�� ���Աݾ� �հ谡 1000���� �̻��� ������ ��ȸ�Ͻÿ� 
           SELECT  EXTRACT (MONTH FROM BUY_DATE) AS ���Կ�,
                    BUY_PROD  AS ��ǰ�ڵ�,
                SUM(BUY_COST*BUY_QTY) AS ��������
        FROM    BUYPROD
        WHERE   BUY_DATE  BETWEEN ('20050101') AND ('20050701')
        GROUP BY  EXTRACT (MONTH FROM BUY_DATE), BUY_PROD 
        HAVING SUM(BUY_COST*BUY_QTY) >= 10000000
        ORDER BY 1;
        
        
        ����)ȸ�����̺��� ���� ���ϸ��� �հ踦 ���Ͻÿ�
        ALIAS�� ����,���ϸ��� �հ��̸�, ���п��� '����ȸ��'�� '����ȸ��'�� ����Ͻÿ� 
        SELECT  CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR   
                SUBSTR(MEM_REGNO2,1,1)='3' THEN
                '����ȸ��'
                ELSE '����ȸ��'
                END AS ����,
                SUM(MEM_MILEAGE) AS ���ϸ����հ� 
        FROM MEMBER
        GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR   
                 SUBSTR(MEM_REGNO2,1,1)='3' THEN
                '����ȸ��'
                ELSE '����ȸ��'
                END;
        
         ����) ȸ�����̺��� ���ɴ뺰 �ش� ���ɴ��� ���ϸ��� �հ踦 ��ȸ�Ͻÿ�
        ALIAS�� ����, ���ϸ��� �հ��̸� ���г����� '10��',..;'70'�� ������ ���ɴ븦 ���
    SELECT  TRUNC((EXTRACT(YEAR FROM SYSDATE)  
          - EXTRACT(YEAR FROM MEM_BIR)),-1)||'��'  AS ����,  
            SUM(MEM_MILEAGE) AS ���ϸ����հ�
    FROM MEMBER
    GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)  
          - EXTRACT(YEAR FROM MEM_BIR)),-1)||'��' 
    ORDER BY 1;
    
    
    
    
        SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                        SUBSTR(MEM_REGNO2,1,1) = '2' THEN
         TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900),-1)
          ELSE
          TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000),-1)
          END  ||'��'  AS ����,  
        SUM(MEM_MILEAGE) AS ���ϸ����հ�
    FROM MEMBER
    GROUP BY ASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                        SUBSTR(MEM_REGNO2,1,1) = '2' THEN
         TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900) ,-1)
          ELSE
          TRUNC(EXTRACT(YEAR FROM SYSDATE)  
          - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000),-1)
          END ||'��' 
    ORDER BY 1;
    
 
    ��뿹) ��ü����� ��ձ޿��� ���  --��ü�� �׷��̴ϱ� GROUP BY�� �Ƚ� 
    SELECT  ROUND(AVG(SALARY)) AS ��ձ޿�,
            SUM(SALARY) AS �޿��հ�,
            COUNT(*) �����
    FROM HR.EMPLOYEES;
    
    ��뿹) ������� �޿��� ��ձ޿����� ������� ������ ��ȸ
     ALIAS�� �����ȣ(GROUP BY �ǹ̾���) ,�����, �μ��ڵ�,�����ڵ�,�޿�,��ձ޿�
     
     SELECT A.EMPLOYEE_ID AS �����ȣ ,
            A.EMP_NAME AS �����, 
            A.DEPARTMENT_ID AS �μ��ڵ�,
            A.JOB_ID AS �����ڵ�,
            A.SALARY AS �޿�,
            B.ASAL AS ��ձ޿�      
     FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES) B  --��ȣ ���� �� ����������
     WHERE A.SALARY < B.ASAL
     ORDER BY 3;
    
    
    
     ��뿹) ������̺��� �� �μ��� �ִ�޿��� �ּұ޿��� ���Ͻÿ�
        ALIAS�� �μ��ڵ�, �μ���, �ִ�޿�, �ּұ޿�
        SELECT  �μ��ڵ�, �μ���, �ִ�޿�, �ּұ޿�
        
        
        
        