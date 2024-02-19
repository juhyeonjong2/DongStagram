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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CertDAO;
import vo.CertVO;
import vo.MemberVO;


@WebFilter("/*")
public class LoginCheckFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;

	public LoginCheckFilter() {
        super();
    }

	public void destroy() {
	}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 전처리
		HttpServletRequest req = (HttpServletRequest)request;
		HttpSession session = req.getSession();
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		if(member != null) {
			// 로그인 유효시간이 완료 됬는지 확인.
			if(CertDAO.isExpired(member.getMno(),member.getToken()))
			{
				// 로그인 유효시간 완료이후라면 로그아웃 처리후 리다이렉트.
				CertVO cert = CertDAO.getCert(member.getMno(),member.getToken());
				if(cert!=null) {
					CertDAO.removeToken(cert);
				}
				//세션 정리
				session.invalidate();

				// 루트로 보냄
				HttpServletResponse res = (HttpServletResponse)response;
				res.sendRedirect("/");  
				return;
			}
			else {
				// 로그인 유효시간 완료 전이라면 유효시간 갱신.
				CertVO cert = CertDAO.getCert(member.getMno(),member.getToken());
				if(cert!=null) {
					CertDAO.refreshToken(cert);
				}
			}
		}
		
	
		// 처리
		chain.doFilter(request, response);
		// 처리 후에 페이지 404알수 있는데 이상태에선 리다이렉트 못함.

		//여기에 후처리		
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
	
	}

}
