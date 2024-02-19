package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReplyController implements SubController {

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
		 System.out.println("ReplyController::doAction");
		 
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
		 
		 if(uris.length < 2) {
			 response.sendRedirect(request.getContextPath());
			 return;
		 }
		 
		 
		 boolean isSuccess = false;
		 
		 switch(uris[1]) 
		 {
		 case "create":
			 isSuccess = create(uris, request, response);
			 break;
			/*
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
			 */
		 }
		 
		  
		 if(isSuccess == false) {
			 response.sendRedirect(request.getContextPath());
		 }
	
	}
	
	protected boolean create(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(uris.length == 2)
		{
		 request.getRequestDispatcher("/board/replyWriteOk.jsp").forward(request, response);
		 return true;
		}
		
		return false;
	}

}