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
				 sql = "SELECT bfrealname FROM boardAttach WHERE bno=?";	//보드를 메인으로 다른거 조인
				 if( db.prepare(sql).setInt(bno).read())
				 {
						while(db.next()){ //next로 차근차근 전부 가져온다.
							BoardAttachVO attach = new BoardAttachVO(); 
							attach.setBfrealname(db.getString("bfrealname"));
							vo.imglist.add(attach);
						}
				 }
				 
				 
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
						rootReply.setPreviousDate(Tnow - Rnow);
						rootReply.setRcontent(db.getString("rcontent"));
						vo.rootReply.add(rootReply);
					}
				}
	
				// 가공된 날짜, 쓴 사람 닉네임, 댓글내용을 가져온다
			 	 sql = " SELECT r.rcontent, m.mnick, r.rno, replace(SUBSTRING(r.rdate, 1, 10), '-', '') as rdate FROM board as b"
			 		 + " inner join member as m on b.mno = m.mno inner join reply as r on b.bno = r.bno"
			 		 + " WHERE b.bno = ? and r.ridx = 1 ";	
				 if( db.prepare(sql).setInt(bno).read()){
						while(db.next()){ //next로 차근차근 전부 가져온다.	
							ReplyVO reply = new ReplyVO(); 
							reply.setRname(db.getString("mnick"));
							reply.setRno(db.getInt("r.rno"));
							int Rnow = db.getInt("rdate");
							reply.setPreviousDate(Tnow - Rnow);
							reply.setRcontent(db.getString("rcontent"));
							vo.replylist.add(reply);
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
					String sql = " delete from reply WHERE rno = ? and mno = ?;";
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
	
	
	
}
