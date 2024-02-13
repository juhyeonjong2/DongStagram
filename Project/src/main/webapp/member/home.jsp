<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">

</head>
<body>
	<%@ include file="/include/header.jsp"%>
	
	<!-- main -->
	<main>
  	<div id="maindiv" class="inner clearfix"> <!--메인 전체 하이트는 auto-->
  	
		  <div class="page"> <!--for문으로 복사될 한 페이지-->

        <div class="mainTop"> <!--상단 태그-->
            <img src="./자산 4.png" class="profile">
            <a href="#" class="main1name">닉네임</a>
            <span class="span2 main1span">2일전</span>
            <button type="button">팔로우</button>
           <!-- <a href="#"><img src="./자산 4.png"></a> -->
        </div> <!--상단 태그-->

        <div class="slideShow"> <!--메인 동영상과 사진 슬라이드-->
          <ul class="bxslider">
            <li><img src="./즐겁다 짤.jpg" ></li>
            <li><img src="./인스타 탑로고.png" ></li>
            <li><img src="./즐겁다 짤.jpg" ></li>
        </ul> 

        </div> <!--메인 동영상과 사진 슬라이드-->

        <div> <!--좋아요나 작성 글 등등-->

            <div class="main2">
              <img src="./icon/heart.png" class="good"> <!--좋아요-->
              <a href="#"><img src="./icon/reply.png"></a> <!--댓글-->
            </div>

            <div class="main3">
              <p>좋아요 ??개</p>
            </div>

            <div class="main4">
              <a href="#">닉네임</a>
              <span>작성글 짧게</span>
              <!--작성글이 길다면 if-->
              <div class="tabmore">
                <!--받아온 글이 길다면 if문으로 이게 보이도록 구현-->
                <div class="more">더보기</div> 
                <section class="main4block">
                  <div class="main4block2">더보기누르면 display block할 곳</div>
                </section>
              </div>
            </div>

            <div class="main5">
              <a href="#">댓글 ?(수) 모두보기</a>
            </div>

            <form class="hotReply" action="#"> <!--빠르게 댓글 작성 하는 곳-->
              <input type="text" placeholder="댓글 달기..">
              <input type="submit" value="게시">
            </form>

        </div> <!--좋아요나 작성 글 등등-->

      </div> <!--for문으로 복사될 한 페이지-->
 	  <div class="page"> <!--for문으로 복사될 한 페이지-->

        <div class="mainTop"> <!--상단 태그-->
            <img src="./자산 4.png" class="profile">
            <a href="#" class="main1name">닉네임</a>
            <span class="span2 main1span">2일전</span>
            <button type="button">팔로우</button>
           <!-- <a href="#"><img src="./자산 4.png"></a> -->
        </div> <!--상단 태그-->

        <div class="slideShow"> <!--메인 동영상과 사진 슬라이드-->
          <ul class="bxslider">
            <li><img src="./즐겁다 짤.jpg" ></li>
            <li><img src="./인스타 탑로고.png" ></li>
            <li><img src="./즐겁다 짤.jpg" ></li>
        </ul> 

        </div> <!--메인 동영상과 사진 슬라이드-->

        <div> <!--좋아요나 작성 글 등등-->

            <div class="main2">
              <img src="./icon/heart.png" class="good"> <!--좋아요-->
              <a href="#"><img src="./icon/reply.png"></a> <!--댓글-->
            </div>

            <div class="main3">
              <p>좋아요 ??개</p>
            </div>

            <div class="main4">
              <a href="#">닉네임</a>
              <span>작성글 짧게</span>
              <!--작성글이 길다면 if-->
              <div class="tabmore">
                <!--받아온 글이 길다면 if문으로 이게 보이도록 구현-->
                <div class="more">더보기</div> 
                <section class="main4block">
                  <div class="main4block2">더보기누르면 display block할 곳</div>
                </section>
              </div>
            </div>

            <div class="main5">
              <a href="#">댓글 ?(수) 모두보기</a>
            </div>

            <form class="hotReply" action="#"> <!--빠르게 댓글 작성 하는 곳-->
              <input type="text" placeholder="댓글 달기..">
              <input type="submit" value="게시">
            </form>

        </div> <!--좋아요나 작성 글 등등-->

      </div> <!--for문으로 복사될 한 페이지-->
      
      
  	</div>
  	
   </main>
	
	<%@ include file="/include/footer.jsp"%>
</body>
</html>