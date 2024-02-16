<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ezen.util.TypeChecker" %>
<%@ page import="dao.MemberDAO" %>
<%

	String nick = request.getParameter("nick");
	if(nick == null && nick.equals("") || !TypeChecker.isValidNick(nick))
	{
		out.print("ERROR");
	}
	else {
		// DB 중복 검사	
		if(MemberDAO.isExistByNick(nick))
		{
			out.print("OK");
		}
		else {
			out.print("NONE");
		}
	}
%>