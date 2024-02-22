package dao;

import ezen.db.DBManager;

public class FavoriteDAO {

	public static boolean isExist(int mno, int bno) {
		
		boolean isExist = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				String sql = "SELECT * FROM favorite WHERE mno=? AND bno=?";
				
				if(db.prepare(sql).setInt(mno).setInt(bno).read()) {
					if(db.next()) {
						isExist = true;
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return isExist;
	}
	
	public static boolean insert(int mno, int bno) {
		
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect(true)) 
			{
				
				String sql = "INSERT INTO favorite(mno, bno) VALUES(?, ?)";
				
				if(db.prepare(sql).setInt(mno).setInt(bno).update()>0) {
					isSuccess = true;
				}
				
				if(isSuccess) {
					sql = "UPDATE board SET bfavorite=bfavorite+1 WHERE bno=?";
				
					if(db.prepare(sql).setInt(bno).update() <=0) {
						isSuccess = false;
					}
				}
				
				if(isSuccess) {
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
	
	public static boolean remove(int mno, int bno) {
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect(true)) 
			{
				String sql = "DELETE FROM favorite WHERE mno=? AND bno=?";
				
				if(db.prepare(sql).setInt(mno).setInt(bno).update()>0) {
					isSuccess = true;
				}
				
				// 보드를 찾아서 좋아요 갯수 줄이기.
				if(isSuccess) {
					sql = "UPDATE board SET bfavorite=bfavorite-1 WHERE bno=?";
				
					if(db.prepare(sql).setInt(bno).update() <=0) {
						isSuccess = false;
					}
				}
				
				if(isSuccess) {
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
	
}
