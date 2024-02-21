package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PageController implements SubController {

	@Override
	public void doAction(String[] uris, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 //System.out.println("PageController::doAction");
		 /*
		 for(String uri : uris) { 
			 System.out.println(uri); 
		 }
		 */
		
		// 이 컨트롤러의 역할은 /Dongstagram/page/[base62endcodingUrl] 값을 실제 페이지로 이동시켜 주기 위해 작성하였으나
		// 팝업으로 처리해서(아작스를 통해 데이터통신) 필요가 없어졌다.
	}

}
