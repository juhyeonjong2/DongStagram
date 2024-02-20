package dao;

import java.util.ArrayList;

import ezen.db.DBManager;
import vo.SearchHistoryVO;

public class SearchHistoryDAO {
	
	public static boolean insert(int mno, String type, String words) {
		
		boolean result = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "INSERT INTO searchhistory(mno, type, words) VALUES(?, ?, ?) ";
				
				if(db.prepare(sql).setInt(mno).setString(type).setString(words).update()>0) {
					result = true;
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public static boolean isExist(int mno, String type, String words) {
		
		boolean result = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT count(*) as cnt FROM searchhistory WHERE mno=? AND type=? AND words=? ";
				
				if(db.prepare(sql).setInt(mno).setString(type).setString(words).read()) {
					if(db.next()) {
						if(db.getInt("cnt") > 0) {
							result = true;
						}
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public static ArrayList<SearchHistoryVO> list(int mno){
		ArrayList<SearchHistoryVO> list = new ArrayList<SearchHistoryVO>();
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				// mno기준으로 목록 반환. 
				String sql = "SELECT * FROM searchhistory WHERE mno=? ";
				
				if(db.prepare(sql).setInt(mno).read()) {
					while(db.next()) {
						
						SearchHistoryVO vo = new SearchHistoryVO();
						vo.setType(db.getString("type"));
						vo.setMno(db.getInt("mno"));
						vo.setWords(db.getString("words"));
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
	
	public static boolean removeList(int mno) {
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				String sql = "DELETE FROM searchhistory WHERE mno=?";				
				
				if(db.prepare(sql).setInt(mno).update() > 0)
				{
					//System.out.println("remove");
					isSuccess = true;
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}	
		return isSuccess;
		
	}

}
