<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="vo.UserReportVO" %>
<%@ page import="dao.AccountDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>

<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member == null){
		response.sendRedirect(request.getContextPath());
	}
	
	ArrayList<UserReportVO> list = AccountDAO.reportList();
 
	// json 만들기
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);
	Map<String,Object> root = new HashMap<String,Object>();
		
	root.put("result", "SUCCESS");
	root.put("list", list);
	
	String json = mapper.writeValueAsString(root);
	
	System.out.println(json);
	out.print(json);

%>