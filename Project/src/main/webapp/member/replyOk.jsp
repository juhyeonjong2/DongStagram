<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="ezen.util.HashMaker" %>
<%@ page import="dao.ReplyDAO" %>

<%
	String bnoParam = request.getParameter("shortUrl"); 

	int bno = 0;
	if(bnoParam != null  && !bnoParam.equals("")){
		bno = (int)HashMaker.Base62Decoding(bnoParam);
	}
	
	String replyText = request.getParameter("reply");
	String nick = request.getParameter("nick");
	
	boolean isSuccess = ReplyDAO.replyWrite(bno, replyText, nick);
	
	out.print(isSuccess);
	
%>