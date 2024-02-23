package vo;

public class ReplyVO {
	private int rno; //댓글 번호
	private int ridx; // 관리인덱스
	private int rpno; // 부모댓글
	private String rdate; //작성일
	private String mdate; //수정일 (ws comment - db에 rmdate로 들어가있음 mdate가 맞는것. db 수정이 필요하나 시간없으니 그냥 진행할 것)
	private String rname; //작성자 닉네임 (ws comment - nick name은 nick으로쓰기로 하였음. rname -> rnick으로 변경 필요)
	private int mno; // 회원번호
	private int bno; // 글 번호
	private String rcontent; //글 내용
	private int pdate; //접속날짜-작성날짜
	private String profile; //프로필
	
	
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public int getPdate() {
		return pdate;
	}
	public void setPdate(int pdate) {
		this.pdate = pdate;
	}
	public String getRcontent() {
		// 개행문자를 <br>로 변경해서 리턴
		return rcontent.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getRidx() {
		return ridx;
	}
	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public int getRpno() {
		return rpno;
	}
	public void setRpno(int rpno) {
		this.rpno = rpno;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
}
