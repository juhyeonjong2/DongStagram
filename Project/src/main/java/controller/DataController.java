package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DataController implements SubController {

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
		 //System.out.println("DataController::doAction");
		 /*
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
		 */
		
		 if(uris.length < 2) {
			 response.sendRedirect(request.getContextPath());
			 return;
		 }
		 
		 
		 boolean isSuccess = false;
		 
		 switch(uris[1]) 
		 {
		 case "home":
			 isSuccess = home(uris, request, response);
			 break;
		 case "favorite":
			 isSuccess = favorite(uris, request, response);
			 break;
		 case "reply":
			 isSuccess = reply(uris, request, response);
			 break;
		 case "search":
			 isSuccess = search(uris, request, response);
			 break;
		 case "remove":
			 isSuccess = remove(uris, request, response);
			 break;
		 case "add":
			 isSuccess = add(uris, request, response);
			 break;
			 
		 }
		 
		 if(isSuccess == false) {
			 response.sendRedirect(request.getContextPath());
		 }
	
	}
	
	protected boolean home(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length < 3)
		{
			return false;
		}
		
		boolean isSuccess = false;
		switch(uris[2]) {
		case "views": // /Dongstagram/data/home/views
			request.getRequestDispatcher("/member/homeOk.jsp").forward(request, response);
			isSuccess = true;
			break;
		
		}
		
		return isSuccess;
	}

	protected boolean favorite(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(uris.length < 3)
		{
			return false;
		}
		
		boolean isSuccess = false;
		switch(uris[2]) {
		case "toggle": // /Dongstagram/data/favorite/toggle
			request.getRequestDispatcher("/board/favoriteOk.jsp").forward(request, response);
			isSuccess = true;
			break;
		
		}
		
		return isSuccess;
	}
	
	protected boolean reply(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length < 3)
		{
			return false;
		}
		
		boolean isSuccess = false;
		switch(uris[2]) {
		case "hot": // /Dongstagram/data/reply/hot
			request.getRequestDispatcher("/board/hotReplyOk.jsp").forward(request, response);
			isSuccess = true;
			break;
		
		}
		return isSuccess;
	}
	
	protected boolean search(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length < 3)
		{
			return false;
		}
		
		boolean isSuccess = false;
		switch(uris[2]) {
		case "content": // /Dongstagram/data/search/content
			request.getRequestDispatcher("/content/searchOk.jsp").forward(request, response);
			isSuccess = true;
			break;
		case "history": // /Dongstagram/data/search/history/
			request.getRequestDispatcher("/content/searchHistoryOk.jsp").forward(request, response);
			isSuccess = true;
			break;
		
		}
		return isSuccess;
	}
	
	protected boolean remove(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length < 3)
		{
			return false;
		}
		
		boolean isSuccess = false;
		switch(uris[2]) {
		case "history": // /Dongstagram/data/remove/history
			request.getRequestDispatcher("/content/searchHistoryRemoveOk.jsp").forward(request, response);
			isSuccess = true;
			break;
		
		}
		return isSuccess;
	}
	
	protected boolean add(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(uris.length < 3)
		{
			return false;
		}
		
		boolean isSuccess = false;
		switch(uris[2]) {
		case "history": // /Dongstagram/data/add/history
			request.getRequestDispatcher("/content/searchHistoryAddOk.jsp").forward(request, response);
			isSuccess = true;
			break;
		
		}
		return isSuccess;
	}

}