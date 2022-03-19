2022-01-10-02) 함수(FUNCTION)
-자주 사용되는 모듈을 미리 컴파일하여 실행 가능한 상태로 저장된 프로그램
-오라클에서 제공하는 함수와 사용자가 작성하는 함수가 있다.
-함수는 중첩사용이 가능(예외로 집계함수간의 중첩은 허용되지 않음)
-문자열 함수, 숫자함수,날짜함수,형변환함수,널처리함수,집계함수 등이 제공

1.문자열함수
 1)CONCAT(C1,C2) ---매개변수 : 외부로부터 제공받은 데이터 통로 역할 
    .주어진 두 문자열 C1과 C2를 결합하여 새로운 문자열 반환 --두개를 입력받아서 
    .문자열 결합 연산자 '||'와 같은 기능 --ADD1||' '||ADD2(문자열3개 합침) 를 하려면  CONCAT두번 사용해야해
사용예)사원테이블에서 FIRST_NAME과  FIRST_NAME LAST_NAME 을 결합하여 출력하시오
SELECT EMPLOYEE_ID AS 사원번호, 
FIRST_NAME AS 이름1,
LAST_NAME AS 이름2,
CONCAT(FIRST_NAME,LAST_NAME) AS "결합된 이름" --네임사이에 공백이 없어
FROM HR.EMPLOYEES;


SELECT EMPLOYEE_ID AS 사원번호, 
FIRST_NAME AS 이름1,
LAST_NAME AS 이름2,
CONCAT(CONCAT(FIRST_NAME,' '),LAST_NAME) AS "결합된 이름1",
FIRST_NAME||' '||LAST_NAME AS "결합된 이름2"
FROM HR.EMPLOYEES;

2)LOWER(C1),UPPER(C1),INITCAB(C1)
.LOWER(C1): 주어진 문자열 C1에 포함된 모든 문자를 소문자로 변환
.UPPER(C1): 주어진 문자열 C1에 포함된 모든 문자를 대문자로 변환
.INITCAB(C1) : 주어진 문자열C1의 단어 시작글자만 대문자로 변환

사용예)상품테이블에서 분류코드가 'p102'에 속한 상품을 조회하시오
ALIAS는 상품코드,상품명,매입가격,매출가격
SELECT PROD_ID AS 상품코드,
PROD_NAME AS 상품명,
PROD_COST AS 매입가격,
PROD_PRICE AS 매출가격
FROM PROD             
WHERE LOWER(PROD_LGU) = 'p102'; --문법적으로는 맞으나 조건에 맞는 데이터가 없다? --LOWER를 써줘서 소문자도 되게 한다 


**사원테이블의 FIRST_NAME과 LAST_NAME을 모두 소문자로 변경하여 저장하시오

--변경해야하니까  UPDATE
UPDATE HR.EMPLOYEES
SET FIRST_NAME = LOWER(FIRST_NAME),
    LAST_NAME = LOWER(LAST_NAME);
    COMMIT;
    
    SELECT EMPLOYEE_ID, FIRST_NAME,LAST_NAME
    FROM HR.EMPLOYEES;
    
사용예) 사원테이블의 FIRST_NAME과 LAST_NAME을 결합하되 중간에 공백을 삽입하고 단어 첫글자를 대문자로 변환하여 출력하시오.
SELECT EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    INITCAP(FIRST_NAME||' '||LAST_NAME),
    EMP_NAME
FROM HR.EMPLOYEES;
                                                                                       

    




