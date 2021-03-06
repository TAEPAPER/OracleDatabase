2022-01-07-02) 데이터 검색명령 (SELECT)

** 객체삭제 (DROP)
.테이블 삭제
DROP TABLE 테이블명;

사용예)쇼핑몰 테이블(BUYER,BUYPROD,CART,LPROD,PROD,MEMBER)을 제외한 모든 테이블삭제

DROP TABLE ORDER_GOODS;          --컨트럴 엔터 (줄실행)
DROP TABLE ORDERS;
DROP TABLE CUSTOMERS;
DROP TABLE GOODS;

DROP TABLE TEMP_01;
DROP TABLE TEMP_02;
DROP TABLE TEMP_03;
DROP TABLE TEMP_04;

** HR계정활성화
1.HR계정의 잠금해제
    ALTER USER HR ACCOUNT UNLOCK; 
    
2.HR계정 암호설정
    ALTER USER HR IDENTIFIED BY java; 
    
**데이터 검색 명령
    -SELECT 문이 제공 
    -SQL명령 중 가장 많이 사용되는 명령
    (사용형식)
SELECT *|[DISTINCT]컬럼명 [AS 컬럼별칭] [,]   ---DISTINCT 는 중복배제할 때~
    컬럼명 [AS 컬럼별칭] [,]
                .
                .
    컬럼명 [AS 컬럼별칭]]
    FROM 테이블명
    [WHERE 조건     ---연산할 행 선택하는것 --생략되어지면 모든 것이 참여
     [AND 조건,...]]
   [GROUP BY 컬럼명 [,컬럼명,....]] ---특정컬럼을 같은 놈끼리 묶음             
    [HAVING 조건]--- GROUP BY절과 같이 사용되어짐       
    [ORDER BY 컬럼명|컬럼index [ASC|DESC] [,  ---순서화 시키는 것 (정렬시키는 것)--오름차순/내림차순
                  컬럼명|컬럼index [ASC|DESC],,,,,]];
        
        ---SELECT 절== FROM WHERE SELECT 순으로 실행된다--기억!   
        
        'DISTINCT' : 중복배제
        'AS 컬럼별칭' : 컬럼에 부여한 또 다른 이름. 컬럼의 제목 출력
        'AS 컬럼별칭'에 특수문자(공백등)나 예약어 등이 포함된 경우 반드시 ""로 묶어주어야 함
        .특정 테이블이 없거나 불필요한 경우 시스템이 제공하는 더미(DUMMY)테이블인 
        DUAL을 사용
        
사용예)회원테이블(MEMBER)에서 여성회원들의 정보를 조회하시오 ---여성회원이라는 게 조건
    Alias는 회원번호, 회원명, 주소, 나이,마일리지다.
    
    SELECT  MEM_ID AS 회원번호, 
            MEM_NAME AS 회원명, 
            MEM_ADD1||' '||MEM_ADD2 AS 주소,
            EXTRACT(YEAR FROM SYSDATE)-      ---SYSDATE에서 년도만 추출
            EXTRACT(YEAR FROM MEM_BIR) AS 나이,       ----연산해서 만나이 구해짐
            MEM_MILEAGE AS 마일리지    --오라클에서는 ||이 앤드이다
        FROM MEMBER
        WHERE SUBSTR (MEM_REGNO2,1,1) = '2';          --첫번째 글자에서 1글자 떼기 = 여성이라면
        
 
 사용예) 26363630*24242 값을 출력
 SELECT 26363630*24242 FROM DUAL;  --CART테이블의 행의 수대로 나온다  그래서 DUAL을 써준다
 
 SELECT SYSDATE FROM DUAL;
 
 1)연산자
 -산술연산자(+,-,/,*)  --나머지 연산자는 없다 (함수로 제공해줌)
 -비교(관계)연산자(>,<,=,>=,<=,!=(<>)) --'크다'의 반대는 '작거나 같다'
 -논리연산자(NOT , AND, OR)  ---결과값은 참과 거짓  NOT은 단항자 // NOT이 제일 빨리 실행된다
 
사용예)HR 계정의 사원테이블(EMPLOYEES)에서 보너스를 구하고 
각 사원의 급여 지급액을 구하시오.
    보너스 = 기본급(SALARY)*영업실적(COMMISSION_PCT)
    지급액 = 기본급 +보너스
    Alias는 사원번호, 사원명, 기본급, 보너스, 지급액이다
    
    SELECT EMPLOYEE_ID AS 사원번호, 
    FIRST_NAME||' '||LAST_NAME AS 사원명, 
    SALARY AS 기본급, 
    COMMISSION_PCT AS 영업실적,            ---NULL 값이 사용되어지면 결과값도 무조건  NULL이다 (어떤 연산을 하든)
    NVL(SALARY * COMMISSION_PCT,0) AS 보너스, ---NVL함수
    SALARY + NVL(SALARY * COMMISSION_PCT,0) AS 지급액 
        FROM HR.EMPLOYEES;              --모든 사원에 대한 것이니 WHERE조건이 필요가 없다  --  .은 소속을 나타내주는 연산자(다른계정에 포함되어있는 테이블일때 사용)
                                        --NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다.
                                        --- 함수  :  NVL("값", "지정값") 

           
                                                    
                                                    
                                                    
                                                    
 
 사용예)회원 테이블에서 마일리지가 3000이상인 회원을 조회하시오---3000이상인게 WHERE의 조건으로 부여되어야한다
        Alias는 회원번호,회원명,마일리지,직업
    
    SELECT MEM_ID AS 회원번호,
    
       MEM_NAME AS 회원명,
       MEM_MILEAGE AS 마일리지,
        MEM_JOB AS 직업  
    FROM MEMBER
        WHERE MEM_MILEAGE>= 3000 ---(순서)행단위로 읽어서 마일리지 값을 비교해서 3000보다 큰지 작은지 확인하고 SELECT절을 출력한다
                                                        ---내림차순                         ---FROM WHERE SELECT 순으로 진행된다.
        ORDER BY 3 DESC;
     
     
     사용예)회원 테이블에서 마일리지가 3000이면서    --접속사로 연결해줌 or, and --
     거주지가 '대전'인 회원을 조회하시오
    Alias는 회원번호,회원명,마일리지,직업,성별
    성별난에는 '여성회원','남성회원', 중 하나를 출력
    
    SELECT MEM_ID AS 회원번호,
    MEM_NAME AS 회원명,
    MEM_MILEAGE AS 마일리지,
    MEM_JOB AS 직업,
    CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' THEN        
            '남성회원'
    ELSE
            '여성회원'
    END AS 성별
    FROM MEMBER
    WHERE MEM_MILEAGE >=3000 
    AND MEM_ADD1 LIKE '대전%'; ---기본주소가 대전으로 시작하면 조건만족 (%는 뒤에 어떤 글자가 와도 상관이 없다는 뜻)
    
    
    
    
