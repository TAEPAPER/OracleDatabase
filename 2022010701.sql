DELETE 문
 -테이블내의 자료를 삭제할 때 사용
-ROLLBACK의 대상

사용형식
DELETE FROM 테이블명
[WHERE조건];
WHERE 절이 생략되면 모든 자료를 삭제  

사용예) 테이블 GOODS의 모든 자료를 삭제
DELETE FROM GOODS; 

SELECT * FROM GOODS;

COMMIT;
SELECT *FROM GOODS;
 
 사용예) 테이블 GOODS의 모든 자료 중 상품코드가 'P102'보다 큰 자료를 삭제하시오

DELETE FROM GOODS;
    WHERE GOOD_ID >= 'P102';  --사전식으로 비교가 된다 A P ,..
    
    SELECT * FROM GOODS;  ---뒤에 꼭 확인 작업이 필요해
    

    