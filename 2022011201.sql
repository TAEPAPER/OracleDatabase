 20220112-01)날짜함수
    1)SYSDATE
    -시스템에서 제공하는 날짜정보(년,월,일,시,분,초) 반환
    -덧셈(장래에 도래할 날짜)과 뺄셈(지나간 날짜) 가능
    -시간정보(시,분,초) 출력은 TO_CHAR함수 사용
    
    사용예)
    SELECT SYSDATE, SYSDATE-20, SYSDATE +20
    FROM DUAL;
    
    SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI;SS'), --시간정보(시,분,초) 출력은 TO_CHAR함수 사용 , TO_DATE 함수는 문자를 숫자로 바꿔줌
           TO_CHAR(SYSDATE-20,'YYYY-MM-DD HH24:MI;SS'),
           TO_CHAR(SYSDATE+20,'YYYY-MM-DD HH24:MI;SS')
    FROM DUAL;
    
    2)ADD_MONTHS (d1,n)
    -주어진 날짜 d1에 n개월을 더한 날짜 반환
    사용예)  헬스장의 자격을 따질 때 (유효한 기간)
    
    SELECT ADD_MONTHS(SYSDATE,4) FROM DUAL;
    
    SELECT EMP_NAME,
           HIRE_DATE,
           ADD_MONTHS(HIRE_DATE,3)
        FROM HR.EMPLOYEES;
        
        
    3)NEXT_DAY(d1,c)
    -d1 일자 이후 가장 먼저(빠른)만나는 C요일의 날짜 변환
    -C는 요일을 지칭하며 '일요일''일''월요일''월'등으로 기술

    사용예)
     SELECT NEXT_DAY(SYSDATE,'월'),
            NEXT_DAY(SYSDATE,'수요일')
       FROM DUAL;
       
     4)LAST_DAY(D1)
    -제시된 날짜 D1에 포함된 월의 마지막일자를 반환
    -주로 2월의 마지막일을 반환 받을 때 사용
    
    사용예) 
    매입테이블(BUYPROD)에서 2005년 2월 일자별 매입집계를 조회하시오
    
    ALIAS는 일자, 수량합계 매입금액합계
    SELECT BUY_DATE AS 일자,
           SUM(BUY_QTY) AS 수량합계,
           SUM(BUY_QTY*BUY_COST) AS 매입금액합계
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
    
    GROUP BY BUY_DATE
    ORDER BY 1;
    
    5)EXTRACT(fmt FROM d1) --D1은 날짜자료
    -제시된 날짜자료 d1에서 'fmt'에 해당하는 요소를 추출하여 반환
    -반환되는 데이터 타입은 **숫자**
    -'fmt(Format String:형식문자열)'은 **YEAR, MONTH,DAY,HOUR,MINUTE,SECOND**중 하나이어야 함
    -그래서 연산가능!
    SELECT EXTRACT (YEAR FROM SYSDATE)
    FROM DUAL;
    
    사용예) 회원테이블에서 연령을 구하고 각 년령대별 회원수를 조회하시오
    
    ALIAS는 연령대, 회원수
    SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)  
          - EXTRACT(YEAR FROM MEM_BIR)),-1)||'대' AS 연령대, --나이에서 일의자리에서 자리버림 하세요
           COUNT(*) AS 회원수  --회원수 세는 것 ,집계함수
    FROM MEMBER
    GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)  --집계함수쓸 때는 꼭 GROUP BY  해줘야해
          - EXTRACT(YEAR FROM MEM_BIR)),-1)
    ORDER BY 1;
    
    사용예)사원테이블에서 1월에 입사한 사원들을 조회하시오 --이번달 익스트랙 함수 써서 월 뽑기
    ALIAS는 사원번호, 사원명, 부서코드, 입사일
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서코드,  --입사일 빠른사람 부터 출력
           HIRE_DATE AS 입사일
    FROM HR.EMPLOYEES
    WHERE EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM HIRE_DATE)
    ORDER BY 4;
    
    
    6)MONTHS_BETWEEN(d1,d2)
       -제시된 두 날짜자료 사이의 월수를 반환
       사용예)1998년 3월 10일에 태어난 사람의 정확한 나이는?
    SELECT  TRUNC(ROUND(MONTHS_BETWEEN(
            SYSDATE, TO_DATE('19980310')))/12)||'년'||
            MOD(ROUND(MONTHS_BETWEEN(
           SYSDATE, TO_DATE('19980310'))),12)||'개월'
     --개월수가 나옴 여기에  ROUND 하고 12개월로 나눈걸 또 ROUND한다
    FROM DUAL;
    
    
    
    
       
       
        
        
    
    