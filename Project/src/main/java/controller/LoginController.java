package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class LoginController implements SubController {
	
	
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		 
		System.out.println("LoginController::doAction");
		  
		 
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
		
		// etc
		 
		 // 처리할수 없으면
		 
		 String fullPath ="";
		 for(String uri : uris) { 
			 fullPath += "/" + uri;
		 }
		 System.out.println(fullPath); 
	//	 request.getRequestDispatcher(fullPath).forward(request, response);
		 
		 request.getRequestDispatcher("/login/login.jsp").forward(request, response);
		
		
	}
	
}
