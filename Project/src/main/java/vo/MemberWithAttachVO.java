package vo;

public class MemberWithAttachVO extends MemberVO{
	// 파일정보추가
	private int mfno;
	private String mfrealname;
	private String mforeignname;
	private String rdate;
	public int getMfno() {
		return mfno;
	}
	public void setMfno(int mfno) {
		this.mfno = mfno;
	}
	public String getMfrealname() {
		return mfrealname;
	}
	public void setMfrealname(String mfrealname) {
		this.mfrealname = mfrealname;
	}
	public String getMforeignname() {
		return mforeignname;
	}
	public void setMforeignname(String mforeignname) {
		this.mforeignname = mforeignname;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	
	
}
