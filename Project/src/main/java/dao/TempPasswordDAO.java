package dao;

import ezen.db.DBManager;

public class TempPasswordDAO {
	
	public static boolean upsert(int mno, String password) 
	{
		// upsert를 처리하기위해  temppassword 테이블의 외래키 mno는 유니크해야한다.
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				// upsert unique 키가 있어야한다.
				String sql = "INSERT INTO temppassword (mno, tpassword, expiretime) "
						   + "VALUES (?, md5(?), DATE_ADD(NOW(), INTERVAL 24 HOUR)) ON DUPLICATE KEY "
						   + "UPDATE tpassword=md5(?), expiretime=DATE_ADD(NOW(), INTERVAL 24 HOUR)";
								
				//System.out.println("password : " + password);
				
				if(db.prepare(sql)
					 .setInt(mno)
					 .setString(password)
					 .setString(password)
					 .update() > 0) 
				{
					//System.out.println("upsertTempPassword"); 
					isSuccess = true; 
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}	
		return isSuccess;
	}
	
	public static boolean remove(int mno) 
	{
		// mno 값으로 임시패스워드를 삭제한다.
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				String sql = "DELETE FROM temppassword WHERE mno=?";				
				
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
