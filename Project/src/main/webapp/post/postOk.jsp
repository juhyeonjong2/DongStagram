<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="ezen.db.DBManager" %>
<%
	request.setCharacterEncoding("UTF-8"); //인코딩
%>
<!--<jsp:useBean id ="boardAttach" class="vo.BoardAttachVO" />
<jsp:setProperty property="*" name="boardAttach" />-->

<!-- 아이디는 변수 , class는 위치 , scope="page"는 페이지에만 이 객체를 쓰겠다 참고로 위는 객체생성한거라 보면 됨-->
<!-- 네임은 유즈빈의 아이디(네임은 왜 필요한지 모르겠음)-->
<!-- 프로퍼티하면 예) mid value = 어쩌고  이런느낌이였음 *는 전체-->
<!-- post.get어쩌고()이거 쓰면 postVO에 작성한것 가져옴  -->
<!-- setProperty는 useBean에 의해 생성된 객체의 setter 메소드를 호출하여 Bean 객체의 필드값을 form태그의 동일 name 속성값으로 변경 -->
<!-- 그러니까 VO에 필드와 form에서 사용할 name값은 동일하게 해야함 -->
<%
	//https://blog.naver.com/PostView.nhn?blogId=nonstop94&logNo=220995513703
	//파일 업로드 참고
	//파일은 다른방법으로 파라미터를 가져와야하는데 빈으로 될지 몰라서 일단 원래방식으로 작성
	
	String saveDir = "image/product";
	String saveDirectoryPath = application.getRealPath(saveDir); // 절대 경로 안쓰기위해 톰캣쪽에 저장됨. (디비 합치면 못씀.) 
	int sizeLimit = 100*1024*1024;//100mb 제한
	
	MultipartRequest multi = new MultipartRequest(request
										, saveDirectoryPath //톰캣 경로
										,sizeLimit
										,"UTF-8"
										, new DefaultFileRenamePolicy());
	
	String boardReply = multi.getParameter("boardReply");
	String boardOpen = multi.getParameter("boardOpen"); 
	String favoriteOpen = multi.getParameter("favoriteOpen");
	String replyOpen = multi.getParameter("replyOpen");
	// 업로드된 실제 파일명
	String realImgNM  = multi.getOriginalFileName("uploadimg"); //이 부분은 input이 얼마나 길어질지도 모르고 이름도 다 달라 뭘 받아와야 할지 모르겠다.
	//원본 파일명
	String originImgNM = multi.getFilesystemName("uploadimg");
	
	
	DBManager db = new DBManager();
%>