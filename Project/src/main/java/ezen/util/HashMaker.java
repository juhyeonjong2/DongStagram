package ezen.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashMaker {
	private static Base62 base62 = new Base62();
	
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
    	return base62.encoding(param);
    }
    
    public static long Base62Decoding(String param) {
    	return base62.decoding(param);
    }
    
    
}


class Base62 {
	final int RADIX = 62;
	final String CODEC = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	public String encoding(long param) {
		StringBuffer sb = new StringBuffer();
		while(param > 0) {
			sb.append(CODEC.charAt((int) (param % RADIX)));
			param /= RADIX;
		}
		return sb.toString();
	}
	
	public long decoding(String param) {
		long sum = 0;
		long power = 1;
		for (int i = 0; i < param.length(); i++) {
			sum += CODEC.indexOf(param.charAt(i)) * power;
			power *= RADIX;
		}
		return sum;
	}
}