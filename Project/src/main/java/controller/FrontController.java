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
@WebServlet(urlPatterns = { "/p/", "/login/*", "/direct/", "/user/" })
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FrontController() {

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("FrontController");
		
		 String command = request.getRequestURI().substring(request.getContextPath().length()+1);
		 String[] uris = command.split("/"); 
		 System.out.println("uris len : " + uris.length); 
		 
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
		
		 // 모든조건을 검사한뒤 안맞으면 루트로보냄
		 String mainPath =uris[0];
		 switch(mainPath) {
		 case "p":
			 break;
		 case "login":
			 	LoginController sampleContoller = new LoginController();
			 	sampleContoller.doAction(uris,request, response);
			 break;
		 case "direct":
			 break;
		 case "user":
			 break;
		 
		 	default:
		 		response.sendRedirect(request.getContextPath());
		 }

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
