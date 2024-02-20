package vo;

public class BoardVO {
	private int bno; //글번호
	private int mno; //회원번호
	private int bhit; //조회수
	private String shorturi; //짧은 경로 인데 어디에 쓰는지 잘 모르겠다.
	private String wdate; //작성일
	private int bfavorite; //좋아요 수
	private int cdate; //접속날짜-작성날짜 
	private int rcnt; //댓글 수
	
	
	public int getRcnt() {
		return rcnt;
	}
	public void setRcnt(int rcnt) {
		this.rcnt = rcnt;
	}
	public int getCdate() {
		return cdate;
	}
	public void setCdate(int cdate) {
		this.cdate = cdate;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getBhit() {
		return bhit;
	}
	public void setBhit(int bhit) {
		this.bhit = bhit;
	}
	public String getShorturi() {
		return shorturi;
	}
	public void setShorturi(String shorturi) {
		this.shorturi = shorturi;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getBfavorite() {
		return bfavorite;
	}
	public void setBfavorite(int bfavorite) {
		this.bfavorite = bfavorite;
	}
	
	
}
