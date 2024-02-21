<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="ezen.util.HashMaker" %>
<%@ page import="vo.BoardViewVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.FollowDAO" %>
<%@ page import="vo.ProfileVO"%>
    
<%
	MemberVO member = (MemberVO)session.getAttribute("login");

	String mnick = request.getParameter("mnick");
	
	ArrayList<BoardViewVO> boardList = new ArrayList<BoardViewVO>();
	
	String intro ="";
	String name = "";
	ProfileVO vo = new ProfileVO();
	String PsaveDir = mnick;
	String Pupload = "upload/";
	
	
	boolean isFollow = FollowDAO.isFollow(member.getMno(), mnick);
	int followerCount = FollowDAO.getFollowerCount(mnick);
	int followingCount = FollowDAO.getFollowingCount(mnick);
	
	DBManager db = new DBManager();
	
	if(db.connect()) {
		// 나의 게시글, 좋아요 수, 댓글 수를 전부 찾는다.
		String sql = "select b.bno ,"
				   + " (select count(*) from favorite f where f.bno = b.bno) as fcnt,"
				   + " (SELECT COUNT(*) FROM reply r where r.bno = b.bno) as rcnt"
				   + " from board b inner join member as m on b.mno = m.mno WHERE m.mnick = ?";
		
		if(db.prepare(sql).setString(mnick).read()) {
			  while(db.next()){
				BoardViewVO board = new BoardViewVO();
				board.setBno(db.getInt("bno"));
				board.setBfavorite(db.getInt("fcnt"));
				board.setRcnt(db.getInt("rcnt"));
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
		
		// 이사람의 프로필 이미지, 성별번호, 내 소개를 전부 찾는다.
		sql = " select m.mfrealname, a.gender, a.intro from account a inner join memberattach m on a.mno = m.mno"
			+ " inner join member e on a.mno = e.mno and e.mnick = ?";
		
		if(db.prepare(sql).setString(mnick).read()) {
			  if(db.next()){
				vo.setRealFileName(db.getString("mfrealname"));
				vo.setGender(db.getInt("gender"));
				vo.setIntro(db.getString("intro"));
			  }
		}

		sql = "SELECT a.intro, m.mname FROM member as m left join account as a on m.mno = a.mno where m.mnick = ?";
		if(db.prepare(sql).setString(mnick).read()) {
			if(db.next()){
				intro = db.getString("intro");
				name = db.getString("mname");
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
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="<%=request.getContextPath()%>/js/util/number.js"></script>
<script src="<%=request.getContextPath()%>/js/member/profile.js"></script>

<script>
$(function(){
	  setFollowerCount(<%= followerCount  %>);
	  setFollowCount(<%= followingCount  %>);
});

</script>
</head>
<body>
    <!--header-->
    <%@ include file="/include/header.jsp"%>
    <!-- css순서문제로 여기에 놨는데 일단 돌아가서 임시로 여기에 둠 -->
    <link href="<%=request.getContextPath()%>/css/post/post.css" type="text/css" rel="stylesheet">  
    <link href="<%=request.getContextPath()%>/css/member/navigation.css" type="text/css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/member/anotherProfile.css" type="text/css" rel="stylesheet">
    <!--header-->

      <main>

        <div id="scanMain" class="inner clearfix">

          <div class="searchField">
            <div class="searchField2">
              <img src="<%=request.getContextPath() +"/" + Pupload + PsaveDir + "/" + vo.getRealFileName()%>" class="searchProfile">
              <input type="hidden" id="profile_nick" value="<%=mnick %>"> 
              <span class="searchSpan1">
                <%=mnick %>
                <%
                if(isFollow){
                %>
                  <button class="btn btn-secondary follow" onclick="requestUnfollow(this)">언팔로우</button>
                <%
                }else { 
                %>            
	                <button class="btn btn-primary follow" onclick="requestFollow(this)">팔로우</button>
                <%
                }
                %>
                <a class="btn btn-secondary">메세지 보내기</a>
                <a data-toggle="modal" href="#bPopup" class="popupviewMainSpan2">· · ·</a>
              </span>
              <span class="searchSpan2">
                <span>게시물 <%=boardList.size()%></span>
                <span><a data-toggle="modal" href="#morePopup3" class="popupviewMainSpan2" id="followerCount">팔로워 4.9만</a></span>
                <span><a data-toggle="modal" href="#morePopup4" class="popupviewMainSpan2" id="followCount">팔로우 16</a></span>
              </span>
              <span class="searchSpan3"><%=name %></span>
              <!--span태그 였지만 띄어쓰기때문에 pre태그로 변경-->
              <pre class="searchSpan4">
<%=intro %>
              </pre>
              <hr>
            </div>
          </div>

            <ul>
           
<%
                	for(BoardViewVO b : boardList)
                	{
                		String saveDir = mnick;
                		String upload = "upload/";
    					String foreignFileName = b.getRealFileName();
                		String realFileName = b.getRealFileName();
                		int bno2 = b.getBno();
                		String bno = HashMaker.Base62Encoding(bno2);
                		//받아온 bno를 인코딩해서 숫자를 수정 후 보냄
                		// 그후 보낸곳에서 받은 수정된 bno를 디코딩해서 사용
                		// 온클릭으로 bno를 보냄 
                		
%>

                <li class="scanimg">
                  <a data-toggle="modal" data-id="<%=bno %>" class="open" onclick="load(this)"><img src="<%=request.getContextPath() +"/" + upload + saveDir + "/" + realFileName%>">
                  <input type="hidden" value="<%=saveDir %>" class="mnick">
                    <span class="scanimgHover">
                      <span>
                        <img src="<%=request.getContextPath()%>/icon/whiteHeart.png"> <%=b.getBfavorite() %>
                        <img src="<%=request.getContextPath()%>/icon/whiteMessage.png"> <%=b.getRcnt() %>
                      </span>
                    </span>
                  </a>
                </li>
<%
                	} // for문 종료
				
%>
            </ul>
        </div>

	
  
    <!--  popup -->
    <%@ include file="/include/popup.jsp"%>
    <!--  popup -->

      </main>

     <!--footer-->
	<%@ include file="/include/footer.jsp"%>
     <!--footer-->
</body>
</html>