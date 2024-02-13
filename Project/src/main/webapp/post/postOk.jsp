<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="vo.MemberVO"%>
<%@ page import="vo.BoardAttachVO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

	MemberVO member = (MemberVO)session.getAttribute("login");
	int mno = 0;
	if(member != null){
		 mno = member.getMno();	
	}
	//https://blog.naver.com/PostView.nhn?blogId=nonstop94&logNo=220995513703
	//파일 업로드 참고
	//파일은 다른방법으로 파라미터를 가져와야하는데 빈으로 될지 몰라서 일단 원래방식으로 작성
	
	String saveDir = "image/boardImg";
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
	String realName  = multi.getOriginalFileName("uploadimg"); //이 부분은 input이 얼마나 길어질지도 모르고 이름도 다 달라 뭘 받아와야 할지 모르겠다.
	//원본 파일명
	String foriginName = multi.getFilesystemName("uploadimg");
	
	DBManager db = new DBManager();
	// 게시글 테이블에는 글번호(자동),회원번호 (로그인한),작성일자 (업데이트로 생성해서 토글태그3개 넣기 (완))
	// 댓글 테이블에는 댓글번호(자동),관리인덱스(0),작성일, 외래키의 회원번호와 글번호
	// 그리고 게시글 파일 전부
	// if(db.connect(true)) // 이거db테스트 109줄 참고해서 트렌젝션 넣기
			if(db.connect(true)) // connect에 true를 줘서  
			{
				boolean isSuccess = true;
				
				String sql = "INSERT INTO board(mno,boardOpen,favoriteOpen,replyOpen,wdate,bhit,bfavorite) "
						   + " VALUES(? ";
						   //게시글 공개 미체크 시
							if(boardOpen == null){
								sql += " ,'n'";
							}else{
								sql += " ,'y'";
							}
							//좋아요 공개 미체크 시
							if(favoriteOpen == null){
								sql += " ,'n'";
							}else{
								sql += " ,'y'";
							}
							//댓글 공개 미체크 시 
							if(replyOpen == null){
								sql += " ,'n'";
							}else{
								sql += " ,'y'";
							}
							
						 sql += " ,now(), 0, 0) ";
				// if안에 if쓰는법 몰라서 위 방식으로 구현 
					if(db.prepare(sql)
							 .setInt(mno)
							 .update(true) <= 0) {
						isSuccess = false;
					}
				
				// 파일 업로드
				int bno = 0;
				if(isSuccess) {
					// 현재 삽입된 상품목록의 기본키(bno)값을 조회후 bno안에 순서대로 집어넣는다.
					sql = "select last_insert_id() as bno from board";
				
					
					if(db.prepare(sql).read())
					{
						if(db.next()){
							bno = db.getInt("bno");
						}
					}
					if(bno != 0) { // 0이 아닌경우 가져오기 성공
						
					// 2. 저장된 파일을 정보를 생성한다.
					List<BoardAttachVO> fileList = new ArrayList<BoardAttachVO>();
					 
					// 순서가 지켜지지 않음. 소트 필요. notification view안에 소트 함수 참고해서 작성
					Enumeration files = multi.getFileNames(); //input 파일 타입의 파일들을 Enumeration 타입으로 저장
					while(files.hasMoreElements()) {      //커서가 첫번째면 0이고 1개라도 있다면 트루반환
						String nameAttr = (String) files.nextElement();
						
							// 이름뒤에 글자를짤라서 index를 얻자. ('file_' + 숫자형태)
							String numberString =  nameAttr.replace("file_",""); // 공백처리함.
							
							
							BoardAttachVO attach = new BoardAttachVO();
							attach.setBfidx(Integer.parseInt(numberString)); //번호를 골라내서 관리번호에 집어넣는다.
							attach.setBno(bno);
							attach.setBfrealname(multi.getFilesystemName(nameAttr)); // 업로드된 실제 파일명(겹치는경우 이름이 바뀐다.)
							attach.setBforeignname(multi.getOriginalFileName(nameAttr)); // 클라이언트에서 올린 파일명 */
							fileList.add(attach);	
						} 
					
						
						sql = "INSERT INTO  boardattach(bno, bfidx, bfrealname, bforeignname, rdate) VALUES(?, ?, ?, ?, now())";
						
						for(BoardAttachVO attach : fileList){ //상품이미지가 여러개 들어갈 가능성이 높으니 for문 사용
						if(db.prepare(sql)
							 .setInt(attach.getBno())
							 .setInt(attach.getBfidx())
							 .setString(attach.getBfrealname())
							 .setString(attach.getBforeignname())
							 .update(true) <= 0) {
							 isSuccess = false;
							}
						}
					}
				}
				
				// 쓴 글 댓글로
				if(isSuccess){
					sql = " INSERT INTO reply(mno, bno, ridx, rpno, rdate, rcontent ) VALUES(?, ?, ?, ?, now(), ?) ";
					
					if(db.prepare(sql)
							 .setInt(mno)
							 .setInt(bno)
							 .setInt(0) 
							 .setInt(0) //이 두가지는 처음 게시글의 글이니까 둘다 0
							 .setString(boardReply)
							 .update(true) <= 0) {
							 isSuccess = false;
							}
					
				}
				
				// 모두 성공인경우
				if(isSuccess) {
					db.txCommit(); // 커밋.
					%>
					<script>
						alert("공유성공")
					</script>
					<%
				}
				
				db.disconnect(); // disconnect에서 autocommit을 기존값으로 되돌려놓음. (disconnect는 반드시 해야함)
		}
%>