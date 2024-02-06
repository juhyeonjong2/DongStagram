use dongstagram;
# set FOREIGN_KEY_CHECKS = 0;

CREATE TABLE member (
	mno int unsigned not null primary key auto_increment comment '회원번호',
    mid varchar(50) not null comment '아이디',
    mpassword char(32) not null comment '패스워드',
    mname text comment '이름',
    mnick varchar(50) not null unique comment '닉네임',
    email varchar(50) not null unique comment '이메일',
    allowemail char(1) comment '이메일 수신 동의',
    mlevel int unsigned comment '권한',
    joindate timestamp comment '가입일',
    delyn char(1) comment '탈퇴 여부'
);

CREATE TABLE board (
	bno int unsigned not null primary key auto_increment comment '글번호',
    blockyn char(1) comment '관리자에 의한 블럭 여부',
    shorturi varchar(50) comment '짧은경로',
    bhit int not null comment '조회수',
    bfavorite int not null comment '좋아요',
    wdate timestamp not null comment '작성일',
    mno int  unsigned not null comment '회원번호',
    foreign key(mno) references member(mno)
);

# board의 bno는 10만부터 시작해야 한다.
ALTER TABLE board AUTO_INCREMENT=100000;

CREATE TABLE boardAttach(
	mfno int unsigned not null primary key auto_increment comment '미디어 파일 번호',
    bfidx int unsigned not null comment '관리번호',
    bfrealname varchar(100) not null comment '실제이름',
    bforeignname varchar(100) not null comment '외부이름',
    rdate timestamp not null comment '등록일',
    bno int unsigned not null comment '게시글번호',
    foreign key(bno) references board(bno)
);

CREATE TABLE reply (
	rno int unsigned not null primary key auto_increment comment '댓글 번호',
    ridx int unsigned not null comment '관리인덱스',
    rdate timestamp not null comment '작성일',
    rmdate timestamp comment '수정일',
    rpno int unsigned comment '부모 댓글',
    mno int unsigned not null comment '회원번호',
    bno int unsigned not null comment '글번호',
    foreign key(mno) references member(mno),
    foreign key(bno) references board(bno)
);

CREATE TABLE room (
	roomno int not null primary key auto_increment comment '방번호',
    rdate timestamp
);

# 방번호가 커보이기 위해 1만부터 시작하자.
ALTER TABLE room AUTO_INCREMENT=10000;

CREATE TABLE message (
	mno int unsigned not null comment '회원번호',
    roomno int not null comment '방번호',
    sayermno int unsigned not null comment '말한사람 번호',
    dm text not null comment '다이렉트 메세지',
    rdate timestamp not null comment '작성일',
    foreign key(mno) references member(mno),
    foreign key(roomno) references room(roomno)
);

CREATE TABLE blockBoard(
	mno int unsigned not null comment '회원번호',
    bno int unsigned not null comment '글번호',
	rdate timestamp comment '차단일',
	foreign key(mno) references member(mno),
    foreign key(bno) references board(bno)
);

CREATE TABLE reportBoard(
	mno int unsigned not null comment '회원번호',
    bno int unsigned not null comment '글번호',
	rdate timestamp not null comment '신고일',
    reason text comment '신고사유',
    foreign key(mno) references member(mno),
    foreign key(bno) references board(bno)
);

CREATE TABLE favorite(
	mno int unsigned not null comment '회원번호',
    bno int unsigned not null comment '글번호',
    foreign key(mno) references member(mno),
    foreign key(bno) references board(bno)
);

CREATE TABLE follow(
	frommno int unsigned not null comment '요청한 회원번호',
    tommo int unsigned not null comment '요청받은 회원번호',
    state char(3) not null comment '상태',
    rdate timestamp comment '갱신일자',
    foreign key(frommno) references member(mno)
);

CREATE TABLE notification(
	mno int unsigned not null comment '회원번호',
    code char(2) not null comment '알람 코드',
    targetmno int unsigned not null comment '대상 회원번호',
    foreign key(mno) references member(mno)
);

CREATE TABLE reportAccount(
	mno int unsigned not null comment '회원번호',
    reason text comment '신고사유',
    rdate timestamp not null comment '신고일',
    reportmno int unsigned not null comment '신고한 회원번호',
    foreign key(mno) references member(mno)
);

CREATE TABLE blockAccount(
	mno int unsigned not null comment '회원번호',
    rdate timestamp not null comment '차단일',
    blockmno int unsigned not null comment '차단한 회원번호',
    foreign key(mno) references member(mno)
);

CREATE TABLE account(
	mno int unsigned not null comment '회원번호',
    intro varchar(150) comment '소개',
    openyn char(1) not null comment '계정 공개 여부',
    gender int comment '성별',
    blockyn char(1) not null comment '관리자에 의한 블럭여부',
    foreign key(mno) references member(mno)
);

CREATE TABLE memberAttach(
	mfno int unsigned primary key auto_increment comment '미디어 파일번호',
    mfrealname varchar(100) not null comment '실제이름',
    mforeignname varchar(100) not null comment '외부이름',
    rdate timestamp not null comment '등록일',
    mno int unsigned not null comment '회원번호',
    foreign key(mno) references member(mno)
);

CREATE TABLE cert (
	hash char(32) not null comment '해시',
    expiretime timestamp not null comment '만료기간',
    mno int unsigned not null comment '회원번호',
    foreign key(mno) references member(mno)
);

CREATE TABLE tempPassword (
	tpassword char(32) not null comment '임시비밀번호 해시값',
    expiretime timestamp not null comment '만료기간',
    mno int unsigned not null comment '회원번호',
    foreign key(mno) references member(mno)
);







# set FOREIGN_KEY_CHECKS = 1;