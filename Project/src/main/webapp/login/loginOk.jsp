<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="dao.CertDAO"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="vo.MemberVO"%>
<%
	String mid = request.getParameter("mid");
	String mpw = request.getParameter("mpassword");
	MemberVO member = MemberDAO.findOne(mid, mpw);
	if(member!=null){
		// 토큰 추가.
		String token = CertDAO.createToken(member.getMno());
		member.setToken(token);
		
		session.setAttribute("login",member);
		
		%>
		<script>
			location.href="<%=request.getContextPath()%>"
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("로그인에 실패하였습니다.");
			location.href="<%=request.getContextPath()%>"
		</script>
		<%
	}
%>