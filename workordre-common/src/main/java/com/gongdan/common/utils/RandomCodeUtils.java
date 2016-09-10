package com.gongdan.common.utils;

import java.util.Random;

/**
 * 随机码生成工具类
 * 
 * @author pengpeng
 * @date 2016年3月12日 下午5:40:04
 * @version 1.0
 */
public class RandomCodeUtils {
	private static final String ALL_NUMBERS = "0123456789";
	private static final String ALL_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private static final String ENGLISH_CHARS = "abcdefghijklmnopqrstuvwxyz";

	public static String generateNumberString(int length) {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; ++i) {
			sb.append(ALL_NUMBERS.charAt(random.nextInt(ALL_NUMBERS.length())));
		}
		return sb.toString();
	}

	public static String generateString(int length) {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; ++i) {
			sb.append(ALL_CHARS.charAt(random.nextInt(ALL_CHARS.length())));
		}
		return sb.toString();
	}

	public static String generateEnglishString(int length) {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; ++i) {
			sb.append(ENGLISH_CHARS.charAt(random.nextInt(ENGLISH_CHARS
					.length())));
		}
		return sb.toString();
	}
}
