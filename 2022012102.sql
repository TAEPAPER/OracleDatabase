 2022-01-21-02 )SUBQUERY
    -SQL���� �ȿ� �� �ٸ� SELECT���� �����ϴ� ���
    -JOIN�̳�  ���⵵�� �����ϱ� ���� ���
    -��� SUBQUERY���� ()�ȿ� ����ؾ���, ��, INSERT���� ���Ǵ� SUBQUERY�� ����
    -���������� WHERE�� ��� ����� ���� ���� �� �ݵ�� ������ �����ʿ� ��ġ
    -���������� �з�
      .��� ��ġ�� ���� : �Ϲݼ�������(SELECT��), **��ø��������(WHERE��),In-line��������(FROM��--��������Ǿ���Ѵ�)**
      .���������� ���迡 ���� : ���ɼ� ���� �������� (���������� ���� ���̺�� JOIN���� ����� ��������) --join�Ǿ��� join���� �ʾҴ���
      .��ȯ�Ǵ� ��/���� ���� : ���Ͽ�|���߿�/ ������|������ �������� => ���Ǵ� �����ڿ� ���� ����
     
      
    -�˷����� ���� ���ǿ� �ٰ��� ������ �˻��ϴ� SELECT�� � Ȱ�� --ex)��ձټӿ����� ���Ͻÿ� 
    -���������� ����Ǳ� ���� �ѹ�  ����ȴ�.
     -FROM(FROM �ȿ� ���������� ������ ����� ���������� �̿��ؼ� ���� ���� �ۼ�) WHERE SELECT
     
     ��뿹) ������̺��� ������� ����ӱ�(����ӱ��� ���ϴ°� ��������) ���� ���� �޿��� �޴� ������� �����ȣ,�����,�μ��ڵ�,�޿��� ��ȸ�Ͻÿ�
     (IN-LINE-VIEW ��������)
     (�������� -���������� ����ϴ� �� : ������� �����ȣ,�����,�μ��ڵ�,�޿�
     
     SELECT A.EMPLOYEE_ID AS A.�����ȣ,EMP_NAME AS �����,A.DEPARTMENT_ID AS �μ��ڵ�,A.SALARY AS �޿�
     FROM HR.EMPLOYEES A, (����ӱ�) B
     WHERE A.SALARY > B.����ӱ�
     ORDER BY 3;
            
    (�������� :����ӱ�) 
    SELECT AVG(SALARY) AS ASAL 
    FROM HR.EMPLOYEES
    
    (����)
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           A.DEPARTMENT_ID AS �μ��ڵ�,
           A.SALARY AS �޿�
    FROM HR.EMPLOYEES A,
            (SELECT AVG(SALARY) AS ASAL 
             FROM HR.EMPLOYEES) B --B.ASAL �̷��� �Ǿ���Ѵ�!!! 
    WHERE A.SALARY > B.ASAL  --�����Ǿ�����
    ORDER BY 3;
   
    (��ø ��������)-where���� ���
    
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ��ڵ�,
           SALARY AS �޿�
    FROM HR.EMPLOYEES 
    WHERE  SALARY > (SELECT AVG(SALARY) 
             FROM HR.EMPLOYEES)  --107���� ����Ǿ��� (��ü ����ӵ��� ������)
    ORDER BY 3;
    
    
    ��뿹)ȸ�����̺��� ȸ���� ������ �ִ븶�ϸ����� ���� �ִ� ȸ�������� ��ȸ�Ͻÿ�
          ALIAS�� ȸ����ȣ,ȸ����,����, ���ϸ��� 
        (�������� : ȸ����ȣ,ȸ����,����, ���ϸ���)
        SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                 MEM_JOB AS ����, 
                MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE (MEM_JOB,MEM_MILEAGE) =  (��������)--�� ������ �ִ� ���ϸ���
        
        (�������� : �� ������ �ִ븶�ϸ���)
        SELECT   MEM_JOB , 
                MAX(MEM_MILEAGE) 
                FROM MEMBER 
                GROUP BY MEM_JOB
                
        (����)
       SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                 MEM_JOB AS ����, 
                MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE (MEM_JOB,MEM_MILEAGE) IN (SELECT  MEM_JOB , 
                                                MAX(MEM_MILEAGE)     --�����࿬���ڴ� IN =SUM =ANY EXIST ���Ǿ������Ѵ�
                                                FROM MEMBER                 --'��ø��������'
                                                GROUP BY MEM_JOB);  --������ ��������!! --�������� ����ȵ����ϱ� '���ü����� ��������'
                                                
         (EXIST ������ ���)
         SELECT A.MEM_ID AS ȸ����ȣ,
                A.MEM_NAME AS ȸ����,
                A.MEM_JOB AS ����, 
                A.MEM_MILEAGE AS ���ϸ���
        FROM MEMBER A   --��ü�� �� ������ (��� ������ ������ ���� ���ϸ����� ���� ����� �Ծ� �׷���  WHERE�� ���� �ǰ� ���������� ����ȴ�)
                      WHERE EXISTS (SELECT 1 --�ǹ̰� ����          --������?
                      FROM(SELECT MEM_JOB,
                            MAX(MEM_MILEAGE)  AS BMILE  
                            FROM MEMBER 
                            GROUP BY MEM_JOB)B
        WHERE A.MEM_JOB = B.MEM_JOB 
             AND A.MEM_MILEAGE = B.BMILE);
       
     ��뿹)��ǰ���̺��� ��ǰ�� �ǸŰ��� ����ǸŰ����� ū ��ǰ�� ��ȸ�Ͻÿ�
     
     ALIAS�� ��ǰ��ȣ, ��ǰ��, �ǸŰ�, ����ǸŰ�
    SELECT  A.PROD_ID AS ��ǰ��ȣ, 
            A.PROD_NAME AS ��ǰ��, 
            A.PROD_PRICE AS �ǸŰ�, 
            B.BAV  AS  ����ǸŰ�
    FROM PROD A,(SELECT ROUND(AVG(PROD_PRICE)) AS BAV
                        FROM PROD)B               
    WHERE A.PROD_PRICE > B.BAV
    ORDER BY 1;
    
     
     
     
     
     
     
     
     
     ��ٱ��� ���̺��� ȸ���� �ִ� ���ż����� ����� ��ǰ�� ��ȸ�Ͻÿ�
     ALIAS�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż���
     SELECT C.CART_MEMBER AS ȸ����ȣ, 
           A.MEM_NAME AS  ȸ����,
           B.PROD_NAME AS ��ǰ��, 
           C.CART_QTY AS ���ż���
     FROM MEMBER A, PROD B, CART C
     WHERE C.CART_MEMBER = A.MEM_ID
          AND C.CART_PROD = B.PROD_ID
          AND C.CART_QTY =(��������)
               
    (�������� : ȸ���� �ִ뱸�� ����)
    SELECT CART_MEMBER ,
    MAX(CART_QTY)
    FROM CART
    GROUP BY CART_MEMBER;
    
    (����)
    SELECT C.CART_MEMBER AS ȸ����ȣ, 
           A.MEM_NAME AS  ȸ����,
           B.PROD_NAME AS ��ǰ��, 
           C.CART_QTY AS ���ż���
     FROM MEMBER A, PROD B, CART C
     WHERE C.CART_MEMBER = A.MEM_ID
          AND C.CART_PROD = B.PROD_ID
          AND (C.CART_MEMBER, C.CART_QTY) IN (SELECT CART_MEMBER ,
                            MAX(CART_QTY)            -- 1���� 23�� 
                            FROM CART                --IN�� ���� (,)���༭ ���� ���Ѵ�
                            GROUP BY CART_MEMBER);
    (�ι�° ���)
    SELECT C.CART_MEMBER AS ȸ����ȣ, 
           A.MEM_NAME AS  ȸ����,
           B.PROD_NAME AS ��ǰ��, 
           C.CART_QTY AS ���ż���
     FROM MEMBER A, PROD B, CART C
     WHERE C.CART_MEMBER = A.MEM_ID
          AND C.CART_PROD = B.PROD_ID
          AND  C.CART_QTY = (SELECT  MAX(D.CART_QTY)            -- 1���� 23�� 
                            FROM CART D
                            WHERE D.CART_MEMBER = C.CART_MEMBER)  --IN�� ���� (,)���༭ ���� ���Ѵ� 
        ORDER BY 1;
        
    
    
    
    
    
    
    
    
    
    
    
    
    SELECT CART_MEMBER , CART_PROD, CART_QTY
    FROM CART
    WHERE CART_MEMBER = 'b001'
    ORDER BY 3 DESC;
    
 
                
                                                       
                
    
    
    
    