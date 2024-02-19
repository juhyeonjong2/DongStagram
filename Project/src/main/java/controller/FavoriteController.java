package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FavoriteController implements SubController {

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
		 System.out.println("FavoriteController::doAction");
		 
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
		 case "touch":
			 isSuccess = touch(uris, request, response);
			 break;
		
		 }
		 
		  
		 if(isSuccess == false) {
			 response.sendRedirect(request.getContextPath());
		 }
	
	}
	
	protected boolean touch(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(uris.length == 2)
		{
		 request.getRequestDispatcher("/board/favoriteOk.jsp").forward(request, response);
		 return true;
		}
		
		return false;
	}

}