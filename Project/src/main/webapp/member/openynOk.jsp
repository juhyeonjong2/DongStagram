<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
    
<%
	MemberVO member = (MemberVO)session.getAttribute("login");
%>

<%
	String openyn = request.getParameter("openyn");
	
	if(member.openyn="y")){
		//if로 openyn = y면 비공개  openyn = n이면 공개 기본상태는 n 으로 만들거ㅛㅅ
	}
	
%>