2022-0118-01 ) TABLE JOIN
    -µ¥ÀÌÅÍº£ÀÌ½º ¼³°è¿¡ Á¤±ÔÈ­ °úÁ¤À» ¼öÇàÇÏ¸é Å×ÀÌºíÀÌ ºÐÈ°µÇ°í ÇÊ¿äÇÑ ÀÚ·á¸¦ Á¶È¸ÇÏ±â À§ÇØ º¹¼ö°³ÀÇ Å×ÀÌºíÀÌ °øÅëÀÇ ÄÃ·³À» ±âÁØÀ¸·Î ¿¬»ê¿¡ Âü¿©ÇØ¾ßÇÔ
     => Á¶ÀÎ ¿¬»ê   --Á¤±ÔÈ­¶õ ÇØ´çÅ×ÀÌºíÀÌ °¡Áö°í ÀÖÀ¸¸é ¾ÈµÇ´Â ÄÃ·³ÀÌ ÀÖÀ» ¶§ Å×ÀÌºíÀ» ºÐÇÒÇÑ´Ù! (6°³ÀÇ °úÁ¤)
                  --±×·¯¸é Á¤º¸µéÀÌ ºÐ»êµÊ.. Á¶È¸¸¦ ÇÏ·Á¸é Á¶ÀÎ¿¬»êÀ» ÀÌ¿ëÇØ¾ßÇØ! µÎ°³ÀÇ Å×ÀÌºí¿¡´Â ¹Ýµå½Ã °ü°èÇü¼ºµÇ¾îÀÖ¾î¾ßÇØ(±âº»Å°,¿Ü·¡Å°)
                  --¹Ýµå½Ã Á¶ÀÎ Á¶°ÇÀ» ±â¼úÇØ¾ß Á¶ÀÎ ¿¬»êÀÌ ½ÇÇàµÈ´Ù!
     -°ü°èÇü µ¥ÀÌÅÍ º£ÀÌ½ºÀÇ ±âº»¿¬»ê
     -Á¾·ù
      .³»ºÎÁ¶ÀÎ(INNER JOIN)-(ºÎÁ·ÇÑ ÂÊ(µ¥ÀÌÅÍÁ¾·ùÀÇ ¸¹°í ÀûÀ½)À» ±âÁØÀ¸·Î Á¶ÀÎ ³²´Â ÀÚ·á´Â ¹«½Ã)°ú 
       ¿ÜºÎÁ¶ÀÎ(OUTER JOIN)- »ç¿ëÀÚÁ¦.. ¸¹ÀºÂÊ Å×ÀÌºí ±âÁØ , ³ª¸ÓÁö´Â NULL°ªÀ» Ã¤¿î´Ù
      .ÀÏ¹ÝÁ¶ÀÎ°ú - Æ¯Á¤ DBMS¿¡ ¸ÂÃç¼­ ±â´É¿¡ ÃÖÀûÈ­µÇ¾îÁø Á¶ÀÎ¹® Çü½Ä
       ANSI JOIN - ¸ðµç DBMS°¡ ¼ö¿ëÇØ¾ßÇØ(DBMS¿¡ »ó°ü¾øÀÌ ´Ù ½ÇÇà°¡´É)
      .µ¿µîÁ¶ÀÎ(EQUI JOIN)°ú -µ¿µî ¿¬»êÀÚ(=) »ç¿ëµÇ¾î Áú ¶§
       ºñµ¿µîÁ¶ÀÎ(NON EQUI JOIN) Á¶ÀÎ¹®¿¡ = ÀÌ¿ÜÀÇ ¿¬»êÀÚ°¡ »ç¿ëµÇ¾îÁú ¶§
      
      
      1.Cartesian product 
        -**Á¶ÀÎÁ¶°ÇÀÌ »ý·«µÇ¾ú°Å³ª Àß¸ø ±â¼úµÈ °æ¿ì** 
        -ANSI JOIN¿¡¼­´Â Cross JoinÀÌ¶ó°í ÇÔ
        -Á¶ÀÎÀÇ °á°ú´Â ÃÖ¾ÇÀÇ °æ¿ì ÇàÀÇ ¼ö¸¦ °öÀÇ °á°ú¿Í ¿­ÀÇ ¼ö¸¦ ´õÇÑ °á°ú ¹ÝÈ¯
        -ºÒ°¡ÇÇÇÏ°Ô ÇÊ¿äÇÑ °æ¿ì°¡ ¾Æ´Ï¸é »ç¿ëÇÏÁö ¸»¾Æ¾ßÇÔ
      (»ç¿ëÇü½Ä)
      SELECT Ä®·³LIST
        FROM Å×ÀÌºí¸í1[º°Äª1],Å×ÀÌºí¸í2 [º°Äª2] Å×ÀÌºí¸í3 [º°Äª4],....] --Å×ÀÌºí º°Äª  
      WHERE Á¶ÀÎÁ¶°Ç1     --»ç¿ëµÈ Å×ÀÌºí °³¼ö N°³¿¡¼­ ÃÖ¼Ò N-1°³ÀÇ Á¶ÀÎÁ¶°ÇÀÌ ÇÊ¿äÇÏ´Ù(±× ÀÌ»óµµ ±¦Ãá) 
      [AND Á¶ÀÎÁ¶°Ç2,...] --µÎ Å×ÀÌºí »çÀÌÀÇ °øÅë ÄÃ·³À» ¿¬»êÀÚ¿¡ ÀÇÇØ ºñ±³ÇÏ´Â °Í
      [AND ÀÏ¹ÝÁ¶°Ç]      --ÀÌÁ¦²¯ »ç¿ëÇÑ Á¶°Ç
      
      (CROSS JOIN¹® Çü½Ä)-ANSI
      SELECT Ä®·³LIST
        FROM Å×ÀÌºí¸í1[º°Äª1] --µü ÇÏ³ª ³ª¿È
        CROSS JOIN Å×ÀÌºí¸í2[º°Äª2]  
        [CROSS JOIN Å×ÀÌºí¸í3[º°Äª3]--Å×ÀÌºí¸í1 Å×ÀÌºí¸í2 °á°ú¿Í Á¶ÀÎµÈ´Ù
                    .
                    .
        [WHERE ÀÏ¹ÝÁ¶°Ç];

        »ç¿ë¿¹)
        SELECT COUNT(*) FROM CART;
        SELECT COUNT(*) FROM PROD;
        SELECT 207*74 FROM DUAL;
        
        SELECT COUNT(*)
        FROM CART ,PROD , BUYPROD; --ÃÖ¾ÇÀÇ °æ¿ì ÇàÀÇ¼ö´Â ¼­·Î °öÇÑ°ª¸¸Å­, ¿­ÀÇ¼ö´Â ´õÇÑ°ª¸¸Å­
      --  WHERE CART_QTY != PROD_QTYSALE; --(Á¶ÀÎ Á¶°Ç)
        
        (ANSIÇü½Ä)
        SELECT COUNT(*)
        FROM CART 
        CROSS JOIN PROD 
        CROSS JOIN BUYPROD;
        
        2.EQUI JOIN (°ÅÀÇ ¿ì¸®°¡ ¾²´Â °Í ´Ù EQUI Á¶ÀÎ)
        -Á¶ÀÎÁ¶°Ç¹®¿¡ µ¿µî¿¬»êÀÚ--**('=')**°¡ »ç¿ë
        -»ç¿ëµÈ**Å×ÀÌºíÀÇ ¼ö°¡ N°³ÀÏ ¶§ Á¶ÀÎÁ¶°ÇÀº Àû¾îµµ N-1°³ ÀÌ»ó**ÀÌ¾î¾ß ÇÔ
        -ANSI¿¡¼­´Â INNER JOIN »ç¿ëÀ» ±Ç°íÇÔ --ºÎÁ·ÇÑ ÂÊÀ» ±âÁØ
        
        (±â¼úÇü½Ä-ÀÏ¹Ý Á¶ÀÎ¹®)
        SELECT [Å×ÀÌºí¸í.|Å×ÀÌºíº°Äª.] ÄÃ·³¸í [AS ÄÃ·³º°Äª][,]
                                :
               [Å×ÀÌºí¸í.|Å×ÀÌºíº°Äª.] ÄÃ·³¸í [AS ÄÃ·³º°Äª]
            FROM Å×ÀÌºí¸í[º°Äª],Å×ÀÌºí¸í[º°Äª][,Å×ÀÌºí¸í[º°Äª],...]
            WHERE Á¶ÀÎÁ¶°Ç    
            [AND Á¶ÀÎÁ¶°Ç]
                   :
            [AND ÀÏ¹ÝÁ¶°Ç];
            
            
            (ANSI)
             SELECT [Å×ÀÌºí¸í.|Å×ÀÌºíº°Äª.] ÄÃ·³¸í [AS ÄÃ·³º°Äª][,]
                                :
               [Å×ÀÌºí¸í.|Å×ÀÌºíº°Äª.] ÄÃ·³¸í [AS ÄÃ·³º°Äª]
            FROM Å×ÀÌºí¸í1[º°Äª]
            INNER JOIN Å×ÀÌºí¸í2[º°Äª] ON (Á¶ÀÎÁ¶°Ç [AND ÀÏ¹ÝÁ¶°Ç])
            [INNER JOIN Å×ÀÌºí¸í3[º°Äª] ON (Á¶ÀÎÁ¶°Ç [AND ÀÏ¹ÝÁ¶°Ç])
            [WHERE ÀÏ¹ÝÁ¶°Ç]; -- ÀüÃ¼ Å×ÀÌºí¿¡ °ü·ÃÇÑ ÀÏ¹ÝÁ¶°Ç
            -Å×ÀÌºí¸í1°ú Å×ÀÌºí¸í2´Â ¹Ýµå½Ã Á¶ÀÎ °¡´ÉÇØ¾ßÇÔ - °øÅë ÄÃ·³ÀÌ ¹Ýµå½Ã Á¸ÀçÇØ¾ßÇÑ´Ù´Â ¶æ
            
            (ÀÏ¹ÝÁ¶ÀÎ¹®Çü½Ä)
        »ç¿ë¿¹)»óÇ°Å×ÀÌºí°ú ºÐ·ùÅ×ÀÌºí Å×ÀÌºíÀ» ÀÌ¿ëÇÏ¿© **ÆÇ¸Å°¡°¡ 10¸¸¿ø ÀÌ»óÀÎ »óÇ°**À» Á¶È¸ÇÏ½Ã¿À.
            ALIAS´Â »óÇ°ÄÚµå, »óÇ°¸í, ºÐ·ùÄÚµå (LPROD_GU), (ºÐ·ù¸í- LPROD_NM ),ÆÇ¸Å°¡
            SELECT A.PROD_ID AS »óÇ°ÄÚµå,
                    A.PROD_NAME AS »óÇ°¸í,
                    A.PROD_LGU AS ºÐ·ùÄÚµå,
                    B.LPROD_NM AS ºÐ·ù¸í,
                    A.PROD_PRICE AS ÆÇ¸Å°¡
            FROM PROD A, LPROD B
            WHERE A.PROD_PRICE >= 100000 --ÀÏ¹ÝÁ¶°Ç
                  AND  A.PROD_LGU = B.LPROD_GU   --µÎ Å×ÀÌºí »çÀÌÀÇ °øÅëµÈ ÄÃ·³À» µ¿µî¿¬»êÀÚ·Î ¿¬°áÇØÁÖ¼¼¿ä --Á¶ÀÎÁ¶°Ç 
            ORDER BY 5;    
                                    --°øÅëÀÇ ÄÃ·³Àº ÀÌ¸§À» ¹Ù²Ù¸é ¾ÈµÈ´Ù! (Áö±Ý Àß¸ø ¼³°èµÇ¾îÀÖ´Ù)
           
           (ANSI Á¶ÀÎ¹®)
           SELECT A.PROD_ID AS »óÇ°ÄÚµå,
                    A.PROD_NAME AS »óÇ°¸í,
                    A.PROD_LGU AS ºÐ·ùÄÚµå,
                    B.LPROD_NM AS ºÐ·ù¸í,
                    A.PROD_PRICE AS ÆÇ¸Å°¡
            FROM PROD A 
            INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU AND
                        A.PROD_PRICE >= 100000)
            ORDER BY 5 DESC;
             
           
        »ç¿ë¿¹)2005³â 6¿ù È¸¿ø**º°**Áý°èÇÔ¼ö ½á¾ßÇØ ±¸¸ÅÇöÈ²À» Á¶È¸ÇÏ½Ã¿À --CART TABLE /MEMBER/ PROD 
        ALIAS´Â È¸¿ø¹øÈ£, È¸¿ø¸í, ±¸¸Å±Ý¾×ÇÕ°è
        SELECT CART_MEMBER  AS È¸¿ø¹øÈ£ ,
        
       (ÀÏ¹Ý Á¶ÀÎ)
         SELECT A.CART_MEMBER AS È¸¿ø¹øÈ£,
                B.MEM_NAME  AS  È¸¿ø¸í,
                SUM(C.PROD_PRICE*A.CART_QTY) AS ±¸¸Å±Ý¾×ÇÕ°è
        FROM CART A, MEMBER B, PROD C
        WHERE A.CART_MEMBER = B.MEM_ID --Á¶ÀÎÁ¶°Ç : È¸¿ø¸í ÃßÃâÀ» À§ÇÑ
            AND A.CART_PROD = C.PROD_ID --Á¶ÀÎÁ¶°Ç : ÆÇ¸Å´Ü°¡¸¦ ÃßÃâÇÏ±â À§ÇÑ
            AND A.CART_NO LIKE '200506%' --ÀÏ¹ÝÁ¶°Ç
        GROUP BY A.CART_MEMBER ,B.MEM_NAME;
        
        (ANSI Á¶ÀÎ)
         SELECT A.CART_MEMBER AS È¸¿ø¹øÈ£,
                B.MEM_NAME  AS  È¸¿ø¸í,
                SUM(C.PROD_PRICE*A.CART_QTY) AS ±¸¸Å±Ý¾×ÇÕ°è
        FROM CART A 
        INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID)--¹Ýµå½Ã FROMÀÇ Å×ÀÌºí°ú Á¶ÀÎÀÌ °¡´ÉÇÑ°ÍÀÌ¿©¾ßÇÑ´Ù
        INNER JOIN PROD C ON(C.PROD_ID = A.CART_PROD)
        WHERE A.CART_NO LIKE '200506%'--ÀÏ¹ÝÁ¶°Ç
        GROUP BY A.CART_MEMBER ,B.MEM_NAME;
        
        »ç¿ë¿¹) **ºÎ¼­º°** ÀÎ¿ø¼ö¿Í Æò±ÕÀÓ±ÝÀ» Á¶È¸ÇÏ½Ã¿À.
        ALIAS ºÎ¼­ÄÚµå, ºÎ¼­¸í, ÀÎ¿ø¼ö, Æò±ÕÀÓ±Ý
        
        (ÀÏ¹ÝÇü½Ä)
        SELECT A.DEPARTMENT_ID AS ºÎ¼­ÄÚµå,
                B.DEPARTMENT_NAME AS ºÎ¼­¸í,
                     COUNT(*) AS ÀÎ¿ø¼ö,
               ROUND(AVG(A.SALARY))  AS Æò±ÕÀÓ±Ý
        FROM  HR.EMPLOYEES A , HR.DEPARTMENTS B         
        WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_ID  
        GROUP BY A.DEPARTMENT_ID,  B.DEPARTMENT_NAME
        ORDER BY 1; 
        
        (ANSI Çü½Ä)
        SELECT A.DEPARTMENT_ID AS ºÎ¼­ÄÚµå,
                B.DEPARTMENT_NAME AS ºÎ¼­¸í,
                     COUNT(*) AS ÀÎ¿ø¼ö,
               ROUND(AVG(A.SALARY))  AS Æò±ÕÀÓ±Ý
        FROM  HR.EMPLOYEES A 
        INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
        ¹®Á¦)2005³â 1¿ù ~ 6¿ù °¢ °Å·¡Ã³º° ¸ÅÀÔÇöÈ²À» Á¶È¸ÇÏ½Ã¿À. --°øÅëÀÇ ÄÃ·³ÀÌ ¾ø±â ¶§¹®¿¡ Á¶ÀÎÀ» ÇÒ ¼ö ¾ø´Ù--Áß¸ÅÀïÀÌ°¡ ÀÖ¾î¾ßÇØ(¿©±â¼­´Â **PROD**)
        ALISAS °Å·¡Ã³ÄÚµå, °Å·¡Ã³¸í, ¸ÅÀÔ±Ý¾×ÇÕ°è
        SELECT   C.PROD_BUYER  AS  °Å·¡Ã³ÄÚµå, 
                 B.BUYER_NAME AS  °Å·¡Ã³¸í,
                SUM(A.BUY_QTY*A.BUY_COST)  AS ¸ÅÀÔ±Ý¾×ÇÕ°è
        FROM  BUYPROD A, BUYER B , PROD C --PROD°¡ Áß¸ÅÇØÁÜ!!!!
        WHERE  A.BUY_PROD = C.PROD_ID
                AND C.PROD_BUYER = B.BUYER_ID
               AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
        GROUP BY  C.PROD_BUYER  ,B.BUYER_NAME
        ORDER BY 1;
        
        (ANSI Çü½Ä)
        SELECT   C.PROD_BUYER  AS  °Å·¡Ã³ÄÚµå, 
                 B.BUYER_NAME AS  °Å·¡Ã³¸í,
                SUM(A.BUY_QTY*A.BUY_COST)  AS ¸ÅÀÔ±Ý¾×ÇÕ°è
        FROM  BUYPROD A
        INNER JOIN PROD C ON(A.BUY_PROD = C.PROD_ID
                            AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630'))
        INNER JOIN BUYER B ON(C.PROD_BUYER = B.BUYER_ID)
        GROUP BY C.PROD_BUYER, B.BUYER_NAME
        ORDER BY 1;
              
                        
      ¹®Á¦)2005³â 4¿ù ~ 6¿ù °¢ »óÇ°º° ¸Å­ŒÇöÈ²À» Á¶È¸ÇÏ½Ã¿À. 
        ALIAS´Â »óÇ°ÄÚµå,»óÇ°¸í, ¸ÅÃâ¼ö·®ÇÕ°è, ¸ÅÃâ±Ý¾×ÇÕ°èÀÌ´Ù
        SELECT A.PROD_ID AS »óÇ°ÄÚµå,
               A.PROD_NAME AS »óÇ°¸í,
                SUM(B.CART_QTY) AS ¸ÅÃâ¼ö·®ÇÕ°è,
                SUM(B.CART_QTY*A.PROD_PRICE) AS  ¸ÅÃâ±Ý¾×ÇÕ°è
        FROM PROD  A, CART B
        WHERE A.PROD_ID = B.CART_PROD
             AND SUBSTR(B.CART_NO,1,8) BETWEEN TO_DATE('20050401')    AND TO_DATE('20050630')
        GROUP BY A.PROD_ID , A.PROD_NAME
        ORDER BY 1;
        
         ¹®Á¦)2005³â 4¿ù ~ 6¿ù °¢ »óÇ°º° ¸ÅÀÔÇöÈ²À» Á¶È¸ÇÏ½Ã¿À. 
        ALIAS´Â »óÇ°ÄÚµå,»óÇ°¸í,¸ÅÀÔ¼ö·®ÀÔ°è,¸ÅÀÔ±Ý¾×ÇÕ°èÀÌ´Ù
        
        SELECT A.PROD_ID AS »óÇ°ÄÚµå,
               A.PROD_NAME AS »óÇ°¸í,
                SUM(B.BUY_QTY) AS ¸ÅÀÔ¼ö·®ÇÕ°è,
                SUM(B.BUY_QTY*B.BUY_COST)¸ÅÀÔ±Ý¾×ÇÕ°è
        FROM   PROD A, BUYPROD B
        WHERE  A.PROD_ID = B.BUY_PROD
              AND BUY_DATE BETWEEN '20050401' AND '20050630'    
        GROUP BY  A.PROD_ID , A.PROD_NAME
        ORDER BY 1;

        
        ¹®Á¦)2005³â 4¿ù ~ 6¿ù °¢ »óÇ°º° ¸ÅÀÔ/¸ÅÃâÇöÈ²À» Á¶È¸ÇÏ½Ã¿À. 
        ALIAS´Â »óÇ°ÄÚµå,»óÇ°¸í,¸ÅÀÔ±Ý¾×ÀÔ°è,¸ÅÃâ±Ý¾×ÇÕ°èÀÌ´Ù
        
        SELECT A.PROD_ID AS »óÇ°ÄÚµå,A.PROD_NAME AS »óÇ°¸í,SUM(B.BUY_QTY*A.PROD_COST) AS ¸ÅÀÔ±Ý¾×ÇÕ°è,SUM(A.PROD_PRICE*C.CART_QTY) AS
        ¸ÅÃâ±Ý¾×ÇÕ°è
        FROM  PROD A, BUYPROD B, CART C
        WHERE B.BUY_PROD = A.PROD_ID
            AND A.PROD_ID =C.CART_PROD
            AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
            AND SUBSTR(C.CART_NO,1,6) BETWEEN '20050401' AND '20050630'
        GROUP BY A.PROD_ID ,A.PROD_NAME 
        ORDER BY 1;
        
        
        
        
        
        
            
            
        
            
        
        
        