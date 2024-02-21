<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath()%>/js/include/popup.js"></script>
</head>
<body>
 <!-- Modal -->
            <div class="modal fade" id="detailBoard" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">게시글 보기</h5>
                    </div>
                    <div class="modal-body">
                    <div class="popupView">
                        <!--왼쪽-->
                        <div class="popupViewLeft">
                            <!--보내진 이미지 들어오는 곳-->
                            
                            <div class="slideShow"> <!--메인 동영상과 사진 슬라이드-->
							    <div class="swiper mySwiper">
							      <div class="swiper-wrapper">
							      <!-- 받아온 bno의있는 모든 이미지를 가져온다 -> 순서대로 나열한다  -->
							        
							      </div>
							      <div class="swiper-button-next"></div>
							      <div class="swiper-button-prev"></div>
							      <div class="swiper-pagination"></div>
							    </div>
							
                    
                            </div> <!--메인 동영상과 사진 슬라이드-->

                        </div>

                        <!--오른쪽-->
                        <div class="popupViewRight">
                            <!--상단 태그-->
                            <div class="mainTop">
                                <img src="./자산 4.png" class="profile">
                                <a href="#" class="main1name">닉네임</a>
                                <button>팔로우</button>
                                <a data-toggle="modal" class="popupviewMainSpan2" onclick="boardModify()">· · ·</a>
                            </div> <!--상단 태그-->

                            <!--댓글 창-->
                            <div class="popupviewMain">
                              <!--댓글이 없을경우 보여주는 글
                              <div class="notReply">
                                  <p>아직 댓글이 없습니다.</p>
                                  <h6>댓글을 남겨보세요</h6>
                              </div>-->

                                <!--for문으로 복사 될 페이지-->
                                    <div class="mainTop">
                                        <img src="./자산 4.png" class="profile">
                                        <a href="#" class="main1name">닉네임</a>
                                        <div class="popupViewReply">123가가가가가각가가가가가가가가가가가가가가가가가가가가가가가가가가가</div>
                                     </div> <!--상단 태그-->
                                     <span class="popupviewMainSpan1">6일</span>
                                     <span class="popupviewMainSpan3">| 댓글달기 |</span>
                                     <a data-toggle="modal"  href="#morePopup" class="popupviewMainSpan2">· · ·</a>

                                     <!--만약 대댓글이(태그를 통해) 달릴 경우 보여줄 글 -->

                                      <div class="reReply">---댓글 보기(?개)</div> 

                                        <div class="replyblock">
                                            <div class="mainTop">
                                              <img src="./자산 4.png" class="profile">
                                              <a href="#" class="main1name">닉네임</a>
                                              <div class="popupViewReply">대댓글입니다.</div>
                                          </div> <!--상단 태그-->
                                          <span class="popupviewMainSpan1">6일</span>
                                          <span class="popupviewMainSpan3">| 댓글달기 |</span>
                                          <a data-toggle="modal" href="#morePopup" class="popupviewMainSpan2">· · ·</a>
                                        </div>
                                    <!--for문으로 복사 될 페이지-->
                                   
                                      <!--댓글이 많다면 보여줄 아이콘-->
                                      <div class="replyPlus">
                                        <img src="./icon/replyPlus.png">
                                      </div>

                                  </div> <!--댓글 창-->
                            <!--하단 태그-->
                            <div class="popupviewBottom">
                            	<form class="favoriteFrm" onsubmit="return false;">
									<input type='hidden' name='bno' id="favorite" value="">
									<input type='hidden' name='req' value="1">
	                                <img src="<%=request.getContextPath()%>/icon/heart.png" id="goodHt" onclick="sendFavorite(this)">
                                	<img src="<%=request.getContextPath()%>/icon/reply.png">
	                            </form>
                                <div class="popupviewBottom2">
                                    <img src="./자산 4.png" class="profile"><!--작은프로필-->
                                    <span class="popupviewBottomSpan1">좋아요 11개</span>
                                    <span class="popupviewBottomSpan2">6일 전</span>
                                </div>

                                    <input type="text" placeholder="   댓글달기..." onkeyup="if(window.event.keyCode==13){enterkey(this)}" id="replyText">
                                    <input type="hidden" id="inputBno" value=""> <!-- 인코딩된 bno라 괜찮을듯 -->
                                    <input type="hidden" id="inputMnick" value="<%=member.getMnick()%>"> <!-- 닉네임을 넘기는거라 괜찮을 듯 -->
                            </div>
                        </div>
                    </div> <!--popupView-->


                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    </div>
                </div>
                </div>
            </div>
