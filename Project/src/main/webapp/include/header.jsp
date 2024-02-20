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
   <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>-->
   <script src="https://code.jquery.com/jquery-3.5.1.js"></script> <!-- 위 때문에 ajax통신이 잘 안됨 -->
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

   
   <!-- Link Swiper's CSS -->
   <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
   <!-- Swiper JS -->
   <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
   
   <link href="<%=request.getContextPath()%>/css/post/post.css" type="text/css" rel="stylesheet">
   <!-- footer css도 포함 -->
   <link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
   <script src="<%=request.getContextPath()%>/js/include/header.js"></script>
</head>
<body>
<header>

    <nav id="nav">
          <h1 id="logo">
          	<a href="#">
          		<img src="<%=request.getContextPath()%>/icon/logo.png">
          	</a>
          </h1>
          <div id="tabmenu">
            <input type="radio" name="tab_radio" id="tab">
              <label for="tab" class="tab3"><a href="./base.html"><img src="<%=request.getContextPath()%>/icon/home.png">홈</a></label>

                <input type="radio" name="tab_radio" id="tab1"/>
                <label for="tab1" class="tab3"><img src="<%=request.getContextPath()%>/icon/search.png">검색</label>
<!-- 아쉽지만 빠이 

                <input type="radio" name="tab_radio" id="tab2"/>
                <label for="tab2" class="tab3"><a href="./message.html"><img src="<%=request.getContextPath()%>/icon/message.png">메세지</a></label>
-->

                <input type="radio" name="tab_radio" id="tab3"/>
                <label for="tab3" class="tab3"><img src="<%=request.getContextPath()%>/icon/notice.png">알림</label>
<!-- 아쉽지만 빠이 
                <input type="radio" name="tab_radio" id="tab4"/>
                <label for="tab4" class="tab3"><a href="./navigation.html"><img src="<%=request.getContextPath()%>/icon/scan.png">탐색 탭</a></label>
-->
                <input type="radio" name="tab_radio" id="tab5"/>
                <label for="tab5" class="tab3"><a data-toggle="modal" href="#postPopup"><img src="<%=request.getContextPath()%>/icon/post.png">만들기</a></label>
                
                <input type="radio" name="tab_radio" id="tab6"/>
                <label for="tab6" class="tab3"><a href="<%=request.getContextPath()%>/member/profile.jsp?mno=<%=memberHeader.getMno()%>"><img src="<%=request.getContextPath()%>/icon/profile.png">프로필</a></label>

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
                  <img src="./icon/hashtag.png" class="profile">
                  <span class="span">검색 한 것</span>
                  <span class="span2">게시물 500만</span>
                </a>
              </div>

              <div class="search">
                <a href="./search2.html">
                  <img src="./즐겁다 짤.jpg" class="profile">
                  <span class="span">abc마트</span>
                  <span class="span2">abc마트 · 팔로워 24.7만명</span>
                </a>
              </div>
            </section>
   <!--     
            <section id="nav2" class="clearfix">
           
              <div id="nickname">자기 닉네임</div>
              <a data-toggle="modal" href="#messagePopup" id="messageLink"><img src="./icon/massagewrite.png" ></a>
              <h5>메세지</h5>
              <div class="massage">
                <a href="#">
                  <img src="./자산 4.png" class="profile">
                  <span class="span">###님에게 메세지가 도착하였습니다.
                    <span class="span2">10분전</span>
                  </span>
                </a>
              </div>
            </section>
      -->
            <section id="nav3">
              <h4>알림</h4>
              <h5>오늘</h5>
              <!--for문으로 div안에 데이터 집어넣음 처음 이미지는 유저 프로필 다음이미지는 게시글 미리보기-->
              <div class="notice">
                <a href="#" class="atag">
                  <img src="./자산 4.png" class="profile">
                  <span class="span">###님이 회원님을 팔로우 하기 시작했습니다.
                    <span class="span2">10분전</span>
                  </span>
                  <a href="#" class="atag2">팔로우</a>
                </a>
              </div>

              <!--임시 페이지 언팔로우는 class atag3으로 변경-->
              <div class="notice">
                <a href="#" class="atag">
                  <img src="./자산 4.png" class="profile">
                  <span class="span">###님이 회원님을 팔로우 하기 시작했습니다.
                    <span class="span2">10분전</span>
                  </span>
                  <a href="#" class="atag3">언팔로우</a>
                </a>
              </div>

              <!--임시 페이지 언팔로우는 class atag3으로 변경-->
              <div class="notice">
                <a href="#" class="atag">
                  <img src="./자산 4.png" class="profile">
                  <span class="span">###님이 회원님께 메세지를 보냈습니다.
                    <span class="span2">10분전</span>
                  </span>
                  <a href="#" class="atag2">확인</a>
                </a>
              </div>
              

            </section>

            <section id="nav4">
              <ul>
                <li><a href="<%=request.getContextPath()%>/accounts/logout">로그아웃</a></li> <!--일단 로그인 가는 경로가 없어 수정 안함-->
                <li><a href="<%=request.getContextPath()%>/member/profileModify.jsp">설정</a></li> <!--만약 관리자라면 href를 adminSetting로 변경-->
              </ul>
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