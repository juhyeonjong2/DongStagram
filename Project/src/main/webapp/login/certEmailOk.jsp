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
		root.put("reason", "CERT_ERROR");
	} 
	else 
	{
		// cert값은 공백이 있어도 상관없다. 공백 제거 후 검사.
		cert = cert.trim();
		if(!TypeChecker.isValidNumber(cert)) // 모두 숫자가 아닌경우.
		{
			root.put("result", "FAIL");
			root.put("reason", "CERT_ERROR");
		}
		else 
		{
			if(JoinCertDAO.verify(email, cert))
			{ 
				// email / cert 값이 존재하고 유효기간이 안지났으면	
				root.put("result", "SUCCESS");
				root.put("reason", "CERT_SUCCESS");
			}
			else 
			{
				// 시간이 지났거나 없음.
				root.put("result", "FAIL");
				root.put("reason", "CERT_ERROR");
			}
		}
	}
	
	String json = mapper.writeValueAsString(root);
	out.print(json);
	
%>