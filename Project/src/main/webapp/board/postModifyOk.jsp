<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="ezen.util.HashMaker" %>
<%
 	 MemberVO member = (MemberVO)session.getAttribute("login");

	String modifyReply = request.getParameter("modifyReply");
	String mboardOpen = request.getParameter("mboardOpen");
	String mfavoriteOpen = request.getParameter("mfavoriteOpen");
	String mreplyOpen = request.getParameter("mreplyOpen");
	
	// 받아온 bno 디코딩
	String modifyBno = request.getParameter("modifyBno");
	int bno = 0;
	if(modifyBno != null  && !modifyBno.equals("")){
		bno = (int)HashMaker.Base62Decoding(modifyBno);
	}
	
	
	try(DBManager db = new DBManager();){
		if(db.connect(true)){
			
			boolean isSuccess = true;
			
			String sql = " UPDATE board SET bopen = ?, fopen = ?, rallow = ?  WHERE bno=?";
			
			db.prepare(sql);
			if(mboardOpen == null) db.setString("n");
			else				  db.setString("y");
			if(mfavoriteOpen == null) db.setString("n");
			else				  db.setString("y");
			if(mreplyOpen == null) db.setString("n");
			else				  db.setString("y");
			db.setInt(bno);
			
			if(db.update(true) <= 0) {
				isSuccess = false;
			}
			
			if(isSuccess){
				sql = "UPDATE reply SET rcontent = ? WHERE bno = ? and ridx = 0;";
				if(db.prepare(sql).setString(modifyReply).setInt(bno).update(true) <= 0) {	
						isSuccess = false;
				}
			}
			
			// 모두 성공인경우
			if(isSuccess) {
				db.txCommit(); // 커밋.
				%>
				<script>
					alert("게시글이 수정되었습니다.");
					location.href="<%=request.getContextPath()%>/user/<%=member.getMnick()%>";
					// $('#detailBoard').modal('hide');
				</script>
				<%
			}
			
			db.disconnect(); // disconnect에서 autocommit을 기존값으로 되돌려놓음. (disconnect는 반드시 해야함)
		}
	}				
	 
 %>
