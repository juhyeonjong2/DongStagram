package dao;

import java.util.ArrayList;

import ezen.FollowType;
import ezen.NotificationCodeType;
import ezen.db.DBManager;
import vo.FollowVO;
import vo.MemberVO;

public class FollowDAO {

	public static boolean isFollow(int mno, String targetNick) {
		
		MemberVO targetMember = MemberDAO.findOneByNick(targetNick);
		if(targetMember == null)
			return false;
		
		return isFollow(mno, targetMember.getMno());
	}
	
	public static boolean isFollow(int mno, int targetMno) {
		boolean isFollow = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) // 트렌젝션 활성화.
			{
				
				String sql = "SELECT count(*) as cnt FROM follow WHERE frommno=? AND tommo =?";
				if(db.prepare(sql).setInt(mno).setInt(targetMno).read()) {
					if(db.next()) {
						if(db.getInt("cnt") > 0) {
							isFollow = true;
						}
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return isFollow;
	}
	
	public static boolean follow(int mno, String targetNick) {
		MemberVO targetMember = MemberDAO.findOneByNick(targetNick);
		if(targetMember == null)
			return false;
		
		return follow(mno, targetMember.getMno());
	}
	
	// 팔로우 요청 (mno가 targetMno를 팔로우 요청함)
	public static boolean follow(int mno, int targetMno) {
		
		// 자신은 팔로우 할수 없음.
		if(mno == targetMno) {
			return false;
		}
		
		boolean isSuccess = true;
		try(DBManager db = new DBManager();)
		{
			if(db.connect(true)) // 트렌젝션 활성화.
			{
				// 타겟 계정이 비공개 계정인이 조회 
				boolean isPublicAccount = false;
				String sql = "SELECT * FROM account WHERE mno=?";
				if(db.prepare(sql).setInt(targetMno).read()) {
					if(db.next()){
						if(db.getString("openyn").equals("y")) {
							isPublicAccount = true;
						}
					}
				}
				
				// 이미 팔로우데이터가 있는지 확인.
				sql = "SELECT count(*) as cnt FROM follow WHERE frommno=? AND tommo =?";
				if(db.prepare(sql).setInt(mno).setInt(targetMno).read()) {
					if(db.next()) {
						if(db.getInt("cnt") > 0) {
							isSuccess = false;
						}
					}
				}
				
				/// follow 처리
				if(isSuccess) 
				{
					//해당 계정이 공개 계정인경우. state는 바로 ack
					// tommo는 오류임 tomno였어야함. 그냥 사용.
					sql = "INSERT INTO follow(frommno, tommo, state, rdate ) VALUES(?, ?, ?, now())";
					
					db.prepare(sql).setInt(mno).setInt(targetMno);
					// 상대계정이 공개상태인경우 바로 승인, 아닌경우 요청처리
					if(isPublicAccount) db.setString(FollowType.ACK.name()); 
					else 				db.setString(FollowType.REQ.name());
					
					if(db.update() == 0) {
						isSuccess = false;
					}
					
				}
				
				// 알림 만들기.
				if(isSuccess) 
				{
					/// mno = targetMno, targetmno = mno (반대로 기록해야함)
					//  알람 조회는 mno기준이므로 mno가 상대방 이어야 한다.
					sql= "INSERT INTO notification(mno, code, targetmno) VALUES(?,?,?)";
					if(db.prepare(sql).setInt(targetMno).setString(NotificationCodeType.FW.name()).setInt(mno).update() == 0) {
						isSuccess = false;
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
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	public static boolean unFollow(int mno, String targetNick) {
		MemberVO targetMember = MemberDAO.findOneByNick(targetNick);
		if(targetMember == null)
			return false;
		
		return unFollow(mno, targetMember.getMno());
	}
	
	// 언팔로우 (팔로우 요청 상태인 경우 취소 : 어쨋든 삭제, 알람도 삭제처리됨)
	public static boolean unFollow(int mno, int targetMno) {
		
		boolean isSuccess = true;
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect(true)) // 트렌젝션 활성화.
			{
				// 이미 팔로우데이터가 있는지 확인.
				String sql = "SELECT count(*) as cnt FROM follow WHERE frommno=? AND tommo =?";
				if(db.prepare(sql).setInt(mno).setInt(targetMno).read()) {
					if(db.next()) {
						// 팔로우데이터가 없다면 실패처리. 
						if(db.getInt("cnt") == 0) {
							isSuccess = false;
						}
					}
				}
				
				/// unfollow 처리
				if(isSuccess) 
				{
					// tommo는 오류임 tomno였어야함. 그냥 사용.
					sql = "DELETE FROM follow WHERE frommno=? AND tommo=?";
					
					if(db.prepare(sql).setInt(mno).setInt(targetMno).update() == 0) {
						isSuccess = false; // 위에서 있는걸 확인했기때문에 실패는 없어야함.
					}
				}
				
				// 알림  제거. 
				if(isSuccess) 
				{
					// 우선 알림 확인했으면 그것부터 제거 (ON DELETE CASCADE 옵션으로 자동삭제될 것)
					
					/// mno = targetMno, targetmno = mno (반대로 기록해야함)
					//  알람 조회는 mno기준이므로 mno가 상대방 이어야 한다.
					sql= "DELETE FROM notification WHERE mno =? AND targetmno =? ";
					if(db.prepare(sql).setInt(targetMno).setInt(mno).update() == 0) {
						isSuccess = false;
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
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	
	public static ArrayList<FollowVO> getFollowerList(String nick, int mymno){
		MemberVO targetMember = MemberDAO.findOneByNick(nick);
		if(targetMember == null)
			return new ArrayList<FollowVO>();
		
		return getFollowerList(targetMember.getMno(), mymno);	
	}
	
	// 팔로워 목록(mno를 팔로우 한 목록중, 로그인한 사용자(mymno)가 팔로우 했는지 여부도 검사)
	public static ArrayList<FollowVO> getFollowerList(int mno, int mymno) {
		ArrayList<FollowVO> list = new ArrayList<FollowVO>();
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) // 트렌젝션 활성화.
			{
				// 1. mno기준으로 follower목록을 찾는다. (ack 상태인 것만)
				//    찾은 frommno의 nick과 프로필 이미지 경로를 가져온다.
				String sql = "SELECT F.frommno as mno, M.mnick as nick ,mfrealname "
						+ "FROM follow as F "
						+ "INNER JOIN member as M ON F.frommno = M.mno "
						+ "INNER JOIN account as A ON M.mno = A.mno "
						+ "LEFT JOIN memberattach as MA ON A.mno = MA.mno "
						+ "WHERE tommo =? AND state=? AND (A.blockyn is null or A.blockyn = 'n')";
				
				if(db.prepare(sql).setInt(mno).setString(FollowType.ACK.name()).read()) {
					while(db.next()) 
					{
						FollowVO vo = new FollowVO();
						vo.setMno(db.getInt("mno"));
						vo.setNick(db.getString("nick"));
						vo.setProfileImage(db.getString("mfrealname"));
						list.add(vo);
					}
				}

				// 2. 그중 mymno가 follow요청을 보냈다면 true. 아니라면 false로 처리한다.
				// mymno가 frommno를 팔로우했는지 확인.
				sql = "SELECT count(*) as cnt FROM follow WHERE frommno=? AND tommo =?";
				for(FollowVO vo : list)
				{
					if(vo.getMno() == mymno) {
						vo.setFollowState(-1);
					}else{
						if(db.prepare(sql).setInt(mymno).setInt(vo.getMno()).read()) {
							if(db.next()) {
								if(db.getInt("cnt") > 0)
								{
									vo.setFollowState(1);
								}
								else {
									vo.setFollowState(0);
								}
							}
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
	
	
	public static ArrayList<FollowVO> getFollowingList(String nick, int mymno){
		MemberVO targetMember = MemberDAO.findOneByNick(nick);
		if(targetMember == null)
			return new ArrayList<FollowVO>();
		
		return getFollowingList(targetMember.getMno(), mymno);	
	}
	
	// 팔로잉 목록(mno가 팔로우 한 목록중, 로그인한 사용자(mymno)가 팔로우 했는지 여부도 검사)
	public static ArrayList<FollowVO> getFollowingList(int mno, int mymno) {
		ArrayList<FollowVO> list = new ArrayList<FollowVO>();
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) // 트렌젝션 활성화.
			{
				// 1. mno기준으로 follower목록을 찾는다. (ack 상태인 것만)
				//    찾은 tommo의 nick과 프로필 이미지 경로를 가져온다.
				String sql = "SELECT F.tommo as mno, M.mnick as nick ,mfrealname "
						+ "FROM follow as F "
						+ "INNER JOIN member as M ON F.tommo = M.mno "
						+ "INNER JOIN account as A ON M.mno = A.mno "
						+ "LEFT JOIN memberattach as MA ON A.mno = MA.mno "
						+ "WHERE frommno =? AND state=? AND (A.blockyn is null or A.blockyn = 'n')";
				
				if(db.prepare(sql).setInt(mno).setString(FollowType.ACK.name()).read()) {
					while(db.next()) 
					{
						FollowVO vo = new FollowVO();
						vo.setMno(db.getInt("mno"));
						vo.setNick(db.getString("nick"));
						vo.setProfileImage(db.getString("mfrealname"));
						list.add(vo);
					}
				}

				// 2. 그중 mymno가 follow요청을 보냈다면 true. 아니라면 false로 처리한다.
				// mymno가 frommno를 팔로우했는지 확인.
				sql = "SELECT count(*) as cnt FROM follow WHERE frommno=? AND tommo =?";
				for(FollowVO vo : list)
				{
					if(vo.getMno() == mymno) {
						vo.setFollowState(-1);
					}else{
						if(db.prepare(sql).setInt(mymno).setInt(vo.getMno()).read()) {
							if(db.next()) {
								if(db.getInt("cnt") > 0)
								{
									vo.setFollowState(1);
								}
								else {
									vo.setFollowState(0);
								}
							}
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

	public static int getFollowerCount(String nick) {
		MemberVO targetMember = MemberDAO.findOneByNick(nick);
		if(targetMember == null)
			return 0;
		
		return getFollowerCount(targetMember.getMno());
	}
	
	// mno에게 팔로우 요청을 보내서 ACK된 숫자. tomno를 기준으로 검색한다. (tomno를 검색하면 됨)
	public static int getFollowerCount(int mno) {
		int count = 0;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				
				String sql = "SELECT count(*) as cnt FROM follow WHERE tommo =? AND state=?";
				if(db.prepare(sql).setInt(mno).setString(FollowType.ACK.name()).read()) {
					if(db.next()) 
					{
						count = db.getInt("cnt");
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	
	public static int getFollowingCount(String nick) {
		MemberVO targetMember = MemberDAO.findOneByNick(nick);
		if(targetMember == null)
			return 0;
		
		return getFollowingCount(targetMember.getMno());
	}
	
	// mno가 요청을 보낸 카운트 (ACK가 된상태의 카운터)
	public static int getFollowingCount(int mno) {
		int count = 0;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) // 트렌젝션 활성화.
			{
				
				String sql = "SELECT count(*) as cnt FROM follow WHERE frommno =? AND state=?";
				if(db.prepare(sql).setInt(mno).setString(FollowType.ACK.name()).read()) {
					if(db.next()) 
					{
						count = db.getInt("cnt");
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public static boolean verify(int mno, String targetNick) {
		MemberVO targetMember = MemberDAO.findOneByNick(targetNick);
		if(targetMember == null)
			return false;
		
		return verify(mno, targetMember.getMno());
	}
	
	
	public static boolean verify(int mno, int targetMno) {
		if(mno == targetMno) {
			return false;
		}
		
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				// targetMno가 mno에게 팔로우한 상황이고 mno가 이를 승인하는 과정이다.
		
				// 팔로우 요청상태 확인.
				String sql = "SELECT state FROM follow WHERE frommno=? AND tommo =?";
				if(db.prepare(sql).setInt(targetMno).setInt(mno).read()) {
					if(db.next()) {
						if(db.getString("state").equals(FollowType.REQ.name())) {
							isSuccess = true;
						}
					}
				}
				/// follow 승인 처리
				if(isSuccess) 
				{
					// tommo는 오류임 tomno였어야함. 그냥 사용.
					sql = "UPDATE follow SET state=? WHERE frommno=? AND tommo=?";
					
					if(db.prepare(sql).setString(FollowType.ACK.name()).setInt(targetMno).setInt(mno).update() <= 0) {
						isSuccess = false;
					}	
				}
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
}
