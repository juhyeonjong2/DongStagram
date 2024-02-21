package vo;

public class ProfileVO {
	
	private String realFileName; //서버에 저장된 파일명 (경로에 사용)
	private String intro; // 내 소개 
	private int gender; // 내 성별 번호
	
	public String getRealFileName() {
		return realFileName;
	}
	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	
}
