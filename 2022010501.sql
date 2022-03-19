20220105-01
2.ALTER
-생성된 객체의 성격, 구조, 이름 등을 변경


    1)컬럼 추가
    ALTER TABLE 테이블명 ADD(컬럼명 데이터타입[(크기)][,                //추가할 대상이 되어지는 테이블 변경은MOTIFY 삭제는 DROP
                            컬럼명 데이터타입[(크기)],,,...]
        
        사용예) 상품테이블(GOODS)에 매입가격(COST)컬럼을 추가하시오
        매입가격은 숫자 7자리 정수임
        ALTER TABLE GOODS ADD(COST NUMBER(7));
    
    2)컬럼 변경(데이터타입,크기)
    ALTER TABLE 테이블명 MODIFY(컬럼명 데이터타입[(크기)][,                //변경은 MOTIFY 삭제는 DROP
                               컬럼명 데이터타입[(크기)],,,...];
    
     상품테이블(GOODS)에 매입가격(COST)컬럼의 데이터타입을
     변경하시오.  데이터타입은 가변길이 문자열 7자리
    ALTER TABLE GOODS MODIFY(COST VARCHAR2(7));
    
    
    2)컬럼 삭제
    ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
    
    COMMIT;   //하드디스크에가서 저장하십시오

    ALTER TABLE GOODS DROP COLUMN COST;      //DROP은 ROLLBACK의 대상이 될 수 없다 //
    
    3)컬럼이름 변경
    ALTER TABLE 테이블명 RENAME COLUMN old_컬럼명 TO new_컬럼명;
    
    사용예)상품테이블의 단가컬럼명(PRICE)를 G_PRICE로 변경하시오
    ALTER TABLE GOODS RENAME COLUMN PRICE TO G_PRICE;
    
    5)제약사항(기본키 및 외래키) 추가
    ALTER TABLE 테이블명 ADD CONSTRAINT 기본키/외래키인덱스
                PRIMARY/FOREIGN KEY(컬럼명,[컬럼명,,,,])
                [REFERENCES 테이블명(컬럼명)];
                
    6)제약사항(기본키 및 외래키) 삭제
    ALTER TABLE 테이블명 DROP CONSTRAINT 기본키/외래키인덱스;
    
    7)테이블 이름변경
    ALTER TABLE old_테이블명 RENAME TO new_테이블명;  //먼저 기본키/외래키 설정안해놓고 테이블 만들어 놓고 나중에 관계파악하고 기본키설정해줌
    
    
    
    
    
    
    
    


    
    
        
