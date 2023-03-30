drop table game_member_auth;
drop table game_member_sec; 
drop sequence game_member_sec_seq;

-- 회원 테이블
create sequence game_member_sec_seq;
create table game_member_sec(
    mno number(10) primary key, 
    memberId varchar2(50) unique not null,
    password varchar2(200)not null,
    memberName varchar2(200)not null,
    phoneNumber varchar2(200)not null,
    email varchar2(200), 
    enabled char(1) default(1)
);


commit;

-- 권한 테이블
create table game_member_auth(
    memberId varchar2(50) not null, 
    memberType varchar2(50) not null, 
	ordinal number(10) not null,
    constraint fk_game_member_auth foreign key(memberId)
    references game_member_sec(memberId)
);


update game_member_auth set memberType='ROLE_ADMIN' where memberId='admin';

commit;

select * from game_member_sec;

select * from game_member_auth;