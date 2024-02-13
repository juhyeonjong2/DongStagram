package ezen.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {

	final String ENCODING = "UTF-8";
	final String PORT = "465";
	final String SMTP_HOST = "smtp.gmail.com";
	final String FROM = "ezen";
	final String FROM_NAME = "Dongstagram";
	
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
	
	public boolean sendMail(Session session,  String targetAddress,  String title, String content) {
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
}
