package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AccountsController implements SubController {

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		 if(uris.length < 2) {
			 response.sendRedirect(request.getContextPath());
			 return;
		 }
		 
		 
		 boolean isSuccess = false;
		 
		 switch(uris[1]) 
		 {
		 case "password":
			 isSuccess = password(uris, request, response);
			 break;
		 case "login":
			 isSuccess = login(uris, request, response);
			 break; 
		 case "join":
			 isSuccess = join(uris, request, response);
			 break; 
		 }
		 
		  
		 if(isSuccess == false) {
			 response.sendRedirect(request.getContextPath());
		 }
	}
	
	
	protected boolean password(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 
		if(uris.length == 3 && uris[2].equals("reset"))
		{
		 request.getRequestDispatcher("/login/passwordSearch.jsp").forward(request, response);
		 return true;
		}
		
		return false;
	}
	
	protected boolean login(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(uris.length == 2)
		{
		 request.getRequestDispatcher("/login/loginOk.jsp").forward(request, response);
		 return true;
		}
		
		return false;
	}
	
	protected boolean join(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(uris.length == 2)
		{
		 request.getRequestDispatcher("/login/joinOk.jsp").forward(request, response);
		 return true;
		}
		
		return false;
	}

}