package vo;

public class BoardVO {
	private int bno; //글번호
	private int mno; //회원번호
	private int bhit; //조회수
	private String shorturi; //짧은 경로 인데 어디에 쓰는지 잘 모르겠다.
	private String wdate; //작성일
	private int bfavorite; //좋아요 수
	
	//전 프로젝트에는 생성자도 있었지만 아마 글 보기에 사용되는거 같아 일단 안 만듬 만약 필요하면 그때 만드는 작업 필요
	
	
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