2022-01-05-02) 데이터타입 //오라클에 사용되어지는 오라클 타입

-오라클에 사용되는 데이터 타입은 문자열,숫자,날짜(덧셈뺄셈기능 유,곱하기 나누기는 없음//타임스탬프),이진자료(동영상자료나 이미지 자료는 이진자료로 변환되어서 사용) 등이 제공
//오라클에서 ""는 컬럼 별칭을 기술할 때나 형식지정 문자열 중에 사용자 형식지정을 사용할때 사용
//오라클에서는 반드시''사용

//오늘날짜에서 서기 1년 1일을 빼면 전체 경과된 일수가 나옴

--1.문자열자료
 .문자열자료('')로 묶인 자료를 저장하기 위한 타입 //''안에서만 대소문자 구분하고 밖에서는 대소문자구분안한다
 .가변길이와 고정길이로 구분   --CHAR(10)하고 11개를 하면 저장되어지지 않는다. ,가변길이 데이터타입은 Char을 제외한 타입들 //사용자가 사용한 공간만큼만 사용되고 나머지는 반납된다
 
-- 1)CHAR(n[BYTE|CHAR])  --[]는 생략가능 - 디폴트로 바이트가 됨- 
 .고정길이 데이터 저장
 .최대 2000 BYTE까지 처리 가능
 .'n[BYTE|CHAR]' : 확보하는 저장공간의 크기 지정 CHAR은 글자수를 의미/ 최대 2000BYTE까지 처리한다. /한글은 666글자(한글은 한글자가 3바이트)
 .'BYTE' 가  default이며 'CHAR'은 n이 문자갯수를 의미
 .한글 한글자는 3BYTE 임
 .보통 기본키나 길이가 고정되고 고정된길이가 중요한 경우(주민번호나 우편번호 등)에 사용 
 
 사용예)
    CREATE TABLE TEMP_01(
        COL1 CHAR(10 BYTE),
        COL2 CHAR(10 CHAR),
        COL3 CHAR(10)); --고정길이니까 빈공간이 생김
        
    INSERT INTO TEMP_01(COL1,COL2,COL3)
        VALUES('대전시','대전시 중구 오류동','중구');  --한글 하나는 3바이트 공백하나는 1바이트 차지  
    
    SELECT*FROM TEMP_01;
    
    SELECT LENGTHB(COL1),   --B는 바이트를 말함 바이트로 컬럼의 길이를 나타내시오라는 뜻 --고정길이니까 덜 쓰더라도 공간을 차지한다
           LENGTHB(COL2),
           LENGTHB(COL3)
        FROM TEMP_01;
        
    
    INSERT INTO TEMP_01 VALUES('대한','대한민국','민국'); --남은 글자는 영어기준 --대한민국 : 12바이트 더하기 나머지 6바이트 :18바이트 CHAR잘 안씀
    SELECT*FROM TEMP_01;
    
    
-- 2)VARCHAR2(n[BYTE|CHAR])
    .가변길이 문자열 저장
    .VARCHAR와 동일 기능 제공
    .최대 4000BYTE 저장가능 
    .사용자가 정의한 데이터를 저장하고 남는 기억공간은 반환
    .가장 널리 사용되는 타입
사용예) N이 붙으면 다국어 지원 (NATIONAL) -UTF-8로 변환해서 저장해준다
가변길이는 남는게 없다 (잘라서 반환함) 

    CREATE TABLE TEMP_02(
        COL1 VARCHAR2(4000 BYTE),
        COL2 VARCHAR2(4000 CHAR),
        COL3 VARCHAR2(4000));
    
    INSERT INTO TEMP_02 
        VALUES('IL POSTINO','PERSIMMON','APPLE');

    SELECT * FROM TEMP_02; --공백이 없다 /저장하고 남은거 다 잘라고 반환해
    SELECT LENGTHB(COL1),   --사용된 공간만 나온다
            LENGTHB(COL2),
            LENGTHB(COL3)
        FROM TEMP_02; 
        
 -- 3)LONG  --길이 없음
    .가변길이 자료 저장
    .최대 2GB까지 저장가능
    .일부 기능은 사용불가
    .한 테이블에 1개의 LONG 타입만 사용가능(기능개선 중단)
    .CLOB 타입으로 대체-- 여러개 사용해도 무관  --LENGTHB가능
    .SELECT문의 SELECT절, UPDATE문의 SET절, INSERT문의 
     VALUES절에서만 사용

사용예)
    CREATE TABLE TEMP_03(
    COL1 LONG,              ----두개이상은 만들 수 없다
    COL2 VARCHAR2(200));  
    
    INSERT INTO TEMP_03 
        VALUES ('대전시 중구 계룡로 846 3층','대덕인재개발원');
    SELECT * FROM TEMP_03;  ---나머지 잘라서 반환
    
    SELECT LENGTHB(COL1),
           LENGTHB(COL2)
        FROM TEMP_03;   ---LONG타입 오류가 나온다
        
        SELECT SUBSTR(COL2,2,5) FROM TEMP_03; --2번째 글자에서 5글자를 뗀다
        SELECT SUBSTR(COL1,2,5) FROM TEMP_03;---오류난다 LONG은 오류가 난다
        
--3)CLOB(Character Large OBjects)  ----BLOB는 BINARY 이진!
    .가변길이 문자열을 저장
    .최대 4GB까지 처리 가능
    .한 테이블에 복수개의 CLOB 사용가능
    .일부 기능은 DBMS_LOB API지원을 받아야 함(예 LENGTHB 등은 --사용자들이 쓸 수 있는 함수가 저장되어 있는 위치.
    제한)
사용예)
    CREATE TABLE TEMP_04(
        COL1 CLOB,
        COL2 CLOB,
        COL3 VARCHAR2(4000));
    
    INSERT INTO TEMP_04
        VALUES ('대전시 중구 계룡로 846 3층','대덕인대개발원','ILPOSTINO');
    SELECT * FROM TEMP_04;
    SELECT DBMS_LOB.GETLENGTH(COL1),  ----CLOB로 있기때문에 LENGTHB 사용되어질 수 없다 그래서  DBMS_LOB API의 지원을 받는다
            LENGTH(COL2),             -----LENGTH  는 글자수를 세는 것이다
            LENGTHB(COL3)
        FROM TEMP_04;
        
    -------------------------문자열 자료 끝-------------------------------
    
    추가질문 : 형변환 하나요?
      A : 네 합니당
        
        예)
        '76'+1900
        자바에서는 761900      문자열 우선
        오라클에서는 1976      숫자 우선
     
     
     
     
    
    
            
    


    
    
    
    
    
    
    
    
        
        
 







