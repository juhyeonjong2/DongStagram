package dao;

import ezen.FollowType;
import ezen.NotificationCodeType;
import ezen.db.DBManager;

public class FollowDAO {

	// 팔로우 요청 (mno가 targetMno를 팔로우 요청함)
	public static boolean follow(int mno, int targetMno) {
		
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
	
	// 언팔로우 (팔로우 요청 상태인 경우 취소 : 어쨋든 삭제, 알람도 삭제처리됨)
	public static boolean unFollow(int mno, int targetMno) {
		
		boolean isSuccess = true;
		/*
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
					// 우선 알림 확인했으면 그것부터 제거
					
					
					
					
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
		*/
		return isSuccess;
	}
	
	// 팔로잉 목록 (mno가 팔로우한 목록중 ack상태인 것만)
	
	
	
	// 팔로워 먹록(mno를 팔로우 한 목록중 ack상태인 것만.)
	
	
}
