    2022-0126-01)
    1.SYNONYM(���Ǿ�)
    -����Ŭ ��ü�� �ο��ϴ� ��Ī
    -�� �̸��� ��ü�� �ٸ���� ������ ��ü�� ������ �� �ַ� ���
    -���̺� ��Ī,�÷� ��Ī���� �������� QUERY�� ������� ��� ����
    (�������)
    CREATE [OR REPLACE] SYNONYM ���Ǿ�
      FOR ��ü��;--���� ��ü�̸�
     
     ��뿹)
     CREATE OR REPLACE SYNONYM EMP
     FOR HR.EMPLOYEES;
     
     CREATE OR REPLACE SYNONYM DEPT
     FOR HR.DEPARTMENTS;
     
     SELECT * FROM EMP;
     SELECT * FROM DEPT;
      
      CREATE OR REPLACE SYNONYM MYDUAL
      FOR SYS.DUAL;
      
      SELECT SYSDATE FROM MYDUAL;  --��ü��� �͵鿡�� ��� ��Ī�� �ο��ؼ� ������ �̸����� �ҷ��� �� �� ����
      
    2.INDEX
    -������ �˻�ȿ���� �����Ű�� ���� ����
    -***WHERE �������� ���Ǵ� �÷�, ����(ORDER BY),�׷�ȭ(GROUP BY)�� ���� �÷��� ����Ͽ� ó�� ȿ���� ����***
    -�ε����� ���� ������ �������� �ҿ�ǰ� , �ý����� �ڿ��� �Һ��
    -�������� ������ ���� ��� �ε��� ������ ���ſ� ���� �ð��� �ڿ��� �䱸��
    
    -�ε����� ����
    .UNIQUE/NON-UNIQUE : �ε����� �ߺ����� ����ϴ��� ���ο� ���� �з�
      'UNIQUE'�ε����� NULL���� ����ϳ� �ϳ��� NULL�� ����--PK�ε����� ����ũ �ε�����
    .SINGLE/COMPOSITE : �ε��� ���� �÷��� 1���ΰ��(SINGLE), 2�� �̻��� �÷����� ����(COMPOSITE) �� ���
    .NORMAL INDEX : DEFAULT �ε����� �÷����� ROWID(������ ��ġ����)�� ������� �ּҰ� ���Ǹ� Ʈ������ �̿�
    .BITMAP INDEX : �÷����� ROWID(������ ��ġ����)�� 2������ �����Ͽ� �ּҰ���ϸ�, CARDINALITY(����������)�� ���� ���
                    (����,���� ��) ȿ������ ���
    .FUNCTION-BASED NORMAL INDEX : �ε��� �����÷��� �Լ��� ����� ���� �� �ε����� �̿��Ͽ� �ڷḦ �˻��ϴ� ��� 
                                    �ε��� ������ ���� �Լ��� ����ϴ� ���� ���� ȿ����
     
     (�������)
        CREATE [UNIQUE|BITMAP] INDEX �ε�����
        ON ���̺��(�÷���[,�÷���,...])[ASC|DESC];
        .'ASC|DESC' :  �ε��� ������ ���� ���(�⺻�� ASC)
        
    (��뿹)��ǰ������ �ε����� �����Ͻÿ�
    CREATE INDEX idx_prod_name
      ON PROD(PROD_NAME);
    
    DROP INDEX idx_prod_name;
    
    SELECT * FROM PROD
    WHERE PROD_NAME = '��� VTR 6���';
    
    ��뿹) ������̺��� 'TJ Olson'��� ������ ��ȸ�Ͻÿ�
    SELECT EMPLOYEE_ID, EMP_NAME, JOB_ID 
    FROM EMP
    WHERE EMP_NAME = 'TJ Olson';
    
    CREATE INDEX idx_emp_name
        ON EMP(EMP_NAME);
        
    **�ε��� �籸��
    -�ڷ��� ����/������ �뷮 �߻��� ���
    -���̺��� ���� ��ġ(TABLE SPACE)�� ����� ���
    (�������)
    ALTER INDEX �ε����� REBUILD;
       
    ALTER INDEX idx_emp_name REBUILD; 
    
        
    
    
      
    
    
    
    