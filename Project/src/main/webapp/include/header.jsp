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
   
    <link href="<%=request.getContextPath()%>/css/post/post.css" type="text/css"
	rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/base.css" type="text/css"
	rel="stylesheet"> <!-- footer css도 포함 -->
	
	<script> //post작업을 위한 코드
	function addImg(){
	      // 추가 버튼은 맨 아래 자식에만 존재해야 함.
	      let childCnt = $("#preview div").length;
	      
	      // 추가 버튼을 포함하여 맨 아래에 추가
	      let html = '<div class="draggable" draggable: "true">';
	      html += ' <label  for="file' + (childCnt) + '" class="changeImg"><img src="<%=request.getContextPath()%>/icon/replyPlus.png"></label>';
	      html += ' <img src="<%=request.getContextPath()%>/icon/noneImg.gif" class="thumbnailImg" onclick="previewImg(this)">'
	      html += ' <input type="file" onchange="thumbnail(event,this)" id="file' + (childCnt) + '" name="file' + (childCnt) + '" hidden="true">';
	      html += ' <button type="button" class="imgDelete" onclick="removeImg(this)">제거</button>';
	      html += '</div>';
	      $("#preview").append(html);

	      //공유버튼 활성화
	      let childCnt2 = $("#preview div").length;
	      if(childCnt2 != 0){
	        document.getElementById("dropBoxSubmit").removeAttribute("disabled");
	        document.getElementById("dropBoxSubmit").style.color ="#4EA685"
	      }else{
	        document.getElementById("dropBoxSubmit").setAttribute("disabled", true);
	        document.getElementById("dropBoxSubmit").style.color ="#aaa"
	      }

	      //썸네일 이미지 드래그 코드 1 (추가버튼을 누를때마다 추가된 div를 찾는다)
	          let = draggables = document.querySelectorAll(".draggable");
	          let = containers = document.querySelectorAll(".preview");
	          // 드래그시 dragging라는 클래스 주입 
	          draggables.forEach(draggable => {
	          draggable.addEventListener("dragstart", () => {
	            draggable.classList.add("dragging");
	          });

	          // 드래그 끝나면 dragging라는 클래스 제거 
	          draggable.addEventListener("dragend", () => {
	              draggable.classList.remove("dragging");
	            });
	          });

	          containers.forEach(container => {
	          container.addEventListener("dragover", e => {
	            e.preventDefault();
	            const afterElement = getDragAfterElement(container, e.clientY); //clientY y값으로 변경
	            const draggable = document.querySelector(".dragging");
	            if (afterElement === undefined) {
	              container.appendChild(draggable);
	            } else {
	              container.insertBefore(draggable, afterElement);
	            }
	          });
	        });
	      
	    } //추가버튼 함수 끝

	      //이미지 드래그 앤 드랍으로 순서 변경하는 코드 (연구 부족으로 일단 아래에서 위로만 드래그 가능)
	      function getDragAfterElement(container, y) {
	        const draggableElements = [
	          ...container.querySelectorAll(".draggable:not(.dragging)"),
	        ];

	        return draggableElements.reduce(
	          (closest, child) => {
	            const box = child.getBoundingClientRect();
	            const offset = y - box.top - box.width / 3; //box.left -> box.top로 변경 box.width 3으로 바꿔 감도 변경
	            if (offset < 0 && offset > closest.offset) {
	              return { offset: offset, element: child };
	            } else {
	              return closest;
	            }
	          },
	          { offset: Number.NEGATIVE_INFINITY },
	        ).element;
	    }

	    //제거 코드
	    function removeImg(e){
	      $(e).parent().remove();
		

	      //제거 시 공유하기 버튼 비활성화 
	      let childCnt2 = $("#preview div").length;
	      console.log(childCnt2)
	      if(childCnt2 != 0){
	        document.getElementById("dropBoxSubmit").removeAttribute("disabled");
	        document.getElementById("dropBoxSubmit").style.color ="#4EA685"
	      }else{
	        document.getElementById("dropBoxSubmit").setAttribute("disabled", true);
	        document.getElementById("dropBoxSubmit").style.color ="#aaa"
	      }
	        
	    };

	    //썸네일 추가 함수
	    function thumbnail(event,obj){
	      const file = event.target.files[0];
	      const img = $(obj).prev()
	       const reader = new FileReader();
	       reader.onload = (e) => {
	        $(img).attr("src", e.target?.result );
	       };
	       reader.readAsDataURL(file);
	      }


	    //글자 수 세주는 코드
	    function calc(){
	      document.getElementById('replyTextareaCount').innerHTML =
	      document.getElementById('replyTextarea').value.length;
	    }


	    //이미지 클릭시 미리보기
	    function previewImg(obj){
	      let previewSrc = $(obj).attr("src");
	      if(previewSrc != "<%=request.getContextPath()%>/icon/noneImg.gif"){
	        $(".dropBox").css("background-image","url("+previewSrc+")")
	        $(".dropBox").css("background-color","#111")
	      }
	    }

	    //공유하기 버튼 클릭 시 유효성 검사 코드
	    function submitCheck(){
	      // input 이름 부여 후 그 후 들어온 input의 안의 데이터에 이상한 src가 있는지 검사

	      //input의 이름을 배정해준다
	      $("#preview div input[type=file]").each(function (index, item){  //item은 preview div input[type=file]의 현재 요소, index는 인덱스 요소(위부터)
	          $(item).attr("name", "file_" + (index) );
	        });

	      //input 파일안에 이미지가 없는 경우 임시로 넣어둔 이미지가 있다면 공유하기 안되도록
	      let imgCheck = false;
	      $(".thumbnailImg").each(function (index, item){ 
	        let previewSrc = $(item).attr("src");
	        //만약 임시이미지가 잘못된 경우
	        if(previewSrc == null || previewSrc == "/Dongstagram/icon/noneImg.gif"){
	          imgCheck = false;
	          return false; //반복하는 도중 문제를 발견하면 바로 반복문 종료(마지막만 제대로된 사진일 경우 트루되버리는거 방지)
	        }else{
	          imgCheck = true
	        }
	      });

	      if(imgCheck){
	        document.postfrm.submit();
	      }else{
	        alert("이미지를 전부 넣어주세요");
	      }

	    }
	</script>
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

                <input type="radio" name="tab_radio" id="tab2"/>
                <label for="tab2" class="tab3"><a href="./message.html"><img src="<%=request.getContextPath()%>/icon/message.png">메세지</a></label>

                <input type="radio" name="tab_radio" id="tab3"/>
                <label for="tab3" class="tab3"><img src="<%=request.getContextPath()%>/icon/notice.png">알림</label>

                <input type="radio" name="tab_radio" id="tab4"/>
                <label for="tab4" class="tab3"><a href="./navigation.html"><img src="<%=request.getContextPath()%>/icon/scan.png">탐색 탭</a></label>

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
      
            <section id="nav2" class="clearfix">
              <div id="nickname">자기 닉네임</div>
              <a data-toggle="modal" href="#messagePopup" id="messageLink"><img src="./icon/massagewrite.png" ></a>
              <h5>메세지</h5>
              <!--for문으로 div안에 데이터 집어넣음-->

              <div class="massage">
                <a href="#">
                  <img src="./자산 4.png" class="profile">
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