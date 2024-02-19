package vo;

public class BoardAttachVO {
	private int mfno; //미디어 파일 번호 (ws comment - 이름이 이상하게 들어갔는데 그냥 사용할 것 -원래이름 bfno)
	private int bfidx; // 파일 관리 번호 0 - 썸네일 1-5 그 외 상 이미지;
	private int bno; //외래키 값
	private String bfrealname; //파일의 실제 이름
	private String bforeignname; //파일이 외부 이름
	private String rdate; //작성일
	
	public int getMfno() {
		return mfno;
	}
	public void setMfno(int mfno) {
		this.mfno = mfno;
	}
	public int getBfidx() {
		return bfidx;
	}
	public void setBfidx(int bfidx) {
		this.bfidx = bfidx;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getBfrealname() {
		return bfrealname;
	}
	public void setBfrealname(String bfrealname) {
		this.bfrealname = bfrealname;
	}
	public String getBforeignname() {
		return bforeignname;
	}
	public void setBforeignname(String bforeignname) {
		this.bforeignname = bforeignname;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	
	

}
