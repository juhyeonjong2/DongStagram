package vo;

public class FollowVO {
	private int mno;
	private String nick;
	private String profileImage;
	private int followState; // -1: 본인, 0:팔로우상태 아님, 1: 팔로우 상태
	
	public int getFollowState() {
		return followState;
	}
	public void setFollowState(int followState) {
		this.followState = followState;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	
	
	
}
