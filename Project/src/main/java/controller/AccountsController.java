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
		 case "logout":
			 isSuccess = logout(uris, request, response);
			 break;
		 case "duplicate":
			 isSuccess = duplicate(uris, request, response);
			 break;
		 case "cert":
			 isSuccess = cert(uris, request, response);
			 break;
		
		 }
		 
		  
		 if(isSuccess == false) {
			 response.sendRedirect(request.getContextPath());
		 }
	}
	
	
	protected boolean password(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length == 3 && uris[2].equals("reset"))
		{
			String method = request.getMethod();
			if(method.equals("GET"))
			{
				request.getRequestDispatcher("/login/passwordSearch.jsp").forward(request, response);
			}
			else {
				request.getRequestDispatcher("/login/passwordSearchOk.jsp").forward(request, response);
				
			}
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
	
	protected boolean logout(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(uris.length == 2)
		{
		 request.getRequestDispatcher("/login/logout.jsp").forward(request, response);
		 return true;
		}
		
		return false;
	}
	
	protected boolean duplicate(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length != 3)
		{
			return true; // 아무 동작도 안함.
		}
		
		String method = request.getMethod();
		if(!method.equals("POST")) // POST가 아니면 아무것도 안함.
		{
			return true; 
		}
		
		if(uris[2].equals("id"))
		{
			request.getRequestDispatcher("/login/checkIdOk.jsp").forward(request, response);
		}
		else if(uris[2].equals("nick"))
		{
			request.getRequestDispatcher("/login/checkNickOk.jsp").forward(request, response);
		}
		else {
			return false;
		}
		
		return true;
	}
	
		protected boolean cert(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length != 3)
		{
			return false;
		}
		
		String method = request.getMethod();
		boolean isPost = method.equals("POST");
		
		
		if(uris[2].equals("email"))
		{
			if(isPost) {
				request.getRequestDispatcher("/login/certEmailOk.jsp").forward(request, response);
			}
			else { // get
				request.getRequestDispatcher("/login/certEmail.jsp").forward(request, response);
			}
			return true;
		}
		
		return false;
	}

}