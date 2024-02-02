package ezen.db;

public class DBTest {

	
	public void read() {
		
		DBManager db = new DBManager();
		if(db.connect()) {
			String sql = "SELECT * FROM board";
			
			if(db.prepare(sql).read()) {
				
				if(db.next()) {
					int bno = db.getInt("bno");
					String title = db.getString("btitle");
					String contents = db.getString("bcontent");
					String rdate = db.getString("rdate");
				}
			}
			
			db.disconnect();
		}
	}
	
	public void insert() {
		
		String title = "testTitle";
		String content = "testContent";
		
		DBManager db = new DBManager();
		if(db.connect()) {
			String sql = "INSERT INTO board (btitle, bcontent, rdate) VALUES(?, ?, now())";
			
			int result = db.prepare(sql)
						  .setString(title)
						  .setString(content)
						  .update();
			
			if(result > 0) {
				// 업데이트 결과
			}
			
			db.disconnect();
		}
	}
	
	public void multiInsertAutoRollback() {
		
		
		String title = "testTitle";
		String content = "testContent";
		
		String realName ="realname";
		String foriginName = "foriginname";
		
		
		DBManager db = new DBManager();
		if(db.connect(true)) // connect에 true를 줘서  
		{
			boolean isSuccess = true;
			
			String sql = "INSERT INTO board (btitle, bcontent, rdate, bhit, mno, delyn) VALUES (?, ?, now(), 222, 2, 'n') ";
			
			// update시에 true를 준경우 update에 결과값이 0이면 rollback을 자동으로 수행한다.
			if(db.prepare(sql).setString(title).setString(content).update(true) <= 0){
				isSuccess = false;
			}
			
			// 업데이트에 성공했다면 다음 작업 수행
			if(isSuccess) {
				
				int bno = db.last_insert_id("bno", "board"); // insert한 마지막 인덱스 가져오기
				if(bno != 0) { // 0이 아닌경우 가져오기 성공
					
					sql = "INSERT INTO boardfile(bno, bfrealnm, bforiginnm, rdate) VALUES(?, ?, ?, now())";
					if(db.prepare(sql)
						 .setInt(bno)
						 .setString(realName)
						 .setString(foriginName)
						 .update(true) <= 0) {
						
						isSuccess = false;
					}
				}
			}
			
			// 모두 성공인경우
			if(isSuccess) {
				db.txCommit(); // 커밋.
			}
			
			db.disconnect(); // disconnect에서 autocommit을 기존값으로 되돌려놓음. (disconnect는 반드시 해야함)
		}
	}
	
	public void multiInsertManualRollback() {
		
		
		String title = "testTitle";
		String content = "testContent";
		
		String realName ="realname";
		String foriginName = "foriginname";
		
		
		DBManager db = new DBManager();
		if(db.connect(true)) // connect에 true를 줘서  
		{
			boolean isSuccess = true;
			
			String sql = "INSERT INTO board (btitle, bcontent, rdate, bhit, mno, delyn) VALUES (?, ?, now(), 222, 2, 'n') ";
			
			// update시에 true를 준경우 update에 결과값이 0이면 rollback을 자동으로 수행한다.
			if(db.prepare(sql).setString(title).setString(content).update() <= 0){
				isSuccess = false;
			}
			
			int bno = db.last_insert_id("bno", "board"); // insert한 마지막 인덱스 가져오기
			if(bno != 0) { // 0이 아닌경우 가져오기 성공
				
				sql = "INSERT INTO boardfile(bno, bfrealnm, bforiginnm, rdate) VALUES(?, ?, ?, now())";
				if(db.prepare(sql)
					 .setInt(bno)
					 .setString(realName)
					 .setString(foriginName)
					 .update() <= 0) {
					
					isSuccess = false;
				}
			}
			
			// 모두 성공인경우
			if(isSuccess) {
				db.txCommit(); // 커밋.
			}
			else {
				db.txRollback(); // 최종 확인후 수동으로 롤백해도 되고 중간에 롤백하고 disconnect해도 상관없음.
			}
			
			db.disconnect(); // disconnect에서 autocommit을 기존값으로 되돌려놓음. (disconnect는 반드시 해야함)
	}
}
