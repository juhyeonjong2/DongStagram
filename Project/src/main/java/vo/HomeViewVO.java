package vo;

import java.util.ArrayList;

public class HomeViewVO extends BoardVO {
	// member 정보
	String profileImage;    // 프로필 사진
	String nick; 				   // 닉네임
	String mfavorite;     //호출자가 좋아요를 설정했는지.

	ReplyVO rootReply;     // 글 내용 (idx == 0)
	
	
	// 미디어 리스트.
	ArrayList<BoardAttachVO> mediaList = new ArrayList<BoardAttachVO>();
	
	// 리플레이
	ArrayList<ReplyVO> replyList = new ArrayList<ReplyVO>();

	public String getMfavorite() {
		return mfavorite;
	}

	public void setMfavorite(String mfavorite) {
		this.mfavorite = mfavorite;
	}
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

	public ArrayList<BoardAttachVO> getMediaList() {
		return mediaList;
	}

	public void setMediaList(ArrayList<BoardAttachVO> mediaList) {
		this.mediaList = mediaList;
	}

	public ArrayList<ReplyVO> getReplyList() {
		return replyList;
	}

	public void setReplyList(ArrayList<ReplyVO> replyList) {
		this.replyList = replyList;
	}

	public ReplyVO getRootReply() {
		return rootReply;
	}

	public void setRootReply(ReplyVO rootReply) {
		this.rootReply = rootReply;
	}

}
