package dao;

import ezen.db.DBManager;

public class ReplyDAO {

	public static boolean replyWrite(int bno, String text, String nick) {
		
		boolean isSuccess = true;
		int mno = 0;
		int rno = 0;
		
		try(DBManager db = new DBManager();){
			if(db.connect(true)) {
				
				//닉네임을 가공해서 mno가져오기		
				String sql = " SELECT mno FROM member where mnick = ?";
				if(db.prepare(sql).setString(nick).read()) {
					if(db.next()) {
						mno = db.getInt("mno");
					}
				}
				// 댓글 insert 하기
				sql = " INSERT INTO reply(bno, mno, ridx, rcontent, rpno, rdate ) VALUES(?, ?, ?, ?, ?, now())";		
				if(db.prepare(sql).setInt(bno).setInt(mno).setInt(1).setString(text).setInt(0).update(true) <= 0) {
					isSuccess = false;
				}
						
						
				// rpon에 rno값을 넣어서 대댓글이 부모댓글을 찾을 수 있도록 한다
				if(isSuccess) {
					rno = db.last_insert_id("reply", "rno"); // insert한 마지막 인덱스 가져오기
					
					sql = " UPDATE reply SET rpno = ? WHERE rno = ?";
					if(db.prepare(sql).setInt(rno).setInt(rno).update(true) <= 0) {
						isSuccess = false;
					}
				}
				
				
				
				
				// 모두 성공인경우
				if(isSuccess) {
					db.txCommit(); // 커밋.
				}
				
				db.disconnect(); // disconnect에서 autocommit을 기존값으로 되돌려놓음. (disconnect는 반드시 해야함)
			} // 커넥트 끝
					
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		
		return isSuccess;
	}
	
	public static int getReplyCount(int bno) {
		
		int count = 0;

		try(DBManager db = new DBManager();)
		{
			if(db.connect(true)) 
			{
				String sql = "SELECT Count(*) as count FROM reply WHERE bno=? AND ridx>0";
				
				if(db.prepare(sql).setInt(bno).read()) {
					if(db.next()) {
						count = db.getInt("count");
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}

}
