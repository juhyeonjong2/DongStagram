<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<!-- 로그인 상태 확인해서 로그인 페이지로 이동시킴 -->
<%
	// (root) / 로 넘어오는경우 여기로 도달.

	/* 
	MemberVO member = (MemberVO)session.getAttribute("login");
	
		  MemberVO member = (MemberVO)session.getAttribute("login"); if(member != null)
		  { isLogin = !CertDAO.isExpired(member.getMno(), member.getToken()); isAdmin =
		  CertDAO.isAdmin(member.getMno(), member.getToken()); } }
	 */
	 MemberVO member = (MemberVO)session.getAttribute("login");
	 if(member == null){
		 System.out.println("index ");
		 request.getRequestDispatcher("/login/login.jsp").forward(request, response);
		 
	 }
	 else {
		 request.getRequestDispatcher("/home/home.jsp").forward(request, response);
	 }
	//response.sendRedirect(request.getContextPath()); //루트로 리다이렉트
%>
