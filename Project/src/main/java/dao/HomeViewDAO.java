package dao;

import java.util.ArrayList;

import ezen.db.DBManager;
import vo.BoardAttachVO;
import vo.HomeViewVO;
import vo.ReplyVO;

public class HomeViewDAO {
	// 1. 일단 모든 목록을 가져와보기. (현재)
	// 1-1. limit 설정하기
	// 2.내가 팔로우한 유저들의 게시물 들고오기
	// 3.내가 팔로우한 유저들의 게시물 중 최근 3일내의 게시물만 들고오기.
	// 4.내가 팔로우한 유저들의 게시물 중 최근 3일내의 게시물 중에 확인을 안했거나 확인한지 1일이 지나지 않은 게시물만 가져오기
	public static ArrayList<HomeViewVO> list(int mno){
		ArrayList<HomeViewVO> list = new ArrayList<HomeViewVO>();
		
		// mno가 좋아요 한 것인지도 조사.
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				//1. 블럭되지 않은 모든 게시물 목록 가져오기
				String sql = "SELECT B.bno as bno, B.mno as mno, shorturi, bhit, bfavorite, wdate, mnick, mfrealname, F.bno as favorite "
						+ "FROM board as B "
						+ "LEFT JOIN member as M ON B.mno = M.mno "
						+ "LEFT JOIN memberattach as A ON M.mno = A.mno "
						+ "LEFT JOIN favorite as F ON F.bno = B.bno "
						+ "WHERE (B.blockyn is null or B.blockyn = 'n') ";
				
				
				if(db.prepare(sql).read()) {
					while(db.next()) {
						HomeViewVO vo = new HomeViewVO();
						vo.setBno(db.getInt("bno"));
						vo.setMno(db.getInt("mno"));
						vo.setBhit(db.getInt("bhit"));
						vo.setBfavorite(db.getInt("bfavorite"));
						vo.setShorturi(db.getString("shorturi"));
						vo.setWdate(db.getString("wdate"));
						// homeview
						vo.setProfileImage(db.getString("mfrealname"));
						vo.setNick(db.getString("mnick"));
						vo.setMfavorite(db.getInt("favorite")>0?"y":"n");
						
						list.add(vo);
					}
				}
				
				// 2. 미디어 리스트
				for(HomeViewVO vo : list) {
					 ArrayList<BoardAttachVO> mediaList = vo.getMediaList();
					 sql = "SELECT * FROM boardattach WHERE bno = ? ";
						
					 if(db.prepare(sql).setInt(vo.getBno()).read()) {
						 while(db.next()) {
							 BoardAttachVO attach = new BoardAttachVO();
							 attach.setBfidx(db.getInt("bfidx"));
							 attach.setBforeignname(db.getString("bforeignname"));
							 attach.setBfrealname(db.getString("bfrealname"));
							 attach.setBno(db.getInt("bno"));
							 attach.setMfno(db.getInt("mfno"));
							 attach.setRdate(db.getString("rdate"));
							 mediaList.add(attach);
						 }
					 }
				}
				
				// 3. 댓글 리스트
				for(HomeViewVO vo : list) {
					 ArrayList<ReplyVO> replyList = vo.getReplyList();
					 sql = "SELECT bno, rmdate, R.mno as mno, rdate, ridx, mnick, rno, rpno, rcontent "
					 		+ "FROM reply as R "
					 		+ "LEFT JOIN member as M ON R.mno = M.mno "
					 		+ "WHERE R.bno = ? ";
						
					 if(db.prepare(sql).setInt(vo.getBno()).read()) {
						 while(db.next()) {
							 ReplyVO reply = new ReplyVO();
							 reply.setBno(db.getInt("bno"));
							 reply.setMdate(db.getString("rmdate")); // ws comment 이름 수정 필요
							 reply.setMno(db.getInt("mno"));
							 reply.setRdate(db.getString("rdate"));
							 reply.setRidx(db.getInt("ridx"));
							 reply.setRname(db.getString("mnick")); // ws comment 변수명 수정 필요 : rname -> rnick
							 reply.setRno(db.getInt("rno"));
							 reply.setRpno(db.getInt("rpno"));
							 reply.setRcontent(db.getString("rcontent"));
							 
							 if(reply.getRidx() == 0) { // 0번인경우 글내용
								 vo.setRootReply(reply);
							 } else { // 그외에 댓글
								 replyList.add(reply);
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
	 
	
	// fulldata (reply, medialist) 
	public static HomeViewVO findOne(String pageUrl) {
		HomeViewVO vo = null;
		
		try(DBManager db = new DBManager();)
		{
			
			if(db.connect()) {
				// pageUrl을 가지고있는 board찾기.
				//1. 게시물 정보
				String sql = "SELECT B.bno as bno, B.mno as mno, shorturi, bhit, bfavorite, wdate, mnick, mfrealname, F.bno as favorite "
						+ "FROM board as B "
						+ "LEFT JOIN member as M ON B.mno = M.mno "
						+ "LEFT JOIN memberattach as A ON M.mno = A.mno "
						+ "LEFT JOIN favorite as F ON F.bno = B.bno "
						+ "WHERE B.shorturi = ? AND (B.blockyn is null or B.blockyn = 'n') ";
				
				
				if(db.prepare(sql).setString(pageUrl).read()) {
					if(db.next()) {
						vo = new HomeViewVO();
						vo.setBno(db.getInt("bno"));
						vo.setMno(db.getInt("mno"));
						vo.setBhit(db.getInt("bhit"));
						vo.setBfavorite(db.getInt("bfavorite"));
						vo.setShorturi(db.getString("shorturi"));
						vo.setWdate(db.getString("wdate"));
						// homeview
						vo.setProfileImage(db.getString("mfrealname"));
						vo.setNick(db.getString("mnick"));
						vo.setMfavorite(db.getInt("favorite")>0?"y":"n");
					}
				}
				
				// 2. 미디어 리스트
				if(vo != null) {
					 ArrayList<BoardAttachVO> list = vo.getMediaList();
					 sql = "SELECT * FROM boardattach WHERE bno = ? ";
						
					 if(db.prepare(sql).setInt(vo.getBno()).read()) {
						 while(db.next()) {
							 BoardAttachVO attach = new BoardAttachVO();
							 attach.setBfidx(db.getInt("bfidx"));
							 attach.setBforeignname(db.getString("bforeignname"));
							 attach.setBfrealname(db.getString("bfrealname"));
							 attach.setBno(db.getInt("bno"));
							 attach.setMfno(db.getInt("mfno"));
							 attach.setRdate(db.getString("rdate"));
							 list.add(attach);
						 }
					 }
				}
				
				
				
				// 3. 댓글 리스트
				if(vo != null) {
					 ArrayList<ReplyVO> list = vo.getReplyList();
					 sql = "SELECT R.mno as mno, * FROM reply as R "
					 		+ "LEFT JOIN member as M ON R.mno = M.mno "
					 		+ "WHERE R.bno = ? ";
						
					 if(db.prepare(sql).setInt(vo.getBno()).read()) {
						 while(db.next()) {
							 ReplyVO reply = new ReplyVO();
							 reply.setBno(db.getInt("bno"));
							 reply.setMdate(db.getString("rmdate")); // ws comment 이름 수정 필요
							 reply.setMno(db.getInt("mno"));
							 reply.setRdate(db.getString("rdate"));
							 reply.setRidx(db.getInt("ridx"));
							 reply.setRname(db.getString("mnick")); // ws comment 변수명 수정 필요 : rname -> rnick
							 reply.setRno(db.getInt("rno"));
							 reply.setRpno(db.getInt("rpno"));
							 reply.setRcontent(db.getString("rcontent"));
							 
							 if(reply.getRidx() == 0) { // 0번인경우 글내용
								 vo.setRootReply(reply);
							 } else { // 그외에 댓글
								 list.add(reply);
							 }
						 }
					 }
				}
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
		
		
	}
	
	// 댓글을 제외한 정보(댓글0번은 포함한다:게시글 내용임)
	public static HomeViewVO findOneWithoutReply(String pageUrl) {
		HomeViewVO vo = null;
		
		
		return vo;
	}
	
	// 댓글 목록 : 이것은 ReplyDAO에 만들 것.
	/*
	 * public static HomeViewVO findOneWithoutReply(String pageUrl) { HomeViewVO vo
	 * = null;
	 * 
	 * 
	 * return vo; }
	 */
	
	
}
