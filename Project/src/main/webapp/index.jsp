<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<!-- 로그인 상태 확인해서 로그인 페이지로 이동시킴 -->
<%

	 MemberVO member = (MemberVO)session.getAttribute("login");
	 if(member == null){
		 System.out.println("index ");
		 request.getRequestDispatcher("/login/login.jsp").forward(request, response);
		 
	 }
	 else {
		 request.getRequestDispatcher("/home/home.jsp").forward(request, response);
	 } 
	//response.sendRedirect(request.getContextPath()); //루트로 리다이렉트
%>


<%-- 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css"
	rel="stylesheet">
</head>
<body>
	<%@ include file="/include/header.jsp"%>
	
	<main>
  	
  </main>
	
	<%@ include file="/include/footer.jsp"%>
</body>
</html>
 --%>