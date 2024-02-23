package ezen.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

//import java.sql.*;

public class DBManager implements AutoCloseable{
	/// 필드 멤버
	// DB 접속용 데이터
	private String host;	// 서버주소, 포트, DB이름, 세팅들
	private String userID;	// DB 접속 계정
	private String userPW;	// DB 계정 비번
	
	// DB 연결 개체들
	private Connection conn=null;
	private PreparedStatement psmt = null;
	private ResultSet result = null;
	private boolean useTx = false;
	private boolean aleadyCommit = false;
	// 내부용
	private int orderCount = 1; // psmt setInt등에 쓰임
	private boolean oldAutoCommitState = true;
	
	
	
	/// 메소드
	// 생성자
	public DBManager() {
		
		this("dongstagram", "dongtester", "1234");
	}
	
	public DBManager(String dbName) {
		
		this(dbName, "dongtester", "1234");
	}
	
	public DBManager(String dbName, String id, String pw) {
		this.host= "jdbc:mysql://127.0.0.1:3306/" + dbName;
		this.host+= "?useUnicode=true";
		this.host+= "&characterEncoding=utf-8";
		this.host+= "&serverTimezone=UTC";
		
		this.userID = id;
		this.userPW = pw;
	}
	
	// getter and setter
	public Connection getConn() {
		return conn;
	}
	
	public PreparedStatement getStatement() {
		return this.psmt;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	public void setUserID(String userID) { 
		this.userID = userID;			   
	}

	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}
	
