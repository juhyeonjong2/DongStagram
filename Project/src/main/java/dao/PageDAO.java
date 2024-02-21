package dao;

import java.util.ArrayList;
import java.util.List;
import ezen.db.DBManager;
import vo.BoardAttachVO;
import vo.MemberVO;
import vo.PageVO;
import vo.ReplyVO;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


public class PageDAO {
	
	//이미지를 가져오는 메소드
	public static PageVO findOne(int bno) {
		
		PageVO vo  = null; 
		try(DBManager db = new DBManager();)
		{
			if(db.connect())
			{	
				 String sql = "SELECT m.mnick FROM board as b  inner join member as m on b.mno = m.mno where b.bno = ?";
				 if( db.prepare(sql).setInt(bno).read())
				 {
						if(db.next()){ //next로 차근차근 전부 가져온다.
							vo = new PageVO(); //값을 넣기위한 생성자
							vo.setNick(db.getString("mnick")); //vo안에 닉네임을 집어넣는다.
							vo.setBno(bno);
					 }
				 }
				 
				
				
				// 이미지는 while문 써야해서 일단 두개로 나눔
				 sql = "SELECT bfrealname, bfidx FROM boardAttach WHERE bno=?";	//보드를 메인으로 다른거 조인
				 if( db.prepare(sql).setInt(bno).read())
				 {
						while(db.next()){ //next로 차근차근 전부 가져온다.
							BoardAttachVO attach = new BoardAttachVO(); 
							attach.setBfrealname(db.getString("bfrealname"));
							attach.setBfidx(db.getInt("bfidx"));
							vo.imglist.add(attach);
						} 
				 }
				 
		 		 vo.imglist.sort((a,b)->{
		 		 	return a.getBfidx() - b.getBfidx();
		 		 });
		 		 
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo; 
	}
	
	
	
	// 댓글을 가져오는 메소드
	public static PageVO findReply(int bno) {
		PageVO vo = new PageVO();
		
        // 현재 날짜 구하기        
		LocalDate now = LocalDate.now();
		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		// 포맷 적용 
		String formatedNow = now.format(formatter);
		
		int Tnow = Integer.parseInt(formatedNow);
		
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect()){
				
				// 루트댓글을 가져온다
				String sql = " SELECT r.rcontent, m.mnick, r.ridx, replace(SUBSTRING(r.rdate, 1, 10), '-', '') as rdate"
						+ " FROM board as b inner join member as m on b.mno = m.mno"
						+ " inner join reply as r on b.bno = r.bno "
						+ " WHERE b.bno = ? and r.ridx = 0;";
				if( db.prepare(sql).setInt(bno).read()){
					if(db.next()) {
						ReplyVO rootReply = new ReplyVO();
						rootReply.setRname(db.getString("mnick"));
						int Rnow = db.getInt("rdate");
						rootReply.setPdate(Tnow - Rnow);
						rootReply.setRcontent(db.getString("rcontent"));
						vo.rootReply.add(rootReply);
					}
				}
	
				// 가공된 날짜, 쓴 사람 닉네임, 댓글내용을 가져온다
			 	 sql = " select r.rcontent, r.rno, m.mnick, replace(SUBSTRING(r.rdate, 1, 10), '-', '') as rdate"
			 	 	 + " from reply r, member m where r.mno = m.mno and r.bno = ? and r.ridx = 1";	
				 if( db.prepare(sql).setInt(bno).read()){
						while(db.next()){ //next로 차근차근 전부 가져온다.	
							ReplyVO reply = new ReplyVO(); 
							reply.setRname(db.getString("mnick"));
							reply.setRno(db.getInt("rno"));
							int Rnow = db.getInt("rdate");
							reply.setPdate(Tnow - Rnow);
							reply.setRcontent(db.getString("rcontent"));
							vo.replylist.add(reply);
						}
				 }
				 		 
				 
				 // 좋아요 수를 가져온다
				 sql = "SELECT COUNT(*) as cnt FROM favorite WHERE bno= ?";
				 if( db.prepare(sql).setInt(bno).read()){
						if(db.next()){ //next로 차근차근 전부 가져온다.	
							vo.setBfavorite(db.getInt("cnt"));
						}
				 }
				 
				 // 가공된 날짜를 가져온다
				 sql = "SELECT replace(SUBSTRING(wdate, 1, 10), '-', '') as wdate FROM board WHERE bno = ?";
				 if( db.prepare(sql).setInt(bno).read()){
						if(db.next()){ //next로 차근차근 전부 가져온다.
							int Rnow = db.getInt("wdate");
							vo.setCdate(Tnow - Rnow);
						}
				 }
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo; 
	}
	
	
	
	// 댓글을 삭제하는 메소드
		public static boolean deleteReply(int rno, int mno) {
			
			boolean isSuccess = false;

			try(DBManager db = new DBManager();){
				if(db.connect()){
					
					// 댓글을  지운다.
					String sql = " delete from reply WHERE rno = ? and mno = ?";
					if( db.prepare(sql).setInt(rno).setInt(mno).update() > 0){
						isSuccess = true; 
					}  
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			
			return isSuccess; 
		}
	
		
		// 게시글을 삭제하는 메소드
		public static boolean deleteBoard(int bno, int mno) {
			
			boolean isSuccess = true;

			try(DBManager db = new DBManager();){
				if(db.connect(true)){
					
					//System.out.println("삭제시작");
					// 댓글을  지운다. (댓글은 반드시 존재, (댓글이 없다는 댓글이 달리는듯))
						String sql = " delete from reply WHERE bno = ?";
						if(db.prepare(sql).setInt(bno).update(true) <= 0){
							isSuccess = false;
							//System.out.println("삭제실패1");
						} 
					 
					// 댓글을 지웠다면 이미지파일을 제거한다 (이미지는 반드시 존재)
						if(isSuccess){
							sql = " delete from boardattach WHERE bno = ?";
							if(db.prepare(sql).setInt(bno).update(true) <= 0){
								isSuccess = false; 
								//System.out.println("삭제실패2");
							} 
						} 
					
					// 이미지 파일도 지웠다면 좋아요도 지운다. (셀렉트로 검사 후 존재한다면 삭제)
					if(isSuccess){
						 int testBno = 1;
						sql = " SELECT bno FROM favorite WHERE bno = ? and mno = ?";
						 if( db.prepare(sql).setInt(bno).setInt(mno).read()){
							 if(db.next()){
								 testBno = db.getInt("bno"); 
							 }
						 }
						 //찾은 값이 없지 않다면 
						 if(testBno != 0 && testBno != 1) {
							sql = " delete from favorite WHERE bno = ? and mno = ?";
							if(db.prepare(sql).setInt(bno).setInt(mno).update(true) <= 0){
								isSuccess = false; 
								//System.out.println("삭제실패3");
							} 
						 }
					}
					// 모두 지웠으면 게시물도 지워준다.
					if(isSuccess){
						sql = " delete from board WHERE bno = ? and mno = ?";
						if(db.prepare(sql).setInt(bno).setInt(mno).update(true) <= 0){
							isSuccess = false;
							//System.out.println("삭제실패4");
						} 
					}
					// 모두 성공인경우
					if(isSuccess) {
						db.txCommit(); // 커밋.
						//System.out.println("커밋함");
					}	
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			
			return isSuccess; 
		}
	
	
}
