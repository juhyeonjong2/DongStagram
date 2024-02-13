package dao;

import ezen.db.DBManager;

public class TempPasswordDAO {
	
	public boolean upsert() 
	{
		// upsert를 처리하기위해  temppassword 테이블의 외래키 mno는 유니크해야한다.
		// ws commnt - 여기작업중.
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				String sql = "INSERT INTO cert (hash, mno, expiretime) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 2 HOUR))";
				
				/*
				 * if(db.prepare(sql).setString(hash).setInt(mno).update() > 0) {
				 * //System.out.println("insertCert"); isSuccess = true; }
				 */
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}	
			return isSuccess;
	}
}
