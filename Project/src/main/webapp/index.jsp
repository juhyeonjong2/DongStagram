<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!-- 로그인 상태 확인해서 로그인 페이지로 이동시킴 -->
<%
	response.sendRedirect(request.getContextPath() + "/login/login.jsp");
%>
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html> -->