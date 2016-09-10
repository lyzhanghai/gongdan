package com.gongdan.common.utils;

import java.util.Random;

/**
 * 加密salt生成器
 */
public class ExchangeCodeUtils {
	private static char[] cs = new char[]{'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};

    /**
     * 生成随机的code
	 *
     * @param byteSize code的位数
     * @return salt串
     */
	public static String randomCode(int byteSize){
		Random rand = new Random();
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<byteSize*2;i++){
			sb.append(cs[rand.nextInt(cs.length)]);
		}
		return sb.toString();
	}
}
