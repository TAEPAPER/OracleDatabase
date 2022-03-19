    2022-0125-03)SEQUENCE 
    - 차례대로 증가되는 연속적인 값 반환
    - 테이블과 독립적이며 여러 테이브리 동시에 사용 가능
    -기본키가 없거나 PK를 의미있게 만들지 않아도 되는 경우
    -자동적으로 부여되는 번호가 필요한 경우 --EX)CART_NO
    --시퀀스는 거꾸로 갈 수 없어(이전의 값들은 참조되어질 수 없어)
    (사용형식)
     CREATE [OR REPLACE ] SEQUENCE 시퀀스명
        [START WITH n] --시작값(n)설정 생략하면 MINVALUE가 할당                          //옵션들은 안써도 된다!!
        [INCREMENT BY n]--증가[감소]값, 음수이면 감소값 //생략되면 n은 1이다
        [MAXVALUE n|NOMAXVALUE]--최대값 설정 , 기본은 NOMAXVALUE이며(10^27)
        [MINVALUE n|NOMINVALUE] --최소값 설정, 기본은 NOMINVALUE(1)
        [CYCLE | NOCYCLE]--최대(최소)값 도달 후 다시 시퀀스생성여부, 기본은 NOCYCLE
        [CACHE n|NOCACHE]--메모리에 미리 생성여부, 기본은 CACHE 20
        [ORDER |NOORDER] -- 위의 선택사항대로 시퀀스 생성을 보증여부, NOORDER이 기본 
       
    -SEQUENCE에서 사용되는 의사컬럼
  ------------------------------------
    의사컬럼            의미          
  ------------------------------------
 시퀀스명.CURRVAL    시퀀스가 갖고 있는 현재값     
 시퀀스명.NEXTVAL    시퀀스의 다음 값 반환
 --------------------------------------
 **시퀀스가 생성된 후 처음 수행되어야하는 명령은 
   NEXTVAL이어야함   --처음 만들어지고 나서는 비어있기 때문에 CURRVAL 쓸 수없다
   
   (사용예)
      CREATE  SEQUENCE SEQ_SAMPLE
        START WITH 10;
        
        SELECT SEQ_SAMPLE.NEXTVAL FROM DUAL;
        --이제부터는 CURR쓸 수 있어
        SELECT SEQ_SAMPLE.CURRVAL FROM DUAL;
       -- 10은 더이상 참조불가하다  //삭제 후 다시 생성해야 쓸 수 있어(세심한 주의 필)
       
       사용예)분류테이블에 다음자료를 추가 하시오
             단, LPROD_ID는 시퀀스를 생성하여 사용할 것
             [자료]
             분류코드             분류명
        ---------------------------------------
            P501                  농산물
            P502                  수산물
            P503                  임산물
        ----------------------------------------
    (시퀀스 생성)
      CREATE SEQUENCE SEQ_LPROD_ID
      START WITH 10;
        
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
        VALUES(SEQ_LPROD_ID.NEXTVAL,'P501','농산물');
          
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
        VALUES(SEQ_LPROD_ID.NEXTVAL,'P502','수산물');
          
         INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
          VALUES(SEQ_LPROD_ID.NEXTVAL,'P503','임산물');
       
        SELECT * FROM LPROD;
        
        사용예) 오늘이 2005년 7월 8일이라하고 장바구니번호를 생성하시오(시퀀스 사용)
        CREATE OR REPLACE PROCEDURE PROC_CARTNO_CREATE(
        P_DATE IN DATE,  --IN을 쓰면 입력용
        P_CNUM OUT NUMBER)--OUT을 쓰면 출력용
        IS
         V_NUM NUMBER := 0;
         V_CNO CHAR(9):= TO_CHAR(P_DATE,'YYYYMMDD')||'%';
        BEGIN
        SELECT MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1
                INTO V_NUM
                FROM CART
                WHERE CART_NO LIKE V_CNO;
        P_CNUM := V_NUM;   
        END;
        
     (실행)
     DECLARE
     V_CNO CHAR(13);
     V_CNUM NUMBER:=0;
     BEGIN
     PROC_CARTNO_CREATE('20050708',V_CNUM);
     V_CNO:='20050708'||TRIM(TO_CHAR(V_CNUM,'00000'));
     DBMS_OUTPUT.PUT_LINE('장바구니 번호 : '||V_CNO);
     END;
        
    
    **시퀀스를 사용할 수 없는 경우
    .SELECT, UPDATE, DELETE 문에 사용되는 SUBQUERY
    .VIEW의 QUERY
    .DISTINCT가 사용된 SELECT문
    .GROUP BY,ORDER BY절이 있는 SELECT문
    .SELECT 문의 WHERE저리
    
    
              
        