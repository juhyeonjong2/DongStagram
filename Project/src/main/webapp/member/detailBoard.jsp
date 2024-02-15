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
<%@ page import="vo.PageVO"%>
<%@ page import="dao.ChangeJsonDAO" %>

<%
	// 질문 1. 순서가 ajax통신으로 여기로 온다음 쿼리문을 사용해 배열을 만들고 그 배열안에 모든 값을 넣은 뒤 json으로 변환하는 dao를 호출해 json으로 변환하고 리턴 
	//         -> ajax에서 json값을 받으면 그곳에서 json을 객체로 변환하는 dao사용해서 객체로 다시 변환 이게 맞는지 질문
	// 질문 2. 이 경우 배열로 만든 값을 dao에 보내서 사용하는 법
	// 질문 2. 위 방법보다 쉬운 방법이 있는지 물어보기 
	// 질문 3. 위가 맞다면 ajax에서 객체로 변환한 값을 let html에 넣어야하는데 java객체로 변환 된 값을 자바스크립트 안에서 사용하는법(profile.jsp에 ajax부분 보여주기)
	// 질문 4. PageVO 배열을 만들어서 값을 넣을 때 댓글값, 이미지값, 멤버값을 받아야 해서 select문을 3개 써야하는데 넣는 방법 질문(PageVO보여주기)
	// 질문 5. 혹시 gson이나 jackson 라이브러리 사용해보신적 있다면 사용법 질문하기(ChangeJsonDAO보여주기)




String bnoParam = request.getParameter("bno");
	
	
	int bno = 0;
	if(bnoParam != null  && !bnoParam.equals("")){
		bno = (int)HashMaker.Base62Decoding(bnoParam);
	}

	DBManager db = new DBManager();
	List<PageVO> attachList = new ArrayList<PageVO>(); //이미지 배열
	// 닉네임, 파일 실제이름, 그 글의 댓글들 전부 -> vo(새로만든 페이지정보 다담는 (allowlist해서 배열로 담아서)) 그걸 json으로 변환하고 리턴해줌
	if(db.connect()) {
		String sql = "SELECT bfrealname, bforeignname, bfidx FROM boardAttach WHERE bno=?";
		
		if(db.prepare(sql).setInt(bno).read()){
	while(db.next()){ //next로 차근차근 전부 가져온다.

		PageVO attach = new PageVO();;
		attach.setRealname(db.getString("pfrealname"));
		attachList.add(attach);
	}
	}
	
		
	 	db.disconnect(); //try안에 DB매니저사용 시 disconnect안해도됨
	}    

	String aa = ChangeJsonDAO.aa(1);
	
	
	out.print(aa);
%>
