    2022-01-19)
    
    ����) ������̺� ���� �̿��Ͽ� **�̱����� ��ġ��** �μ��� ������� ����̹��� ��ȸ�Ͻÿ�.
          alias�� �μ���ȣ, �μ���, �����, ����ӱ��̴�.
          SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
                    B.DEPARTMENT_NAME AS �μ���, 
                    COUNT(*) AS �����, -- �׷� ���� ���� ���� ��
                ROUND(AVG(A.SALARY)) AS  ����ӱ�
           FROM HR.EMPLOYEES A , HR.DEPARTMENTS B, HR.LOCATIONS C,
                HR.COUNTRIES D
            WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_ID
                   AND B.LOCATION_ID = C.LOCATION_ID
                   AND C.COUNTRY_ID = D.COUNTRY_ID
                   AND LOWER(D.COUNTRY_NAME) LIKE '%america%'
            GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME 
            ORDER BY 1;
            
    ����) 2005 4-6�� ������Ȳ��ȸ
    ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Լ����հ�, ���Աݾ��հ�
    
    ����) 2005 4-6�� ������Ȳ��ȸ
    ALIAS�� ��ǰ�ڵ�, ��ǰ��, ��������հ�, ����ݾ��հ�
    
    ����) 2005 4-6�� ����/������Ȳ��ȸ
    ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Աݾ��հ�, ����ݾ��հ�
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
      A.PROD_NAME AS ��ǰ��, 
      SUM(C.BUY_QTY*A.PROD_COST) AS ���Աݾ��հ�,
      SUM(A.PROD_PRICE*B.CART_QTY) AS ����ݾ��հ�
      FROM PROD A, CART B, BUYPROD C
      WHERE A.PROD_ID = B.CART_PROD
            AND C.BUY_PROD = A.PROD_ID
            AND SUBSTR(B.CART_NO,1,6 )  BETWEEN   '200504'    AND '200506'
            AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE( '20050630') --�� �� ������ �� �� �����ؾ��ϱ� ������ ������ �߸��Ǿ��ٰ� �Ǵ�.
                                                                                --īƼ�� ���δ�Ʈ ����  (���� ��� �߻�)    
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1;
        
        ( ANSI ����)
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
             A.PROD_NAME AS ��ǰ��, 
             SUM(C.BUY_QTY*A.PROD_COST) AS ���Աݾ��հ�,
             SUM(A.PROD_PRICE*B.CART_QTY) AS ����ݾ��հ�
      FROM PROD A
      INNER JOIN  CART B ON(A.PROD_ID = B.CART_PROD AND SUBSTR(B.CART_NO,1,6 )  BETWEEN   '200504'    AND '200506')
      INNER JOIN BUYPROD C ON( C.BUY_PROD = A.PROD_ID AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE( '20050630'))
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;  
      --�Ѵ� �ذ��� �ȵȴ�
      
      (���� ������ ���� ����)
      74���� ���� ���´� --�Ѵ� ���� ���� ���ϱ� ������ ���� ���Ե� ������ ����
      //�¶��� ������Ʈ
      
     ����)��ٱ������̺�(CART)���� 2005�� �����ڷḦ �м��Ͽ� �ŷ�ó��. ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
        ALIAS�� �ŷ�ó �ڵ�, �ŷ�ó��,��ǰ��,�������,����ݾ�
        SELECT  A.BUYER_ID AS �ŷ�ó�ڵ�, 
                A.BUYER_NAME AS �ŷ�ó��,
                C.PROD_NAME AS ��ǰ��,
                SUM(B.CART_QTY) AS �������,
                SUM(B.CART_QTY * C.PROD_PRICE) AS ����ݾ�
        FROM BUYER A, CART B , PROD C
        WHERE  A.BUYER_ID = C.PROD_BUYER
               AND C.PROD_ID =B.CART_PROD --�������� ���
               AND SUBSTR(B.CART_NO, 1, 4) = '2005'
                --  B.CART_NO LIKE '2005%' �ᵵ �ȴ�!
      GROUP BY A.BUYER_ID , A.BUYER_NAME ,C.PROD_NAME 
      ORDER BY 1;
      
       (ANSI ����)
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
                A.BUYER_NAME AS �ŷ�ó��,
                C.PROD_NAME AS ��ǰ��,
                SUM(B.CART_QTY) AS �������,
                SUM(B.CART_QTY * C.PROD_PRICE) AS ����ݾ�
        FROM BUYER A
        INNER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER)
        INNER JOIN CART B ON(C.PROD_ID =B.CART_PROD AND SUBSTR(B.CART_NO, 1, 4) = '2005' )
        GROUP BY  A.BUYER_ID , A.BUYER_NAME ,C.PROD_NAME
        ORDER BY 1;
        
        
        
        
        
        
      
      
      
        
          
          
