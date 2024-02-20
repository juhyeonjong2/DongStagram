<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="vo.SearchHistoryVO" %>
<%@ page import="dao.SearchHistoryDAO" %>
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

	// 멤버가 가지고있는 히스토리를 검색하고
	// 그 히스토리를 기반으로 데이터를 다시 들고온뒤에. SearchContent를 검색해서 보내줌.
	ArrayList<SearchHistoryVO> historyList = SearchHistoryDAO.list(member.getMno());
	ArrayList<SearchContentVO> contentList = new ArrayList<SearchContentVO>(); 
	if(historyList.size() > 0){
		for(SearchHistoryVO history : historyList)
		{
			SearchContentVO vo = null;
			if(history.getType().equals("nick")){
				vo = SearchContentDAO.findOneByNick(history.getWords());
			}else {
				vo = SearchContentDAO.findOneByTag(history.getWords());
			}
			
			if(vo != null){
				contentList.add(vo);
			}
		}	
	}
	
	// json 만들기
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);
	Map<String,Object> root = new HashMap<String,Object>();
		
	root.put("result", "SUCCESS");
	root.put("contents", contentList);
	
	String json = mapper.writeValueAsString(root);
	
	//System.out.println(json);
	out.print(json);

%>