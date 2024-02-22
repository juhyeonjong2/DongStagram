package dao;

import java.util.ArrayList;
import ezen.db.DBManager;
import vo.SearchContentVO;


public class SearchContentDAO {
	public static ArrayList<SearchContentVO> list(String searchWords){
		ArrayList<SearchContentVO> list = new ArrayList<SearchContentVO>();
		

		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				//1. 블럭되지 않은 유저들이면서 자신은 아니고 swearchWords가 nickname에 포함되는 유저들을 검색 
				String sql = "SELECT mnick, mname, mfrealname, "
						+ "(SELECT count(*) FROM follow WHERE tommo=M.mno AND state='ack') as followers "
						+ "FROM member as M "
						+ "INNER JOIN account as A ON M.mno=A.mno "
						+ "LEFT JOIN memberAttach as MA ON M.mno=MA.mno "
						+ "WHERE M.mlevel=1 AND (A.blockyn is null or A.blockyn='n') AND M.mnick LIKE CONCAT('%',?,'%') ";
				
				if(db.prepare(sql).setString(searchWords).read()) {
					while(db.next()) {
						
						SearchContentVO vo = new SearchContentVO();
						vo.setType("nick");// 타입설정
						vo.setSearchWords(db.getString("mnick"));
						vo.setName(db.getString("mname"));
						vo.setProfileImage(db.getString("mfrealname"));
						vo.setFollowers(db.getInt("followers"));
						// Type: 해시태그의 정보. 
						vo.setBoards(0);
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

	public static SearchContentVO findOneByNick(String nick) {
		
		SearchContentVO vo = null;
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				//1. 블럭되지 않은 유저들이면서 자신은 아니고 swearchWords가 nickname에 포함되는 유저들을 검색 
				String sql = "SELECT mnick, mname, mfrealname, "
						+ "(SELECT count(*) FROM follow WHERE tommo=M.mno AND state='ack') as followers "
						+ "FROM member as M "
						+ "INNER JOIN account as A ON M.mno=A.mno "
						+ "LEFT JOIN memberAttach as MA ON M.mno=MA.mno "
						+ "WHERE (A.blockyn is null or A.blockyn='n') AND M.mnick=? ";
				
				
				if(db.prepare(sql).setString(nick).read()) {
					if(db.next()) {
						vo = new SearchContentVO();
						vo.setType("nick");// 타입설정
						vo.setSearchWords(db.getString("mnick"));
						vo.setName(db.getString("mname"));
						vo.setProfileImage(db.getString("mfrealname"));
						vo.setFollowers(db.getInt("followers"));
						// Type: 해시태그의 정보. 
						vo.setBoards(0);
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public static SearchContentVO findOneByTag(String hashTag) {
		 // not use
		return null;
	}

}
