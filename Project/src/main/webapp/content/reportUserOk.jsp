<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.AccountDAO" %>
<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	String targetNick = request.getParameter("target");
	String reason = request.getParameter("reason");
	if(member == null || targetNick == null || reason == null){
		response.sendRedirect(request.getContextPath());
	}
	
	if(AccountDAO.report(member.getMno(), targetNick, reason))
	{
		out.print("SUCCESS");
	}
	else {
		out.print("FAIL");
	}
%>