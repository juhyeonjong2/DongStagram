<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.SearchHistoryDAO" %>

<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member == null){
		response.sendRedirect(request.getContextPath());
	}

    SearchHistoryDAO.removeList(member.getMno());
    
	out.print("OK"); // OK를 전달받으면 리로드한다.
%>