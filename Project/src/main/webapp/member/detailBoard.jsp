<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.List"%>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="ezen.util.HashMaker" %>
<%
	String bnoParam = request.getParameter("bno");
	
	
	int bno = 0;
	if(bnoParam != null  && !bnoParam.equals("")){
		bno = (int)HashMaker.Base62Decoding(bnoParam);
	}

	DBManager db = new DBManager();
	
	if(db.connect()) {
		String sql = "SELECT bfrealname, bforeignname, bfidx FROM boardAttach WHERE bno=?";
		
		if(db.prepare(sql).setInt(bno).read()){
			while(db.next()){ //next로 차근차근 전부 가져온다.

				ProductAttach attach = new ProductAttach();
				attach.setPfno(db.getInt("pfno"));
				attach.setPno(db.getInt("pno"));
				attach.setPfrealname(db.getString("pfrealname"));
				attach.setPforeignname(db.getString("pforeignname"));
				attach.setRdate(db.getString("rdate"));
				attach.setPfidx(db.getInt("pfidx"));
				attachList.add(attach);
			}
	}
	
	//이부분이 순서 맞추는건데 일단 보류
	attachList.sort((a,b)->{
		return a.getPfidx() - b.getPfidx();
	});
		
	 	db.disconnect(); //try안에 DB매니저사용 시 disconnect안해도됨
	}



    String[] beer = {"Kloud", "Cass", "Asahi", "Guinness", "Heineken"};  
	
    String str = String.join(", ", beer);
	
    
    
	out.print(bno);  
%>
