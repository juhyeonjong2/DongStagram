use dongstagram;

# 댓글테이블에 내용 추가
ALTER TABLE reply ADD column rcontent varchar(2200) not null comment '내용';

# member table의 mid를 유니크로 변경 (중복체크를 디비에서처리)
SHOW FULL COLUMNS FROM member;
ALTER TABLE member MODIFY column mid varchar(50) not null unique comment '아이디';

# member table의 allowemail 제거(스토리보드에 없음)
ALTER TABLE member drop column allowemail;