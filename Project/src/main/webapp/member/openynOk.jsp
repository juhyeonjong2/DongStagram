<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="vo.MemberVO"%>
<%@ page import="ezen.db.DBManager" %>

<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	int mno = member.getMno();
	String openyn = request.getParameter("openyn");
	

	//db연결
	DBManager db = new DBManager();
	
	if(db.connect()) {
		String sql = "UPDATE  account set openyn = ? WHERE mno=? ";
		
	
		int result = db.prepare(sql).setString(openyn).setInt(mno).update();
		
		db.release();
		db.close();
		
		out.print(result);
	}else{
		out.print(0);
	}
	
%>