package com.gongdan.common.support;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 哈希算法
 * 
 * @author	  	pengpeng
 * @date	  	2015年1月14日 下午1:19:59
 * @version  	1.0
 */
public enum HashAlgorithm {

	KETAMA_HASH;
	
	public long hash(final String k) {
		long rv = 0;
		switch (this) {
		case KETAMA_HASH:
			byte[] bKey = computeMd5(k);
			rv = (long) (bKey[3] & 0xFF) << 24 | (long) (bKey[2] & 0xFF) << 16
					| (long) (bKey[1] & 0xFF) << 8 | bKey[0] & 0xFF;
			break;
		default:
			assert false;
		}

		return rv & 0xffffffffL; /* Truncate to 32-bits */
	}

	public static byte[] computeMd5(String key) {
		MessageDigest md5;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("MD5 not supported", e);
		}
		md5.reset();
		byte[] keyBytes = null;
		try {
			keyBytes = key.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("Unsupported encoding!", e);
		}
		
		md5.update(keyBytes);
		return md5.digest();
	}
	
}
