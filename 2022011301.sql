    2022011301)
    형변환함수
    1)CAST(EXPR AS 타입)
    ㅡ한번만 일시적으로 변환된다(영원히 노!)
    -'expr'로 정의된 컬럼 또는 수식의 데이터 타입이 '타입명'형식으로 변환--캐스트한다
    
    사용예) 장바구니테이블에서 2005년 5월 판매정보를 조회하시오                                                          --로그인 되어진 순번                      
    ALIAS는 일자, 상품명, 수량 , 금액 이며 일자순으로 출력하시오 --멤버테이블에서 가져옴 (외래키) // CART_NO 8자리 날짜자료 +5자리 숫자 결합해서 고정길이 문자열 13자리로 
    SELECT CAST(SUBSTR(CART.CART_NO,1,8) AS DATE ) AS 일자,                 --상품코드 가지고 PROD가서 상품명 확인
    PROD.PROD_NAME AS 상품명, 
    CART.CART_QTY AS 수량 , 
    CART.CART_QTY*PROD.PROD_PRICE AS 금액
    FROM CART , PROD     
    WHERE CART.CART_PROD = PROD.PROD_ID   -- 조인조건                       --테이블 별칭은 복잡하게 안쓴다
    AND CART.CART_NO LIKE '200505%'
    ORDER BY 1;
    
    2)--********TO_CHAR(EXPR[,FMT])*********--
    -**문자열(CHAR,CLOB=> VARCHAR2로)**, 숫자, 날짜 자료를 **문자열 자료**로 형변환      --모든 자료를 문자열로 바꿔주는 역할 
    -변환형식을 지정할 때에는 'FMT'(형식지정문자열)을 기술
    -날짜관련 형식문자열
    ------------------------------------------------------
    FORMAT                       의미                사용예
    -------------------------------------------------------
    BC,AD                     서기, 기원전         SELECT TO_CHAR(SYSDATE, 'BC') FROM DUAL; --양수이기 때문에 서기라고 출력이 되어진다!
    CC                        CC                 SELECT TO_CHAR(SYSDATE, 'CC') FROM DUAL;     
    YYYY,YYY,YY,Y년도                             SELECT TO_CHAR(SYSDATE, 'YYYY'),
                                                         TO_CHAR(SYSDATE, 'YYY'),
                                                         TO_CHAR(SYSDATE, 'YY'),
                                                         TO_CHAR(SYSDATE, 'Y')
                                                  FROM DUAL;
    
    MM          (01~12월)
    MON, MONTH   월이 같이 나온다                          SELECT TO_CHAR(SYSDATE,'MM'),
                                                         TO_CHAR(SYSDATE,'MONTH'),
                                                         TO_CHAR(SYSDATE,'YYYY-MM')
                                                         FROM DUAL;
                                                  
    DD          (01~31)일표시         
    DDD         (01~365)일표시
    D           주중 요일 순번 값 --일요일부터 
    DY          '월'~'일'
    DAY          '월요일'~'일요일'                     SELECT TO_CHAR(SYSDATE,'DD'),
                                                            TO_CHAR(SYSDATE,'DDD'),
                                                            TO_CHAR(SYSDATE,'D'),
                                                            TO_CHAR(SYSDATE,'DY'),
                                                            TO_CHAR(SYSDATE,'DAY')
                                                     FROM DUAL;
    
    WW              연중 주 (01~53)                    SELECT TO_CHAR(SYSDATE,'WW') FROM DUAL;                                 
    AM PM
    A.M. , P.M.        오전 오후                        SELECT  TO_CHAR(SYSDATE,'PM') FROM DUAL;
    HH HH12 HH24        시간                           SELECT TO_CHAR(SYSDATE,'HH12') FROM DUAL;
    MI                  분                             SELECT TO_CHAR(SYSDATE,'MI') FROM DUAL;
    SS                  초(-1~60)                      SELECT TO_CHAR(SYSDATE,'SS') FROM DUAL;
    SSSSS               초 (01~86000)                  SELECT TO_CHAR(SYSDATE,'HH:MI:SS') FROM DUAL; 
                                                       SELECT TO_CHAR(SYSDATE,'SSSSS') FROM DUAL;--오늘 시작이후로 지금까지 경과된 초
    ---------------------------------------------------------------   
    SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8)))
    FROM CART
    WHERE CART_NO LIKE '200504%';
    
    SELECT TO_CHAR() FROM PROD;   --VARCHAR2에서  VARCHAR2로 변환가능
    
    숫자 관련 형식문자열
     ------------------------------------------------------
    FORMAT             의미                        사용예
    -------------------------------------------------------
      9       대응되는 무효의 0을 공백처리        SELECT TO_CHAR(12345,'9999999') FROM DUAL;                                    
      0       대응되는 무효의 0을 '0'으로 처리    SELECT TO_CHAR(12345,'0000000') FROM DUAL;
      PR      자료가 음수이면 < >안에 출력        SELECT TO_CHAR(-12345,'99999PR') FROM DUAL; --회계에서 사용
                                              SELECT TO_CHAR(12345,'99999PR') FROM DUAL;
    ,(COMMA) 자리점
    .(DOT)   소숫점                               SELECT TO_CHAR(-12345,'99,999.9PR') ,
                                               TO_CHAR(-12345,'99,999.0PR') FROM DUAL;            
    $,L      화폐기호                             SELECT TO_CHAR(12345,'$99,999.9') ,
                                               TO_CHAR(12345,'L99,999.0') FROM DUAL;
                                                SELECT TO_NUMBER(TO_CHAR(1234,'99,999.9') ,'999999.9')+20
                                                FROM DUAL;
  ------------------------------------------------------------------                                              
   
   사용예) 오늘이 2005년 7월 31일이고 쇼핑몰 페이지에 처음 로그인한 경우  장바구니번호를 생성하시오
    SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||TRIM(TO_CHAR(1,'00000'))  --공백이 생김(변환 오류)-- 그래서 TRIM 사용
    FROM DUAL
    
    사용예) 오늘이 2005년 7월 28일이고 쇼핑몰 페이지에 처음 로그인한 경우  장바구니번호를 생성하시오
          SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
                 TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000')) --무효의 0을 추가시키기 위해'00000'! 
            FROM CART
           WHERE SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE,'YYYYMMDD');
     
     
    3)TO_NUMBER(expr,[,fmt])
    -**문자열을 숫자자료**로 변환
    -변환시킬 문자자료는 숫자로 변환 가능한 자료이어야 함
    -'fmt'는 TO_CHAR에서 사용된 것과 동일
    
    CREATE TABLE GOODS AS 
    SELECT PROD_ID, PROD_NAME, PROD_LGU, PROD_PRICE
      FROM PROD;
    
    SELECT * FROM GOODS;
    
    사용예)상품테이블(GOODS)에 다음자료를 추가로 등록하시오
    상품코드 
     상품명 : 삼성 노트북 15인치 
     거래처 코드 : P101
     판매가격 : 1200000원
  
     
     
    (상품코드 생성)
    
    SELECT 'P101'
            ||TRIM(TO_CHAR(TO_NUMBER(
              SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS P_CODE
    FROM GOODS
    WHERE PROD_LGU = 'P101';
    
    (추가등록)
    INSERT INTO GOODS
    SELECT A.P_CODE, '삼성 노트북 15인치','P101',1200000
    FROM (SELECT 'P101'
            ||TRIM(TO_CHAR(TO_NUMBER(
                SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS P_CODE
                    FROM GOODS
                    WHERE PROD_LGU = 'P101') A;
        
        SELECT * FROM GOODS
        WHERE PROD_LGU = 'P101';
      
      SELECT TO_NUMBER('￦1,234' ,'L99,999') ,
             TO_NUMBER('<1,234>','9,999PR')+10
      FROM DUAL;          --원본을 알려준다
      
     4)TO_DATE(expr[,fmt])
     -날짜형식의 문자열 자료를 날짜형식으로 변환하여 반환
     -'fmt'는 TO_CHAR에서 사용된 날짜형 형식문자열과 동일
     
     사용예)
     SELECT TO_DATE('20050708'),
            TO_CHAR(TO_DATE('20220113092035','YYYYMMDDHHMISS'),
                    'YYYY/MM/DD HH:MI:SS')
        FROM DUAL;
     
     사용예) 회원테이블에서 주민등록번호를 이용하여 다음과 같은 형식으로 자료를 출력하시오
     
     출력
     회원번호  회원명      생년월일           직업    마일리지 
     XXXX      XXX   1997년 00월 00일      자영업   9999
    
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            CASE WHEN SUBSTR(MEM_REGNO2,1,1) ='1' OR
                SUBSTR(MEM_REGNO2,1,1) ='2' THEN
                TO_CHAR(TO_DATE('19'||MEM_REGNO1),'YYYY"년" MM"월" DD"일"')
            ELSE
            TO_CHAR(TO_DATE('20'||MEM_REGNO1),'YYYY"년" MM"월" DD"일"')
            
            END AS 생년월일,
            MEM_JOB AS 직업,
            MEM_MILEAGE AS 마일리지
        FROM MEMBER;
        
        
     
     
     
     
     
     
      
      
                                                     