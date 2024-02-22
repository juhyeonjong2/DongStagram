<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%@ page import="vo.ProfileVO"%>
<%@ page import="ezen.db.DBManager" %>
<%
	MemberVO member = (MemberVO)session.getAttribute("login");

	ProfileVO vo = new ProfileVO();
	String saveDir = member.getMnick();
	String upload = "upload/";
	try(DBManager db = new DBManager();)
	{
		if(db.connect()) {
			// 나의 프로필 이미지, 성별번호, 내 소개를 전부 찾는다.
			String sql = "select m.mfrealname, a.gender, a.intro from account a inner join memberattach m on a.mno = m.mno and m.mno = ?";
			
			if(db.prepare(sql).setInt(member.getMno()).read()) {
				  if(db.next()){
					vo.setRealFileName(db.getString("mfrealname"));
					vo.setGender(db.getInt("gender"));
					vo.setIntro(db.getString("intro"));
				  }
			}
			
		} //db connect	
	}catch(Exception e) {
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 설정</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/member/profileModify.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script>

	$(document).ready(function() {
		if(<%=vo.getGender()%> == 0){
			$(".settingOp").val(0).prop("selected", true);
		}else if(<%=vo.getGender()%> == 1){
			$(".settingOp").val(1).prop("selected", true);
		}else{
			$(".settingOp").val(2).prop("selected", true);
		}
		
	});
	
	
	
	function checkPassword(){
		let me = $("#pwModify");
		let errorP = $("#errorText");
		let value = me.val();
		
		const regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,20}$/; // 대소문자, 특문, 숫자 최소 한개씩 포함 8~20자 
		let regRs = regex.test(value);
		
		if(value == ""){
			errorP.text("필수입력입니다");
			errorP.css("color", "red");
			return false;
		}else if(!regRs){
			errorP.text("영문 대소문자, 숫자, 특수문자 포함 8~20자입니다.");
			errorP.css("color", "red");
			return false;
		}
	}
	
</script>
</head>
<body>
    <!--header-->
    <%@ include file="/include/settingHeader.jsp"%>
    <div class="inner2 clearfix">
      <h3>프로필 편집</h3>
      <form action="<%=request.getContextPath()%>/member/profileModifyOk.jsp" name="frm" method="post" enctype=multipart/form-data>
        <div class="settingMain">
            <img src="<%=request.getContextPath() +"/" + upload + saveDir + "/" + vo.getRealFileName()%>" class="profile">
            <span class="span"><%=member.getMnick() %>
              <span class="span2"><%=member.getMname() %></span>
            </span>
            <label class="labelBtn " id="label" for="settingInput">사진변경</label>
            <input type="file" hidden="true" id="settingInput" onchange="thumbnail(event,this)" name="profileImg">
        </div>

        <div class="settingMain2">
          <h5>소개</h5>
          <div class="textarea">
            <textarea class="replyTextarea" id="replyTextarea2" name="replyTextarea" onkeydown="calc()" onkeyup="calc()" onkeypress="calc()"><%=vo.getIntro()%></textarea>
          </div>
          <div class="textCnt">
            <span class="replyTextareaCount" id="replyTextareaCount">0</span>
            <span class="replyTextareaCount2">/150</span>
          </div>
        </div>

        <div class="settingMain3">
          <h5>성별</h5>
          <select class="settingOp" name="gender">
            <option value="0">밝히고 싶지 않음</option>
            <option value="1">남자</option>
            <option value="2">여자</option>
          </select>
        </div>
        <div id="submitBox">
          <a class="deleteBtn" data-toggle="modal" href="#deletePopup">회원 탈퇴</a>
          <button type="button" class="settingSubmit" onclick="profileSubmit()">제출</button>
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
                <form action="<%=request.getContextPath()%>/member/deleteMember.jsp" method="post">
                  <p>비밀번호를 입력해주세요</p>
                  <p id="errorText"></p>
                  <input type="password" name="deletePw" id="pwModify" onblur="checkPassword()">
                  <p>회원탈퇴를 적어주세요</p>
                  <input type="text" placeholder="회원탈퇴" name="deleteText">
                  <input type="submit" value="회원탈퇴하기" class="deleteBtn">
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>

    <script>
	//썸네일 추가 함수
	function thumbnail(event,obj){
	  const file = event.target.files[0];
	  const img = $(obj).prev().prev().prev();
	  const reader = new FileReader();
	  reader.onload = (e) => {
	    	$(img).attr("src", e.target?.result );
	  };
	  reader.readAsDataURL(file);
	}
	
	
	//제출하기
	function profileSubmit(){
		let deleteCon = confirm("프로필을 편집하시겠습니까?");
		if(deleteCon){
		   document.frm.submit();
		}
	}
	
	

	$(document).ready(function() {
		console.log(<%=vo.getIntro()%>);
		if(<%=vo.getIntro()%> == null){
			$("#replyTextarea2").val("소개 문구가 없습니다.");
		}
		
	});
	
</script>
    <!--footer-->
	<%@ include file="/include/footer.jsp"%>
     <!--footer-->
</body>
</html>