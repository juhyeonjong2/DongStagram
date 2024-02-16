package dao;

import ezen.db.DBManager;
import vo.HomeViewVO;
import vo.MemberVO;

public class HomeViewDAO {
	public static HomeViewVO findOne(String pageUrl) {
		HomeViewVO vo = null;
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				// pageUrl을 가지고있는 board찾기.
				
				
				// ws comment - 여기 작업중
				String sql = "SELECT * FROM board WHERE shorturl=?";
				if(db.prepare(sql).setString(pageUrl).read()) {
					if(db.next()) {
						vo = new HomeViewVO();
						vo.setBno(db.getInt("bno"));
						vo.setMno(db.getInt("mno"));
						/* vo.set */
						
						//private int bno; //글번호
						//private int mno; //회원번호
						//private String boardReply; //글 작성할 때 쓴 글
						//private String blockyn; //블록여부
						//private int bhit; //조회수
						//private String shorturi; //짧은 경로 인데 어디에 쓰는지 잘 모르겠다.
						//private String wdate; //작성일
						//private int bfavorite; //좋아요 수
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