<!-- Modal -->

  <!-- 댓글 ... -->
      <div class="modal fade" id="morePopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-body">
              <div class="morePopupMain">
                <div class="morePopupBox1"><a href="#">신고</a></div>
                <!--삭제는 if문 사용으로 숨기기-->
                <div class="morePopupBox2"><a onclick="replyDelete()">삭제</a></div>
                <button type="button" class="morePopupBox3" data-dismiss="modal">취소</button>
                <input type="hidden" id="inputRno" value="">
              </div>
            </div>
          </div>
        </div>
      </div>
      
   <!-- 타인 게시물 ... -->
      <div class="modal fade" id="bPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-body">
              <div class="morePopupMain">
                <div class="morePopupBox1"><a href="#">신고</a></div>
                <button type="button" class="morePopupBox3" data-dismiss="modal">취소</button>
                <input type="hidden" id="inputRno" value="">
              </div>
            </div>
          </div>
        </div>
      </div>

  <!--게시물 보기 안 ... -->
      <div class="modal fade" id="morePopup2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-body">
              <div class="morePopupMain">
                <div class="morePopupBox1"><a data-toggle="modal" onclick="modifyOk()">수정<a></div>
                <div class="morePopupBox1"><a data-toggle="modal" onclick="deleteOk()">삭제<a></div>
                <button type="button" class="morePopupBox3" data-dismiss="modal">취소</button>
                <input type="hidden" id="boardBno" value="">  
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 팔로워 -->
      <div class="modal fade" id="morePopup3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLongTitle">팔로워</h5>
            </div>
            <div class="modal-body">
              <div class="spanBox">
              <!--    <span>abc마켓 님만 모든 팔로워를 볼 수 있습니다</span> -->
              </div>
              <div id="followerList">
               <!--팔로우가 늘 때 복사될 페이지-->
              <div class="search">
                  <img src="./인스타 탑로고.png" class="profile">
                  <span class="span">tester1</span>
                  <button class="btn btn-primary">팔로우</button>
                <!-- 팔로우 버튼 누르면 바뀌는 거
                  <button class="btn btn-secondary">언팔로우</button>
                -->
              </div>
              <!--팔로우가 늘 때 복사될 페이지-->
              
              <!--임시 페이지-->
              <div class="search">
                  <img src="./인스타 탑로고.png" class="profile">
                  <span class="span">tester1</span>
                  <button class="btn btn-primary">팔로우</button>
              </div>
              <!--임시 페이지-->
              </div>
             
            </div>
          </div>
        </div>
      </div>

        <!-- 팔로잉 -->
        <div class="modal fade" id="morePopup4" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">팔로잉</h5>
              </div>
              <div class="modal-body">
              <div id="followingList">
                <!--팔로우가 늘 때 복사될 페이지-->
                <div class="search">
                    <img src="./인스타 탑로고.png" class="profile">
                    <span class="span">tester1</span>
                    <button class="btn btn-secondary">언팔로우</button>
                <!-- 팔로우 버튼 누르면 바뀌는 거
                  <button class="btn btn-secondary">언팔로우</button>
                -->
                </div>
                <!--팔로우가 늘 때 복사될 페이지-->
                
                <!--임시 페이지-->
                <div class="search">
                    <img src="./인스타 탑로고.png" class="profile">
                    <span class="span">tester1</span>
                    <button class="btn btn-secondary">언팔로우</button>
                </div>
                <!--임시 페이지-->
                
                </div>
              </div>
              </div>
            </div>
          </div>
        </div>


    <!-- 게시글 수정 -->
    <div class="modal fade" id="modifyPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">게시글 수정하기</h5>
          </div>
          <div class="modal-body">
			<form class="container" action="<%=request.getContextPath()%>/board/postModifyOk.jsp" method="post" name="modifyfrm">
			<input type="hidden" value="" name="modifyBno" id="modifyBno">
                <div class="dropBox" id="dropBox">

                  <div class="slideShow"> <!--메인 동영상과 사진 슬라이드-->
                  
       				<div class="swiper mySwiper">
				      <div class="swiper-wrapper">
				      <!-- 받아온 bno의있는 모든 이미지를 가져온다 -> 순서대로 나열한다  -->
				        
				      </div>
				      <div class="swiper-button-next"></div>
				      <div class="swiper-button-prev"></div>
				      <div class="swiper-pagination"></div>
				    </div>
				    
                  </div> <!--메인 동영상과 사진 슬라이드-->

                </div>

              <div class="postRight">
                
                <div class="rightTop">
                  <div class="rightTop2">
                    <img src="./즐겁다 짤.jpg" class="profile">
                    <span class="nickname">tester123</span>
                  </div>
                  <textarea class="replyTextarea" id="modifyTextarea" name="modifyReply" placeholder="문구를 입력하세요..." onkeydown="calc()" onkeyup="calc()" onkeypress="calc()"></textarea>
                  <span class="replyTextareaCount" id="modifyTextareaCount">0
                  </span>
                  <span class="replyTextareaCount2">/2200</span>
                </div>

                <div class="rightBottom">
                  <h4>설정</h4>
                  <ul class="righrToggle">
                    <li>
                      <span>게시물 공개</span>
                      <input type='checkbox' id='toggle21' class='tgl' name="mboardOpen" value="y" />
                      <label for='toggle21'></label>
                    </li>
                    <li>
                      <span>좋아요 공개</span>
                      <input type='checkbox' id='toggle22' class='tgl' name="mfavoriteOpen" value="y" />
                      <label for='toggle22'></label>
                    </li>
                    <li>
                      <span>댓글 기능 허용</span>
                      <input type='checkbox' id='toggle23' class='tgl' name="mreplyOpen" value="y" />
                      <label for='toggle23'></label>
                    </li>
                  </ul>
                </div>

              </div>
              <input type="submit" value="수정하기" class="dropBoxReply">
            </form>


          </div>
        </div>
      </div>
    </div>


</body>
</html>