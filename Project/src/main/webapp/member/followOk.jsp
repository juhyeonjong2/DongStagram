<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="dao.FollowDAO" %>
<%
	String targetNick = request.getParameter("target");
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member == null || targetNick == null || targetNick.equals("")){
		response.sendRedirect(request.getContextPath());
	}

	
	// 명령이 왔을때 팔로우중이면
	if(FollowDAO.isFollow(member.getMno(), targetNick))
	{
		 // 팔로우 상태였다면 언팔로우 처리.
		 FollowDAO.unFollow(member.getMno(), targetNick);
	}
	else {
		// 팔로우 상태가 아니라면 팔로우 처리.
		FollowDAO.follow(member.getMno(), targetNick);	
	}
	
	// 처리후 마지막에 다시 검사.
	boolean isFollow = FollowDAO.isFollow(member.getMno(), targetNick);
	int targetFollowerCount = FollowDAO.getFollowerCount(targetNick);
	
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);
	Map<String,Object> root = new HashMap<String,Object>();
		
	root.put("result", "SUCCESS");
	root.put("targetFollowerCount", targetFollowerCount); 
	root.put("isRequestFollow", isFollow);
	
	
	String json = mapper.writeValueAsString(root);
	
	//System.out.println(json);
	out.print(json);

%>