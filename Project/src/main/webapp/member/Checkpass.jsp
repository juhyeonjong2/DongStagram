<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO"%>
<%@ page import="ezen.db.DBManager"%>

<%
String pass = request.getParameter("pass");
//1. session 에서 로그인한 회원 mno 가져오기

//2. 현재 비밀번호 암호와 방식 파악하기 (비교하기 위해서 sql 비교를 하는지 java 코드로 비교하는지)
//3. 파악한 방식을 통하여 pass 변수의 값과 로그인한 회원의 mno와 일치하는 비밀번호 데이터가 일치하는지 확인하고
//4. 일치하면 응답데이터로 SUCCESS 넘기기 불일치하면 FAIL 넘기기

MemberVO member = (MemberVO) session.getAttribute("login");

try (DBManager db = new DBManager();) {
	if (db.connect()) {
		/*// 원본
		  String sql = "SELECT mno, mid, email, mnick, mname, joindate FROM member " 
		   + " WHERE mid=? AND mpassword= md5(?) AND (delyn is null or delyn = 'n') ";
		 */

		// 임시비밀번호 포함으로 변경
		String sql = "SELECT count(*) as cnt " + "FROM member as M " + " WHERE M.mpassword= md5(?) AND M.mno = ? ";
		//System.out.println(sql);
		int cnt = 0;
		if (db.prepare(sql).setString(pass).setInt(member.getMno()).read()) {
			if (db.next()) {
				cnt = db.getInt("cnt");
			}
		}

		if (cnt > 0) {
			out.print("SUCCESS");
		} else {
			out.print("FAIL");
		}
	} else {
		out.print("FAIL");
	}
} catch (Exception e) {
	//e.printStackTrace();
	out.print("FAIL");
}
%>