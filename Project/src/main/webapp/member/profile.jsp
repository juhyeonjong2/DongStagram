<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="vo.BoardViewVO"%>
<%@ page import="java.util.ArrayList"%>
    
<%
	MemberVO member = (MemberVO)session.getAttribute("login");

	String mnoParam = request.getParameter("mno");
	int mno=0;
	
	if(mnoParam != null && !mnoParam.equals("")){
		mno = Integer.parseInt(mnoParam);
	}
	
	if(member == null 
			|| (!member.getMid().equals("admin") 
					&& member.getMno()!= mno)){
%>
		<script>
			alert("권한이 없습니다.");
			location.href="<%=request.getContextPath()%>";
		</script>
<%	
	}
	
	ArrayList<BoardViewVO> boardList = new ArrayList<BoardViewVO>();
	
	DBManager db = new DBManager();
	
	if(db.connect()) {
		// 나의 게시글을 전부 찾는다.
		String sql = "SELECT bno, bfavorite FROM board WHERE mno=?";
		
		if(db.prepare(sql).setInt(mno).read()) {
			  while(db.next()){
				BoardViewVO board = new BoardViewVO();
				board.setBno(db.getInt("bno"));
				board.setBfavorite(db.getInt("bfavorite"));
				boardList.add(board);
			  }
		}
		//그후 나의 게시글들에서 추출한 bno의 썸네일을 추출한다.
		sql = "SELECT bfrealname, bforeignname FROM boardAttach WHERE bno=? AND bfidx=0 ";

		for(BoardViewVO board : boardList){
			if(db.prepare(sql).setInt(board.getBno()).read()){
				if(db.next()){
					board.setRealFileName(db.getString("bfrealname"));
					board.setForeignFileName(db.getString("bforeignname"));
				}
			}
		}
		
	 	db.disconnect(); //try안에 DB매니저사용 시 disconnect안해도됨
	 	
	} //db connect
		
	
	
%>   
 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필</title>


    <script> 
    //대댓글 클릭시 보이도록 (자신만 선택하는 방법 추가 필요(아마 this))
    $(document).ready(function(){
        $('.reReply').click(function(){
          $('.replyblock').css('display','block');
      }); 
    });
    
    </script>



</head>
<body>
    <!--header-->
    <%@ include file="/include/header.jsp"%>
    <!-- css순서문제로 여기에 놨는데 일단 돌아가서 임시로 여기에 둠 -->
    <link href="<%=request.getContextPath()%>/css/post/post.css" type="text/css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/member/navigation.css" type="text/css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/member/profile.css" type="text/css" rel="stylesheet">
    <!--header-->

      <main>

        <div id="scanMain" class="inner clearfix">

          <div class="searchField">
            <div class="searchField2">
              <img src="./icon/home.png" class="searchProfile">
              <span class="searchSpan1">
                <%=member.getMnick() %>
                <a class="btn btn-secondary" href="#">프로필 편집</a>
              </span>
              <span class="searchSpan2">
                <span>게시물 <%=boardList.size()%></span>
                <span><a data-toggle="modal" href="#morePopup3" class="popupviewMainSpan2">팔로워 4.9만</a></span>
                <span><a data-toggle="modal" href="#morePopup4" class="popupviewMainSpan2">팔로우 16</a></span>
              </span>
              <span class="searchSpan3"><%=member.getMname() %></span>
              <!--span태그 였지만 띄어쓰기때문에 pre태그로 변경-->
              <pre class="searchSpan4">
제품/서비스
세상의 모든 신발
              </pre>
              <hr>
            </div>
          </div>

            <ul>
           
<%
                	for(BoardViewVO b : boardList)
                	{
                		String saveDir = member.getMnick();
    					String foreignFileName = b.getRealFileName();
                		String realFileName = b.getRealFileName(); 
%>

                <li class="scanimg">
                  <a data-toggle="modal" href="#exampleModalCenter"><img src="<%=request.getContextPath() +"/" + saveDir + "/" + realFileName%>">
                    <span class="scanimgHover">
                      <span>
                        <img src="./icon/whiteHeart.png"><%=b.getBfavorite() %>
                        <img src="./icon/whiteMessage.png">9
                      </span>
                    </span>
                  </a>
                </li>
<%
                	} // for문 종료
				
