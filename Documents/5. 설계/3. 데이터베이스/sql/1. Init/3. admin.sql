use dongstagram;

# 관리자 아이디생성
INSERT INTO member (mid, mpassword, mname, mnick, email, allowemail, joindate,  mlevel, delyn)
 VALUES('admin',  md5('1234') ,'관리자', 'administrator', 'admin@dongstagram.com', 'n', now(), 2, 'n');