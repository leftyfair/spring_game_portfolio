drop table game_reply_tbl; 

create table game_reply_tbl(
    rno int primary key, -- 댓글 번호
    bno int not null, -- 게시물 번호
    reply nvarchar2(1000) not null, -- 댓글 내용
    writer varchar2(50) not null, -- 댓글 작성자
    replyDate date default sysdate, -- 댓글 작성 시간
    modifyDate date default sysdate, -- 댓글 수정 시간
    constraint fk_game_reply_board foreign key(bno) -- 제약조건
    references board_file_list(bno) on delete cascade
);

drop sequence seq_game_reply; 
create sequence seq_game_reply; 


commit;
select * from game_reply_tbl;