<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ezen.util.HashMaker" %>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.MemberDAO" %>
 
<%
	String email = request.getParameter("email");
	// email 형식 검사.
	System.out.println(email);
	
	// 이메일 형식에 맞다면 해당 email의 가입자가 있는지 확인
	MemberVO vo = MemberDAO.findOneByEmail(email);
	if(vo != null){
		// 가입자가 있는경우 임시 비밀번호를 만들어서 DB에 인서트하고
		String tempPass = HashMaker.randomPassword(10);
		
		// DB에 인서트
		// ws comment - 여기 작업중
		
		System.out.println(tempPass);
		// 메일로 발송
	}
	
	
	
	
	
	

%>


<script>
	alert("임시비밀번호 발송!");
	location.href="<%=request.getContextPath()%>";
</script>