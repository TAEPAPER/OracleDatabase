2022-0118-01 ) TABLE JOIN
    -�����ͺ��̽� ���迡 ����ȭ ������ �����ϸ� ���̺��� ��Ȱ�ǰ� �ʿ��� �ڷḦ ��ȸ�ϱ� ���� �������� ���̺��� ������ �÷��� �������� ���꿡 �����ؾ���
     => ���� ����   --����ȭ�� �ش����̺��� ������ ������ �ȵǴ� �÷��� ���� �� ���̺��� �����Ѵ�! (6���� ����)
                  --�׷��� �������� �л��.. ��ȸ�� �Ϸ��� ���ο����� �̿��ؾ���! �ΰ��� ���̺��� �ݵ�� ���������Ǿ��־����(�⺻Ű,�ܷ�Ű)
                  --�ݵ�� ���� ������ ����ؾ� ���� ������ ����ȴ�!
     -������ ������ ���̽��� �⺻����
     -����
      .��������(INNER JOIN)-(������ ��(������������ ���� ����)�� �������� ���� ���� �ڷ�� ����)�� 
       �ܺ�����(OUTER JOIN)- �������.. ������ ���̺� ���� , �������� NULL���� ä���
      .�Ϲ����ΰ� - Ư�� DBMS�� ���缭 ��ɿ� ����ȭ�Ǿ��� ���ι� ����
       ANSI JOIN - ��� DBMS�� �����ؾ���(DBMS�� ������� �� ���డ��)
      .��������(EQUI JOIN)�� -���� ������(=) ���Ǿ� �� ��
       �񵿵�����(NON EQUI JOIN) ���ι��� = �̿��� �����ڰ� ���Ǿ��� ��
      
      
      1.Cartesian product 
        -**���������� �����Ǿ��ų� �߸� ����� ���** 
        -ANSI JOIN������ Cross Join�̶�� ��
        -������ ����� �־��� ��� ���� ���� ���� ����� ���� ���� ���� ��� ��ȯ
        -�Ұ����ϰ� �ʿ��� ��찡 �ƴϸ� ������� ���ƾ���
      (�������)
      SELECT Į��LIST
        FROM ���̺��1[��Ī1],���̺��2 [��Ī2] ���̺��3 [��Ī4],....] --���̺� ��Ī  
      WHERE ��������1     --���� ���̺� ���� N������ �ּ� N-1���� ���������� �ʿ��ϴ�(�� �̻� ����) 
      [AND ��������2,...] --�� ���̺� ������ ���� �÷��� �����ڿ� ���� ���ϴ� ��
      [AND �Ϲ�����]      --������ ����� ����
      
      (CROSS JOIN�� ����)-ANSI
      SELECT Į��LIST
        FROM ���̺��1[��Ī1] --�� �ϳ� ����
        CROSS JOIN ���̺��2[��Ī2]  
        [CROSS JOIN ���̺��3[��Ī3]--���̺��1 ���̺��2 ����� ���εȴ�
                    .
                    .
        [WHERE �Ϲ�����];

        ��뿹)
        SELECT COUNT(*) FROM CART;
        SELECT COUNT(*) FROM PROD;
        SELECT 207*74 FROM DUAL;
        
        SELECT COUNT(*)
        FROM CART ,PROD , BUYPROD; --�־��� ��� ���Ǽ��� ���� ���Ѱ���ŭ, ���Ǽ��� ���Ѱ���ŭ
      --  WHERE CART_QTY != PROD_QTYSALE; --(���� ����)
        
        (ANSI����)
        SELECT COUNT(*)
        FROM CART 
        CROSS JOIN PROD 
        CROSS JOIN BUYPROD;
        
        2.EQUI JOIN (���� �츮�� ���� �� �� EQUI ����)
        -�������ǹ��� �������--**('=')**�� ���
        -����**���̺��� ���� N���� �� ���������� ��� N-1�� �̻�**�̾�� ��
        -ANSI������ INNER JOIN ����� �ǰ��� --������ ���� ����
        
        (�������-�Ϲ� ���ι�)
        SELECT [���̺��.|���̺�Ī.] �÷��� [AS �÷���Ī][,]
                                :
               [���̺��.|���̺�Ī.] �÷��� [AS �÷���Ī]
            FROM ���̺��[��Ī],���̺��[��Ī][,���̺��[��Ī],...]
            WHERE ��������    
            [AND ��������]
                   :
            [AND �Ϲ�����];
            
            
            (ANSI)
             SELECT [���̺��.|���̺�Ī.] �÷��� [AS �÷���Ī][,]
                                :
               [���̺��.|���̺�Ī.] �÷��� [AS �÷���Ī]
            FROM ���̺��1[��Ī]
            INNER JOIN ���̺��2[��Ī] ON (�������� [AND �Ϲ�����])
            [INNER JOIN ���̺��3[��Ī] ON (�������� [AND �Ϲ�����])
            [WHERE �Ϲ�����]; -- ��ü ���̺� ������ �Ϲ�����
            -���̺��1�� ���̺��2�� �ݵ�� ���� �����ؾ��� - ���� �÷��� �ݵ�� �����ؾ��Ѵٴ� ��
            
            (�Ϲ����ι�����)
        ��뿹)��ǰ���̺�� �з����̺� ���̺��� �̿��Ͽ� **�ǸŰ��� 10���� �̻��� ��ǰ**�� ��ȸ�Ͻÿ�.
            ALIAS�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ� (LPROD_GU), (�з���- LPROD_NM ),�ǸŰ�
            SELECT A.PROD_ID AS ��ǰ�ڵ�,
                    A.PROD_NAME AS ��ǰ��,
                    A.PROD_LGU AS �з��ڵ�,
                    B.LPROD_NM AS �з���,
                    A.PROD_PRICE AS �ǸŰ�
            FROM PROD A, LPROD B
            WHERE A.PROD_PRICE >= 100000 --�Ϲ�����
                  AND  A.PROD_LGU = B.LPROD_GU   --�� ���̺� ������ ����� �÷��� ������ڷ� �������ּ��� --�������� 
            ORDER BY 5;    
                                    --������ �÷��� �̸��� �ٲٸ� �ȵȴ�! (���� �߸� ����Ǿ��ִ�)
           
           (ANSI ���ι�)
           SELECT A.PROD_ID AS ��ǰ�ڵ�,
                    A.PROD_NAME AS ��ǰ��,
                    A.PROD_LGU AS �з��ڵ�,
                    B.LPROD_NM AS �з���,
                    A.PROD_PRICE AS �ǸŰ�
            FROM PROD A 
            INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU AND
                        A.PROD_PRICE >= 100000)
            ORDER BY 5 DESC;
             
           
        ��뿹)2005�� 6�� ȸ��**��**�����Լ� ����� ������Ȳ�� ��ȸ�Ͻÿ� --CART TABLE /MEMBER/ PROD 
        ALIAS�� ȸ����ȣ, ȸ����, ���űݾ��հ�
        SELECT CART_MEMBER  AS ȸ����ȣ ,
        
       (�Ϲ� ����)
         SELECT A.CART_MEMBER AS ȸ����ȣ,
                B.MEM_NAME  AS  ȸ����,
                SUM(C.PROD_PRICE*A.CART_QTY) AS ���űݾ��հ�
        FROM CART A, MEMBER B, PROD C
        WHERE A.CART_MEMBER = B.MEM_ID --�������� : ȸ���� ������ ����
            AND A.CART_PROD = C.PROD_ID --�������� : �ǸŴܰ��� �����ϱ� ����
            AND A.CART_NO LIKE '200506%' --�Ϲ�����
        GROUP BY A.CART_MEMBER ,B.MEM_NAME;
        
        (ANSI ����)
         SELECT A.CART_MEMBER AS ȸ����ȣ,
                B.MEM_NAME  AS  ȸ����,
                SUM(C.PROD_PRICE*A.CART_QTY) AS ���űݾ��հ�
        FROM CART A 
        INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID)--�ݵ�� FROM�� ���̺�� ������ �����Ѱ��̿����Ѵ�
        INNER JOIN PROD C ON(C.PROD_ID = A.CART_PROD)
        WHERE A.CART_NO LIKE '200506%'--�Ϲ�����
        GROUP BY A.CART_MEMBER ,B.MEM_NAME;
        
        ��뿹) **�μ���** �ο����� ����ӱ��� ��ȸ�Ͻÿ�.
        ALIAS �μ��ڵ�, �μ���, �ο���, ����ӱ�
        
        (�Ϲ�����)
        SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                B.DEPARTMENT_NAME AS �μ���,
                     COUNT(*) AS �ο���,
               ROUND(AVG(A.SALARY))  AS ����ӱ�
        FROM  HR.EMPLOYEES A , HR.DEPARTMENTS B         
        WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_ID  
        GROUP BY A.DEPARTMENT_ID,  B.DEPARTMENT_NAME
        ORDER BY 1; 
        
        (ANSI ����)
        SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
                B.DEPARTMENT_NAME AS �μ���,
                     COUNT(*) AS �ο���,
               ROUND(AVG(A.SALARY))  AS ����ӱ�
        FROM  HR.EMPLOYEES A 
        INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
        ����)2005�� 1�� ~ 6�� �� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�. --������ �÷��� ���� ������ ������ �� �� ����--�߸����̰� �־����(���⼭�� **PROD**)
        ALISAS �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�
        SELECT   C.PROD_BUYER  AS  �ŷ�ó�ڵ�, 
                 B.BUYER_NAME AS  �ŷ�ó��,
                SUM(A.BUY_QTY*A.BUY_COST)  AS ���Աݾ��հ�
        FROM  BUYPROD A, BUYER B , PROD C --PROD�� �߸�����!!!!
        WHERE  A.BUY_PROD = C.PROD_ID
                AND C.PROD_BUYER = B.BUYER_ID
               AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
        GROUP BY  C.PROD_BUYER  ,B.BUYER_NAME
        ORDER BY 1;
        
        (ANSI ����)
        SELECT   C.PROD_BUYER  AS  �ŷ�ó�ڵ�, 
                 B.BUYER_NAME AS  �ŷ�ó��,
                SUM(A.BUY_QTY*A.BUY_COST)  AS ���Աݾ��հ�
        FROM  BUYPROD A
        INNER JOIN PROD C ON(A.BUY_PROD = C.PROD_ID
                            AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630'))
        INNER JOIN BUYER B ON(C.PROD_BUYER = B.BUYER_ID)
        GROUP BY C.PROD_BUYER, B.BUYER_NAME
        ORDER BY 1;
              
                        
      ����)2005�� 4�� ~ 6�� �� ��ǰ�� �ŭ���Ȳ�� ��ȸ�Ͻÿ�. 
        ALIAS�� ��ǰ�ڵ�,��ǰ��, ��������հ�, ����ݾ��հ��̴�
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
               A.PROD_NAME AS ��ǰ��,
                SUM(B.CART_QTY) AS ��������հ�,
                SUM(B.CART_QTY*A.PROD_PRICE) AS  ����ݾ��հ�
        FROM PROD  A, CART B
        WHERE A.PROD_ID = B.CART_PROD
             AND SUBSTR(B.CART_NO,1,8) BETWEEN TO_DATE('20050401')    AND TO_DATE('20050630')
        GROUP BY A.PROD_ID , A.PROD_NAME
        ORDER BY 1;
        
         ����)2005�� 4�� ~ 6�� �� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�. 
        ALIAS�� ��ǰ�ڵ�,��ǰ��,���Լ����԰�,���Աݾ��հ��̴�
        
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
               A.PROD_NAME AS ��ǰ��,
                SUM(B.BUY_QTY) AS ���Լ����հ�,
                SUM(B.BUY_QTY*B.BUY_COST)���Աݾ��հ�
        FROM   PROD A, BUYPROD B
        WHERE  A.PROD_ID = B.BUY_PROD
              AND BUY_DATE BETWEEN '20050401' AND '20050630'    
        GROUP BY  A.PROD_ID , A.PROD_NAME
        ORDER BY 1;

        
        ����)2005�� 4�� ~ 6�� �� ��ǰ�� ����/������Ȳ�� ��ȸ�Ͻÿ�. 
        ALIAS�� ��ǰ�ڵ�,��ǰ��,���Աݾ��԰�,����ݾ��հ��̴�
        
        SELECT A.PROD_ID AS ��ǰ�ڵ�,A.PROD_NAME AS ��ǰ��,SUM(B.BUY_QTY*A.PROD_COST) AS ���Աݾ��հ�,SUM(A.PROD_PRICE*C.CART_QTY) AS
        ����ݾ��հ�
        FROM  PROD A, BUYPROD B, CART C
        WHERE B.BUY_PROD = A.PROD_ID
            AND A.PROD_ID =C.CART_PROD
            AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
            AND SUBSTR(C.CART_NO,1,6) BETWEEN '20050401' AND '20050630'
        GROUP BY A.PROD_ID ,A.PROD_NAME 
        ORDER BY 1;
        
        
        
        
        
        
            
            
        
            
        
        
        