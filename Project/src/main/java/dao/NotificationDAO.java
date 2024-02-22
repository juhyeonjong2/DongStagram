package dao;

import java.util.ArrayList;
import ezen.NotificationCodeType;
import ezen.db.DBManager;
import vo.NotificationVO;

public class NotificationDAO {

	
	// 알림 확인
	public static ArrayList<NotificationVO> list(int mno) {
		ArrayList<NotificationVO> list = new ArrayList<NotificationVO>();
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				// 1. mno기준으로 follower목록을 찾는다. (ack 상태인 것만)
				//    찾은 tommo의 nick과 프로필 이미지 경로를 가져온다.
				String sql = "SELECT nno, code, N.mno as mno, M.mno as targetmno, M.mnick as targetnick, MA.mfrealname as targetrealfilename, F.state as state "
						   + "FROM notification as N "
						   + "INNER JOIN member as M ON N.targetmno=M.mno "
						   + "INNER JOIN account as A ON M.mno = A.mno "
						   + "LEFT JOIN memberattach as MA ON M.mno=MA.mno "
						   + "LEFT JOIN follow as F ON N.mno=F.frommno AND M.mno=F.tommo "
						   + "WHERE N.mno=? AND (A.blockyn is null or A.blockyn = 'n')";
				
				
				if(db.prepare(sql).setInt(mno).read()) {
					while(db.next()) 
					{
						NotificationVO vo = new NotificationVO();
						vo.setNno(db.getInt("nno"));
						vo.setType(db.getString("code"));
						vo.setNick(db.getString("targetnick"));
						vo.setProfileImage(db.getString("targetrealfilename"));
						vo.setTargetmno(db.getInt("targetmno"));
						if(db.getString("state") == null) {
							vo.setFollowState(false);
						}
						else {
							vo.setFollowState(true);
						}

						list.add(vo);
					}
				}
				
				// 상태 채우기
				for(NotificationVO vo : list) 
				{
					// 우선 검사는 FW만한다. 
					if(NotificationCodeType.FW.name().equals(vo.getType()))
					{
						// follow 알람이기때문에 follow 테이블 조회. (요청보낸 사람의 mno가 필요 = targetmno 가 mno에게 보낸것.)
						sql = "SELECT state, rdate FROM follow WHERE frommno=? AND tommo=?";
						
						if(db.prepare(sql).setInt(vo.getTargetmno()).setInt(mno).read()) {
							if(db.next()){
								vo.setState(db.getString("state"));
								vo.setRdate(db.getString("rdate"));
							}
						}
					}
					else if(NotificationCodeType.RE.name().equals(vo.getType()))
					{
						// 댓글 알림 : 사용안함
					}
					else if(NotificationCodeType.DM.name().equals(vo.getType()))
					{
						// 다이렉트 메세지 알림 : 사용안함
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
