package com.gongdan.service;

import com.gongdan.common.entity.User;

public interface UserService {
	
	
	public User getUserInfo(String userNum);
	
	public User doUserLogin(String userNum,String password);

	
	public void changePwd(String userNum,String oldPwd,String newPwd);
}
