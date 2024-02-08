package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PageController implements SubController {

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		 
		System.out.println("PageController::doAction");
		  
		 
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
		
		// etc
		 
		 // 두번째 uri[1] 데이터를 가지고 page를 찾음. 그거보다 더길면 오류. (uri [2]가 있으면 오류임)
		 
	//	 request.getRequestDispatcher(fullPath).forward(request, response);
		 
		 //request.getRequestDispatcher("/login/login.jsp").forward(request, response);
		
	}

}
