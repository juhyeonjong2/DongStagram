<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="vo.SearchContentVO" %>
<%@ page import="dao.SearchContentDAO" %>
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


   // 검색어를 통해 해시태그 또는 맴버를 검색후 리턴한다.
   // 1. 멤버 검색후 리턴.
   //    1-1. 이름에 검색어가 포함되는경우.
   
   // ---------- 보류 --------------------
   // 2. 해시태그 포함
   //   2-1. 글에 해시태그가 있는경우 검색한다.
   
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);
	Map<String,Object> root = new HashMap<String,Object>();
	String searchWords = request.getParameter("searchWords");
	//System.out.println(searchWords);
	if(searchWords == null){
		root.put("result", "FAIL");
	
	} else {
		ArrayList<SearchContentVO> contentList = SearchContentDAO.list(searchWords);
		
		root.put("result", "SUCCESS");
		root.put("contents", contentList);
		
	}
   
	String json = mapper.writeValueAsString(root);
	
	//System.out.println(json);
	out.print(json);

%>
