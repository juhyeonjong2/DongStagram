
#모든 테이블을 비우고, 관리자 계정 추가.
use dongstagram;

set FOREIGN_KEY_CHECKS = 0;
TRUNCATE account;
TRUNCATE blockaccount;
TRUNCATE blockboard;
TRUNCATE board;
TRUNCATE boardattach;
TRUNCATE boardview;
TRUNCATE cert;
TRUNCATE favorite;
TRUNCATE follow;
TRUNCATE joincert;
TRUNCATE member;
TRUNCATE memberattach;
TRUNCATE notification;
TRUNCATE notificationview;
TRUNCATE reply;
TRUNCATE reportaccount;
TRUNCATE reportboard;
TRUNCATE searchhistory;
TRUNCATE temppassword;
set FOREIGN_KEY_CHECKS = 1;

# 관리자 아이디생성
INSERT INTO member (mid, mpassword, mname, mnick, email, joindate,  mlevel, delyn) VALUES('admin',  md5('1234') ,'관리자', 'administrator', 'admin@dongstagram.com', now(), 2, 'n');
INSERT INTO account(mno, intro, openyn, gender, blockyn) values((SELECT last_insert_id() FROM member), '','n',0,'n');
 