package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class CharacterEncodingFilter extends HttpFilter implements Filter {
       
   
	private static final long serialVersionUID = 1L;

	
    public CharacterEncodingFilter() {
        super();
       
    }

	
	public void destroy() {
	
	}


	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		
		// 전처리
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
	
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		System.out.println("PageNotFoundFilter:doFilter() 전...." + "status :" + httpResponse.getStatus());
		
		// 처리
		chain.doFilter(request, response);
		// 처리 후에 페이지 404알수 있는데 이상태에선 리다이렉트 못함.
		  

		//여기에 후처리
		System.out.println("PageNotFoundFilter:doFilter() 후...." + "status :" + httpResponse.getStatus());
		 
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