	// DB 연결 메소드
	public boolean connect() {
		return connect(false);
	}
	
	
	public boolean connect(boolean useTx) {
		try {
			// 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 연결
			this.conn =DriverManager.getConnection(host,userID,userPW);
			this.oldAutoCommitState = conn.getAutoCommit();
			this.useTx = useTx;
			this.aleadyCommit = false;
			if(this.useTx ) {
				this.conn.setAutoCommit(false);
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	// DB 종료 메소드
	public boolean disconnect() {
		try {
			
			release();
		
			if(conn != null) {
				
				if(useTx ) {
					conn.setAutoCommit(oldAutoCommitState);
				}
				
				conn.close();	
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public DBManager txCommit()
	{
		if(conn == null)
			return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
		
		try {
			if(useTx) {
				conn.commit();
				aleadyCommit = true;
			}	
		} catch (Exception e) {
			e.printStackTrace();
			return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
		}
	
		
		return this;
	}
	
	public boolean txRollback()
	{
		if(conn == null)
			return false;
		
		if(!useTx) {
			return false;
		}
		
		try {
			
			conn.rollback();
			
			aleadyCommit = true;
				
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public DBManager prepare(String sql) {
		if(conn == null)
			return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
		
		try {
			release(); // rs, state 모두 초기화.
			
			psmt = conn.prepareStatement(sql);
			orderCount = 1;
		}catch (Exception e) {
			e.printStackTrace();
			return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
		}
		
		return this;
	}
	
	public DBManager clearParameter() {
		
		orderCount=1;
		if(psmt!=null) 
		{
			try {
				psmt.clearParameters();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return this;
	}
	
/*	Statement의 setXXX 함수들
   // 작업완료
    void setBoolean(int parameterIndex, boolean x) throws SQLException; 
    void setInt(int parameterIndex, int x) throws SQLException; 
    void setString(int parameterIndex, String x) throws SQLException;
    void setTimestamp(int parameterIndex, java.sql.Timestamp x)throws SQLException;
    
    // 보류
    void setByte(int parameterIndex, byte x) throws SQLException;
    void setShort(int parameterIndex, short x) throws SQLException;
    void setLong(int parameterIndex, long x) throws SQLException;
    void setFloat(int parameterIndex, float x) throws SQLException;
    void setDouble(int parameterIndex, double x) throws SQLException;
    void setBigDecimal(int parameterIndex, BigDecimal x) throws SQLException;
    void setBytes(int parameterIndex, byte x[]) throws SQLException;
    void setDate(int parameterIndex, java.sql.Date x) throws SQLException;
    void setTime(int parameterIndex, java.sql.Time x)throws SQLException;
    
*/
	public DBManager setBoolean(boolean v) {
		if(psmt != null) 
		{
			try 
			{
				psmt.setBoolean(orderCount, v);
			}catch(Exception e) {
				e.printStackTrace();
				return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
			}
			orderCount++;
			return this;
		}
		
		return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
	}
	
	public DBManager setInt(int val) {
		if(psmt != null) 
		{
			try 
			{
				psmt.setInt(orderCount, val);
			}catch(Exception e) {
				e.printStackTrace();
				return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
			}
			orderCount++;
			return this;
		}
		
		return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
	}
	
	public DBManager setString(String s) {
		if(psmt != null) 
		{
			try 
			{
				psmt.setString(orderCount, s);
			}catch(Exception e) {
				e.printStackTrace();
				return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
			}
			orderCount++;
			return this;
		}
		
		return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
	}
	
	public DBManager setTimestamp(java.sql.Timestamp ts) {
		if(psmt != null) 
		{
			try 
			{
				psmt.setTimestamp(orderCount, ts);
			}catch(Exception e) {
				e.printStackTrace();
				return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
			}
			orderCount++;
			return this;
		}
		
		return new NullDBManager(); // null 대신 null 객체를 반환해서 크래시를 막는다. ( 객체풀에서 가져올수 있지만 그냥 new로 넘긴다.)
	}
	
	public int update()
	{
		return update(false);
	}
	
	// autoRollback이 true인경우 오류가 나거나 업데이트결과가 0인경우 롤백.
	// 보통 tx는 update에서 필요하므로 update에서 처리한다.
	public int update(boolean autoRollback) 
	{
		int result = 0;
		try 
		{
			if(psmt!=null) {
				result = psmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if(result == 0 && autoRollback) {
			txRollback();
		}
		return result;
	}
	
	public boolean read()
	{
		try {
			if(psmt!=null) {
				if(result != null) {
					result.close();
				}
				result = psmt.executeQuery();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	// util : mysql의 last_insert_id 흉내내기 (향후 오라클/ mysql에 따라 분기할수 있음)
	public int last_insert_id(String tableName, String columnName )
	{
		//sql = "select last_insert_id() as nno from notification"; // DB샘에 알려준 mysql전용방법
		String sql = "SELECT MAX(" + columnName + ") as " +columnName + " FROM "+ tableName; // 담임샘이 알려준 방법. (마지막 넣은 index가져오기. 이번에는 이걸로 써야함.)
		int index = 0;
		if(prepare(sql).read()) {
			if(next()){
				index = getInt(columnName);
			}
		}
		return index; // 0인경우 오류 처리 할것. (실패)
	}
	
	public boolean release()
	{
		try {
			
			if(useTx && !aleadyCommit) {
				// tx를 사용하는데 커밋이나 롤백을 안했다?
				// 롤백이 의도된상황이 아닌것으로 판단되므로 커밋해줌.
				txCommit();
			}
			
			
			if(result != null)
				result.close();
		
			//문맥 객체 닫음
			if(psmt != null) 
				psmt.close();
			
		}catch(Exception e) {
			
			return false;
		}
		return true;
	}
	
	
	// result next() 실행할 메소드
	public boolean next() {
		if(result == null)
			return false;
		
		try {	
			return this.result.next();
		}catch(Exception e) {
			return false;
		}
	}
	// result로부터 값을 받아올 메소드 / int, String 등등
	public String getString(String colName ) {
		try {
			return this.result.getString(colName);
		}catch(Exception e) {
			
			return null;
		}
	}
	public int getInt(String colName ) {
		try {
			return this.result.getInt(colName);
		}catch(Exception e) {
			return 0;
		}
	}
	public boolean getBoolean(String colName) {
		try {
			return this.result.getBoolean(colName);
		}catch(Exception e) {
			return false;
		}
	}
	public java.sql.Timestamp getTimestamp(String colName){
		try {
			return this.result.getTimestamp(colName);
		}catch(Exception e) {
			return null;
		}
	}

	//try-with-resources 로 생성한경우 disconnect호출하지 않아도 됨.
	@Override
	public void close() throws Exception {
		disconnect();
	}
	
}


// null 객체 추가
class NullDBManager extends DBManager {
	
	@Override
	public DBManager prepare(String sql) {
		Log("prepare - null object use");
		return this;
	}
	
	
	@Override
	public DBManager txCommit() {
		Log("txCommit - null object use");
		return this;
	}
	@Override
	public DBManager setBoolean(boolean v) {
		Log("setBoolean - null object use");
		return this;
	}
	@Override
	public DBManager setInt(int val) {
		Log("setInt - null object use");
		return this;
	}
	@Override
	public DBManager setString(String s) {
		Log("setString - null object use");
		return this;
	}
	@Override
	public DBManager setTimestamp(java.sql.Timestamp ts) {
		Log("setTimestamp - null object use");
		return this;
	}
	
	
	private void Log(String msg) {
		System.out.println(msg);
	}
}
