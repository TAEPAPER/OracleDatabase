2022-0104-02) ���̺� ����
.CREATE TABLE �������� ����
(ǥ������)
CREATE TABLE ���̺���(
     �÷��� ������Ÿ��[(ũ��)] [NOT NULL][DEFAULT ��][,]
                            :
     �÷��� ������Ÿ��[(ũ��)] [NOT NULL][DEFAULT ��][,] 
     [CONSTRAINT �⺻Ű�ε��� PRIMARY KEY(�÷���[,�÷���,...])[,]]
     [CONSTRAINT  �ܷ�Ű�ε��� FOREIGN KEY (�÷���)
        REFERENCES ���̺���(�÷���)[,]]
     [CONSTRAINT �ܷ�Ű�ε��� FOREIGN KEY(Į����)
        REFERENCES ���̺���(�÷���)];


��뿹)
    CREATE TABLE GOODS(
        GOOD_ID CHAR(4) NOT NULL,
        GOOD_NAME VARCHAR2(30),
        PRICE NUMBER(7),
        CONSTRAINT pk_goods PRIMARY KEY(GOOD_ID));
    
    CREATE TABLE CUSTOMERS(
        CUST_ID CHAR(3),
        CUST_NAME VARCHAR2(20),
        CUST_ADDR VARCHAR2(100),
        CONSTRAINT pk_customers PRIMARY KEY (CUST_ID));
    
    CREATE TABLE ORDERS(
        ORDER_ID CHAR(12),--�⺻Ű
        ORDER_DATE DATE DEFAULT SYSDATE,
        CUST_ID CHAR(3), --�ܷ�Ű
        CONSTRAINT pk_oders PRIMARY KEY (ORDER_ID),
        CONSTRAINT fk_oders_cust FOREIGN KEY (CUST_ID)
            REFERENCES CUSTOMERS(CUST_ID)); 

    CREATE TABLE ORDER_GOODS(
        ORDER_ID CHAR(12),
        GOOD_ID CHAR(4),
        ORDER_QTY NUMBER(4) DEFAULT 0,
        CONSTRAINT pk_ogoods PRIMARY KEY (ORDER_ID,GOOD_ID),           //�ܷ�Ű �̸鼭 �⺻Ű
        CONSTRAINT fk_ogoods_order FOREIGN KEY (ORDER_ID)
            REFERENCES ORDERS(ORDER_ID),
        CONSTRAINT fk_ogoods_goods FOREIGN KEY (GOOD_ID)         
            REFERENCES GOODS(GOOD_ID));