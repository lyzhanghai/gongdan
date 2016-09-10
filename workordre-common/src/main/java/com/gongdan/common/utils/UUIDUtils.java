package com.gongdan.common.utils;

import java.util.UUID;

public class UUIDUtils {

	public static String uuid(){
		String uuid =  UUID.randomUUID().toString();
		return uuid.replace("-", "");
	}
	
}
