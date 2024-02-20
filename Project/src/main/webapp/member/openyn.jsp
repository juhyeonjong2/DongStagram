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
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css"
	rel="stylesheet">
<script src="./post.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
</head>
<body>
	<header>

		<nav id="nav">
			<h1 id="logo">
				<a href="#"></a>
			</h1>
			<div id="tabmenu">
				<input type="radio" name="tab_radio" id="tab"> <label
					for="tab" class="tab3"><a href="./base.html"><img
						src="<%=request.getContextPath()%>/icon/home.png">홈</a></label> <input
					type="radio" name="tab_radio" id="tab1" /> <label for="tab1"
					class="tab3"><img
					src="<%=request.getContextPath()%>/icon/search.png">검색</label> <input
					type="radio" name="tab_radio" id="tab2" /> <label for="tab2"
					class="tab3"><a href="./message.html"><img
						src="<%=request.getContextPath()%>/icon/message.png">메세지</a></label> <input
					type="radio" name="tab_radio" id="tab3" /> <label for="tab3"
					class="tab3"><img
					src="<%=request.getContextPath()%>/icon/notice.png">알림</label> <input
					type="radio" name="tab_radio" id="tab4" /> <label for="tab4"
					class="tab3"><a href="./navigation.html"><img
						src="<%=request.getContextPath()%>/icon/scan.png">탐색 탭</a></label> <input
					type="radio" name="tab_radio" id="tab5" /> <label for="tab5"
					class="tab3"><a data-toggle="modal" href="#postPopup"><img
						src="<%=request.getContextPath()%>/icon/post.png">만들기</a></label> <input
					type="radio" name="tab_radio" id="tab6" /> <label for="tab6"
					class="tab3"><a href="./search3.html"><img
						src="<%=request.getContextPath()%>/icon/profile.png">프로필</a></label> <input
					type="radio" name="tab_radio" id="tab7" /> <label for="tab7"
					class="tab3"><img
					src="<%=request.getContextPath()%>/icon/more.png">더 보기</label>

				<section id="nav1">
					<h4>검색</h4>
					<form action="#">
						<input type="text" placeholder="  검색" id="hdsearch">
					</form>
					<hr>
					<h5>최근 검색 항목</h5>
					<!--for문으로 div안에 데이터 집어넣음-->
					<div class="search">
						<a href="./search.html"> <img src="./icon/hashtag.png"
							class="profile"> <span class="span">검색 한 것</span> <span
							class="span2">게시물 500만</span>
						</a>
					</div>

					<div class="search">
						<a href="./search2.html"> <img src="./즐겁다 짤.jpg"
							class="profile"> <span class="span">abc마트</span> <span
							class="span2">abc마트 · 팔로워 24.7만명</span>
						</a>
					</div>
				</section>

				<section id="nav2" class="clearfix">
					<div id="nickname">자기 닉네임</div>
					<a data-toggle="modal" href="#messagePopup" id="messageLink"><img
						src="./icon/massagewrite.png"></a>
					<h5>메세지</h5>
					<!--for문으로 div안에 데이터 집어넣음-->

					<div class="massage">
						<a href="#"> <img src="./자산 4.png" class="profile"> <span
							class="span">###님에게 메세지가 도착하였습니다. <span class="span2">10분전</span>
						</span>
						</a>
					</div>
				</section>

				<section id="nav3">
					<h4>알림</h4>
					<h5>오늘</h5>
					<!--for문으로 div안에 데이터 집어넣음 처음 이미지는 유저 프로필 다음이미지는 게시글 미리보기-->
					<div class="notice">
						<a href="#" class="atag"> <img src="./자산 4.png"
							class="profile"> <span class="span">###님이 회원님을 팔로우
								하기 시작했습니다. <span class="span2">10분전</span>
						</span> <a href="#" class="atag2">팔로우</a>
						</a>
					</div>

					<!--임시 페이지 언팔로우는 class atag3으로 변경-->
					<div class="notice">
						<a href="#" class="atag"> <img src="./자산 4.png"
							class="profile"> <span class="span">###님이 회원님을 팔로우
								하기 시작했습니다. <span class="span2">10분전</span>
						</span> <a href="#" class="atag3">언팔로우</a>
						</a>
					</div>

					<!--임시 페이지 언팔로우는 class atag3으로 변경-->
					<div class="notice">
						<a href="#" class="atag"> <img src="./자산 4.png"
							class="profile"> <span class="span">###님이 회원님께 메세지를
								보냈습니다. <span class="span2">10분전</span>
						</span> <a href="#" class="atag2">확인</a>
						</a>
					</div>


				</section>

				<section id="nav4">
					<ul>
						<li><a href="./login.html">로그인</a></li>
						<!--일단 로그인 가는 경로가 없어 수정 안함-->
						<li><a href="./setting.html">설정</a></li>
						<!--만약 관리자라면 href를 adminSetting로 변경-->
					</ul>
				</section>

				<section id="settingTab">
					<h4>설정</h4>
					<div class="settingTop">
						<p>내 Donstaram 사용 방식</p>
						<a class="settingBt" href="./setting.html"> <img
							src="./icon/profile.png"> <span>프로필 편집</span>
						</a> <a class="settingBt" href="./settingPW.html"> <img
							src="./icon/key.png" class="imgSize"> <span>비밀번호 변경</span>
						</a>
					</div>
					<div class="settingBottom">
						<p>내 콘텐츠를 볼 수 있는 사람</p>
						<a class="settingBt" href="./setting2.html"> <img
							src="./icon/lock.png"> <span>계정 공개 범위</span>
						</a> <a class="settingBt" href="./setting3.html"> <img
							src="./icon/block.png" class="imgSize"> <span>차단된 계정</span>
						</a>
					</div>
				</section>

			</div>
			<!--tabmenu-->
		</nav>
		<!--nav-->
	</header>
	<!--header-->

	<main>

		<div class="inner2 clearfix">
			<h3>계정 공개 범위</h3>
			<div id="settingTop">
				<span>비공개 계정</span> <input type='checkbox' id='toggle2' class='tgl'
					onchange="sendData(this)" /> <label for='toggle2'></label>






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
<script>
	function sendData(e) {
		// 진짜가는지 확인

		// 1. checkbox element를 찾습니다.
		const checkbox = document.getElementById('toggle2');
		
		// 2. checked 속성값을 확인합니다.
		const is_checked = checkbox.checked;
		
		let checkdata =  'N';
		
		if(is_checked == true ){
			checkdata = 'Y';
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
</html>