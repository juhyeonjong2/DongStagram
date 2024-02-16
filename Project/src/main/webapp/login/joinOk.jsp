<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.MemberDAO" %>

<jsp:useBean id ="member" class="vo.MemberVO" />
<jsp:setProperty property="*" name="member" /> 
<%
	if(member.isValid() == false)
	{
		%>
		<script>
			alert("회원가입을 실패하였습니다. 1");
			location.href="<%=request.getContextPath()%>"
		</script>
		<%
	}
	else 
	{
		
		// isValid는 형식에 맞는지만 확인하고 디비의 중복체크는 하지 않음.
		// 따라서 여기서 한번더 디비 중복체크를 한다. (디비에서 하도록 유니크 처리하였음)
		boolean isSuccess = MemberDAO.insert(member);
		if(isSuccess)	
		{
			%>
				<script>
					alert("회원가입 되었습니다. 로그인을 시도하세요");
					location.href="<%=request.getContextPath()%>"
				</script>
			<%
		}else{
			%>
			<script>
				alert("회원가입을 실패하였습니다. 2");
				location.href="<%=request.getContextPath()%>"
			</script>
			<%
		}
	}
%>
