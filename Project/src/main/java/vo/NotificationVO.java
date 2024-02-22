package vo;


public class NotificationVO {
	
	private int nno;
	private String type;
	private String state;
	private String nick;
	private int targetmno; // 이건 안보내도됨. 검색용
	public int getTargetmno() {
		return targetmno;
	}
	public void setTargetmno(int targetmno) {
		this.targetmno = targetmno;
	}
	private String rdate;
	private boolean followState; // false:팔로우상태 아님, true: 팔로우 상태
	private String profileImage;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	
	public boolean isFollowState() {
		return followState;
	}
	public void setFollowState(boolean followState) {
		this.followState = followState;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public int getNno() {
		return nno;
	}
	public void setNno(int nno) {
		this.nno = nno;
	}
	
	
}
