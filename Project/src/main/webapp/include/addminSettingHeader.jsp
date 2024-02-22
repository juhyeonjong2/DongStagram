<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%
	MemberVO memberHeader = (MemberVO)session.getAttribute("login"); //인덱스에 합쳐지는 헤드가 인덱스와 겹쳐서 이름 바꿔준다.
%>
<!DOCTYPE html>
<html>
<head>
   <!-- CSS CDN 링크 -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
   integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
   crossorigin="anonymous">
     
     
   <!-- JavaScript CDN 링크 -->
   <!--  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
   <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

   
    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <link href="<%=request.getContextPath()%>/css/post/post.css" type="text/css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet"> <!-- footer css도 포함 -->
    <script src="<%=request.getContextPath()%>/js/util/number.js"></script>
	<script src="<%=request.getContextPath()%>/js/include/header.js"></script>
	<script src="<%=request.getContextPath()%>/js/include/search.js"></script>
	<script src="<%=request.getContextPath()%>/js/include/notification.js"></script>
</head>
<body>
  <header>

    <nav id="nav">
      <h1 id="logo"><a href="#"></a></h1>
      <div id="tabmenu">
        <input type="radio" name="tab_radio" id="tab">
          <label for="tab" class="tab3"><a href="./base.html"><img src="<%=request.getContextPath()%>/icon/home.png">홈</a></label>

            <input type="radio" name="tab_radio" id="tab1"/>
            <label for="tab1" class="tab3"><img src="<%=request.getContextPath()%>/icon/search.png">검색</label>

            <input type="radio" name="tab_radio" id="tab3"/>
            <label for="tab3" class="tab3"><img src="<%=request.getContextPath()%>/icon/notice.png">알림</label>

            <input type="radio" name="tab_radio" id="tab5"/>
            <label for="tab5" class="tab3"><a data-toggle="modal" href="#postPopup"><img src="<%=request.getContextPath()%>/icon/post.png">만들기</a></label>
            
            <input type="radio" name="tab_radio" id="tab6"/>
            <label for="tab6" class="tab3"><a href="<%=request.getContextPath()%>/member/profile.jsp?mno=<%=memberHeader.getMno()%>"><img src="<%=request.getContextPath()%>/icon/profile.png">프로필</a></label>

            <input type="radio" name="tab_radio" id="tab7"/>
            <label for="tab7" class="tab3"><img src="<%=request.getContextPath()%>/icon/more.png">더 보기</label>
        
		<section id="nav1">
		<h4>검색</h4>
			<form class="searchFrm" onsubmit="return false;">
				<input type="text" name="serach" placeholder="  검색" id="hdsearch" onkeyup="searchContent(this);">
			</form>
			<div id="searchBody">
			</div>
		</section>

        <section id="nav3">
          <h4>알림</h4>
          <!-- <h5>오늘</h5> -->
          <div id="notificationBody" style="overflow-x:hidden; width:380px; height:700px;">
		  </div>
        </section>

        <section id="nav4">
          <ul>
             <li><a href="<%=request.getContextPath()%>/accounts/logout">로그아웃</a></li> <!--일단 로그인 가는 경로가 없어 수정 안함-->
             <li><a href="<%=request.getContextPath()%>/accounts/setting/profile">설정</a></li> <!--만약 관리자라면 href를 adminSetting로 변경-->
           </ul>
        </section>

            <section id="settingTab">
              <h4>설정</h4>
              <div class="settingTop">
                <p>사용자 관리</p>
                <a class="settingBt" href="<%=request.getContextPath()%>/accounts/setting/block/user">
                  <span>블랙리스트</span>
                </a>
                <a class="settingBt" href="<%=request.getContextPath()%>/accounts/setting/report/user">
                  <span>신고된 계정</span>
                </a>
                </div>
                <!-- 보류 -->
               <!--      
              <div class="settingBottom">
                <p>게시물 관리</p>
                <a class="settingBt" href="<%=request.getContextPath()%>/accounts/setting/block/board">
                  <span>차단된 게시물</span>
                </a>
                <a class="settingBt" href="<%=request.getContextPath()%>/accounts/setting/report/board">
                  <span>신고된 게시물</span>
                </a>
              </div>
               -->
            </section>

        </div><!--tabmenu-->
    </nav> <!--nav-->
  </header> <!--header-->
  
  <main>
  
  
  
  
  
  	<!--header post popup (만들기의 팝업창)-->
        <div class="modal fade" id="postPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">새 게시글 만들기</h5>
              </div>
              <div class="modal-body">


                <form class="container" action="<%=request.getContextPath()%>/board/postOk.jsp" name="postfrm" method="post" enctype="multipart/form-data">
                    <div class="dropBox" id="dropBox"></div>
                  <div class="postLeft">
                    <div class="preview" id="preview"></div>
                    <button onclick="addImg()" class="plusBtn" type="button">
                      <img src="<%=request.getContextPath()%>/icon/post.png" class="postPlus">
                    </button>
                  </div>

                  <div class="postRight">
                    
                    <div class="rightTop">
                      <div class="rightTop2">
                        <img src="./즐겁다 짤.jpg" class="profile">
                        <span class="nickname">tester123</span>
                      </div>
                      <textarea name="boardReply" class="replyTextarea" id="replyTextarea" placeholder="문구를 입력하세요..." onkeydown="calc()" onkeyup="calc()" onkeypress="calc()"></textarea>
                      <span class="replyTextareaCount" id="replyTextareaCount">0
                      </span>
                      <span class="replyTextareaCount2">/2200</span>
                    </div>

                    <div class="rightBottom">
                      <h4>설정</h4>
                      <ul class="righrToggle">
                        <li>
                          <span>게시물 공개</span>
                          <input type='checkbox' id='toggle' class='tgl' name="boardOpen" value="y"/>
                          <label for='toggle'></label>
                        </li>
                        <li>
                          <span>좋아요 공개</span>
                          <input type='checkbox' id='toggle2' class='tgl' name="favoriteOpen" value="y" />
                          <label for='toggle2'></label>
                        </li>
                        <li>
                          <span>댓글 기능 허용</span>
                          <input type='checkbox' id='toggle3' class='tgl' name="replyOpen" value="y" />
                          <label for='toggle3'></label>
                        </li>
                      </ul>
                    </div>

                  </div>
                  <input type="button" value="공유하기" class="dropBoxSubmit" id="dropBoxSubmit" onclick="submitCheck()" disabled/>
                </form>

              </div>
            </div>
          </div>
        </div>
  </main>
</body>
</html>