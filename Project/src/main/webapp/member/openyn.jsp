<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>설정</title>

<link href="<%=request.getContextPath()%>/css/setting/setting.css"
	type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/setting/setting2.css"
	type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script>
	function sendData(e) { //sendData 라는 함수 선언 e라는 매개 변수
		// 진짜가는지 확인
		console.log("!");	
		// 1. checkbox element를 찾습니다.
		const checkbox = document.getElementById('toggle2'); // getElementById는 document 객체의 내장함수 이므로 앞에 document가 붙었다
															 // const는 상수 선언하는 키워드 checkbox라는 친구 상수로만든다음 toggle2라는 매개변수 값 넣음
 		
		// 2. checked 속성값을 확인합니다.
		const is_checked = checkbox.checked; // 상수 is_ckecke는 checkbox라는 애의 자식인 ckecked라는 친구의 값을 받음 맞는지 모르겠다 
		
		
		let checkdata =  'n'; // 체크 데이터라는 변수의 기본값은 n
		
		if(is_checked == true ){ //만약  is_Ckecked가 진실이면
			checkdata = 'y';		// 체크 데이터는 y이다
		}
		

		// 에이잭스통신문
		$.ajax({
			url : "openynOk.jsp", // openYnOK.jsp 의주소로 이동시킨다
			type : "post", //포스트방식으로 안전하게 보낸다
			data : { // 데이터는 openyn 라는 컬럼 의 변수 체크데이터 를 보낼것임
				openyn : checkdata
			},
			success : function(result) { // 리절트라는 함수띄우기? 모르겠다
				console.log(result); // 콘솔에 result 띄우기
			},
			error : function(error) {	//아모르겠다
				console.error(error)
			}
		});

	}
</script>
</head>
<body>
<%@ include file="/include/settingHeader.jsp"%>
	

	<main>

		<div class="inner2 clearfix">
			<h3>계정 공개 범위</h3>
			<div id="settingTop">
				<span>비공개 계정</span> 
				<input type='checkbox' id='togglecheck' class='tgl' onchange="sendData(this)" /> 
				<label for='togglecheck'></label>
			</div>

			<div class="textBoxP">
				<p>계정이 공개 상태인 경우 로그인한 사용자는 프로필과 게시물을 모두 볼</p>
				<p>수 있습니다. 또한 팔로우 요청을 자동으로 수락합니다.</p>
			</div>
			<div class="textBoxP">
				<p>계정이 비공개 상태인 경우 회원님이 승인한 팔로워만 게시물을 볼 수</p>
				<p>있습니다.</p>
			</div>
			<div class="textBoxP">
				<p>계정 공개 유무와 상관없이 비공개 게시물은 자신만 볼 수 있습니다.</p>
			</div>

		</div>

	</main>
</body>

</html>