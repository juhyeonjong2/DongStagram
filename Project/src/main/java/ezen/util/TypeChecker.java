package ezen.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

// 각종 형식 테스트기 (ex 이메일 형식 검사)
public class TypeChecker {

	public static boolean isValidEmail(String email) {
		//출처: https://solbel.tistory.com/309 [개발자의 끄적끄적:티스토리]
		boolean err = false;
		String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";   
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(email);
		if(m.matches()){
			err = true; 
		}
		return err;
	}
	
	public static boolean isValidId(String id) {
		// 출처 : https://moonong.tistory.com/31
		boolean err = false;
		String regex = "^[a-zA-Z0-9]*$";   
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(id);
		if(m.matches()){
			err = true; 
		}
		return err;
	}
	
	public static boolean isValidNick(String id) {
		boolean err = false;
		String regex = "^[a-zA-Z0-9]*$";   
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(id);
		if(m.matches()){
			err = true; 
		}
		return err;
	}
	
	public static boolean isValidNumber(String number) {
		boolean err = false;
		String regex = "^[0-9]*$";   
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(number);
		if(m.matches()){
			err = true; 
		}
		return err;
	}
	
	public static boolean isValidPassword(String password) {

		boolean err = false;
		 // /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,20}$/		
		String regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,20}$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(password);
		if(m.matches()){
			err = true; 
		}
		return err;
	}
	
	public static boolean isValidName(String name) {
		
		boolean err = false;
		String regex = "^[가-힣a-zA-Z0-9]*$"; // 한글, 숫자, 영어만
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(name);
		if(m.matches()){
			err = true; 
		}
		return err;
	}

}
