<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="ezen.util.TypeChecker" %>
<%@ page import="dao.JoinCertDAO" %>

<%
	String email = request.getParameter("email");
	String cert = request.getParameter("cert");
	
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);	
	Map<String,Object> root = new HashMap<String,Object>();
	
	boolean isValidEmail = TypeChecker.isValidEmail(email);
	if(!isValidEmail || cert==null || cert.equals("")) 
	{
		// 이메일 형식이 안맞거나, cert데이터가 없다면.
		root.put("result", "FAIL");
		root.put("reason", "ERROR");
	} 
	else 
	{
		// cert값은 공백이 있어도 상관없다. 공백 제거 후 검사.
		cert = cert.trim();
		// ws comment - 넘어온 데이터가 숫자로만되어있는지 검사 필요 typechecker 추가 할 것
		
		if(JoinCertDAO.isExpired(email, cert))
		{ 
			// 시간이 지났거나 없음.
			root.put("result", "FAIL");
			root.put("reason", "NONE");
		}
		else {
			// email / cert 값이 존재하고 유효기간이 안지났으면	
			root.put("result", "SUCCESS");
		}
	}
	
	String json = mapper.writeValueAsString(root);
	out.print(json);
	
%>