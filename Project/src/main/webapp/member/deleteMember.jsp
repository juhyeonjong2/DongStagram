<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="vo.MemberVO"%>
<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	int mno = 0;
	if(member != null){
		 mno = member.getMno();	
	} 
	
	String deletePw = request.getParameter("deletePw");
	String deleteText = request.getParameter("deleteText");
	
	
	//만약 회원탈퇴라는 글을 잘못적었을 경우
	if(!deleteText.equals("회원탈퇴")){
		%>
		<script>
			alert("회원탈퇴를 정확하게 적어주세요!")
			location.href="<%=request.getContextPath()%>/accounts/setting/profile";
		</script>
		<%
	}
	
	boolean isSuccess = true;
	try(DBManager db = new DBManager();){
		 if(db.connect(true)){
			 // 이메일 인증 정보 확인.
			 String sql = "UPDATE member SET delyn = 'y' WHERE mpassword = md5(?)";
			 if(db.prepare(sql).setString(deletePw).update(true) <= 0) {
				 isSuccess = false;
			}
			 
			// 모두 성공인경우
			if(isSuccess) {
				db.txCommit(); // 커밋.
				%>
				<script>
					alert("회원탈퇴 되었습니다.")
					location.href="<%=request.getContextPath()%>";
				</script>
				<%
			}else{
				%>
				<script>
					alert("회원탈퇴에 실패했습니다.")
					location.href="<%=request.getContextPath()%>/accounts/setting/profile";
				</script>
				<%
			}
			
		 }
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	
	
	
	
%>
