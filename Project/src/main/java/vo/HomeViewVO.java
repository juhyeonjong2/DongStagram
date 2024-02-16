package vo;

import java.util.ArrayList;

public class HomeViewVO extends BoardVO {
	// member 정보
	String profileImage;    // 프로필 사진
	String nick; 				   // 닉네임
	
	// 리플레이
	ArrayList<String> mediaList = new ArrayList<String>();
	
	// 미디어 리스트.
	ArrayList<ReplyVO> replyList = new ArrayList<ReplyVO>();

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public ArrayList<String> getMediaList() {
		return mediaList;
	}

	public void setMediaList(ArrayList<String> mediaList) {
		this.mediaList = mediaList;
	}

	public ArrayList<ReplyVO> getReplyList() {
		return replyList;
	}

	public void setReplyList(ArrayList<ReplyVO> replyList) {
		this.replyList = replyList;
	}

}
