package dao;

import ezen.db.DBManager;
import vo.MemberVO;

public class MemberDAO {

	public static boolean insert(MemberVO vo)
	{
		// 맴버 만들고
		// 계정 만들고(디폴트값)
		
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			
			 if(db.connect(true)) // 트렌젝션 활성화.
			 {
			    String sql = "INSERT INTO member (mid, mpassword, mname, mnick, email, joindate,  mlevel, delyn) "
						    + " VALUES(?, md5(?), ?, ?, ?, now(), ?, 'n')";
				
			    vo.setMlevel(1);
				
				if( db.prepare(sql)
				  .setString(vo.getMid())
				  .setString(vo.getMpassword())
				  .setString(vo.getMname())
				  .setString(vo.getMnick())
				  .setString(vo.getEmail())
				  .setInt(vo.getMlevel())
				  .update() > 0)
				{
					isSuccess = true;
				}
				
				if(isSuccess)
				{
					// mno가져오기
					int mno = db.last_insert_id("member", "mno");
					
					// account 추가.
					sql = "INSERT INTO account (mno, intro, openyn, gender, blockyn) "
						    + " VALUES(?, ?, ?, ?, 'n')";
					
					if( db.prepare(sql)
						  .setInt(mno)
						  .setString("")
						  .setString("y") // 기본값은 계정 공개
						  .setInt(0) // 기본값은 알리고 싶지 않음.
						  .update() == 0)
						{
							isSuccess = false; // 업데이트 실패인경우.
						}
				}
				
				if(isSuccess){
					db.txCommit();
				}
				else {
					db.txRollback();
				}
			 }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}	
		
		return isSuccess;
	}
	
	public static MemberVO findOne(String id, String pw) {
		
		MemberVO vo = null;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT mno, mid, email, mnick, mname, joindate FROM member " 
						   + " WHERE mid=? AND mpassword= md5(?) AND (delyn is null or delyn = 'n') ";
				
				if(db.prepare(sql).setString(id).setString(pw).read()) {
					if(db.next()) {
						vo = new MemberVO();
						vo.setMno(db.getInt("mno"));
						vo.setEmail(db.getString("email"));
						vo.setJoindate(db.getString("joindate"));
						vo.setMid(db.getString("mid"));
						vo.setMname(db.getString("mname"));
						vo.setMnick(db.getString("mnick"));
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public static MemberVO findOneByEmail(String email) {
		
		MemberVO vo = null;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT mno, mid, email, mnick, mname, joindate FROM member " 
						   + " WHERE email=? AND (delyn is null or delyn = 'n') ";
				
				if(db.prepare(sql).setString(email).read()) {
					if(db.next()) {
						vo = new MemberVO();
						vo.setMno(db.getInt("mno"));
						vo.setEmail(db.getString("email"));
						vo.setJoindate(db.getString("joindate"));
						vo.setMid(db.getString("mid"));
						vo.setMname(db.getString("mname"));
						vo.setMnick(db.getString("mnick"));
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
}
