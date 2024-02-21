<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
 <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 변경</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/base.css"
  type="text/css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/setting/setting.css"
  type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
 
	
	<script>
	
	
	let checkPW = false;
	
	function alpass(p1){
		var pas = p1.value;
		$.ajax({
			url : "Checkpass.jsp",
			type : "get",
			data : {
				pass :pas
			},
			success : function(result) {
				if(result.trim() == 'SUCCESS'){
					checkPW = true;
				}
			},
			error : function(error) {
				console.error(error)
			}
		});
	}
	
	alpass(document.getElementById("p1")); 
	
	function validation(){
		 var p2 = document.getElementById('p2').value;
	     var p3 = document.getElementById('p3').value;
	     

	      const regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,20}$/; // 대소문자, 특문, 숫자 최소 한개씩 포함 8~20자 
		  let regRs = regex.test(p2);
	      
	      if(checkPW){
		      if(!regRs){
		    	 alert("비밀번호 유효성이 일치 하지 않습니다");
			     return false;
		      }else if( p2 != p3 ) {
		        alert("비밀번호가 일치 하지 않습니다");
		        return false;
		      } else{
		        return true;
		      }
	      }else{
	    	  alert("현재 비밀번호가 일치 하지 않습니다");
		        return false;
	      }
	      
			
	}
	
	</script>
	
  <%-- <script src="<%=request.getContextPath()%>/js/member/post.js"></script> --%>
</head>
<body>
	<%@ include file="/include/header.jsp"%>
	 

     

  <main>

    <div class="inner2 clearfix">
      <h3>비밀번호 변경</h3>

    <form action="SettingPwOk.jsp" method="post">
        <div class="settingPW">
            <p>기존 비밀번호 입력</p>
            <input type="password" id="p1" onblur="alpass(this)" >
            <p>변경할 비밀번호 입력</p>
            <input type="password" id="p2" name="password">
            <p>변경할 비밀번호 확인</p>
            <input type="password" id="p3">
        </div>
        <button type="submit" class="settingPWSubmit" onclick="return validation();">변경</button>
        <!--변경의 회색버전은 class에 settingPWSubmit2로 바꿔주면 됨-->
        <!--<button type="submit" class="settingSubmit2">제출</button>-->
    </form>

    </div>
  </main>
  
</body>
</html>