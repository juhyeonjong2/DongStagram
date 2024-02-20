<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="vo.PagingVO" %>
<%@ page import="vo.HomeViewVO" %>
<%@ page import="dao.HomeViewDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%

	String nowPageParam = request.getParameter("nowPage");
	MemberVO member = (MemberVO)session.getAttribute("login");
	if(member == null || nowPageParam == null || nowPageParam.equals("")){
		response.sendRedirect(request.getContextPath());
	}
	
	int nowPage = Integer.parseInt(nowPageParam);
	int totalCnt = HomeViewDAO.count(member.getMno());
	PagingVO pagingVO = new PagingVO(nowPage, totalCnt, 5);
	ArrayList<HomeViewVO> viewList = HomeViewDAO.list(member.getMno(), pagingVO.getStart()-1 , pagingVO.getPerPage());
	
	
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);
	Map<String,Object> root = new HashMap<String,Object>();
	
	root.put("result", "SUCCESS");
	root.put("views", viewList);
	
	String json = mapper.writeValueAsString(root);
	
	//System.out.println(json);
	out.print(json);
%>