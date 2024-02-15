<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
	<%-- <link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet"> --%>
	<link href="<%=request.getContextPath()%>/css/login/login.css" type="text/css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/login/login.js"></script>
</head>
<body>
    <div>

        <div class="login-wrap"> 
            <!--로그인-->
            <div class="login-html">
              <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">로그인</label>
              <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">회원가입</label>
              <div class="login-form">
                <div class="sign-in-htm">

                  <form name="loginfrm" action="<%=request.getContextPath()%>/accounts/login" method="post">
                    <div class="group">
                      <label for="user" class="label">아이디</label>
                      <input id="user" type="text" class="input" name="mid">
                    </div>
                    <div class="group">
                      <label for="pass" class="label">비밀번호</label>
                      <input id="pass" type="password" class="input" data-type="password" name="mpassword">
                    </div>
                    <div class="group">
                    </div>
                    <div class="group">
                      <input type="submit" class="button" value="로그인" id="submitcolor1">
                    </div>
                  </form>
                    <div class="foot-lnk">
                      <a href="<%=request.getContextPath()%>/accounts/password/reset">비밀번호를 잊으셨나요?</a>
                      <label for="tab-2" class="label">회원이 아니신가요?</a>
                    </div>

                </div> <!--로그인-->

                <div class="sign-up-htm"> <!--회원 가입 checkBox의 span은 오류메세지 적는 공간-->

                  <form name="joinfrm" action="<%=request.getContextPath()%>/accounts/join" method="post">
                    <div class="group">
                      <label for="joinUser" class="label">아이디</label>
                      <input id="joinUser" type="text" class="input" name="mid" onblur="checkId()" onchange="resetIdDupCheck()">
                      <button type="button" class="checkBtn long" onclick="checkDuplicateIdWithUI(this)">중복 확인</button>
                      
                      <div class="checkBox">
                        <span></span>
                      </div>

                    </div>
                    <div class="group">
                      <label for="joinPass" class="label">비밀번호</label>
                      <input id="joinPass" type="password" class="input" data-type="password" name="mpassword" onblur="checkPassword()">

                      <div class="checkBox">
                        <span></span>
                      </div>

                    </div>
                    <div class="group">
                      <label for="joinRepass" class="label">비밀번호 확인</label>
                      <input id="joinRepass" type="password" class="input" data-type="password" onblur="checkRepassword()">

                      <div class="checkBox">
                        <span></span>
                      </div>

                    </div>
                    <div class="group">
                      <label for="joinName" class="label">이름</label>
                      <input id="joinName" type="text" class="input textname" name="mname" onblur="checkName()">

                      <div class="checkBox">
                        <span></span>
                      </div>

                    </div>
                    <div class="group">
                      <label for="joinNick" class="label">닉네임</label>
                      <input id="joinNick" type="text" class="input"  name="mnick" onblur="checkNick()" onchange="resetNickDupCheck()">
                      <button class="checkBtn long" onclick="checkDuplicateNickWithUI(this)">중복 확인</button>
                       <div class="checkBox">
                        <span></span>
                      </div>
                    </div>
                    
                    
                    <div class="group">
                      <label for="joinEmail" class="label">이메일</label>
                      <input id="joinEmail" type="text" class="input" name="email" onblur="checkEmail()">
                      <button type="button" class="checkBtn" onclick="sendCertNumber()">인증번호 전송</button>
                      <div class="none"></div>
                      
                      <!--  여기는 인증번호 전송을 누르면 나타나게 하자. -->
                      <input id="joinCertNumber" type="text" class="input" style="display:none">
                      <button id="joinCertNumberCheck" class="checkBtn" style="display:none">인증번호 확인</button>

                      <div class="checkBox">
                        <span></span>
                      </div>

                    </div>
                    <div class="group">
                      <input type="submit" class="button" value="회원가입" id="submitcolor2">
                    </div>
                </form> <!--form-->

                  <div class="foot-lnk">
                    <label for="tab-1">이미 회원이신가요?</a>
                  </div>

                </div> <!--회원 가입-->
              </div>
            </div>
          </div>

    </div>
</body>
</html>