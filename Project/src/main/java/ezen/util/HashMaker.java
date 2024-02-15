package ezen.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashMaker {
	
    public static String sha256(String msg) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(msg.getBytes());
        
        return bytesToHex(md.digest());
    }
    
    public static String bytesToHex(byte[] bytes) {
        StringBuilder builder = new StringBuilder();
        for (byte b: bytes) {
          builder.append(String.format("%02x", b));
        }
        return builder.toString();
    }
    
    
    public static String Base62Encoding(long param) {
    	return Base62.encoding(param);
    }
    
    public static long Base62Decoding(String param) {
    	return Base62.decoding(param);
    }
    
    
    public static String randomPassword(int len) {
    	
    	int index = 0;
		char[] charSet = new char[] {
			    '0','1','2','3','4','5','6','7','8','9'
			    ,'A','B','C','D','E','F','G','H','I','J','K','L','M'
			    ,'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
			    ,'a','b','c','d','e','f','g','h','i','j','k','l','m'
			    ,'n','o','p','q','r','s','t','u','v','w','x','y','z'};
		
		StringBuffer sb = new StringBuffer();
		for (int i=0; i<len; i++) {
			index =  (int) (charSet.length * Math.random());
			sb.append(charSet[index]);
		}
		
		return sb.toString();
    }
    
}


class Base62 {
	final static int RADIX = 62;
	final static String CODEC = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	public static  String encoding(long param) {
		StringBuffer sb = new StringBuffer();
		while(param > 0) {
			sb.append(CODEC.charAt((int) (param % RADIX)));
			param /= RADIX;
		}
		return sb.toString();
	}
	
	public static long decoding(String param) {
		long sum = 0;
		long power = 1;
		for (int i = 0; i < param.length(); i++) {
			sum += CODEC.indexOf(param.charAt(i)) * power;
			power *= RADIX;
		}
		return sum;
	}
}
