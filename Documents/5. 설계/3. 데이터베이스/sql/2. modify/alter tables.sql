use dongstagram;

# 댓글테이블에 내용 추가
ALTER TABLE reply ADD column rcontent varchar(2200) not null comment '내용';

# member table의 mid를 유니크로 변경 (중복체크를 디비에서처리)
SHOW FULL COLUMNS FROM member;
ALTER TABLE member MODIFY column mid varchar(50) not null unique comment '아이디';

# member table의 allowemail 제거(스토리보드에 없음)
ALTER TABLE member drop column allowemail;

# 게시글 옵션 추가
ALTER TABLE board ADD COLUMN bopen char(1) NOT NULL comment '게시물 공개';
ALTER TABLE board ADD COLUMN fopen char(1) NOT NULL comment '좋아요 공개';
ALTER TABLE board ADD COLUMN rallow char(1) NOT NULL comment '댓글 기능 허용';

# 알림확인 테이블 생성전 알림테이블에 pk 지정
ALTER TABLE notification ADD COLUMN nno int unsigned primary key auto_increment comment '알림번호';

# 알림 확인 테이블 생성
CREATE TABLE notificationView (
	nno int unsigned not null comment '알림번호',
    mno int unsigned not null comment '회원번호',
	rdate timestamp not null comment '확인일',
    foreign key(nno) references notification(nno),
	foreign key(mno) references member(mno)
);

# 게시물 확인 테이블 생성
CREATE TABLE boardView (
	bno int unsigned not null comment '글번호',
    mno int unsigned not null comment '회원번호',
	rdate timestamp not null comment '확인일',
    foreign key(bno) references board(bno),
	foreign key(mno) references member(mno)
);

# 임시 비밀번호 테이블의 upsert를 위한 unique 추가 
ALTER TABLE temppassword modify column mno int unsigned not null unique comment '회원번호';

# 회원가입 인증번호 테이블 생성
CREATE TABLE joinCert (
	email varchar(100) not null primary key comment '이메일',
    cert char(8) not null comment '인증번호',
	expiretime timestamp not null comment '만료일'
);

ALTER TABLE joincert ADD COLUMN verifyyn char(1) comment '인증유무';

# 2024.02.20 변경 - 메세지 삭제 및 검색기록 추가
# 1. 메세지 테이블 제거 
set FOREIGN_KEY_CHECKS = 0;
DROP TABLE room;
DROP TABLE message;
set FOREIGN_KEY_CHECKS = 1;
# 2. 검색어 히스토리 테이블 생성
CREATE TABLE searchHisotry (
	mno int unsigned not null comment '회원번호',
    type varchar(10) not null comment '타입',
    words text not null comment '검색어',
    foreign key(mno) references member(mno)
);