사용예) 년도를 입력받아 윤년과 평년을 구별하시오

ACCEPT P_YEAR PROMPT '년도입력:'
DECLARE
V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
V_RES VARCHAR2(100);
BEGIN
IF (MOD(V_YEAR,4)=0 AND  MOD(V_YEAR,100)!=0)  OR
    (MOD(v_YEAR,400)=0) THEN
    V_RES:=V_YEAR||'년도는 윤년입니다.';
ELSE
    V_RES:=V_YEAR||'년도는 평년입니다.';
    
END IF;
DBMS_OUTPUT.PUT_LINE(V_RES);
END;

2)기타연산자  --많이 사용되어짐
-범위지정이나 복수개의 표현식을 지정할 때 등을 표현
-IN , ANY, SOME, ALL, BETWEEN, LIKE, EXISTS 등이 제공
(1)IN 연산자--다른 연산자와 사용 불가 (in안에 =이 포함되어있기때문에)
.질의 탐색을 위해 사용될 둘 이상의 표현식을 지정
.제시된 복수개의 자료 중 어느하나와 일치하면 전체 결과가 참을 반환
(사용형식)
컬럼명 IN (값1[,값2,....])
-'컬럼명'에 저장된 값이 '값1[,값2,....]' 중 어느하나와 일치하면
결과가 참(true)을 반환
- =ANY,  =SOME  으로 바꾸어 사용 가능함--다른 연산자와 사용가능
-연속된 값은 BETWEEN으로, 불연속적인 값의 비교는 IN으로 수행
-OR 연산자로 치환 가능 

사용예)사원테이블에서 부서번호 20,50,90,110에 속한 사원정보를
조회하시오. 
Alias는 사원번호,사원명,부서번호,급여
(OR 연산자 사용)
SELECT EMPLOYEE_ID AS 사원번호,
FIRST_NAME||' '||LAST_NAME AS 사원명,
DEPARTMENT_ID AS 부서번호,
SALARY AS 급여
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID =20
    OR DEPARTMENT_ID = 50
    OR DEPARTMENT_ID = 90
   OR DEPARTMENT_ID = 110
  ORDER BY 3; 

SELECT EMPLOYEE_ID AS 사원번호,
FIRST_NAME||' '||LAST_NAME AS 사원명,
DEPARTMENT_ID AS 부서번호,
SALARY AS 급여
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN(20,50,90,110)   ----이중 어느 하나가 참이면 전체가 참 ( WHERE  참이후 SELECT 출력)
    ORDER BY 3; 
    
    
    
(2) ANY(SOME)연산자
.IN 연산자와 유사한 기능제공 
.주어진 데이터 중 어느하나의 값과 ANY(SOME)앞에
기술된 관계연산자를 만족하면 참(true)인 결과를 반환
(사용형식)
컬럼명 관계연산자ANY|SOME (값1,[,값2,...])   ---오라클에서 공백은  하나와 하나를 구별하는 구별자야

사용예)사원테이블에서 부서번호 20,50,90,110에 속한 사원정보를
조회하시오. 
Alias는 사원번호,사원명,부서번호,급여
SELECT EMPLOYEE_ID AS 사원번호,
FIRST_NAME||' '||LAST_NAME AS 사원명,
DEPARTMENT_ID AS 부서번호,
SALARY AS 급여
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID =ANY(20,50,90,110)  
    ORDER BY 3; 
    
    
사용예) 회원테이블에서 회원들이 보유한 마일리지가 직업이 공무원인 회원들이 보유한 마일리지보다 많은 마일리지를 보유한 회원들을 조회하시오
ALIAS는 회원번호,회원명,직업,마일리지

SELECT MEM_ID AS 회원번호,
    MEM_NAME AS 회원명,
    MEM_JOB AS 직업,
    MEM_MILEAGE AS 마일리지
FROM MEMBER 
WHERE MEM_MILEAGE >=ANY (SELECT MEM_MILEAGE             --SUBCALL 연산자보다 먼저 실행되서 다 가져다 놓고 그 후 연산자 실행
                        FROM MEMBER 
                        WHERE MEM_JOB = '공무원');      --하나는 하나와 비교해야하는데 (SELECT)가 4개여서 비교할 수 없어서 에러; 그래서 ANY를 써줌

                        
 
 
 

 
 
 
 
        
        
        
        
        
                    
            