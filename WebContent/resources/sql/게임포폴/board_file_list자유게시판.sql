DROP TABLE board_file_list;
DROP SEQUENCE bno_file01_list_seq;

CREATE TABLE board_file_list(
    bno NUMBER(10) PRIMARY KEY,
    title VARCHAR2(500) NOT NULL,
    content VARCHAR2(400) NOT NULL,
    writer VARCHAR2(50) NOT NULL,
    fileName VARCHAR2(100),
    fileType VARCHAR2(30)
);

CREATE SEQUENCE bno_file01_list_seq;

SELECT * FROM board_file_list;


