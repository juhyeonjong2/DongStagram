package dao;

import ezen.db.DBManager;
import vo.CertVO;
import vo.JoinCertVO;

public class JoinCertDAO {
	
	public static boolean upsert(String email, String cert) 
	{
		// upsert를 처리하기위해  temppassword 테이블의 외래키 mno는 유니크해야한다.
		boolean isSuccess = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) 
			{
				// upsert unique 키가 있어야한다. (pk도 상관없음)
				String sql = "INSERT INTO joincert (email, cert, expiretime) "
						   + "VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 5 MINUTE)) ON DUPLICATE KEY "
						   + "UPDATE cert=?, expiretime=DATE_ADD(NOW(), INTERVAL 5 MINUTE)";
			
				
				if(db.prepare(sql)
					 .setString(email)
					 .setString(cert)
					 .setString(cert)
					 .update() > 0) 
				{
					//System.out.println("upsertJoinCert"); 
					isSuccess = true; 
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}	
		return isSuccess;
	}
	
	public static JoinCertVO findOne(String email, String certNumber){
		JoinCertVO vo = null;
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect())
			{
				 String sql = "SELECT email, cert, expiretime FROM joincert WHERE email=? AND cert=?";	 
				 if( db.prepare(sql).setString(email).setString(certNumber).read())
				 {
					 if(db.next())
					 {
						 vo = new JoinCertVO();
						 vo.setEmail(db.getString("email"));
						 vo.setCert(db.getString("cert"));
						 vo.setExpiretime(db.getString("expiretime"));
					 }
				 }
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public static boolean isExist(String email) {
		boolean result = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				String sql = "SELECT * FROM joincert WHERE email=? ";
				
				if(db.prepare(sql).setString(email).read()) {
					if(db.next()) {
						result = true;	
					}
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public static boolean isExpired(String email, String certNumber) throws Exception{
		boolean isExpired = false;
		
		// 없으면 타임오버나 마찬가지.
		if(findOne(email,certNumber) == null) {
			return true;
		}
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect())
			{
				 String sql = "SELECT TIMESTAMPDIFF(SECOND, expiretime, now()) as result FROM joincert WHERE email=?";	 
				 if( db.prepare(sql).setString(email).read())
				 {
					 if(db.next())
					 {
						//System.out.println("isExpiredTime");
						int result = db.getInt("result");
						//System.out.println(result);
						if(result > 0) {
							isExpired = true;
						}
					 }
					 else {
						 // 없는경우는 문제가 있는경우라 예외를 던진다.
						 db.disconnect();
						 throw new Exception("joincert does not exist");
					 }
				 }
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return isExpired; // 
	}
	
	
}