%>
            </ul>
        </div>

        <!-- Modal -->
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
                              <ul class="bxslider">
                                <li><img src="./즐겁다 짤.jpg" ></li>
                                <li><img src="./인스타 탑로고.png" ></li>
                                <li><img src="./즐겁다 짤.jpg" ></li>
                            </ul> 
                    
                            </div> <!--메인 동영상과 사진 슬라이드-->

                        </div>

                        <!--오른쪽-->
                        <div class="popupViewRight">
                            <!--상단 태그-->
                            <div class="mainTop">
                                <img src="./자산 4.png" class="profile">
                                <a href="#" class="main1name">닉네임</a>
                                <button>팔로우</button>
                                <a data-toggle="modal" href="#morePopup2" class="popupviewMainSpan2">· · ·</a>
                            </div> <!--상단 태그-->

                            <!--댓글 창-->
                            <div class="popupviewMain">
                              <!--댓글이 없을경우 보여주는 글-->
                              <div class="notReply">
                                  <p>아직 댓글이 없습니다.</p>
                                  <h6>댓글을 남겨보세요</h6>
                              </div>

                                <!--for문으로 복사 될 페이지-->
                                    <div class="mainTop">
                                        <img src="./자산 4.png" class="profile">
                                        <a href="#" class="main1name">닉네임</a>
                                        <div class="popupViewReply">123가가가가가각가가가가가가가가가가가가가가가가가가가가가가가가가가가</div>
                                     </div> <!--상단 태그-->
                                     <span class="popupviewMainSpan1">6일</span>
                                     <span class="popupviewMainSpan3">| 댓글달기 |</span>
                                     <a data-toggle="modal" href="#morePopup" class="popupviewMainSpan2">· · ·</a>

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
                                    
                                    
                                    <!--임시 페이지-->
                                    <div class="mainTop">
                                      <img src="./자산 4.png" class="profile">
                                      <a href="#" class="main1name">닉네임</a>
                                      <div class="popupViewReply">123가가가가가각가가가가가가가가가가가가가가가가가가가가가가가가가가가</div>
                                   </div> <!--상단 태그-->
                                   <span class="popupviewMainSpan1">6일</span>
                                   <span class="popupviewMainSpan3">| 댓글달기 |</span>
                                   <a data-toggle="modal" href="#morePopup" class="popupviewMainSpan2">· · ·</a>

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
                                    <!--임시 페이지-->
                                    
                                      <!--댓글이 많다면 보여줄 아이콘-->
                                      <div class="replyPlus">
                                        <img src="./icon/replyPlus.png">
                                      </div>

                                  </div> <!--댓글 창-->
                            <!--하단 태그-->
                            <div class="popupviewBottom">
                                <img src="./icon/heart.png">
                                <img src="./icon/reply.png">
                                <div class="popupviewBottom2">
                                    <img src="./자산 4.png" class="profile"><!--작은프로필-->
                                    <span class="popupviewBottomSpan1">좋아요 11개</span>
                                    <span class="popupviewBottomSpan2">6일 전</span>
                                </div>
                                <form action="#">
                                    <input type="text" placeholder="   댓글달기...">
                                </form>

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

  <!-- Modal2 -->
      <div class="modal fade" id="morePopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-body">
              <div class="morePopupMain">
                <div class="morePopupBox1"><a href="#">신고</a></div>
                <!--삭제는 if문 사용으로 숨기기-->
                <div class="morePopupBox2"><a href="#">삭제</a></div>
                <button type="button" class="morePopupBox3" data-dismiss="modal">취소</button>
              </div>
            </div>
          </div>
        </div>
      </div>

  <!-- Modal3 -->
      <div class="modal fade" id="morePopup2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-body">
              <div class="morePopupMain">
                <div class="morePopupBox1"><a data-toggle="modal" href="#modifyPopup">수정<a></div>
                <button type="button" class="morePopupBox3" data-dismiss="modal">취소</button>
                
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Modal4 -->
      <div class="modal fade" id="morePopup3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLongTitle">팔로워</h5>
            </div>
            <div class="modal-body">
              <div class="spanBox">
                <span>abc마켓 님만 모든 팔로워를 볼 수 있습니다</span>
              </div>
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

        <!-- Modal5 -->
        <div class="modal fade" id="morePopup4" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">팔로잉</h5>
              </div>
              <div class="modal-body">
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


    <!--header post popup-->
    <!-- Modal -->
    <div class="modal fade" id="postPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">새 게시글 만들기</h5>
           <!--<button id="btn-share" type="button" disabled>공유</button>-->
          </div>
          <div class="modal-body">


            <form class="container">
              <label class="label" id="label" for="input">
                <!--이 안에 drop해야함 or 클릭-->
                <div class="dropBox" id="dropBox"></div>
              </label>
              <input id="input" class="input" accept="image/*" type="file" required="true" multiple="true" hidden="true">
              <!--저장된 모든 값은 이 input file에 모두 저장되는 듯?-->
              <!--올린거 여기다가 아래 div는 포지션으로 정렬 프리뷰는 옮기면 안돼-->
              <div class="postLeft">
                <div class="preview" id="preview"></div>
                <label for="input">
                  <img src="./icon/post.png" class="postPlus">
                </label>
              </div>

              <div class="postRight">
                
                <div class="rightTop">
                  <div class="rightTop2">
                    <img src="./즐겁다 짤.jpg" class="profile">
                    <span class="nickname">tester123</span>
                  </div>
                  <textarea class="replyTextarea" id="replyTextarea" placeholder="문구를 입력하세요..." onkeydown="calc()" onkeyup="calc()" onkeypress="calc()"></textarea>
                  <span class="replyTextareaCount" id="replyTextareaCount">0
                  </span>
                  <span class="replyTextareaCount2">/2200</span>
                </div>

                <div class="rightBottom">
                  <h4>설정</h4>
                  <ul class="righrToggle">
                    <li>
                      <span>게시물 공개</span>
                      <input type='checkbox' id='toggle' class='tgl' />
                      <label for='toggle'></label>
                    </li>
                    <li>
                      <span>좋아요 공개</span>
                      <input type='checkbox' id='toggle2' class='tgl'  />
                      <label for='toggle2'></label>
                    </li>
                    <li>
                      <span>댓글 기능 허용</span>
                      <input type='checkbox' id='toggle3' class='tgl' />
                      <label for='toggle3'></label>
                    </li>
                  </ul>
                </div>

              </div>
              <input type="submit" value="공유하기" class="dropBoxSubmit" id="dropBoxSubmit" disabled/>
              <script src="./post.js"></script>
            </form>


          </div>
        </div>
      </div>
    </div>


    <!-- Modal2 -->
    <div class="modal fade" id="modifyPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">게시글 수정하기</h5>
          </div>
          <div class="modal-body">

                <div class="dropBox" id="dropBox">

                  <div class="slideShow"> <!--메인 동영상과 사진 슬라이드-->
                    <ul class="bxslider">
                      <li><img src="./즐겁다 짤.jpg" ></li>
                      <li><img src="./인스타 탑로고.png" ></li>
                      <li><img src="./즐겁다 짤.jpg" ></li>
                  </ul> 
          
                  </div> <!--메인 동영상과 사진 슬라이드-->

                </div>

              <div class="postRight">
                
                <div class="rightTop">
                  <div class="rightTop2">
                    <img src="./즐겁다 짤.jpg" class="profile">
                    <span class="nickname">tester123</span>
                  </div>
                  <textarea class="replyTextarea" id="replyTextarea" placeholder="문구를 입력하세요..." onkeydown="calc()" onkeyup="calc()" onkeypress="calc()"></textarea>
                  <span class="replyTextareaCount" id="replyTextareaCount">0
                  </span>
                  <span class="replyTextareaCount2">/2200</span>
                </div>

                <div class="rightBottom">
                  <h4>설정</h4>
                  <ul class="righrToggle">
                    <li>
                      <span>게시물 공개</span>
                      <input type='checkbox' id='toggle' class='tgl' />
                      <label for='toggle'></label>
                    </li>
                    <li>
                      <span>좋아요 공개</span>
                      <input type='checkbox' id='toggle2' class='tgl'  />
                      <label for='toggle2'></label>
                    </li>
                    <li>
                      <span>댓글 기능 허용</span>
                      <input type='checkbox' id='toggle3' class='tgl' />
                      <label for='toggle3'></label>
                    </li>
                  </ul>
                </div>

              </div>
              <input type="submit" value="수정하기" class="dropBoxSubmit2" >
              <script src="./post.js"></script>
            </form>


          </div>
        </div>
      </div>
    </div>


      </main>

     <!--footer-->
	<%@ include file="/include/footer.jsp"%>
     <!--footer-->
</body>
</html>