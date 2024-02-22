package dao;

import java.util.ArrayList;

import ezen.db.DBManager;
import vo.MemberVO;
import vo.UserBlockVO;
import vo.UserReportVO;

public class AccountDAO {
	
	public static ArrayList<UserBlockVO> blockList() {
		ArrayList<UserBlockVO> list = new ArrayList<UserBlockVO>();
		
		//account bolckyn이 y인 모든 계정 정보.
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				
				String sql = "SELECT A.mno as mno, mname, mnick, mfrealname "
						   + "FROM account as A "
						   + "INNER JOIN member as M ON M.mno=A.mno "
						   + "LEFT JOIN memberattach as MA ON A.mno=MA.mno "
						   + "WHERE A.blockyn='y'";
				
				if(db.prepare(sql).read()) {
					while(db.next()) {
						UserBlockVO vo  = new UserBlockVO();
						vo.setMno(db.getInt("mno"));
						vo.setName(db.getString("mname"));
						vo.setNick(db.getString("mnick"));
						vo.setProfileImage(db.getString("mfrealname"));
						list.add(vo);
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	public static boolean block(int mno) {
		// 블럭하는경우 신고된 모든 정보를 삭제함. (ON DELETE CASCADE 걸었으면 더 좋았을지도)
		// account bolckyn을 y로 세팅.
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect(true)) // 트랜젝션. 
			{
				
				String sql = "UPDATE account SET blockyn=? WHERE mno=?";
				if(db.prepare(sql).setString("y").setInt(mno).update()>0) {
					isSuccess = true;
				}
				
				if(isSuccess) {
					// 신고당한 데이터를 날려줘야함.
					sql = "DELETE FROM reportaccount WHERE reportmno=?";
					if(db.prepare(sql).setInt(mno).update() >= 0) { // 없을수도 있어서 >= 0
						isSuccess = true;
					}
				}
				
				if(isSuccess) {
					db.txCommit();
				}else {
					db.txRollback();
				}
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
		
	}
	
	public static boolean unblock(int mno ) {
		
		// account bolckyn을 n로 세팅.
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{	
				String sql = "UPDATE account SET blockyn=? WHERE mno=?";
				if(db.prepare(sql).setString("n").setInt(mno).update()>0) {
					isSuccess = true;
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public static boolean report(int mno, String targetNick, String reason) {
		MemberVO targetMember = MemberDAO.findOneByNick(targetNick);
		if(targetMember == null)
			return false;
		
		return report(mno, targetMember.getMno(), reason);
	}
	
	public static boolean report(int mno, int targetMno, String reason) {
		
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				boolean isExsit = false;
				
				// 신고한적이 있으면 변경 없으면 추가
				String sql = "SELECT count(*) as cnt FROM reportaccount WHERE mno=? AND reportmno =?";
				if(db.prepare(sql).setInt(mno).setInt(targetMno).read()) {
					if(db.next()) {
						if(db.getInt("cnt") > 0) {
							isExsit = true;
						}
					}
				}
				
				if(isExsit) // 이미 있으면 업데이트. (reason + rdate) 
				{
					sql = "UPDATE reportaccount SET reason=?, rdate=now() WHERE mno=? AND reportmno =?";
					if(db.prepare(sql).setString(reason).setInt(mno).setInt(targetMno).update() > 0) {
						isSuccess = true;
					}
				}
				else 
				{
					sql = "INSERT INTO reportaccount(mno, reportmno, reason, rdate) VALUES(?,?,?,now())";
					if(db.prepare(sql).setInt(mno).setInt(targetMno).setString(reason).update() > 0) {
						isSuccess = true;
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public static ArrayList<UserReportVO> reportList(){
		ArrayList<UserReportVO> list = new ArrayList<UserReportVO>();
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				// 파일명만뻬고 찾아옴.
				String sql = "SELECT reportmno, COUNT(RA.mno) as cnt, mnick, mname "
						+ "FROM reportaccount as RA "
						+ "LEFT JOIN member as M ON RA.reportmno=M.mno "
						+ "GROUP BY RA.reportmno ";
				
				if(db.prepare(sql).read()) {
					while(db.next()){
						UserReportVO vo = new UserReportVO();
						vo.setMno(db.getInt("reportmno"));
						vo.setCount(db.getInt("cnt"));;
						vo.setName(db.getString("mname"));
						vo.setNick(db.getString("mnick"));
						list.add(vo);
					}
				}
				
				
				sql = "SELECT mfrealname FROM memberattach WHERE mno=?";
				for(UserReportVO vo : list) {
					if(db.prepare(sql).setInt(vo.getMno()).read()) {
						if(db.next()) {
							vo.setProfileImage(db.getString("mfrealname"));
						}
					}
				}
			}	
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
}
