<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="vo.FollowVO" %>
<%@ page import="dao.FollowDAO" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
	String targetNick = request.getParameter("target");
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member == null || targetNick == null || targetNick.equals("")){
		response.sendRedirect(request.getContextPath());
	}

	ArrayList<FollowVO> list = FollowDAO.getFollowingList(targetNick, member.getMno());
	
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);
	Map<String,Object> root = new HashMap<String,Object>();
		
	root.put("result", "SUCCESS"); 
	root.put("followings", list);
	
	String json = mapper.writeValueAsString(root);
	
	//System.out.println(json);
	out.print(json);

%>