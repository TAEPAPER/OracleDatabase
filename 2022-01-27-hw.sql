사원테이블에서 **부서별** 평균임금을 구하고 해당부서에 속한 사원 중 자기부서의 평균 급여보다 많은 급여를 받는 사원을 조회하시오
        ALIAS는 사원번호, 사원명, 부서명, 부서평균급여, 급여
          
          (메인쿼리 : 사원번호, 사원명, 부서명, 부서평균급여,급여)
          
    SELECT A.EMPLOYEE_ID AS 사원번호, 
           A.EMP_NAME AS 사원명, 
           B.DEPARTMENT_NAME AS 부서명, 
           C.DAVG    AS 부서평균급여,
           A.SALARY    AS 급여
    FROM  HR.EMPLOYEES A, HR.DEPARTMENTS B, 
          (SELECT DEPARTMENT_ID AS DNAME , ROUND(AVG(SALARY)) AS DAVG
            FROM HR.EMPLOYEES
            GROUP BY DEPARTMENT_ID
            ORDER BY 1) C
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
       AND B.DEPARTMENT_ID = C.DNAME
       AND A.SALARY > C.DAVG
          ORDER BY 1;
    
    
    
    
    
    (서브쿼리 : 부서별 평균 급여)
    SELECT DEPARTMENT_ID AS DNAME , ROUND(AVG(SALARY)) AS DAVG
    FROM HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY 1;