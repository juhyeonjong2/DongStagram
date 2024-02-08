use dongstagram;

# 댓글테이블에 내용 추가
ALTER TABLE reply ADD column rcontent varchar(2200) not null comment '내용';