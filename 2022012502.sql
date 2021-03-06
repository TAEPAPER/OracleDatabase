    2022-01-25-02) 오라클 객체
    -오라클에서 제공하는 OBJECT로 VIEW,INDEX,PROCEDURE,FUNCTION,PACKAGE,TRIGGER,SYNONYM,SEQUENCE,DIRECTORY,
    등이 있음
    -생성 시 CREATE, 제거시 DROP 명령 사용
    
    1.VIEW--FROM 절에 VIEW 나올 수 있음!//테이블과는 독립적으로 생성(내가 필요한 정보가 여러테이블에 나누어 있을 때 사용)
    -가상의 테이블
    -기존의 테이블이나 뷰를 통하여 새로운 SELECT문의 결과를
     테이블처럼 사용
    -테이블과 독립적
    -필요한 정보가 여러 테이블에 분산된 경우 
    -테이블의 모든 자료에 대한 접근을 제한하고 필요한 자료만을 제공하는 경우
    (사용형식)
    CREATE [OR REPLACE-] VIEW 뷰이름[(컬럼LIST)] --1(컬럼명)
    AS 
        SELECT 문 --2--3   
        [WITH CHECK OPTION]--뷰에서 해당조건을 위배하는 값으로 바꿀 수 없다 --변경은 허용
        [WITH READ ONLY]; --읽기 전용 (변경할 수 없다는 이야기) 원래는 : 뷰를 고치면 원본도 수정 //
                          --두개를 동시에 쓸 수 없음
                          
    사용예)회원테이블에서 마일리지가 2000이상인 회원의 회원번호,이름,직업,마일리지로 구성된 뷰를 생성하시오
    
    CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
    AS
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 이름,
            MEM_JOB AS 직업,
            MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000;
 ---------------------------------
    CREATE OR REPLACE VIEW V_MEM
    AS
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 이름,
            MEM_JOB AS 직업,
            MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000;
 ----------------------------------
    CREATE OR REPLACE VIEW V_MEM
    AS
    SELECT MEM_ID,
            MEM_NAME,
            MEM_JOB,
            MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000; 
    SELECT * FROM V_MEM; --뷰를 테이블처럼
     
    사용예) 생성된 뷰 V_MEM에서 'r001'회원의 마일리지를 500으로 변경하시오
    --뷰변경
    
    UPDATE V_MEM
    SET MEM_MILEAGE = 500
    WHERE MEM_ID = 'r001';
    
    SELECT * FROM V_MEM;
    
    SELECT MEM_ID,MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_ID = 'r001';   --뷰를 바꾸면 원본테이블도 바뀐다
   ------------------------------------ 
    
     CREATE OR REPLACE VIEW V_MEM
    AS
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 이름,
            MEM_JOB AS 직업,
            MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000
   WITH CHECK OPTION; 
    
    사용예)뷰 V_MAX의 'r001'회원의 마일리지를 1500으로 변경하시오.
     UPDATE V_MEM
    SET 마일리지 = 1500
    WHERE 회원번호 = 'r001';  --조건 위배 해서 업데이트 실행 할 수 없음!
    
    **회원테이블에서 'n001' 회원의 마일리지를 2500으로 변경하시오
    UPDATE MEMBER
    SET MEM_MILEAGE = 2500
    WHERE MEM_ID = 'n001';
    
       **회원테이블에서 'f001' 회원의 마일리지를 1500으로 변경하시오
    UPDATE MEMBER
    SET MEM_MILEAGE = 1500 --원본테이블 뭘해도 지장없어!
    WHERE MEM_ID = 'f001';
    
    SELECT * FROM V_MEM; --변경되어진 내용 뷰에 반영
    COMMIT;
   -------------------------------------------- 
    CREATE OR REPLACE VIEW V_MEM(MID,MNAME,MJOB,MILE)
    AS
    SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 이름,
            MEM_JOB AS 직업,
            MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_MILEAGE >=2000
    WITH READ ONLY;
    
    **생성된 뷰 V_MEM의 모든 자료를 삭제하시오
    DELETE FROM V_MEM;
    
    **VIEW 사용시 주의할 점
    (1) VIEW 생성시 WITH절을 사용한 제약조건이 부여된 경우 ORDER BY절 사용불가
    (2) VIEW 생성에 집계함수가 사용된 경우  뷰에 INSERT,UPDATE,DELETE를 사용할 수 없음
    (3) VIEW 컬럼이  표현식(CASE~WHEN)이나 함수가 사용된 경우 컬럼추가 또는 수정이 불가
    (4) Pseudo COLUMN(CURVAL, NEXTVAL등 ) 사용 불가--시퀀스 객체에서 제공되어지는 것
    
    사용예)
        CREATE OR REPLACE VIEW V_CART
        AS
        SELECT CART_PROD AS CID,
               COUNT(*) AS CNT
        FROM CART
        WHERE CART_NO LIKE '200505%'
        GROUP BY CART_PROD
        ORDER BY 1;
        
        SELECT * FROM V_CART
        
        UPDATE V_CART  --집계함수가 사용된 경우 INSERT DELETE UPDATE를 사용할 수 없다
        SET CNT = 10
        WHERE CID = 'P101000001' 
    
    사용예)
        CREATE OR REPLACE V_MEM02
        AS
        SELECT MEM_ID  AS MID,
               MEM_NAME AS MNAME,
               CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1'  OR 
                         SUBSTR(MEM_REGNO2,1,1) = '3' THEN
                         '남성'
                ELSE  '여성'
                END AS GUBUN
        FROM MEMBER;
        
SELECT * FROM V_MEM02;

        UPDATE V_MEM02
           SET GUBUN = '여성회원'
           WHERE GUBUN = '여성';
        
    
    