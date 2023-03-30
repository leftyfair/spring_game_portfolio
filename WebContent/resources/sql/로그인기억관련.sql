drop table member_auth;
drop table member_sec01; 
drop sequence member_sec01_seq;
drop table persistent_logins;

-- 회원테이블과 권한 테이블은 1:N 관계
-- 회원 테이블 1
create sequence member_sec01_seq; 
create table member_sec01(
    mno number(10) primary key, -- 회원번호
    memberId varchar2(50) unique not null, -- 회원아이디
    password varchar2(200)not null, -- 비밀번호
    email varchar2(200), -- 이메일
    enabled char(1) default(1) -- 계정의 활성화 상태
);

-- 권한 테이블 N
create table member_auth(
    memberId varchar2(50) not null, -- 회원아이디
    memberType varchar2(50) not null, -- 권한
	ordinal number(10) not null, -- 권한의 우선순위
    constraint fk_member_auth foreign key(memberId)
    references member_sec01(memberId)
);

create table persistent_logins (
	username varchar(64) not null,
	series varchar(64) primary key,
	token varchar(64) not null,
	last_used timestamp not null
);


select * from member_sec01;
select * from member_auth;
select * from persistent_logins;
