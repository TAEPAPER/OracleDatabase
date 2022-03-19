2022-01-11-01)

    3)LPAD(c1,n[,c2]), RPAD(c1,n[,c2])
    -정의된 기억공간의 크기(n)에서 C1문자열을 채우고 남는 공간 왼쪽(LPAD) 또는 오른쪽(RPAD)에 C2를 채움
    -C2가 생략되면 공백을 채움
    -수표보호문자 등에 주로 사용되었음-
    
    사용예)
    상품 테이블에서 상품명을 출력하되 왼쪽 남는 공간에 '*'를 채워 출력하시오
    SELECT LPAD(PROD_NAME,40,'*'),
           RPAD(PROD_NAME,40,'*')--오른쪽부터 채워서 왼쪽 남는 공간에 '*'
    FROM PROD;
    
    SELECT LPAD(EMP_NAME,30),SALARY  --C2가 생략되면 공백이 채워진다
    FROM   HR.EMPLOYEES;
    
    SELECT LPAD(SALARY,8,'*') FROM HR.EMPLOYEES;
    
    4)LTRIM(C1[,C2]), RTRIM(C1[,C2])
    -주어진 문자열 맨오른쪽(RTRIM) 또는 왼쪽(LTRIM)의 문자열이 
    C2와 일치하면 삭제
    -C2가 생략되면 공백을 삭제  --중간에 일치하는 것은 못찾아    TRIM은 왼,오 빈공간을 삭제
    
    **회원테이블(MEMBER)의 구조와 테이터를 복사하여 CUSTOMER테이블을 생성하고 이름컬럼(MEM_NAME)의 데이터 타입을 
    CHAR(20)으로 변경하시오
    
    CREATE TABLE CUSTOMER AS
        SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
         FROM MEMBER; --기본키 X 관계도 안된다 (그냥 테스트용으로 만들어 쓰고 버릴 때 생성)
         
    ALTER TABLE CUSTOMER 
     MODIFY (MEM_NAME CHAR(20));
    
    SELECT*FROM CUSTOMER
    --WHERE MEM_NAME ='오철희';   
    WHERE RTRIM(MEM_NAME) ='오철희';
    
    SELECT MEM_ID,
           MEM_NAME,
           RTRIM(MEM_NAME) AS 이름,
           MEM_MILEAGE
    FROM CUSTOMER;
    
    SELECT LTRIM('PERSIMMON','ER'),--ER은 있지만 맨첫번째부터 시작되지 않기 때문에 제거 X
        RTRIM('PERSIMMON','ON')   --공백을 제거하는 목적으로 쓰임!!
        FROM DUAL;
        
        5)TRIM(C1)
        -주어진 문자열 C1의 앞과 뒤에 존재하는 모든 무효의 공백(주어진 문자열 앞서서 나온 공백)을 제거
        -문자열 내부의 공백 제거는 불가능 -REPLACE 함수로 제거가능
        
    사용예)CUSTOMER테이블의 이름커럼의 자료타입을 VARCHAR2(20)
          형식으로 변환하시오.
          ALTER TABLE CUSTOMER 
          MODIFY (MEM_NAME VARCHAR2(20)); 
          UPDATE CUSTOMER                  --아무리 기억장소가 가변길이로 변경되었어도 유효한 공백이기 때문에 공백을 없앨 수는 없어 그래서 나중에 업데이트를 해줘야 해
           SET MEM_NAME =TRIM(MEM_NAME);   --공백을 모두 자르고 자기자신에게 
           
          COMMIT;
          
          SELECT * FROM CUSTOMER; 
          
    7)***SUBSTR(C1,N1[,N2])***   n1 문자의 시작위치, 자바는 끝나는 위치   // n2는 잘라낼 갯수
    -주어진 문자열 C1에서 N1번째에서 N2갯수만큼의 문자를 추출
    -N1,N2는 1부터 시작하는 index
    -n2가 생략되면 n1부터 그 이후의 모든 문자열이 추출
    -**추출된 결과도 문자열임
    -n1이 음수이면 오른쪽문자열부터 처리
    
    
    사용예)
        SELECT SUBSTR('APPLEBANNER',2,5),
                SUBSTR('APPLEBANNER',2),
                SUBSTR('APPLEBANNER',-6,5)
        FROM DUAL;
        
    **회원테이블에서  MEM_REGNO1   MEM_REGNO2    MEM_BIR
    j001 김윤희      751019      2448920      1975/11/21 자료를
    j001 김윤희       001019     4448920      2000/11/21 로
    UPDATE MEMBER
      SET MEM_REGNO1 = '001019',
            MEM_REGNO2 = '4448920',
            MEM_BIR = '2000/11/21'
        WHERE MEM_ID = 'j001'
        COMMIT;
        
    t001 성원태	     760506	    1454731	      1976/05/06 자료를
    t001 성원태	     010506	    3454731     	2001/05/06 로
    UPDATE MEMBER
      SET MEM_REGNO1 = '010506',
            MEM_REGNO2 = '3454731',
            MEM_BIR = '2001/05/06'
        WHERE MEM_ID = 't001';
        COMMIT;
            
    b001 이쁜이	741004	2900000	1974/01/07  자료를
    b001 이쁜이	031004	4900000	2003/01/07  로 변경
    UPDATE MEMBER
      SET MEM_REGNO1 = '031004',
            MEM_REGNO2 = '4900000',
            MEM_BIR = '2003/01/07'
        WHERE MEM_ID = 'b001';
        
        
        q001		육평회	721020	1402722	1972/10/20
        q001		육평회	951020	1402722	1995/10/20
        
        UPDATE MEMBER
      SET MEM_REGNO1 = '951020',
            MEM_REGNO2 = '1402722',
            MEM_BIR = '1995/10/20'
        WHERE MEM_ID = 'q001';
        
   **표현식 --SELECT 문의 SELECT절에서만 사용가능
   -SELECT 문에서 사용되는 비교기능을 가진 수식
   -CASE WHEN THEN과 DECODE 가 제공
   (사용형식1)
   CASE  WHEN 조건식1 THEN 결과1 --조건이 맞지않으면 밑의 조건식2
         WHEN 조건식2 THEN 결과2
                    ..
            [ELSE 결과n]  --위조건들이 전부다 만족되지 않을 때 처리해야할 내용 (생략가능)
    END --END로 반드시 끝나야해 -- 명령문일 때는 END CASE로 끝나
     
   
   
  -**(사용형식2)**
   CASE 조건식 WHEN 값1 THEN 결과1 --조건식이 값과 일치하느냐 그렇다면 결과1 실행
              WHEN 값2 THEN 결과2 
                    ..
         [ELSE 명령n]  --다 아니다 그러면 ELSE
    END 
    
    
 (사용형식3)
    DECODE(컬럼명, 조건1,결과1, 조건2, 결과2,...) -- 삼항연산자와 비슷 쭈욱 가서 맞는 것 찾고 , 맞는 조건이 없는 경우 끝나
    END
   
   
   
    사용예)회원테이블에서 20대이하의 회원정보를 조회하시오
         ALIAS는 회원번호, 회원명,성별,나이,마일리지
         성별에는 '여성회원' ,'남성회원' 중 하나 출력
         나이는 주민번호를 이용하여 구하시오
         
      SELECT MEM_ID  AS 회원번호,
      MEM_NAME AS 회원명,
      CASE WHEN SUBSTR(MEM_REGNO2,1,1)  = '1' OR   
                SUBSTR(MEM_REGNO2,1,1)='3' THEN
                '남성회원'
      ELSE '여성회원'
      END AS 성별,
      MEM_REGNO1||' '||MEM_REGNO2 AS 주민번호,
      CASE WHEN SUBSTR(MEM_REGNO2,1,1) ='1' OR
                SUBSTR(MEM_REGNO2,1,1)= '2' THEN
                EXTRACT(YEAR FROM SYSDATE) - 
                (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900) 
            ELSE
                 EXTRACT(YEAR FROM SYSDATE) - 
                (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000) 
           END  AS 나이,
      MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE EXTRACT(YEAR FROM SYSDATE)-
              EXTRACT(YEAR FROM MEM_BIR) <= 29;  --20대 이하
              
    
    8)REPLACE(C1,C2[,C3])
    -주어진 문자열 C1에 포함된 C2문자열을 찾아 C3문자열로 치환
    -C3가 생략되면 C2문자열을 제거함 
    -반복된 C3를 모두 제거
    -문자열 내부 공백제거에 주로 사용
    
    사용예)
    SELECT REPLACE('APPLEPERSIMMON','PL','KL')  
        FROM DUAL;
        
    사용예)
        SELECT PROD_ID AS 상품코드,
                PROD_NAME AS 상품명1,
                REPLACE(PROD_NAME,' ') AS 상품명2, --찾은 문자를 제거(C3가 생략되면  C2문자열을 제거함)
                PROD_PRICE AS 판매가격
        FROM PROD
        WHERE PROD_COST>=300000;
        
        
    9)ASCII(c1),CHR(N1)
       -ASCII(C1) : C1문자열의 첫글자만 ASCII 코드값
       -CHR(N1) : N1코드에 대응하는 문자열 반환
       
       SELECT ASCII('ABC'), ASCII('대'),  --A하나만 변환된다
              CHR(65)
            FROM DUAL;
        
    10)LENGTH(C1), LENGTHB(C1)
    -LENGTH(C1): 주어진 문자열 C1내의 글자수 반환 
    -LENGTHB(C1): 주어진 문자열C1 내의 기억공간의 크기 (BYTE)반환
    
    
        
    
    
        
                  
     
         
         

         
         
         
         
    
    
    
          
          
          
        
        
    
    
    
        
    
    
    
    
    
    
    
    
    