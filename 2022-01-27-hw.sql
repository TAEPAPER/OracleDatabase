������̺��� **�μ���** ����ӱ��� ���ϰ� �ش�μ��� ���� ��� �� �ڱ�μ��� ��� �޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�
        ALIAS�� �����ȣ, �����, �μ���, �μ���ձ޿�, �޿�
          
          (�������� : �����ȣ, �����, �μ���, �μ���ձ޿�,�޿�)
          
    SELECT A.EMPLOYEE_ID AS �����ȣ, 
           A.EMP_NAME AS �����, 
           B.DEPARTMENT_NAME AS �μ���, 
           C.DAVG    AS �μ���ձ޿�,
           A.SALARY    AS �޿�
    FROM  HR.EMPLOYEES A, HR.DEPARTMENTS B, 
          (SELECT DEPARTMENT_ID AS DNAME , ROUND(AVG(SALARY)) AS DAVG
            FROM HR.EMPLOYEES
            GROUP BY DEPARTMENT_ID
            ORDER BY 1) C
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
       AND B.DEPARTMENT_ID = C.DNAME
       AND A.SALARY > C.DAVG
          ORDER BY 1;
    
    
    
    
    
    (�������� : �μ��� ��� �޿�)
    SELECT DEPARTMENT_ID AS DNAME , ROUND(AVG(SALARY)) AS DAVG
    FROM HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY 1;