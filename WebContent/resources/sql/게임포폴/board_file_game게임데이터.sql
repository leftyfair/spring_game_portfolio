DROP TABLE board_file_game;
DROP SEQUENCE gno_file01_game_seq;

-- 조건있는 테이블 강제 삭제
-- DROP TABLE board_file_game CASCADE CONSTRAINTS PURGE;
CREATE SEQUENCE gno_file01_game_seq;

create table category_board (
    cid varchar2(15) primary key,
    cname NVARCHAR2(10) not null
);

insert into category_board (cid, cname) VALUES ('action', '공지');

select * from category_board;

create SEQUENCE category_cno_seq;

CREATE TABLE board_file_game(
    gno NUMBER(10) PRIMARY KEY,
    cid VARCHAR2(15) not null,
    title VARCHAR2(500) NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    price NUMBER(10) NOT NULL,
    volSize VARCHAR2(50) NOT NULL,
    developer VARCHAR2(50) NOT NULL,
    fileName VARCHAR2(100),
    fileType VARCHAR2(30),
    constraint fk_cid FOREIGN key(cid)
    REFERENCES category_board(cid) on delete cascade
    
);

commit;

SELECT * FROM board_file_game;


