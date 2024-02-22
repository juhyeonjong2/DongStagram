package vo;

// 데이터로 보내질걸 고려한 정의
public class UserReportVO {
	private int mno; // 신고당한 user mno (없어도 될수 있지만 넣음)
	private int count ; // 신고당한 횟수.
	private String profileImage;
	private String nick;
	private String name;
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
