<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.List"%>
<%@ page import="ezen.util.HashMaker" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="ezen.util.MailSender" %>
<%@ page import="vo.MemberVO"%>
<%@ page import="vo.PageVO"%>
<%@ page import="dao.PageDAO"%>

<%
	String bnoParam = request.getParameter("shortUrl"); 
	int bno = 0;
	if(bnoParam != null  && !bnoParam.equals("")){
		bno = (int)HashMaker.Base62Decoding(bnoParam);
	}

	
	// 이미지 가져오기
	if(bno != 0){

		PageVO vo = PageDAO.findOne(bno); // 타입공부
		
		// jackson사용해서 json만들기
		ObjectMapper mapper = new ObjectMapper();
		mapper.enable(SerializationFeature.INDENT_OUTPUT);	

		String json = mapper.writeValueAsString(vo);
		//System.out.println(json);
		out.print(json);
	}
	
	
	
	String bnoParamReply = request.getParameter("shortUrlReply"); 
	int bno2 = 0;
	if(bnoParamReply != null  && !bnoParamReply.equals("")){
		bno2 = (int)HashMaker.Base62Decoding(bnoParamReply);
	}
	
	//댓글 가져오기
	if(bno2 != 0){
		PageVO vo = PageDAO.findReply(bno2); 

		// jackson사용해서 json만들기
		ObjectMapper mapper = new ObjectMapper();
		mapper.enable(SerializationFeature.INDENT_OUTPUT);	

		String json = mapper.writeValueAsString(vo);

		out.print(json);
	}
	
	
	
	
	MemberVO member = (MemberVO)session.getAttribute("login");
	
	String rnoParam = request.getParameter("rno"); 
	int rno = 0;
	if(rnoParam != null  && !rnoParam.equals("")){
		rno = Integer.parseInt(rnoParam);
	}
	
	//댓글 지우기
	if(rno != 0){
		boolean isSuccess = PageDAO.deleteReply(rno, member.getMno()); 
		out.print(isSuccess);
	}
	
	
	
	
	

	
%>
