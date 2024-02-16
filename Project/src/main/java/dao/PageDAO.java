package dao;

import java.util.ArrayList;
import java.util.List;

import ezen.db.DBManager;
import vo.BoardAttachVO;
import vo.MemberVO;
import vo.PageVO;

public class PageDAO {

	public static PageVO findOne(int bno) {
		
		PageVO vo  = null; 
		try(DBManager db = new DBManager();)
		{
			if(db.connect())
			{	
				 String sql = "SELECT m.mnick FROM board as b  inner join member as m on b.mno = m.mno where b.bno = ?";
				 if( db.prepare(sql).setInt(bno).read())
				 {
						if(db.next()){ //next로 차근차근 전부 가져온다.
							vo = new PageVO(); //값을 넣기위한 생성자
							vo.setNick(db.getString("mnick")); //vo안에 닉네임을 집어넣는다.
					 }
				 }
				 
				
				
				// 이미지는 while문 써야해서 일단 두개로 나눔
				 sql = "SELECT bfrealname FROM boardAttach WHERE bno=?";	//보드를 메인으로 다른거 조인
				 if( db.prepare(sql).setInt(bno).read())
				 {
						while(db.next()){ //next로 차근차근 전부 가져온다.
							BoardAttachVO attach = new BoardAttachVO(); 
							attach.setBfrealname(db.getString("bfrealname"));
							vo.imglist.add(attach);
						}
				 }
				 
				 
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo; 
	}
	
	
	
}
