    2022-0125-03)SEQUENCE 
    - ���ʴ�� �����Ǵ� �������� �� ��ȯ
    - ���̺�� �������̸� ���� ���̺긮 ���ÿ� ��� ����
    -�⺻Ű�� ���ų� PK�� �ǹ��ְ� ������ �ʾƵ� �Ǵ� ���
    -�ڵ������� �ο��Ǵ� ��ȣ�� �ʿ��� ��� --EX)CART_NO
    --�������� �Ųٷ� �� �� ����(������ ������ �����Ǿ��� �� ����)
    (�������)
     CREATE [OR REPLACE ] SEQUENCE ��������
        [START WITH n] --���۰�(n)���� �����ϸ� MINVALUE�� �Ҵ�                          //�ɼǵ��� �Ƚᵵ �ȴ�!!
        [INCREMENT BY n]--����[����]��, �����̸� ���Ұ� //�����Ǹ� n�� 1�̴�
        [MAXVALUE n|NOMAXVALUE]--�ִ밪 ���� , �⺻�� NOMAXVALUE�̸�(10^27)
        [MINVALUE n|NOMINVALUE] --�ּҰ� ����, �⺻�� NOMINVALUE(1)
        [CYCLE | NOCYCLE]--�ִ�(�ּ�)�� ���� �� �ٽ� ��������������, �⺻�� NOCYCLE
        [CACHE n|NOCACHE]--�޸𸮿� �̸� ��������, �⺻�� CACHE 20
        [ORDER |NOORDER] -- ���� ���û��״�� ������ ������ ��������, NOORDER�� �⺻ 
       
    -SEQUENCE���� ���Ǵ� �ǻ��÷�
  ------------------------------------
    �ǻ��÷�            �ǹ�          
  ------------------------------------
 ��������.CURRVAL    �������� ���� �ִ� ���簪     
 ��������.NEXTVAL    �������� ���� �� ��ȯ
 --------------------------------------
 **�������� ������ �� ó�� ����Ǿ���ϴ� ����� 
   NEXTVAL�̾����   --ó�� ��������� ������ ����ֱ� ������ CURRVAL �� ������
   
   (��뿹)
      CREATE  SEQUENCE SEQ_SAMPLE
        START WITH 10;
        
        SELECT SEQ_SAMPLE.NEXTVAL FROM DUAL;
        --�������ʹ� CURR�� �� �־�
        SELECT SEQ_SAMPLE.CURRVAL FROM DUAL;
       -- 10�� ���̻� �����Ұ��ϴ�  //���� �� �ٽ� �����ؾ� �� �� �־�(������ ���� ��)
       
       ��뿹)�з����̺� �����ڷḦ �߰� �Ͻÿ�
             ��, LPROD_ID�� �������� �����Ͽ� ����� ��
             [�ڷ�]
             �з��ڵ�             �з���
        ---------------------------------------
            P501                  ��깰
            P502                  ���깰
            P503                  �ӻ깰
        ----------------------------------------
    (������ ����)
      CREATE SEQUENCE SEQ_LPROD_ID
      START WITH 10;
        
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
        VALUES(SEQ_LPROD_ID.NEXTVAL,'P501','��깰');
          
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
        VALUES(SEQ_LPROD_ID.NEXTVAL,'P502','���깰');
          
         INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
          VALUES(SEQ_LPROD_ID.NEXTVAL,'P503','�ӻ깰');
       
        SELECT * FROM LPROD;
        
        ��뿹) ������ 2005�� 7�� 8���̶��ϰ� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�(������ ���)
        CREATE OR REPLACE PROCEDURE PROC_CARTNO_CREATE(
        P_DATE IN DATE,  --IN�� ���� �Է¿�
        P_CNUM OUT NUMBER)--OUT�� ���� ��¿�
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
        
     (����)
     DECLARE
     V_CNO CHAR(13);
     V_CNUM NUMBER:=0;
     BEGIN
     PROC_CARTNO_CREATE('20050708',V_CNUM);
     V_CNO:='20050708'||TRIM(TO_CHAR(V_CNUM,'00000'));
     DBMS_OUTPUT.PUT_LINE('��ٱ��� ��ȣ : '||V_CNO);
     END;
        
    
    **�������� ����� �� ���� ���
    .SELECT, UPDATE, DELETE ���� ���Ǵ� SUBQUERY
    .VIEW�� QUERY
    .DISTINCT�� ���� SELECT��
    .GROUP BY,ORDER BY���� �ִ� SELECT��
    .SELECT ���� WHERE����
    
    
              
        