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
// 질문 1. 순서가 ajax통신으로 여기로 온다음 쿼리문을 사용해 배열을 만들고 그 배열안에 모든 값을 넣은 뒤 json으로 변환하고 리턴 
	//         -> ajax에서 json값을 받으면 그곳에서 json을 객체로 변환 이게 맞는지 질문
	// 질문 2. 위 방법보다 쉬운 방법이 있는지 물어보기 
	// 질문 3. PageVO 배열을 만들어서 값을 넣을 때 댓글값, 이미지값, 멤버값을 받아야 해서 select문을 3개 써야하는데 넣는 방법 질문(PageVO보여주기)


	String bnoParam = request.getParameter("shortUrl"); 
	int bno = 0;
	if(bnoParam != null  && !bnoParam.equals("")){
		bno = (int)HashMaker.Base62Decoding(bnoParam);
	}

	
	
	//dao호출 ->(bno)넘김 -> 리턴하는값은 vo안에 set어쩌고해서 여러개가 들어간 객체를 배열로 만들어서 반환(PageVO보여주기)
			// 배열을 리턴한다면 -> 그 배열을 json해서 out 프린트 

	PageVO vo = PageDAO.findOne(bno); // 타입공부
		
	// jackson사용해서 json만들기
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);	

	String json = mapper.writeValueAsString(vo);
	
	// 여기서 json 어캐나왔는지 확인 하고 뒤 작업
	
	//root안에 키값 벨류값을 넣어야 하는데 (root.put("키 값" , "밸류 값"))
	//받아온 배열을 분리해서 값을 넣는 방법(배열안에는 파일의 실제이름들(경로로 사용할), 파일의 순서가 저장되어있는데)
	//							   (키값은 "path" : 밸류 값은 경로(동스타그램/닉네임/파일이름.png))이런느낌
	//							   (키값은 "path" : 밸류 값은 경로(동스타그램/닉네임/파일이름.png)) 이 경우 여러개의 파일중 내가 원하는 순서의 벨류값 가져오는법(ajax에서)
	
	System.out.println(json);
	out.print(json);
%>
