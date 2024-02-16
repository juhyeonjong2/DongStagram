<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/member/home.js"></script>

</head>
<body>
	<%@ include file="/include/header.jsp"%>
	<main>
	
	<div id="maindiv" class="inner clearfix"> <!--메인 전체 하이트는 auto-->
    <button onclick="addPage('')">add</button>	
	
	</div> <!--메인 전체 하이트는 auto-->
	
	</main>
	<%@ include file="/include/footer.jsp"%>
	
</body>
</html>