    2022-02-08-01)트리거
    
    **HR 계정의 사원테이블에 퇴직일자 컬럼을 추가하시오
      ALTER TABLE HR.EMPLOYEES ADD(RETIRE_DATE DATE);
      
    **HR 계정에 퇴직자 테이블을 생성하시오
      테이블명 : RETIRES
      컬럼명        테이터타입      NULLABLE     PK/FK
------------------------------------------------------
    EMPLOYEE_ID    NUMBER(6)      N.N          PK & FK
    RETIRE_DATE    DATE
    JOB_ID         VARCHAR2(10)                 FK
    DEPARTMENT_ID   NUMBER(4,0)                 FK
------------------------------------------------------

    CREATE TABLE RETIRES(
    EMPLOYEE_ID    NUMBER(6),
    RETIRE_DATE    DATE,
    JOB_ID         VARCHAR2(10),
    DEPARTMENT_ID   NUMBER(4),
    CONSTRAINT pk_retires PRIMARY KEY(EMPLOYEE_ID),
    CONSTRAINT fk_ret_emp FOREIGN KEY(EMPLOYEE_ID)
        REFERENCES EMPLOYEES(EMPLOYEE_ID),
    CONSTRAINT fk_ret_jobs FOREIGN KEY(JOB_ID)
        REFERENCES JOBS(JOB_ID),    
    CONSTRAINT fk_ret_dept FOREIGN KEY(DEPARTMENT_ID)
        REFERENCES DEPARTMENTS(DEPARTMENT_ID));
    
    
    
    
    사용예)사원테이블에서 2003년 이전에 입사한 사원들을 퇴직처리하려한다.
          퇴직자는 사원테이블 퇴직일자에 오늘날짜로 변경하고 퇴직자테이블에 정보를 입력해야한다.
       
       CREATE TRIGGER tg_retire
       BEFORE UPDATE ON EMPLOYEES   --업데이트 일어나기 전에 비긴엔드 블럭이 먼저 실행되어진다
       FOR EACH ROW --**각행마다 트리거가 실행될 수 있도록 만들어줌**   (업데이트행마다 트리거 실행)
       BEGIN
       INSERT INTO RETIRES   --인서트문은 8번 실행되어진다(FOR EACH ROW)
              VALUES(:OLD.EMPLOYEE_ID, SYSDATE, 
                     :OLD.JOB_ID,:OLD.DEPARTMENT_ID);
       END;
       
       UPDATE EMPLOYEES 
       SET RETIRE_DATE = SYSDATE
       WHERE HIRE_DATE <= TO_DATE('20030101'); 
       
       
        
    
        
        
        
        
        
        