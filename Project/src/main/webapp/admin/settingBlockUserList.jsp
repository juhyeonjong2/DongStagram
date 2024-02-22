<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>설정</title>
	<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/setting/adminSetting.css" type="text/css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/admin/blockUser.js"></script>
	
</head>


<body>
<%@ include file="/include/addminSettingHeader.jsp"%>

<main>
<div class="inner2 clearfix">
	<h3>블랙리스트</h3>
    <div id="items">
     
	</div>
</div>
</main>

</body>
</html>