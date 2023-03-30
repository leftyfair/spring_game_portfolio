drop table game_reply_tbl; 

create table game_reply_tbl(
    rno int primary key, -- ��� ��ȣ
    bno int not null, -- �Խù� ��ȣ
    reply nvarchar2(1000) not null, -- ��� ����
    writer varchar2(50) not null, -- ��� �ۼ���
    replyDate date default sysdate, -- ��� �ۼ� �ð�
    modifyDate date default sysdate, -- ��� ���� �ð�
    constraint fk_game_reply_board foreign key(bno) -- ��������
    references board_file_list(bno) on delete cascade
);

drop sequence seq_game_reply; 
create sequence seq_game_reply; 


commit;
select * from game_reply_tbl;