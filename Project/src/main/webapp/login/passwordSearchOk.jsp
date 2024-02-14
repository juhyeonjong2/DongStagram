<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ezen.util.HashMaker" %>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.MemberDAO" %>
<%@ page import="dao.TempPasswordDAO" %>
<%@ page import="ezen.util.MailSender" %>
<%@ page import="ezen.thread.ThreadPool" %>
<%@ page import="ezen.util.TypeChecker" %>
 
<%
	String email = request.getParameter("email");
	//System.out.println(email);
	
	// email 형식 검사.
	boolean isValidEmail = TypeChecker.isValidEmail(email);
	if(isValidEmail)
	{
		// 이메일 형식에 맞다면 해당 email의 가입자가 있는지 확인
		MemberVO vo = MemberDAO.findOneByEmail(email);
		if(vo != null){
			// 가입자가 있는경우 임시 비밀번호를 만들어서 DB에 인서트하고
			String tempPass = HashMaker.randomPassword(10);
			//System.out.println(tempPass);
			
			// DB에 인서트
			if(TempPasswordDAO.upsert(vo.getMno(), tempPass))
			{
				// 메일발송이 느려서 이걸 쓰레드로 처리함. (느린걸 이용해서 실제 메일 발송인지 확인이 가능해서 쓰레드 처리를 통해 확인 못하게 함)
				
				// 메일 본문 작성
				StringBuffer sb = new StringBuffer();
				sb.append("<h3>[Dongstagram] 임시비밀 번호입니다.</h3>\n");
				sb.append("<h3>임시 비밀 번호 : <span style='color:red'>"+ tempPass +"</span></h3>\n");
				sb.append("<h4 style='color:blue'># 임시 비밀 번호의 유효기간은 발행후 24시간 입니다. 로그인 후 새 비밀번호로 변경해 주세요.</h3>\n");
				
				
				MailSender sender = new MailSender("ezenbteam2024","zdog gfut htfp nzql");
				sender.setTitle("임시 비밀 번호 발급");
				sender.setContent(sb.toString());
				sender.setTo(email);
				
				// 쓰레드 실행
				ThreadPool.execute(sender);
				
				/* 원본
				
				// 메일 본문 작성
				StringBuffer sb = new StringBuffer();
				sb.append("<h3>[Dongstagram] 임시비밀 번호입니다.</h3>\n");
				sb.append("<h3>임시 비밀 번호 : <span style='color:red'>"+ tempPass +"</span></h3>\n");
				
				// 인서트 성공시 메일로 발송 
				MailSender helper = new MailSender();
				boolean isSuccess = helper.send(helper.createSession("ezenbteam2024","zdog gfut htfp nzql"),
						email,
						"임시 비밀 번호 발급",
						sb.toString());
				
				System.out.println("sendMail:" + isSuccess);
				*/	
			}	
		}
	}
	// 어떤 경우에도 결과는 임시비밀번호 발송! 이라고 처리한다.
	// 악의적 사용자에 의한 무분별한 리셋 요청 대응.
%>


<script>
<%
	if(isValidEmail) 
	{
%>
	alert("임시비밀번호 발송!");
	location.href="<%=request.getContextPath()%>";
<%
	} else {
%>
	alert("이메일 형식이 아닙니다.");
<%
	}
%>
</script>