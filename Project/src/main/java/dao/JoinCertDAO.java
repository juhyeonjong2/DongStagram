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
				String sql = "INSERT INTO joincert (email, cert, expiretime, verifyyn) "
						   + "VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 5 MINUTE), 'n') ON DUPLICATE KEY "
						   + "UPDATE cert=?, expiretime=DATE_ADD(NOW(), INTERVAL 5 MINUTE), verifyyn='n' ";
			
				
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
				 String sql = "SELECT email, cert, expiretime, verifyyn FROM joincert WHERE email=? AND cert=?";	 
				 if( db.prepare(sql).setString(email).setString(certNumber).read())
				 {
					 if(db.next())
					 {
						 vo = new JoinCertVO();
						 vo.setEmail(db.getString("email"));
						 vo.setCert(db.getString("cert"));
						 vo.setExpiretime(db.getString("expiretime"));
						 vo.setVerifyyn(db.getString("verifyyn"));
					 }
				 }
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public static boolean verify(String email, String certNumber) {
		boolean result = false;
		try(DBManager db = new DBManager();)
		{
			if(db.connect()) {
				boolean isExpired = false;
				
				 // 인증기간내인지 확인.
				 String sql = "SELECT TIMESTAMPDIFF(SECOND, expiretime, now()) as result FROM joincert WHERE email=? AND cert=?";	 
				 if( db.prepare(sql).setString(email).setString(certNumber).read())
				 {
					 if(db.next()) {
						if(db.getInt("result") > 0) 
						{
							isExpired = true;
						}
					 }
					 else {
						 //결과가 없는 경우는 데이터가 없는경우라서 기간 지났음과 같은 처리. 
						 isExpired = true;
					 }
				 }
				 
				 if(!isExpired) { // 기간내인경우 verify 처리
					 sql = "UPDATE joincert SET verifyyn='y' WHERE email=? AND cert=?";
					 if( db.prepare(sql).setString(email).setString(certNumber).update() > 0)
					 {
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
	
	public static boolean isExpired(String email, String certNumber){
		boolean isExpired = false;
		
		// 없으면 타임오버나 마찬가지.
		/*
		 * if(findOne(email,certNumber) == null) { return true; }
		 */
		
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
						 // 없는경우는  데이터가 없는경우라서 인증대기중인 이메일이 아님 그냥 true 리턴 (기간지났음처리)
						 isExpired = true;
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
