package vo;

import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class PageVO extends BoardVO{
	



	// ArrayList<BoardViewVO> imglist = new ArrayList<BoardViewVO>();
	
	// ArrayList<ReplyVO> replylist = new ArrayList<ReplyVO>();
	
	private String realname;
	private String nick;
	
	
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	

}
