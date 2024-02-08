package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DirectController implements SubController {

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
		System.out.println("DirectController::doAction");
		 
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
	   // 다이렉트 컨트롤러는 uri[2]가 존재할수 있음.
	}

}