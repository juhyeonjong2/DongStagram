<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%@ page import="ezen.db.DBManager" %>


<% 						//지금내가 해야할 일 : 넘어온 비밀번호를 받고 sql에 수정하는 절차를 밟아야된다.
						
	MemberVO member = (MemberVO)session.getAttribute("login"); //지금 로그인한 계정의 비밀번호를 변경해야되니깐 
	int mno = member.getMno();    // mno가 숫자니깐 int로 멤버의 mno를 받아온다
	String mpassword = request.getParameter("mpassword"); //숫자열 컬럼 openyn 은 mpassword라는 값을 받아온다 	
	System.out.print(mpassword);
	DBManager db = new DBManager(); //넘어온 mpassword 를 
	if(db.connect()) {
		
		String sql = "UPDATE  member set mpassword = ? WHERE mno=? ";
		
		
		int result = db.prepare(sql).setString(mpassword).setInt(mno).update();
		
		System.out.print(result);
		
		db.disconnect();
		
		%> 
		<script>
		location.href="<%=request.getContextPath()%>"
			</script>
		<%

	}else{
		 
		%>
		<script>
		location.href="<%=request.getContextPath()%>"
		</script>
		<%
	}
	
%>
