<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="vo.CertVO" %>
<%@ page import="dao.CertDAO" %>

<%
	//cert 정리.
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member != null){
		CertVO cert = CertDAO.getCert(member.getMno(),member.getToken());
		CertDAO.removeToken(cert);
	}

	//세션 정리
	session.invalidate();
	
	// 루트로 보냄
	response.sendRedirect(request.getContextPath());  
%>
