drop table member_auth;
drop table member_sec01; 
drop sequence member_sec01_seq;
drop table persistent_logins;

-- ȸ�����̺�� ���� ���̺��� 1:N ����
-- ȸ�� ���̺� 1
create sequence member_sec01_seq; 
create table member_sec01(
    mno number(10) primary key, -- ȸ����ȣ
    memberId varchar2(50) unique not null, -- ȸ�����̵�
    password varchar2(200)not null, -- ��й�ȣ
    email varchar2(200), -- �̸���
    enabled char(1) default(1) -- ������ Ȱ��ȭ ����
);

-- ���� ���̺� N
create table member_auth(
    memberId varchar2(50) not null, -- ȸ�����̵�
    memberType varchar2(50) not null, -- ����
	ordinal number(10) not null, -- ������ �켱����
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
