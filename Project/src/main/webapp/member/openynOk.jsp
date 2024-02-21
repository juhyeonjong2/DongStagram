<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="vo.MemberVO"%>
<%@ page import="ezen.db.DBManager" %>

<%
	MemberVO member = (MemberVO)session.getAttribute("login"); //로그인정보를 얻어온다
	int mno = member.getMno();						// 숫자열 mn0 는 member라는 ? mno를 받아온다
	String openyn = request.getParameter("openyn");	// 문자열 openyn은 getParameter
	

	//db연결
	DBManager db = new DBManager();
	
	if(db.connect()) {
		String sql = "UPDATE  account set openyn = ? WHERE mno=? ";
		
	
		int result = db.prepare(sql).setString(openyn).setInt(mno).update();
		
		db.disconnect();
		
		out.print(result);
	}else{
		out.print(0);
	}
	
%>