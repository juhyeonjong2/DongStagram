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
	function sendData(e) {
		// 진짜가는지 확인
		console.log("!");
		// 1. checkbox element를 찾습니다.
		const checkbox = document.getElementById('toggle2');
		
		// 2. checked 속성값을 확인합니다.
		const is_checked = checkbox.checked;
		
		let checkdata =  'n';
		
		if(is_checked == true ){
			checkdata = 'y';
		}
		

		// 프론트에서 어카운트의 
		$.ajax({
			url : "openynOk.jsp",
			type : "post",
			data : {
				openyn : checkdata
			},
			success : function(result) {
				console.log(result);
			},
			error : function(error) {
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