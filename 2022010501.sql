20220105-01
2.ALTER
-������ ��ü�� ����, ����, �̸� ���� ����


    1)�÷� �߰�
    ALTER TABLE ���̺�� ADD(�÷��� ������Ÿ��[(ũ��)][,                //�߰��� ����� �Ǿ����� ���̺� ������MOTIFY ������ DROP
                            �÷��� ������Ÿ��[(ũ��)],,,...]
        
        ��뿹) ��ǰ���̺�(GOODS)�� ���԰���(COST)�÷��� �߰��Ͻÿ�
        ���԰����� ���� 7�ڸ� ������
        ALTER TABLE GOODS ADD(COST NUMBER(7));
    
    2)�÷� ����(������Ÿ��,ũ��)
    ALTER TABLE ���̺�� MODIFY(�÷��� ������Ÿ��[(ũ��)][,                //������ MOTIFY ������ DROP
                               �÷��� ������Ÿ��[(ũ��)],,,...];
    
     ��ǰ���̺�(GOODS)�� ���԰���(COST)�÷��� ������Ÿ����
     �����Ͻÿ�.  ������Ÿ���� �������� ���ڿ� 7�ڸ�
    ALTER TABLE GOODS MODIFY(COST VARCHAR2(7));
    
    
    2)�÷� ����
    ALTER TABLE ���̺�� DROP COLUMN �÷���;
    
    COMMIT;   //�ϵ��ũ������ �����Ͻʽÿ�

    ALTER TABLE GOODS DROP COLUMN COST;      //DROP�� ROLLBACK�� ����� �� �� ���� //
    
    3)�÷��̸� ����
    ALTER TABLE ���̺�� RENAME COLUMN old_�÷��� TO new_�÷���;
    
    ��뿹)��ǰ���̺��� �ܰ��÷���(PRICE)�� G_PRICE�� �����Ͻÿ�
    ALTER TABLE GOODS RENAME COLUMN PRICE TO G_PRICE;
    
    5)�������(�⺻Ű �� �ܷ�Ű) �߰�
    ALTER TABLE ���̺�� ADD CONSTRAINT �⺻Ű/�ܷ�Ű�ε���
                PRIMARY/FOREIGN KEY(�÷���,[�÷���,,,,])
                [REFERENCES ���̺��(�÷���)];
                
    6)�������(�⺻Ű �� �ܷ�Ű) ����
    ALTER TABLE ���̺�� DROP CONSTRAINT �⺻Ű/�ܷ�Ű�ε���;
    
    7)���̺� �̸�����
    ALTER TABLE old_���̺�� RENAME TO new_���̺��;  //���� �⺻Ű/�ܷ�Ű �������س��� ���̺� ����� ���� ���߿� �����ľ��ϰ� �⺻Ű��������
    
    
    
    
    
    
    
    


    
    
        
