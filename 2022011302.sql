 2022011302) NULLó���Լ�
 
     -NULL�� ���̰� ���� �ڷ�
     -���꿡 NULL�� ���Ǹ� ��� ����� NULL�̴�.!
     -NULL ���� �Լ��� NVL, NVL2, NULLIF��  �����Ͱ� NULL�� ������ �Ǵ��� ���� IS NULL, IS NOT NULL ,�� �����ڰ� ������  -- =�� ���� �ʾ� 
    
    1.IS NULL, IS NOT NULL 
     .NULL���� ��� �򰡸� ���� ������
     .NULL�� '='�����ڷ� �Ǻ� �Ұ���
     
     ��뿹) ������̺��� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ� ����� ��ȸ�Ͻÿ�.
     ALIAS �� �����ȣ, �����,�μ��ڵ�,���������ڵ�
     SELECT EMPLOYEE_ID AS �����ȣ, 
     EMP_NAME AS �����,
     DEPARTMENT_ID AS �μ��ڵ�,
     COMMISSION_PCT AS ���������ڵ� 
     FROM HR.EMPLOYEES
     WHERE COMMISSION_PCT IS NOT NULL;
     
     ��뿹)��ǰ���̺��� ��������(PROD_COLOR)�� �ڷᰡ �������� �ʴ�
            ������ ��ȸ�Ͻÿ�
            ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ��������
            SELECT PROD_ID AS ��ǰ�ڵ�, 
            PROD_NAME AS ��ǰ��, 
            PROD_COST AS ���Դܰ�, 
            PROD_COLOR AS ��������
            FROM PROD
            WHERE PROD_COLOR IS NULL;
    
    2.NULL ó���Լ�
     --**1)NVL(COL1,VAL)
        -'COL'�� ����  NULL�̸� 'VAL'�� ��ȯ�ϰ� NULL�� �ƴϸ� 'COL'���� ��ȯ
        -'COL'���� 'VAL'�� �ݵ�� **���� Ÿ��**�̾�� ��
        
        ��뿹) 2005�� 6�� **���** ��ǰ�� ���� ��ǰ�� ������Ȳ�� ��ȸ
        ALIAS�� ��ǰ��, ���� �������� , ���Աݾ����� --�ܺ� ���� (�ƿ��� ����)
        
        (2005�� 6�� ���� ��ǰ)
        SELECT DISTINCT BUY_PROD
         FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630')
         ORDER BY 1;
            
            
        SELECT B.PROD_NAME AS ��ǰ��, 
       NVL(SUM(A.BUY_QTY),0) AS ���� �������� ,
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS ���Աݾ�����
        FROM BUYPROD A   
        RIGHT OUTER JOIN PROD B ON(A.BUY_PROD =B.PROD_ID)
        AND A.BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630')
        GROUP BY B.PROD_NAME;
        
        
        