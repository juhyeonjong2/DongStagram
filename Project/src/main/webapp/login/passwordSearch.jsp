<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%=request.getContextPath()%>/css/login/login.css" type="text/css" rel="stylesheet">
    <title>임시 비밀 번호</title>
</head>
<body>
    <div id="passwordsearch">
        <div class="login-form">
            <div class="sign-in-htm">
                <form class="group" name="pwsearchfrm" action="<%=request.getContextPath()%>/accounts/password/reset" method="post">
                <div class="group">
                    <img src="<%=request.getContextPath() +"/icon/lock.png" %>">
                    <label for="user" class="label emailsearch">가입한 이메일 입력</label>
                    <input id="user" name="email" type="email" class="input passwordsearch1"> <!--타입을 이메일로 만듬-->
                </div>
                    <input type="submit" class="button" value="임시 비밀번호 발급" id="submitcolor1">
                </form>
                <div class="hr"></div>
                <div class="foot-lnk">
                    <a href="<%=request.getContextPath()%>">로그인으로 돌아가기</a>
                </div>
            </div> 
        </div> 
    </div> 
</body>
</html>