drop sequence cart_gno_seq;
drop table game_cart;

CREATE TABLE game_cart(
    cartId NUMBER(10) PRIMARY KEY,
	memberId VARCHAR2(50),
	gno NUMBER(10),
	amount NUMBER DEFAULT 0
);

create SEQUENCE cart_gno_seq;

commit;

ALTER TABLE game_cart ADD CONSTRAINT cart_fk_gno FOREIGN KEY (gno) REFERENCES board_file_game(gno);
ALTER TABLE game_cart ADD CONSTRAINT cart_fk_memberId FOREIGN KEY (memberId) REFERENCES game_member_sec(memberId);

select * from game_cart;
