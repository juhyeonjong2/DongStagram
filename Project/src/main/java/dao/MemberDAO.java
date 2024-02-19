package dao;

import ezen.db.DBManager;
import vo.MemberVO;
import vo.MemberWithAttachVO;

public class MemberDAO {

	public static boolean insert(MemberVO vo)
	{
		// 맴버 만들고
		// 계정 만들고(디폴트값)
		
		boolean isSuccess = true;
		try(DBManager db = new DBManager();)
		{
			
			 if(db.connect(true)) // 트렌젝션 활성화.
			 {
				 // 이메일 인증 정보 확인.
				 String sql = "SELECT * FROM joincert WHERE email=? AND verifyyn = 'y'";
				 if(db.prepare(sql).setString(vo.getEmail()).read()) {
					if(!db.next()) {
						isSuccess = false;	
					}
				}
			 
				 
				if(isSuccess)
			 	{
				 
				    sql = "INSERT INTO member (mid, mpassword, mname, mnick, email, joindate,  mlevel, delyn) "
							    + " VALUES(?, md5(?), ?, ?, ?, now(), ?, 'n')";
					
				    vo.setMlevel(1);
					
					if( db.prepare(sql)
					  .setString(vo.getMid())
					  .setString(vo.getMpassword())
					  .setString(vo.getMname())
					  .setString(vo.getMnick())
					  .setString(vo.getEmail())
					  .setInt(vo.getMlevel())
					  .update() <= 0)
					{
						isSuccess = false;
					}
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
				
				if(isSuccess) {
					// 인증 정보 삭제.
					sql = "DELETE FROM joincert WHERE email=?";
					db.prepare(sql).setString(vo.getEmail()).update(); // 삭제 여부는 상관없음.
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
				/*// 원본
				  String sql = "SELECT mno, mid, email, mnick, mname, joindate FROM member " 
						   + " WHERE mid=? AND mpassword= md5(?) AND (delyn is null or delyn = 'n') ";
				 */
				
				// 임시비밀번호 포함으로 변경
				 String sql ="SELECT M.mno as mno, mid, mname, mnick, email, mlevel, joindate, delyn, mpassword " 
						    +"FROM member as M "
						    +"LEFT JOIN temppassword as T "
						    +"ON M.mno = T.mno "
						    +" WHERE (delyn is null or delyn = 'n') "
						    +"AND (M.mid=? AND M.mpassword= md5(?)) "
						    +"OR (T.tpassword=md5(?) AND TIMESTAMPDIFF(SECOND, T.expiretime, now()) <=0) ";
				
				//System.out.println(sql);
				
				if(db.prepare(sql).setString(id).setString(pw).setString(pw).read()) {
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
	
	public static MemberVO findOneByMno(int mno) {
		
		MemberVO vo = null;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT mno, mid, email, mnick, mname, joindate FROM member " 
						   + " WHERE mno=? AND (delyn is null or delyn = 'n') ";
				
				if(db.prepare(sql).setInt(mno).read()) {
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
	
	public static MemberWithAttachVO findOneByMnoWithAttach(int mno) {
		
		MemberWithAttachVO vo = null;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT M.mno as mno, mid, email, mnick, mname, joindate, mfrealname, mforeignname, rdate, mfno "
						   + "FROM member as M "
						   + "LEFT JOIN memberattach as A "
						   + "ON M.mno=A.mno "
						   + "WHERE M.mno=? AND (delyn is null or delyn = 'n') ";
				
				if(db.prepare(sql).setInt(mno).read()) {
					if(db.next()) {
						vo = new MemberWithAttachVO();
						vo.setMno(db.getInt("mno"));
						vo.setEmail(db.getString("email"));
						vo.setJoindate(db.getString("joindate"));
						vo.setMid(db.getString("mid"));
						vo.setMname(db.getString("mname"));
						vo.setMnick(db.getString("mnick"));
						
						// fileinfo
						vo.setMfno(db.getInt("mfno"));
						vo.setMforeignname(db.getString("mforeignname"));
						vo.setMfrealname(db.getString("mfrealname"));
						vo.setRdate(db.getString("rdate"));
						
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
	
	public static boolean isExistById(String id) {
		
		boolean result = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT * FROM member WHERE mid=? ";
				
				if(db.prepare(sql).setString(id).read()) {
					if(db.next()) {
						result = true;	
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public static boolean isExistByNick(String nick) {
		
		boolean result = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT * FROM member WHERE mnick=? ";
				
				if(db.prepare(sql).setString(nick).read()) {
					if(db.next()) {
						result = true;	
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public static boolean isExistByEmail(String email) {
		
		boolean result = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT * FROM member WHERE email=? ";
				
				if(db.prepare(sql).setString(email).read()) {
					if(db.next()) {
						result = true;	
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
