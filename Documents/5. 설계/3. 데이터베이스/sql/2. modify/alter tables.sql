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
ALTER TABLE board ADD COLUMN ropen char(1) NOT NULL comment '댓글 기능 허용';
