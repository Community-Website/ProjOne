# JSP Model1 Project Schema
# D/N : community 

########################
# drop database community;
########################


drop database community;

create database community;
use community;

######### 가입회원 테이블 시작 #########
create table member (
num					int 			unique 		auto_increment,
uId 					char(30) 											,
uPw 					char(30) 	not null								,
uName 				char(30) 	not null								,
uEmail 				char(100) 	not null								,
gender 				char(2) 											,
uBirthday 			char(10) 											,
uZipcode 			char(8) 											,
uAddr				char(100) 											,
uHobby				char(10) 											,
uJob					char(30) 											,
joinTM 				datetime											,
constraint 	primary key(uId)
);


desc member;
select * from member order by num desc limit 0, 10;
######### 가입회원 테이블 끝 #########

## ID 중복 체크용 데이터 입력
insert into member (uId, uPw, uName, uEmail)   
values ('tester01', '1234', '테스터01', 'tester01@google.com' );

insert into member (uId, uPw, uName, uEmail)   
values ('you', '1234', '유재석', 'you@naver.com' );

insert into member (uId, uPw, uName, uEmail)   
values ('lee', '1234', '이미주', 'lee@daum.net' );

select num, uId, uPw, uName 
from member order by num desc limit 0, 10;


select * from member order by num desc limit 0, 10;




######### 회원가입용 우편번호 테이블 시작 #########
create table tblZipcode(
zipcode 				char(7),
area1 				char(10),
area2 				char(20),
area3 				char(40),
area4 				char(20)
);

desc tblZipcode;
select * from tblZipcode limit 0, 10;
######### 회원가입용 우편번호 테이블 끝 #########




######### 게시판 테이블 시작 #########
create table tblBoard (
    num          int                    auto_increment,
    uId 			char(30) 			not null,				
    uName		char(30)			not null,
    subject     char(50)			not null,
    content		text					null,    
    pos			int					not null,
    ref			int					not null,
    depth		int					not null,
    regTM		datetime			not null,
    ip				char(15)			null,    
    readCnt		int				not null,
    fileName	char(50)			null,
    fileSize		int					null,
    constraint		primary key(num)
);
# oriFilename, sysFilename
# 원본파일명         서버에 업로드된 파일명

desc tblBoard;
select * from tblBoard order by num desc limit 0, 10;
######### 게시판 테이블 끝 #########


select num, uId, uName, subject,
ref, pos, depth from tblBoard 
order by num desc limit 0, 10;

#답변글의 ref를 원본글의  ref와 동일하게 만든 이유
# => 그룹핑(Grouping,  같은 것 끼리 묶기) ,  ref를 order by desc로 묶는다.


select num, uId, uName, subject,
ref, pos, depth from tblBoard 
order by num desc;

select num, uId, uName, subject,
ref, pos, depth from tblBoard 
where ref = 3
order by ref desc, pos asc;


create table test (
num     int ,
txt		char(100)
);

desc test;

insert into test values (1, '&lt;');
select * from test;
##JDBC  검토


select * from tblBoard order by num desc limit 0, 10;

select * from tblBoard order by num desc limit 0, 5;

/*drop table tblBoard;*/

select * from member order by num desc limit 0,10;
# member 테이블 : 회원정보가 있는 회원목록테이블
select * from tblboard order by num desc limit 0,10;
# tblBoard 테이블 : 가입한 회원이 작성한 자유게시판 테이블
select * from tblzipcode limit 0,10;
#tblZipcode 테이블: 회원가입에서 사용되는 우편번호 테이블

######### 공지게시판 테이블 시작 #########
create table noticeBoard (
    num          int                    auto_increment,
    uId 			char(30) 			not null,				
    uName		char(30)			not null,
    subject     char(50)			not null,
    content		text					null		,    
    pos			int					not null,
    ref			int					not null,
    depth		int					not null,
    regTM		datetime			not null,
    ip				char(15)			null,    
    readCnt		int				not null,
    fileName	char(50)			null,
    fileSize		int					null,
    constraint		primary key(num)
);

insert into noticeBoard(uId, uName, subject, content, pos, ref, depth, regTM, readCnt)
values ('admin', '관리자', '[공지사항] 테스트', '안녕하세요', 0, 1, 0, now(),0);

######### 공지게시판 코멘트 시작 #########
create table noticeReply (
    num          int                    auto_increment,
    uId 			char(30) 			not null,				
    uName		char(30)			not null,
    content		text					null,    
    pos			int					not null,
    ref			int					not null,
    depth		int					not null,
    regTM		datetime			not null,
    ip				char(15)			null, 
    constraint		primary key(num)
);
select * from noticeReply;



######### 관리자 테이블 시작 #########
create table admin (
num		int 		unique auto_increment,
uId 		char(30) 				,
#uPw 		char(30) 	not null			,
#uName 		char(30) 	not null			,	
ulevel		int 				,
constraint 	primary key(uId)
);

## level1: 수정, 삭제, 검색
## level2: 수정, 검색
## level3: 검색

insert into admin (uId, uPw, uName, ulevel)   
values ('admin', '1234', '슈퍼관리자', 1);  

insert into admin (uId, uPw, uName, ulevel)
values('adminSub', '1234', '서브관리자', 2); 

######### 관리자 테이블 끝#########