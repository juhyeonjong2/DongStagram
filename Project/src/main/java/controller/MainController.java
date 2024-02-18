package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CertDAO;
import vo.MemberVO;

// /nick 검색을 포기
// /user/nick 으로 검색할 것.
// "/" 디폴트 서블릿을 매핑하는경우 tomcat이 처리하는 디폴트 서블릿을 재정의하게되서. css나 js의 경로를 찾을수 없게됨
// 따라서 패턴으로 매칭해서 디폴트 서블릿을 오버라이딩 하지 않아야함.
// (참고 : https://devpanda.tistory.com/95)
//@WebServlet("/")
@WebServlet(urlPatterns = { "/page/*", "/direct/*", "/user/*", "/accounts/*", "/reply/*", "/explore" }) // 가상경로만 여기에 넣기. 실제 경로는 이
																							// 가상경로를 포함하면 안됨. (무한루프걸림)
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MainController() {

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// System.out.println("FrontController");

		String command = request.getRequestURI().substring(request.getContextPath().length() + 1);
		String[] uris = command.split("/");

		/*
		  System.out.println("uris len : " + uris.length); 
		  for(String uri : uris) {
			  System.out.println(uri); 
		  }
		 */

		// 모든조건을 검사한뒤 안맞으면 루트로보냄
		String mainPath = uris[0];
		switch (mainPath) {
		case "page": // 실제 경로 board/view.jsp
			PageController pageContoller = new PageController();
			pageContoller.doAction(uris, request, response);
			break;
		case "direct": // 실제경로 message/*
			DirectController directContoller = new DirectController();
			directContoller.doAction(uris, request, response);
			break;
		case "user": // 유저의 프로필 페이지로 이동. (실제경로 member/profile.jsp)
			UserController userContoller = new UserController();
			userContoller.doAction(uris, request, response);
			break;
		case "accounts": // 유저의 프로필 페이지로 이동. (실제경로 member/profile.jsp)
			AccountsController accountsContoller = new AccountsController();
			accountsContoller.doAction(uris, request, response);
			break;
		case "reply": // 댓글. (실제경로 board/reply.jsp)
			ReplyController replyContoller = new ReplyController();
			replyContoller.doAction(uris, request, response);
			break;
		case "explore": // 유저의 프로필 페이지로 이동. (실제경로 member/profile.jsp)
			// UserController userContoller = new UserController();
			// userContoller.doAction(uris, request, response);
			break;

		default: // 그외에 모든 경로는 루트로 리다이렉트 시킴(홈 or 로그인페이지)
			response.sendRedirect(request.getContextPath());
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
