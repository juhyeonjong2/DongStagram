<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.JoinCertDAO" %>
<%@ page import="dao.MemberDAO" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="ezen.util.MailSender" %>
<%@ page import="ezen.thread.ThreadPool" %>
<%@ page import="ezen.util.TypeChecker" %>
<%@ page import="ezen.util.HashMaker" %>

<%

	String email = request.getParameter("email");

	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);	
	Map<String,Object> root = new HashMap<String,Object>();
	
	boolean isValidEmail = TypeChecker.isValidEmail(email);
	if(!isValidEmail) 
	{
		// 이메일 형식이 안맞으면
		root.put("result", "FAIL");
		root.put("reason", "ERROR");
	} 
	else 
	{
		// 2. 이미 가입되어 있는 이메일인지 검사한다.
		if(MemberDAO.isExistByEmail(email))
		{ 
			// 가입되어 있다면.
			root.put("result", "FAIL");
			root.put("reason", "DUP");	
		}
		else 
		{
			// 가입되어 있지 않다면 인증번호를 만들어서 DB에 인서트하고
			String certNumber = HashMaker.randomNumber(8);
			//System.out.println(certNumber);
			
			// DB에 인서트하고
			if(JoinCertDAO.upsert(email, certNumber))
			{
				// 인증번호 메일 발송.	
				
				// 메일 본문 작성
				StringBuffer sb = new StringBuffer();
				sb.append("<h3>[Dongstagram] 회원 가입 인증번호입니다.</h3>\n");
				sb.append("<h3>인증 번호 : <span style='color:red'>"+ certNumber +"</span></h3>\n");
				
				
				MailSender sender = new MailSender("ezenbteam2024","zdog gfut htfp nzql");
				sender.setTitle("회원가입 인증번호");
				sender.setContent(sb.toString());
				sender.setTo(email);
				
				// 쓰레드 실행
				ThreadPool.execute(sender);
				
				// 응답데이터
				root.put("result", "SUCCESS");
				
			} 
			else 
			{
			  // 만약 디비 인서트에 실패하면.
				root.put("result", "FAIL");
				root.put("reason", "UNKNOWN");	
			}
		}
	}
		
	String json = mapper.writeValueAsString(root);
	out.print(json);
%>