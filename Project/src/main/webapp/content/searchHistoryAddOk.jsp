<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.SearchHistoryDAO" %>
<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	String searchWords = request.getParameter("searchWords");
	String searchType = request.getParameter("searchType");
	if(member == null || searchWords == null || searchType == null){
		response.sendRedirect(request.getContextPath());
	}
	
	//System.out.println(searchWords);
	//System.out.println(searchType);
	
	if(!SearchHistoryDAO.isExist(member.getMno(), searchType, searchWords) &&  // 검색했던 기록이 없고
		SearchHistoryDAO.insert(member.getMno(), searchType, searchWords))	   // 추가에 성공한 경우.
	{
		out.print("OK");
	}
	else {
		out.print("FAIL");
	}
%>