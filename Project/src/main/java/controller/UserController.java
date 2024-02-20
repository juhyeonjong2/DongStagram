package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.MemberVO;

public class UserController implements SubController {
	

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
		System.out.println("UserController::doAction");
		 
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
		 
		 boolean isSuccess = user(uris, request, response);
		 
	 
		 if(isSuccess == false) {
			 response.sendRedirect(request.getContextPath());
		 }

	}
	
	protected boolean user(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인한 세션 가져옴
		// 상속 boxing unboxing
		//session.getAttribute("login"); = request.getSession().getAttribute("login");
		MemberVO member = (MemberVO)request.getSession().getAttribute("login");
		// 위 세션을 통해 클릭해온 닉네임과 세션의 닉네임이 같은지 비교 후 같다면 내 프로필 아니라면 타인의 프로필에?해서mno보내기
		
		if(uris.length == 2)
		{
			// 닉네임이랑 로그인한 사람의 닉네임이 같은 경우 마이페이지로 아니면 타인의 페이지로 마이페이지나 타인이나 mno를 보내야해
			if(uris[1].equals(member.getMnick())) {
				 request.getRequestDispatcher("/member/profile.jsp?mno="+member.getMno()).forward(request, response);
				 return true;
			}else { // 타인 프로필 페이지 구현 시 수정
				 request.getRequestDispatcher("/member/anotherProfile.jsp?mnick="+uris[1]).forward(request, response);
				 return true;
			}
		}
		
		return false;
	}
	
	
	
	

}