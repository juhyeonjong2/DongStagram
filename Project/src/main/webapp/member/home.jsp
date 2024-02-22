<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.HomeViewDAO" %>
<%@ page import="vo.HomeViewVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.BoardAttachVO" %>
<%@ page import="vo.MemberVO" %>
<%@ page import="vo.ReplyVO" %>
<%@ page import="vo.PagingVO" %>


<%
	// 최초 10개를 보여주기.
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member == null){
	 response.sendRedirect(request.getContextPath());
	}
	
	
	//HomeViewDAO에서 최신 10개를 들고온다 
	// 1차. 게시물 전부 들고오기 + 페이징
    //      내가 작성하지 않은 게시물 전부 들고오기 : 탐색 대체 가능. -> 우선작업
    //      or
	// 2차. 내가 팔로우한 유저들의 게시물 들고오기
	//      
	
	// -----------------------------------------
	// 3차. 내가 팔로우한 유저들의 게시물 중 최근 3일내의 게시물만 들고오기.
	// 4차. 내가 팔로우한 유저들의 게시물 중 최근 3일내의 게시물 중에 
	//      확인을 안했거나 확인한지 1일이 지나지 않은 게시물만 가져오기
	int totalCnt = HomeViewDAO.count(member.getMno());
	int nowPage = 1;
	PagingVO pagingVO = new PagingVO(nowPage, totalCnt, 5);
	ArrayList<HomeViewVO> viewList = HomeViewDAO.list(member.getMno(), pagingVO.getStart()-1 , pagingVO.getPerPage());
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/util/time.js"></script>
<script src="<%=request.getContextPath()%>/js/util/text.js"></script>
<script src="<%=request.getContextPath()%>/js/util/number.js"></script>
<script src="<%=request.getContextPath()%>/js/member/home.js"></script>
<script>
	$(function(){
		setNowPage(<%=nowPage%>);
	});
	
</script>
</head>

<body>
	<%@ include file="/include/header.jsp"%>
	
	<main>
		<div id="maindiv" class="inner clearfix">
<%
			
	    	for(HomeViewVO vo : viewList)
	    	{	
	    		String mediaFolder = request.getContextPath() + "/upload/" + vo.getNick() + "/";
	    		String profileImagePath = 	request.getContextPath() + "/icon/profile.png";
	    		if(vo.getProfileImage() != null){ // 프로필이미지가 있는경우 해당 프로필 이미지로
	    			profileImagePath = mediaFolder + vo.getProfileImage();
	    		}
	    		String profileLink =  request.getContextPath() + "/user/" +  vo.getNick();
	    		String boardPageLink = request.getContextPath() + "/page/" +  vo.getShorturi();
	    		
%>
			<div class="page">
				<div class="mainTop">
					<img class="profile" src="<%=profileImagePath%>" alt="ProfileImage" >
					<a href="<%=profileLink%>" class="main1name"><%= vo.getNick() %></a>
					<span class="span2 main1span writetime_<%=vo.getBno()%>"></span>
					<button type="button" onclick="follow(this)">팔로우</button>
				</div>
				<div class="slideShow">
					<div class="swiper mySwiper_<%=vo.getBno()%>">
						<div class="swiper-wrapper">
						<%
							for(BoardAttachVO attach : vo.getMediaList())
							{	
						%>
							<div class="swiper-slide">	
								<img src="<%= mediaFolder + attach.getBfrealname()%>" alt="<%= attach.getBforeignname() %>">
							</div>
						<%
							}
						%>
						</div>
			 		<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
						<div class="swiper-pagination"></div>
					</div>
				</div>
				<div> 
					<div class="main2">
						<!--  좋아요 버튼기능? -->
						<form class="favoriteFrm" onsubmit="return false;">
							<input type='hidden' name='bno' value="<%=vo.getBno()%>">
							<input type='hidden' name='req' value="1">
							<img src="<%=request.getContextPath()%>/icon/heart.png" class="good favoriteImg_<%=vo.getBno()%>" onclick="sendFavorite(this)">
							<a href="<%=boardPageLink%>"><img src="<%=request.getContextPath()%>/icon/reply.png"></a>
						</form>
						
					</div>
					<div class="main3">
						<p> 좋아요 <span class="favorite_<%=vo.getBno()%>"></span>개</p>
					</div>
					<div class="main4">
					<%
					   // 작성글(루트 댓글)이 있으면 작성하고 없으면 공백
					   ReplyVO rootReply = vo.getRootReply();
					   if(rootReply != null){
					%>
						<a href="<%=profileLink%>"><%=vo.getNick()%></a>
						<span class="rootReply_<%=vo.getBno()%>"></span>
					<%
					   }
					%>
					</div>
					
					<div class="main5">
					<%
					if(vo.getReplyList().size() > 0){
					%>
						댓글 <span class="reply_<%=vo.getBno()%>"></span>개 <a href="<%=boardPageLink%>">모두보기</a>
					<%
					   }
					%>
					</div>
					<form class="hotReply" onsubmit="return false;">
						<input type='hidden' name='bno' value="<%=vo.getBno()%>">
						<input type="text" name="reply" placeholder="댓글 달기.." onkeyup="if(window.event.keyCode==13){sendHotReply(this);}">
						<!-- <input type="submit" value="게시">-->
					</form>
				</div>
			</div>
			
			<script>
				initSwiper("mySwiper_<%=vo.getBno()%>");
				setWriteDate("writetime_<%=vo.getBno()%>", "<%=vo.getWdate()%>");
				setFavoriteCount("favorite_<%=vo.getBno()%>", <%=vo.getBfavorite()%>);
				setFavorite("favoriteImg_<%=vo.getBno()%>", "<%=vo.getMfavorite()%>");
				<% 
				if(rootReply != null) {
				%>
					setShortContent("rootReply_<%=vo.getBno()%>", "<%=rootReply.getRcontent()%>");
				<%
				}
				%>
				<%
				if(vo.getReplyList().size() > 0){
				%>
					setReply("reply_<%=vo.getBno()%>", <%=vo.getReplyList().size()%>);
				<%
				}
				%>
			</script> 
<%
	    	} // for(HomeViewVO vo : viewList)
%>
			

		</div>
	</main>
	
	<%@ include file="/include/footer.jsp"%>
</body>
</html>