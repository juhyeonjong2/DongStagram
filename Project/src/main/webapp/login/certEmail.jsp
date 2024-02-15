<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ezen.util.TypeChecker" %>
<%@ page import="dao.MemberDAO" %>
<%

	String email = request.getParameter("email");
	// 1. 이메일 형식을 검사하고
	
	// 2. 중복인지 검사하고
	
	// 3. 인증번호를 전송한다.
	
	// 4. 인증번호를 전송한 후에 해당 이메일에 대한 



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