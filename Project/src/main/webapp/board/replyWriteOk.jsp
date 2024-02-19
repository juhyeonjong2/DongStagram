<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
 // 로그인 정보 가져오기
 
 // 파라메터 정보 가져오기.
	String bnoParam = request.getParameter("bno");
	String replyParam = request.getParameter("reply");
	
	System.out.println(bnoParam);
	System.out.println(replyParam);
	
	// ws comment - 여기 작업중

	out.print("OK");
%>

