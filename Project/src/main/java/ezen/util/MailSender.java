package ezen.util;

import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender implements Runnable {
	final boolean useLog = false; // false 처리하면 로그안나옴
	
	final String ENCODING = "UTF-8";
	final String PORT = "465";
	final String SMTP_HOST = "smtp.gmail.com";
	final String FROM = "ezen";
	final String FROM_NAME = "Dongstagram";
	
	
	private String userName;
	private String password;
	private String title;
	private String content;
	private ArrayList<String> toList = new ArrayList<String>();
	
	public MailSender() {
		
	}
	
	public MailSender(String userName, String password) {
		this.userName = userName;
		this.password = password;
	}
	
	public MailSender setTitle(String title) {
	
		this.title = title;
		return this;
	}
	
	public MailSender setContent(String content) {
		
		this.content = content;
		return this;
	}
	
	public MailSender setTo(String email) {
		toList.clear();
		toList.add(email);
		return this;
	}
	
	public MailSender addTo(String email) {
		toList.add(email);
		return this;
	}
	
	
	public Session createSession(String userName, String pass) {		
		return createSession(new Properties(), userName, pass );
	}
	
	public Session createSession(Properties props, String userName, String pass) {
		Session session = null;
		try {
			props.put("mail.tarnsport.protocol",  "smtp");
			
			props.put("mail.smtp.host",  SMTP_HOST);
			props.put("mail.smtp.port",  PORT);
			props.put("mail.smtp.auth",  true);
			props.put("mail.smtp.ssl.enable", true);
			props.put("mail.smtp.ssl.trust",  SMTP_HOST);
			props.put("mail.smtp.starttls.required", true);
			props.put("mail.smtp.starttls.enable",  true);
			props.put("mail.smtp.ssl.protocols",  "TLSv1.2");
			
			props.put("mail.smtp.quit-wait",  "false");
			props.put("mail.smtp.socketFactory.port", PORT);
			props.put("mail.smtp.socketFactory.class",  "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback",  "false");
			
			session = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(userName, pass);
				}
			});
						
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return session;
	}
	
	public boolean send(Session session,  String targetAddress,  String title, String content) {
		Message msg = new MimeMessage(session);
		try {
			
			msg.setFrom(new InternetAddress(FROM,FROM_NAME, ENCODING));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(targetAddress));
			msg.setSubject(title);
			msg.setContent(content, "text/html; charset=utf-8");
			
			Transport.send(msg);
			return true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean send(Session session, String title, String content) {
		Message msg = new MimeMessage(session);
		try {
			
			msg.setFrom(new InternetAddress(FROM,FROM_NAME, ENCODING));
			for(String to : toList) {
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			}
			msg.setSubject(title);
			msg.setContent(content, "text/html; charset=utf-8");
			
			Transport.send(msg);
			return true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public void run() {

		// 1. 세션 생성
		Session session = createSession(userName,password);
		
		// 인서트 성공시 메일로 발송
		boolean isSuccess = send(session, title, content);
		sendLog(isSuccess);
	}
	
	private void sendLog(boolean isSuccess)
	{
		if(!useLog) 
			return;
		
		System.out.println("[MailSender]"); 
		System.out.println("From : " + userName);
		
		StringBuffer sb = new StringBuffer();
		for(String to : toList)
		{
			sb.append(to + ", ");
		}
		System.out.println("To : " + sb.toString());
		System.out.println("Send : " + isSuccess);
	}
}
