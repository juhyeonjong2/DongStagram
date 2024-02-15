package ezen.thread;

import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

// 참고 : https://blog.naver.com/devstory/130035779193
public class ThreadPool extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static ScheduledExecutorService executor;
	
    public ThreadPool() {
        super();
      
    }

	
	@Override
	public void destroy() {
		
		super.destroy();
		
		 try 
		 {
		   executor.shutdownNow();
		   executor.awaitTermination(5000, TimeUnit.MILLISECONDS);

		   if (!executor.isTerminated()) {
			   //log.info("Force shut down the thread.");
			   System.out.println("Force shut down the thread.");
		   }
		 } 
		 catch (InterruptedException ie) {
			 // log.debug(ie.getMessage());
			 System.out.println(ie.getMessage());
		  }
	}


	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		
		int threadPoolQuantity = 5;
		// 쓰레드 풀 생성
		executor = new ScheduledThreadPoolExecutor(threadPoolQuantity);
	}
	
	public static void execute(Runnable command) {
		  // Runnable 인터페이스를 구현한 클래스를 실행
		  executor.execute(command);
	}
	
	// 일정 주기마다 한번씩 실행시켜주는 기능 
	public static void scheduleAtFixedRate(Runnable command, long initialDelay, long period){
		// initialDelay 이후 (단위 : 초)
		// period 마다 한번씩 호출됨  (단위 : 초)
		executor.scheduleAtFixedRate(command, initialDelay, period,TimeUnit.SECONDS);
	}
	
}
