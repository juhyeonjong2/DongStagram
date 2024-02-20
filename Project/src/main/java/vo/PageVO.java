package vo;

import java.util.ArrayList;

public class PageVO extends BoardVO{
	
	
	 // 닉네임 받아올 리스트(Arraylist로 만든 이유는 저 vo에 여러가지 값을 넣기 위해서인듯) 퍼블릭이라 가져와지는거인듯
	 private String nick = new String(); //new String(); 유무 공부 null
	 
	 public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}
	

	// 이미지 받아올 리스트
	 public ArrayList<BoardAttachVO> imglist = new ArrayList<BoardAttachVO>();

	 // 글 작성시 쓴 글을 받아올 리스트
	 public ArrayList<ReplyVO> rootReply = new ArrayList<ReplyVO>();

	// 댓글 받아올 리스트
	 public ArrayList<ReplyVO> replylist = new ArrayList<ReplyVO>();
	 
	 
	 
	 
	
}
