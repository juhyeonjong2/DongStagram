<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="dao.ReplyDAO" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.databind.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%

	// 로그인 정보 가져오기
 	MemberVO member = (MemberVO)session.getAttribute("login");
	//파라메터 정보 가져오기.
	String bnoParam = request.getParameter("bno");
	String replyParam = request.getParameter("reply");
	
	ObjectMapper mapper = new ObjectMapper();
	mapper.enable(SerializationFeature.INDENT_OUTPUT);	
	Map<String,Object> root = new HashMap<String,Object>();
	
	if(member == null || bnoParam == null ||  replyParam == null)
	{
		root.put("result", "FAIL");
	}
	else 
	{
		int bno=0;
		if(!bnoParam.equals("")){
			bno = Integer.parseInt(bnoParam);
		}
		
		System.out.println(bnoParam);
		System.out.println(replyParam);
		System.out.println(bno);
		
		if(bno != 0 && !replyParam.equals(""))
		{
			if(ReplyDAO.replyWrite(bno, replyParam, member.getMnick()))
			{
				root.put("result", "SUCCESS");
				root.put("bno", bno);
				root.put("replyCount", ReplyDAO.getReplyCount(bno));
				
			}
			else {
				root.put("result", "FAIL");
			}
		}
		else {
			root.put("result", "FAIL");
		}
	 }
	
	String json = mapper.writeValueAsString(root);
	out.print(json);
%>

