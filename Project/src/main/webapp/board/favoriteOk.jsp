<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.FavoriteDAO" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%

	// 로그인 정보 가져오기
 	MemberVO member = (MemberVO)session.getAttribute("login");
	//파라메터 정보 가져오기.
	String bnoParam = request.getParameter("bno");
	String reqParam = request.getParameter("req");
	
	// req가 있으면 응답 데이터를 JSON형태로 담아서 보낸다.
	// 없다면 OK/FAIL만보낸다.
	if(reqParam != null){
		ObjectMapper mapper = new ObjectMapper();
		mapper.enable(SerializationFeature.INDENT_OUTPUT);	
		Map<String,Object> root = new HashMap<String,Object>();
		// 내용 시작
		int bno=0;
		if(!bnoParam.equals("")){
			bno = Integer.parseInt(bnoParam);
		}
		
		boolean isSuccess = false;
		// 이미 좋아요 상태인지 확인.
		if(FavoriteDAO.isExist(member.getMno(), bno))
		{
			// 이미 좋아요 상태이면 좋아요 제거.
			if(FavoriteDAO.remove(member.getMno(), bno))
			{
				isSuccess = true;
				root.put("isFavorite", "n");
			}
		}
		else {
			// 좋아요상태가 아니면 좋아요 처리
			if(FavoriteDAO.insert(member.getMno(), bno))
			{
				isSuccess = true;
				root.put("isFavorite", "y");
			}
		}
		
		if(isSuccess){
			root.put("result", "SUCCESS");
			root.put("bno", bno);
		}
		else {
			root.put("result", "FAIL");
		}
		
		
		// 내용끝
		String json = mapper.writeValueAsString(root);
		out.print(json);
	}
	else 
	{
		if(member == null || bnoParam == null)
		{
			out.print("FAIL");
		}
		else 
		{
			int bno=0;
			if(!bnoParam.equals("")){
				bno = Integer.parseInt(bnoParam);
			}
			
			boolean isSuccess = false;
			// 이미 좋아요 상태인지 확인.
			if(FavoriteDAO.isExist(member.getMno(), bno))
			{
				// 이미 좋아요 상태이면 좋아요 제거.
				if(FavoriteDAO.remove(member.getMno(), bno))
				{
					isSuccess = true;
				}
			}
			else {
				// 좋아요상태가 아니면 좋아요 처리
				if(FavoriteDAO.insert(member.getMno(), bno))
				{
					isSuccess = true;
				}
			}
			
			if(isSuccess){
				out.print("SUCCESS");
			}
			else {
				out.print("FAIL");
			}
		}
	}
%>

