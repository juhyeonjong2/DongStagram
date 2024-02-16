<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 설정</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/member/profileModify.css" type="text/css" rel="stylesheet">

</head>
<body>
    <!--header-->
    <%@ include file="/include/settingHeader.jsp"%>
    <div class="inner2 clearfix">
      <h3>프로필 편집</h3>
      <form action="#">
        <div class="settingMain">
            <img src="./자산 4.png" class="profile">
            <span class="span">abcabcs123
              <span class="span2">abc마트</span>
            </span>
            <label class="labelBtn " id="label" for="settingInput">사진변경</label>
            <input type="file" hidden="true" id="settingInput">
        </div>

        <div class="settingMain2">
          <h5>소개</h5>
          <div class="textarea">
            <textarea class="replyTextarea" id="replyTextarea" onkeydown="calc()" onkeyup="calc()" onkeypress="calc()">소개 문구가 여기에 입력되어있다.</textarea>
          </div>
          <div class="textCnt">
            <span class="replyTextareaCount" id="replyTextareaCount">0</span>
            <span class="replyTextareaCount2">/150</span>
          </div>
        </div>

        <div class="settingMain3">
          <h5>성별</h5>
          <select class="settingOp">
            <option>밝히고 싶지 않음</option>
            <option>남자</option>
            <option>여자</option>
          </select>
        </div>
        <div id="submitBox">
          <a class="deleteBtn" data-toggle="modal" href="#deletePopup">회원 탈퇴</a>
          <button type="submit" class="settingSubmit">제출</button>
          <!--제출의 회색버전은 class에 settingSubmit2로 바꿔주면 됨-->
          <!--<button type="submit" class="settingSubmit2">제출</button>-->
        </div>
      </form>
    </div>
    
      

      <!-- deletePopup -->
      <div class="modal fade" id="deletePopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-body">
              <div class="deletePopupMain">
                <form action="#">
                  <p>비밀번호를 입력해주세요</p>
                  <input type="password">
                  <p>회원탈퇴를 적어주세요</p>
                  <input type="text" placeholder="회원탈퇴">
                  <input type="submit" value="회원탈퇴하기" class="deleteBtn">
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      
     
    
    <!--footer-->
	<%@ include file="/include/footer.jsp"%>
     <!--footer-->
</body>
</html>