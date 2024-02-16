<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ezen.util.TypeChecker" %>
<%@ page import="dao.MemberDAO" %>
<%

	String id = request.getParameter("id");
	// id 검사
	if(id == null && id.equals("") || !TypeChecker.isValidId(id))
	{
		out.print("ERROR");
	}
	else {
		// DB 중복 검사	
		if(MemberDAO.isExistById(id))
		{
			out.print("OK");
		}
		else {
			out.print("NONE");
		}
	}
%>