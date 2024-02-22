<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.AccountDAO" %>
<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	String mnoParam = request.getParameter("mno");
	if(member == null || mnoParam == null || mnoParam.equals("")){
		response.sendRedirect(request.getContextPath());
	}
	
	int mno= Integer.parseInt(mnoParam);
	if(AccountDAO.unblock(mno))
	{
		out.print("SUCCESS");
	}
	else {
		out.print("FAIL");
	}
%>