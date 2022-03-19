2022011102)숫자함수

    1)수학적 함수
    -ABS, SIGN, SQRT, POWER 등이 제공
    -ABS(N1) : N1의 절대값
    -SIGN(N1) : N1의 부호에 따라 양수이면 1, 음수이면 -1, 0이면 0을 반환 --N1의 크기에 상관없음
    -SQRT(N1) : N1의 평방근 값 반환
    -POWER(N1,N2) : N1의 N2승 값
    
    사용예)
    SELECT  ABS(100), ABS(-100),
            SIGN(-9000),SIGN(-0.0009), SIGN(100000),SIGN(0.000001),
            SIGN(0),
            SQRT(10),SQRT(81),
            POWER(2,10),POWER(2,32)
    FROM DUAL;

    2)GREATEST(N1,[,N2,...]), LEAST(N1,[,N2,...])
    -GREATEST(N1,[,N2,...]) : 제시된 N1,[,N2,...]에서 가장 큰 값을 반환
    -LEAST(N1,[,N2,...]) : 제시된 N1,[,N2,...]에서 가장 작은 값을 반환
    --여러 컬럼들에서 제일 큰값을 구할  때 사용한다 (한 컬럼내에서는 MAX, MIN을 사용)
    
    사용예)
    SELECT GREATEST(100,200,20),
           GREATEST('홍길동','홍길순','강감찬') 
    FROM   DUAL;
    
    사용예) 회원테이블에서 마일리지가 1000이하인 회원의 마일리지를 1000으로 바꾸어 조회하시오.
           ALIAS는 회원번호, 회면명,직업,마일리지
           
           SELECT MEM_ID AS 회원번호, 
                  MEM_NAME AS 회원명,
                  MEM_JOB AS 직업,
                  MEM_MILEAGE AS 원본마일리지,             --행에서 비교할 때는 GREATEST와 LEASTEST를 쓴다
                 GREATEST(MEM_MILEAGE,1000) AS 마일리지  --컬럼 데이터랑 1000이랑 비교
                FROM MEMBER;                            --MAX로 풀기 못한다
                
           SELECT MAX(MEM_MILEAGE),
                  MIN(MEM_MILEAGE)
               FROM MEMBER;
               
    3)ROUDN(N1,l), TRUNC(N1,1)   
       -ROUND(N1,l):제시된 수 N1에서 소숫점이하 l+1번째 자리에서 반올림하여 l자리까지 반환  --돈을 내어줄 때 사용
       -TRUNC(N1,l):제시된 수 N1에서 소숫점이하 l+1번째 자리에서  자리버림하여 l자리까지 반환 --돈을 받아들일 때 사용
       -l이 생락되면 0으로 간주 --소수자리수 아예없어져서 정수가 된다
       -l이 음수이면 정수(소숫점이상)부분의 1번째자리에서 반올림(ROUND) 또는 자리버림(TRUNC)
       
       
    4)FLOOR(N1),CEIL(N1)
    -FLOOR(N1) : N1과 같거나 작은 수 중 제일 큰 정수 --제시된 수가 실수라면 그 중 가장 큰 정수를 반환
    -CELL(N1) : N1과 같거나 큰 수 중 제일 작은 정수 =>소숫점 이하의 값이 존재하면 무조건 반올림한 값 반환
    -급여, 세금 등 금액에 관련된 항목에 주로 사용 --오라클은 정확한 자료를 보관하다가 사용자가 요구할 때 정확하게 제공해주는 역할을 한다
    
    사용예)
    SELECT FLOOR(12.987),FLOOR(12),FLOOR(-12.987),FLOOR(-12),
           CEIL(12.987),CEIL(12),CEIL(-12.987),CEIL(-12)
    FROM DUAL;
      
        
    5)MOD(N1, E) , REMAINDER(N1,E)
    -MOD(N1, E):      N1을 E로 나눈 나머지 반환
    -REMAINDER(N1,E): N1을 E로 나눈 몫의 소수점이하가 0.5.보다 크면 (나머지가 E의 중간값 보다 크면) 
                      다음 몫이 되기위한 값 반환
    -**내부적 처리 방법이 상이**
    -MOD : 나머지 = N1 - E*FLOOR(N1/E)
   - REMAINDER : 나머지 = N1 - E*ROUND(N1/E)

    EX) MOD(15,4)
        15-4*FLOOR(15/4)
        15-4*FLOOR(3.75)
        15-4*3 => 3 
        
        REMAINDER(15,4)
        15 - 4*ROUND(15/4)
        15 - 4*4 => -1           
        
        
        
         MOD(13,4)
        13-4*FLOOR(13/4)
        13-4*FLOOR(3.25)
        13-4*3 => 1 
        
        REMAINDER(13,4)
        13 - 4*ROUND(13/4)
        13 - 4*3 => 1   --다음 부족한 수?   (피젯수가 다음 몫이 되기위해서 부족한 수)
        
        
        사용예)
        SELECT CASE MOD((TRUNC(SYSDATE) - TO_DATE('00010101')-1),7) --SYSDATE는 년월일시분초( TRUNC써서 오늘날짜에서 시분초를 날려버림 년월일만 남겨둠)
                            WHEN 0 THEN '일요일'                      --서기 1년 1월 1일을 빼면 경과되어진 일수가 나옴 거기서 아직 하루가 안지났으니까 -1을 빼고
                            WHEN 1 THEN '월요일'                      --7로 나눈 나머지를 구해서 ~ 나머지가 0이면 일요일 1이면 월요일~
                            WHEN 2 THEN '화요일'                       
                            WHEN 3 THEN '수요일'
                            WHEN 4 THEN '목요일'                        --만년달력 구할 때 쓰임
                            WHEN 5 THEN '금요일'
                            ELSE '토요일'
                        END AS 요일
         FROM DUAL;
        
        
        6)WIDTH_BUCKET(VAL,MIN,MAX,B)
            -구간 하한값 MIN에서 상한 값 MAX를 B개의 구간으로 나누었을 때 제시된 값 VAL이 어느 구간에 속하는지를 판단하여 구간의 INDEX를 반환
            --어느 구간에 속하는지를 나타내준다 (그 구간의 INDEX를 반환해줌) --0구간이 있음  -- B+2개의 구간이 생성된다
            
        사용예) 회원테이블에서 각 회원들의 마일리지를 입력받아 마일리지를 1000~9000사이를 9개 구간으로 구분할 때 
               그 값이 어느구간에 속하는지 판별하시오
               
              ALIAS는 회원번호,회원명,마일리지,구간값
              
              SELECT MEM_ID AS 회원번호,
                     MEM_NAME AS  회원명,
                     MEM_MILEAGE AS 마일리지,
              WIDTH_BUCKET(MEM_MILEAGE,1000,8700,9) AS 구간값               
              FROM MEMBER;  --1000이하는 인덱스 0구간이 된다 --하한값은 범위에 포함되지만 상한값은 범위에 포함되지 않는다 실제 구간은 11구간이 생성된다!
                                                                                   --(N+2개의 구간이 생성)
                                                                    
                                                                    
         사용예) 회원테이블에서 각 회원들의 마일리지를 입력받아 마일리지를 1000~9000사이를 9개 구간으로 구분할 때 
               그 값이 어느구간에 속하는지 판별하여 등급을 나타내시오. 단, 가장 많은 마일리지 가지고 있는 회원이 1등급임    
               ALIAS는 회원번호,회원명,마일리지,등급
               
               SELECT MEM_ID AS 회원번호,
                     MEM_NAME AS  회원명,
                     MEM_MILEAGE AS 마일리지,
                  -- 10- WIDTH_BUCKET(MEM_MILEAGE,1000,9000,9) AS 구간값    이 방법 이거나 밑에 방법
                  WIDTH_BUCKET(MEM_MILEAGE,9000,1000,9) AS 구간값  
              FROM MEMBER;
              
              
        사용예)사원테이블에서 사원들의 급여가 
                2000-5000사이에 속하면 '저임금 사원'
                5001-10000사이에 속하면 '평균임금 사원'
                10001-20000  사이에 속하면 '고임금 사원'
                을 비고난에 출력
                alias는 사원번호,사원명,부서카드,급여
            SELECT EMPLOYEE_ID AS 사원번호,
                    EMP_NAME AS 사원명,
                   DEPARTMENT_ID AS 부서코드,
                   SALARY AS 급여 ,
                CASE  WIDTH_BUCKET(SALARY,1,25000,5) 
                WHEN 1 THEN '저임금 사원'
                WHEN 2 THEN '평균임금 사원'
                ELSE '고임금 사원'
                END AS 비고
            FROM HR.EMPLOYEES;
               
            
            
            
            
        
        
        
        
         
         
    
    
           
            
           

    
    
