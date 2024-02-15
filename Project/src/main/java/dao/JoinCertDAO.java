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
	
	public static JoinCertVO findOne(String email) 
	{
		JoinCertVO cert = null;
		
		try(DBManager db = new DBManager();)
		{
			if(db.connect())
			{
				 String sql = "SELECT mno, hash, expiretime FROM cert WHERE mno=? AND hash=?";	 
				 if( db.prepare(sql).setInt(mno).setString(token).read())
				 {
					 if(db.next())
					 {
							/* System.out.println("getCert(int mno, String token)"); */
						cert = new JoinCertVO();
						cert.setMno(db.getInt("mno"));
						cert.setHash(db.getString("hash"));
						cert.setExpiretime(db.getString("expiretime"));
					 }
				 }
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return cert;
		
	}
	
}
