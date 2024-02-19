package vo;

import ezen.util.TypeChecker;

public class MemberVO {
	private int mno;
	private String mid;
	private String mname;
	private String mnick;
	private String email;
	private int mlevel;
	private String joindate;
	private String delyn;
	private String mpassword;
	private String token; // 로그인시 넣어주는 인증 토큰
	
	
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMnick() {
		return mnick;
	}
	public void setMnick(String mnick) {
		this.mnick = mnick;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getMlevel() {
		return mlevel;
	}
	public void setMlevel(int mlevel) {
		this.mlevel = mlevel;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public String getMpassword() {
		return mpassword;
	}
	public void setMpassword(String mpassword) {
		this.mpassword = mpassword;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	
	
	
	@Override
	public String toString() {
		return "mno(" + mno + "), mid(" +mid+ "), mname(" +mname+ "), mnick("+mnick+"), email(" + email+"), " +
	           "mlevel(" +mlevel+"), joindate(" +joindate+"), delyn(" + delyn+"), mpassword(" + mpassword+"), token(" + token+")";		
	}
	
	public boolean isValid() {
		// 이함수로 데이터의 이상 유무를 검사한다.
		
		// checkID
		if(!TypeChecker.isValidId(mid)) {
			System.out.println("TypeChecker.isValidId");
			return false;
		}
		// checkPassword
		if(!TypeChecker.isValidPassword(mpassword)) {
			System.out.println("TypeChecker.isValidPassword");
			return false;
		}
		// checkName
		if(!TypeChecker.isValidName(mname)) {
			System.out.println("TypeChecker.isValidName");
			return false;
		}
		
		// checkNick
		if(!TypeChecker.isValidNick(mnick))  {
			System.out.println("TypeChecker.isValidNick");
			return false;
		}
		
		// checkEmail
		if(!TypeChecker.isValidEmail(email)) {
			System.out.println("TypeChecker.isValidEmail");
			return false;
		}
		
		
		return true;
	}
	
}
