    2022-0119-03)
    
    3.SELF JOIN
    -�ϳ��� ���̺� ���� ���� ��Ī�� �ο��Ͽ� �����ϴ� ����
    
    ��뿹)ȸ�����̺��� '����ȣ'ȸ���� ���ϸ��� ���� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�
    --�ΰ��� MEMBER���̺��� ���� �ٸ���Ī���� �Ҹ���
         SELECT B.MEM_ID AS ȸ����ȣ, B.MEM_NAME AS ȸ����, B.MEM_JOB AS ����, B.MEM_MILEAGE AS ���ϸ���
         FROM MEMBER A, MEMBER B  --A�� ����ȣ 
         WHERE A.MEM_NAME = '����ȣ' --���ξƳ�
            AND   B.MEM_MILEAGE > A.MEM_MILEAGE --A���̺��� ����ȣ ���� ���̾�
          ORDER BY 1;
          
          
    ��뿹)������̺��� �� ����� �������̸��� ��ȸ�Ͻÿ�
        �����ڰ� ������ 'CEO'�� ����Ͻÿ�
        
        ALIAS�� �����ȣ, �����, �μ���, �������̸�
        
        SELECT C.EMPLOYEE_ID AS �����ȣ, 
               C.EMP_NAME AS �����, 
                B.DEPARTMENT_NAME AS �μ���, 
                NVL((SELECT D.EMP_NAME FROM HR.EMPLOYEES D WHERE D.EMPLOYEE_ID = C.MANAGER_ID),'CEO')  AS �������̸� 
        FROM   HR.DEPARTMENTS B  , HR.EMPLOYEES C
        WHERE C.DEPARTMENT_ID = B.DEPARTMENT_ID 
        ORDER BY 1;
        
        