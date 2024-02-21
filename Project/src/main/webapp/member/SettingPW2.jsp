<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
 <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 변경</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/base.css"
  type="text/css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/setting.css"
  type="text/css" rel="stylesheet">
  <script src="./post.js"></script>

	<script>
	ipt>
	function validation(){
		let mpassword = document.frm.mpassword.value;
		
		
		let check = true;
		if(mpassword == ""){
			check = false;
			document.frm.password.style.border="1px solid red";
		}else{
			check = true;
			document.frm.password.removeAttribute("style");
		}
	}
	
	</script>
</head>
<body>
	 <nav id="nav">
      <h1 id="logo"><a href="#"></a></h1>
      <div id="tabmenu">
        <input type="radio" name="tab_radio" id="tab">
          <label for="tab" class="tab3"><a href="./base.html"><img src="<%=request.getContextPath()%>/icon/home.png">홈</a></label>

            <input type="radio" name="tab_radio" id="tab1"/>
            <label for="tab1" class="tab3"><img src="<%=request.getContextPath()%>/icon/search.png">검색</label>

            <input type="radio" name="tab_radio" id="tab2"/>
            <label for="tab2" class="tab3"><a href="./message.html"><img src="<%=request.getContextPath()%>/icon/message.png">메세지</a></label>

            <input type="radio" name="tab_radio" id="tab3"/>
            <label for="tab3" class="tab3"><img src="<%=request.getContextPath()%>/icon/notice.png">알림</label>

            <input type="radio" name="tab_radio" id="tab4"/>
            <label for="tab4" class="tab3"><a href="./navigation.html"><img src="<%=request.getContextPath()%>/icon/scan.png">탐색 탭</a></label>

            <input type="radio" name="tab_radio" id="tab5"/>
            <label for="tab5" class="tab3"><a data-toggle="modal" href="#postPopup"><img src="<%=request.getContextPath()%>/icon/post.png">만들기</a></label>
            
            <input type="radio" name="tab_radio" id="tab6"/>
            <label for="tab6" class="tab3"><a href="./search3.html"><img src="<%=request.getContextPath()%>/icon/profile.png">프로필</a></label>

            <input type="radio" name="tab_radio" id="tab7"/>
            <label for="tab7" class="tab3"><img src="<%=request.getContextPath()%>/icon/more.png">더 보기</label>
        
        <section id="nav1">
          <h4>검색</h4>
          <form action="#"> 
            <input type="text" placeholder="  검색" id="hdsearch">
          </form>
          <hr>
          <h5>최근 검색 항목</h5>
          <!--for문으로 div안에 데이터 집어넣음-->
          <div class="search">
            <a href="./search.html">
              <img src="<%=request.getContextPath()%>/icon/hashtag.png" class="profile">
              <span class="span">검색 한 것</span>
              <span class="span2">게시물 500만</span>
            </a>
          </div>

          <div class="search">
            <a href="./search2.html">
              <img src="<%=request.getContextPath()%>/즐겁다 짤.jpg" class="profile">
              <span class="span">abc마트</span>
              <span class="span2">abc마트 · 팔로워 24.7만명</span>
            </a>
          </div>
        </section>
  
        <section id="nav2" class="clearfix">
          <div id="nickname">자기 닉네임</div>
          <a data-toggle="modal" href="#messagePopup" id="messageLink"><img src="./icon/massagewrite.png" ></a>
          <h5>메세지</h5>
          <!--for문으로 div안에 데이터 집어넣음-->

          <div class="massage">
            <a href="#">
              <img src="<%=request.getContextPath()%>/자산 4.png" class="profile">
              <span class="span">###님에게 메세지가 도착하였습니다.
                <span class="span2">10분전</span>
              </span>
            </a>
          </div>
        </section>
  
        <section id="nav3">
          <h4>알림</h4>
          <h5>오늘</h5>
          <!--for문으로 div안에 데이터 집어넣음 처음 이미지는 유저 프로필 다음이미지는 게시글 미리보기-->
          <div class="notice">
            <a href="#" class="atag">
              <img src="<%=request.getContextPath()%>/자산 4.png" class="profile">
              <span class="span">###님이 회원님을 팔로우 하기 시작했습니다.
                <span class="span2">10분전</span>
              </span>
              <a href="#" class="atag2">팔로우</a>
            </a>
          </div>

          <!--임시 페이지 언팔로우는 class atag3으로 변경-->
          <div class="notice">
            <a href="#" class="atag">
              <img src="<%=request.getContextPath()%>/자산 4.png" class="profile">
              <span class="span">###님이 회원님을 팔로우 하기 시작했습니다.
                <span class="span2">10분전</span>
              </span>
              <a href="#" class="atag3">언팔로우</a>
            </a>
          </div>

          <!--임시 페이지 언팔로우는 class atag3으로 변경-->
          <div class="notice">
            <a href="#" class="atag">
              <img src="<%=request.getContextPath()%>/자산 4.png" class="profile">
              <span class="span">###님이 회원님께 메세지를 보냈습니다.
                <span class="span2">10분전</span>
              </span>
              <a href="#" class="atag2">확인</a>
            </a>
          </div>
          

        </section>

        <section id="nav4">
          <ul>
            <li><a href="./login.html">로그인</a></li> <!--일단 로그인 가는 경로가 없어 수정 안함-->
            <li><a href="./setting.html">설정</a></li> <!--만약 관리자라면 href를 adminSetting로 변경-->
          </ul>
        </section>

            <section id="settingTab">
              <h4>설정</h4>
              <div class="settingTop">
                <p>내 Donstaram 사용 방식</p>
                <a class="settingBt" href="./setting.html">
                  <img src="<%=request.getContextPath()%>/icon/profile.png">
                  <span>프로필 편집</span>
                </a>
                <a class="settingBt" href="./settingPW.html">
                  <img src="<%=request.getContextPath()%>/icon/key.png" class="imgSize">
                  <span>비밀번호 변경</span>
                </a>
                </div>
              <div class="settingBottom">
                <p>내 콘텐츠를 볼 수 있는 사람</p>
                <a class="settingBt"  href="./setting2.html">
                  <img src="<%=request.getContextPath()%>/icon/lock.png">
                  <span>계정 공개 범위</span>
                </a>
                <a class="settingBt" href="./setting3.html">
                  <img src="<%=request.getContextPath()%>/icon/block.png" class="imgSize">
                  <span>차단된 계정</span>
                </a>
              </div>
            </section>

        </div><!--tabmenu-->
    </nav> <!--nav-->
  </header> <!--header-->

  <main>

    <div class="inner2 clearfix">
      <h3>비밀번호 변경</h3>

    <form action="SettingpwOk.jsp" method="post">
        <div class="settingPW">
            <p>기존 비밀번호 입력</p>
            <input type="password">
            <p>변경할 비밀번호 입력</p>
            <input type="password">
            <p>변경할 비밀번호 확인</p>
            <input type="password">
        </div>
        <button type="submit" class="settingPWSubmit">변경</button>
        <!--변경의 회색버전은 class에 settingPWSubmit2로 바꿔주면 됨-->
        <!--<button type="submit" class="settingSubmit2">제출</button>-->
    </form>

    </div>
  </main>
  
</body>
</html>
































