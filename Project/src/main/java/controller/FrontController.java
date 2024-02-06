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

@WebServlet("/*")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FrontController() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		boolean isLogin = false;
		boolean isAdmin = false;
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		if(session != null) {
		
			MemberVO member = (MemberVO)session.getAttribute("login");
			if(member != null) {
				isLogin = !CertDAO.isExpired(member.getMno(), member.getToken());
				isAdmin = CertDAO.isAdmin(member.getMno(), member.getToken());
			}
		}
		
		String command = request.getRequestURI()
 		        .substring(request.getContextPath()
 		        .length()+1);

		String[] uris = command.split("/");
		System.out.println("uris len : " + uris.length);
		for(String uri : uris) {
			System.out.println(uri);
		}
		
		
		// 어떤 페이지가 오든지 login이 안되어 있다면 login 페이지로 이동.
		if(!isLogin) {
			
			
		}
		else {

			/*
			 * String command = request.getRequestURI() .substring(request.getContextPath()
			 * .length()+1);
			 * 
			 * String[] uris = command.split("/");
			 */
			
			// 첫번째 경로가 비어 있다면 (로그인 된 상태이므로 홈으로 간다)
			
			/*
			 * for(String uri : uris) { System.out.println(uri); }
			 */
			
			/*
			 * RequestDispatcher rd= request.getRequestDispatcher("/sample/ex02.jsp");
			 * rd.forward(request, response);
			 */
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		/*
String command = request.getRequestURI()
				 		        .substring(request.getContextPath()
				 		        .length()+1);
		
		String[] uris = command.split("/");
		 * if(uris[0].equals("sample")) { SampleController sampleContoller = new
		 * SampleController(); sampleContoller.doAction(uris,request, response); }else
		 * if(uris[0].equals("board")) { BoardController boardController = new
		 * BoardController(); boardController.doAction(uris, request, response); }
		 */		
		
		// 여기서 허용된 명령만 통과
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		doGet(request, response);
	}

}
