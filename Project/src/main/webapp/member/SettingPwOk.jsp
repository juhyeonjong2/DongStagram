<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.db.DBManager" %>

<%

	int mno = member.getMno();
	String openyn = request.getParameter("mpassword");	

	DBManager db = new DBManager();
	if(db.connect()) {
		String sql = "UPDATE  member set mpassword = ? WHERE mno=? ";
		
	
		int result = db.prepare(sql).setString(mpassword).setInt(mno).update();
		
		db.disconnect();
		
		out.print(result);
	}else{
		out.print(0);
	}
	

%>