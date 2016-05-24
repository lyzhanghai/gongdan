package com.gongdan.entity;

import java.io.Serializable;

public class User implements Serializable{

	
	private Long userId;
	
	private String userNum;

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	
	
	
}
