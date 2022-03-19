    2022-02-07-01) Ʈ����(TIRGGER)
    
    -Ư�� ���̺� �߻��� �̺�Ʈ(INSERT,UPDATE,DELETE)
    �� ���Ͽ� ������ ������ �ʿ��� ������ ���ν���--�ڵ����� ȣ��Ǿ����� ó���Ǿ���ϴ� ��
   
    (�������)
    CREATE TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER INSERT|UPDATE|DELETE 
    ON ���̺��
    [FOR EACH ROW]
    [WHEN ����]
    [DECLARE]
    �����;
    BEGIN
    Ʈ���� ����; --INSERT UPDATE DELETE�� �߻��� �� Ʈ���� ���� �����ض� 
                --(���� ���� ���̺� �ȵ�!-���ѷ��� ���ɼ� ����)
    END;
    
    .'BEFORE|AFTER' : timming-Ÿ�̹����� Ʈ���� ������ ����Ǵ� ����(�̺�Ʈ �߻� ��|��)
    .'INSERT|UPDATE|DELETE': event�� Ʈ���� ������ �����Ű�� ������ �Ǵ� dml���. 
                             ���ջ�� ����(INSERT OR UPDATE ��)
    .'ON ���̺��': Ʈ���� ������ �Ǵ� �̺�Ʈ�� �߻��� ���̺��
    .'FOR EACH ROW' : ����� Ʈ����(�̺�Ʈ ��� �� �ึ�� Ʈ���� ����)
                      �����ϸ� ������� Ʈ����--Ʈ���� ����(�����,�������)
                      --���� ���ȿ��� �ٸ� Ʈ���Ÿ� ������ �� ����
    .'WHEN ����': �����Ʈ���ſ����� ����� �� ������ Ʈ���Ÿ� �߻� ��Ű�� �̺�Ʈ�� �߻��Ǵ� ���̺��� 
                  �̺�Ʈ�� �߻��� �� ���� ��ü���� �˻����� ���ÿ� ���
    
    *Ʈ���� ����
    -����� Ʈ���ſ� ������� Ʈ���ŷ� ����
    
    1)������� Ʈ���� : �̺�Ʈ �������� ������� 1���� ����
                      'FOR EACH ROW' ����
    2)����� Ʈ���� : �̺�Ʈ��� ���� ����� �������� ���� ��ȯ�Ǵ� ��� �� �ึ�� Ʈ���� ���� ����
                    ** 'FOR EACH ROW' ��� **  --���� ���ȿ��� �ٸ� Ʈ���Ÿ� ������ �� ����
                     
    *�ǻ緹�ڵ� 
    -**����� Ʈ���ſ�����** ��밡��
    -----------------------------------------------
    �ǻ緹�ڵ�   �ǹ�              
    ------------------------------------------------
    :NEW       �̺�Ʈ�� **INSERT, UPDATE**�϶��� ���
               �����Ͱ� ����(����)��  �� ���Ӱ�  
               �ԷµǴ� �ڷ�(��)�� ��Ī
               DELETE�� ���Ǹ� ��� �÷����� NULL --EX)NEW.ȸ����ȣ
   -------------------------------------------------            
    :OLD       �̺�Ʈ�� **DELETE, UPDATE**�϶��� ���
               �����Ͱ� ����(����)��  �� �ش� ������
               ����� �Ǵ� �ڷ�(��)�� ��Ī
               INSERT�� ���Ǹ� ��� �÷����� NULL
     ------------------------------------------------
    *Ʈ���� �Լ�
    -�̺�Ʈ�� ���ǵ� ����� �����ϱ����� ���
    -----------------------------------------------
    �Լ�          �ǹ�              
    ------------------------------------------------
    INSERTING  �̺�Ʈ��  INSERT�̸� ��(TRUE)��ȯ
    UPDATING   �̺�Ʈ��  UPDATE�̸� ��(TRUE)��ȯ
    DELETING   �̺�Ʈ��  DELETE�̸� ��(TRUE)��ȯ
    
    ��뿹)�з����̺�(LPROD)���� ���� 10���� ��� �����Ͻÿ�
          ���� �� '�з��ڵ尡 �����Ǿ����ϴ�'-Ʈ���� ��� �޽����� ����Ͻÿ�.
          �̺�Ʈ�� ����Ʈ
          
    CREATE TRIGGER TG_DEL_LPROD
    AFTER DELETE ON LPROD
   
    BEGIN
     DBMS_OUTPUT.PUT_LINE('�з��ڵ尡 �����Ǿ����ϴ�');
   END;
   
   DELETE FROM LPROD 
   WHERE LPROD_ID = 10;
   
   COMMIT;
   SELECT * FROM LPROD;

    ROLLBACK;
    SELECT * FROM LPROD;
    
    ��뿹) CUSTOMER ���̺� �ڷḦ �����ϸ� '�ڷᰡ �����Ǿ���'�� �ڷᰡ �����Ǹ� '�ڷᰡ �����Ǿ���'�� ����ϴ� Ʈ���� �ۼ�
   
    CREATE TRIGGER TG_DELUPDATE_CUST
     AFTER UPDATE OR DELETE ON CUSTOMER 
     BEGIN
     IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ���');
     ELSIF DELETING THEN
           DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ���');
     END IF;
     END;
     
     DROP TRIGGER  TG_DELUPDATE_CUST;
     
     
    CREATE TRIGGER TG_DELUPDATE_CUST
     AFTER UPDATE OR DELETE ON CUSTOMER 
     BEGIN
     IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ���');
     ELSIF DELETING THEN
           DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ���');
     END IF;
     END;

     customer�� ���ϸ����� ��� 500�� ����
     UPDATE CUSTOMER 
        SET MEM_MILEAGE = MEM_MILEAGE + 500;
    COMMIT;
    
    ��)CUSTOMER�� �ڷ� �� ���ϸ����� 3000�̸� �ڷ� ����
    DELETE FROM CUSTOMER 
    WHERE MEM_MILEAGE <3000;
    SELECT * FROM CUSTOMER;
    
            
    
    
    
    
    
    
                 