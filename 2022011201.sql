 20220112-01)��¥�Լ�
    1)SYSDATE
    -�ý��ۿ��� �����ϴ� ��¥����(��,��,��,��,��,��) ��ȯ
    -����(�巡�� ������ ��¥)�� ����(������ ��¥) ����
    -�ð�����(��,��,��) ����� TO_CHAR�Լ� ���
    
    ��뿹)
    SELECT SYSDATE, SYSDATE-20, SYSDATE +20
    FROM DUAL;
    
    SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI;SS'), --�ð�����(��,��,��) ����� TO_CHAR�Լ� ��� , TO_DATE �Լ��� ���ڸ� ���ڷ� �ٲ���
           TO_CHAR(SYSDATE-20,'YYYY-MM-DD HH24:MI;SS'),
           TO_CHAR(SYSDATE+20,'YYYY-MM-DD HH24:MI;SS')
    FROM DUAL;
    
    2)ADD_MONTHS (d1,n)
    -�־��� ��¥ d1�� n������ ���� ��¥ ��ȯ
    ��뿹)  �ｺ���� �ڰ��� ���� �� (��ȿ�� �Ⱓ)
    
    SELECT ADD_MONTHS(SYSDATE,4) FROM DUAL;
    
    SELECT EMP_NAME,
           HIRE_DATE,
           ADD_MONTHS(HIRE_DATE,3)
        FROM HR.EMPLOYEES;
        
        
    3)NEXT_DAY(d1,c)
    -d1 ���� ���� ���� ����(����)������ C������ ��¥ ��ȯ
    -C�� ������ ��Ī�ϸ� '�Ͽ���''��''������''��'������ ���

    ��뿹)
     SELECT NEXT_DAY(SYSDATE,'��'),
            NEXT_DAY(SYSDATE,'������')
       FROM DUAL;
       
     4)LAST_DAY(D1)
    -���õ� ��¥ D1�� ���Ե� ���� ���������ڸ� ��ȯ
    -�ַ� 2���� ���������� ��ȯ ���� �� ���
    
    ��뿹) 
    �������̺�(BUYPROD)���� 2005�� 2�� ���ں� �������踦 ��ȸ�Ͻÿ�
    
    ALIAS�� ����, �����հ� ���Աݾ��հ�
    SELECT BUY_DATE AS ����,
           SUM(BUY_QTY) AS �����հ�,
           SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
    
    GROUP BY BUY_DATE
    ORDER BY 1;
    
    5)EXTRACT(fmt FROM d1) --D1�� ��¥�ڷ�
    -���õ� ��¥�ڷ� d1���� 'fmt'�� �ش��ϴ� ��Ҹ� �����Ͽ� ��ȯ
    -��ȯ�Ǵ� ������ Ÿ���� **����**
    -'fmt(Format String:���Ĺ��ڿ�)'�� **YEAR, MONTH,DAY,HOUR,MINUTE,SECOND**�� �ϳ��̾�� ��
    -�׷��� ���갡��!
    SELECT EXTRACT (YEAR FROM SYSDATE)
    FROM DUAL;
    
    ��뿹) ȸ�����̺��� ������ ���ϰ� �� ��ɴ뺰 ȸ������ ��ȸ�Ͻÿ�
    
    ALIAS�� ���ɴ�, ȸ����
    SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)  
          - EXTRACT(YEAR FROM MEM_BIR)),-1)||'��' AS ���ɴ�, --���̿��� �����ڸ����� �ڸ����� �ϼ���
           COUNT(*) AS ȸ����  --ȸ���� ���� �� ,�����Լ�
    FROM MEMBER
    GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)  --�����Լ��� ���� �� GROUP BY  �������
          - EXTRACT(YEAR FROM MEM_BIR)),-1)
    ORDER BY 1;
    
    ��뿹)������̺��� 1���� �Ի��� ������� ��ȸ�Ͻÿ� --�̹��� �ͽ�Ʈ�� �Լ� �Ἥ �� �̱�
    ALIAS�� �����ȣ, �����, �μ��ڵ�, �Ի���
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ��ڵ�,  --�Ի��� ������� ���� ���
           HIRE_DATE AS �Ի���
    FROM HR.EMPLOYEES
    WHERE EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM HIRE_DATE)
    ORDER BY 4;
    
    
    6)MONTHS_BETWEEN(d1,d2)
       -���õ� �� ��¥�ڷ� ������ ������ ��ȯ
       ��뿹)1998�� 3�� 10�Ͽ� �¾ ����� ��Ȯ�� ���̴�?
    SELECT  TRUNC(ROUND(MONTHS_BETWEEN(
            SYSDATE, TO_DATE('19980310')))/12)||'��'||
            MOD(ROUND(MONTHS_BETWEEN(
           SYSDATE, TO_DATE('19980310'))),12)||'����'
     --�������� ���� ���⿡  ROUND �ϰ� 12������ ������ �� ROUND�Ѵ�
    FROM DUAL;
    
    
    
    
       
       
        
        
    
    