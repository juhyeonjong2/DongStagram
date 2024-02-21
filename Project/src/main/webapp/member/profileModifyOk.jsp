<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ezen.db.DBManager" %>
<%@ page import="java.io.File" %>
<%@ page import="vo.BoardAttachVO"%>
<%
	MemberVO member = (MemberVO)session.getAttribute("login");
	int mno = 0;
	if(member != null){
		 mno = member.getMno();	
	} 
	
	String saveDir = "upload/" + member.getMnick(); // member 닉네임

	
	String saveDirectoryPath = application.getRealPath(saveDir); // 절대 경로 안쓰기위해 톰캣쪽에 저장됨. (디비 합치면 못씀.) 
		// 위 경로에  폴더가 있는지 확인 후 없다면 폴더 생성
		String path = saveDirectoryPath;
		File Folder = new File(path);
	
		 //해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try{
			    Folder.mkdir(); //폴더 생성합니다.
			    //System.out.println("폴더가 생성되었습니다.");
		        } 
		        catch(Exception e){
			    e.getStackTrace();
			}        
	         }else {
			//System.out.println("이미 폴더가 생성되어 있습니다.");
		}
		
		
		//System.out.println(saveDirectoryPath);
		int sizeLimit = 100*1024*1024;//100mb 제한
		
		MultipartRequest multi = new MultipartRequest(request
											, saveDirectoryPath //톰캣 경로
											,sizeLimit
											,"UTF-8"
											, new DefaultFileRenamePolicy());
		
		String replyTextarea = multi.getParameter("replyTextarea");
		String genderParam = multi.getParameter("gender");
		//만약 내 소개가 없다면
		if(replyTextarea == null || replyTextarea.equals("")){
			replyTextarea = "소개 문구가 없습니다.";
		}
		
		
		
		int gender = 0;
		if(genderParam != null  && !genderParam.equals("")){
			gender = Integer.parseInt(genderParam);
		}


		// 업로드된 실제 파일명
		String realName  = multi.getOriginalFileName("uploadimg"); //이 부분은 input이 얼마나 길어질지도 모르고 이름도 다 달라 뭘 받아와야 할지 모르겠다.
		//원본 파일명
		String foriginName = multi.getFilesystemName("uploadimg");
		
		DBManager db = new DBManager();
		if(db.connect(true)) // connect에 true를 줘서  
		{
			boolean isSuccess = true;

			String sql = "UPDATE account SET intro = ?, gender = ? WHERE mno = ?";
			
			if(db.prepare(sql).setString(replyTextarea).setInt(gender).setInt(member.getMno()).update(true) <= 0){
				isSuccess = false;
			}	
		
			if(isSuccess) {
				List<BoardAttachVO> fileList = new ArrayList<BoardAttachVO>();
				Enumeration files = multi.getFileNames(); //input 파일 타입의 파일들을 Enumeration 타입으로 저장
				String nameAttr = (String) files.nextElement();
				
				if(multi.getFilesystemName(nameAttr) != null){
					sql = "SELECT count(mno) as cnt FROM memberattach where mno = ?";
					int cnt = 1;
					 if( db.prepare(sql).setInt(mno).read())
					 {
						 if(db.next()){
							// System.out.println(mno+" ?의 mno 값 ");
							 cnt = db.getInt("cnt");
							 //System.out.println(cnt+" cnt의 값"); 
						 }
					 }
					
					 //찾은 값이 없다면
					 if(cnt == 0) {
						 //System.out.println("값이 없어서 만듬");
						sql = "INSERT INTO  memberattach(mno, mfrealname, mforeignname, rdate) VALUES(?, ?, ?, now())";	
						
						if(db.prepare(sql)
							 .setInt(mno)
							 .setString(multi.getFilesystemName(nameAttr))
							 .setString(multi.getOriginalFileName(nameAttr))
							 .update(true) <= 0) {
								 isSuccess = false;
							 } 
					  //값이 있다면 업데이트	
					 }else{
						// System.out.println("값이 있어서 업뎃");
						sql = "UPDATE memberattach SET mfrealname = ?, mforeignname = ?, rdate = now() WHERE mno = ?";				
						if(db.prepare(sql)
							 .setString(multi.getFilesystemName(nameAttr))
							 .setString(multi.getOriginalFileName(nameAttr))
							 .setInt(mno)
							 .update(true) <= 0) {
								 isSuccess = false;
						}
					 }
				}

		   	}

			// 모두 성공인경우
			if(isSuccess) {
				db.txCommit(); // 커밋.
				%>
				<script>
					alert("프로필을 수정하였습니다.")
					location.href="<%=request.getContextPath()%>/accounts/setting/profile";
				</script>
				<%
			}else{
			}
			
			db.disconnect(); // disconnect에서 autocommit을 기존값으로 되돌려놓음. (disconnect는 반드시 해야함)
	}
		
		
		
		
		
%>