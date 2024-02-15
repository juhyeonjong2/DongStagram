<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.List"%>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="ezen.util.HashMaker" %>
<%@ page import="com.fasterxml.jackson.core.JsonProcessingException" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="vo.MemberVO"%>

<%
	String bnoParam = request.getParameter("bno");
	
	
	int bno = 0;
	if(bnoParam != null  && !bnoParam.equals("")){
		bno = (int)HashMaker.Base62Decoding(bnoParam);
	}

	DBManager db = new DBManager();
	// 닉네임, 파일 실제이름, 그 글의 댓글들 전부 -> vo(새로만든 페이지정보 다담는 (allowlist해서 배열로 담아서)) 그걸 json으로 변환하고 리턴해줌
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
	
    // Student 객체 생성 
    MemberVO student = new MemberVO();
    student.setMno(1);
    // jackson objectmapper 객체 생성 
    ObjectMapper objectMapper = new ObjectMapper(); 
    // Student 객체 -> Json 문자열
    String studentJson = objectMapper.writeValueAsString(student); 
    

    
	out.print("");  
%>
