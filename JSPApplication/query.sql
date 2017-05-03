select * from tab;

CREATE Table tblZip(
	ZIPCODE		varchar2(10),
 	SIDO		varchar2(10),
 	GUGUN		varchar2(25),
 	DONG		varchar2(70),
 	BUNJI		varchar2(25)
)

CREATE TABLE tblBoard(
	num			number,
	name		varchar2(20),
	email		varchar2(50), 
	homepage	varchar2(50),
	subject		varchar2(50),
	content		varchar2(4000),
	pass		varchar2(10),
	count		number,
	ip			varchar2(50),
	regdate		date,
	pos			number,
	depth		number,
	constraint pk_num primary key(num)
);

CREATE SEQUENCE seq_num;

select * from tblBoard;

delete from TBLBOARD;