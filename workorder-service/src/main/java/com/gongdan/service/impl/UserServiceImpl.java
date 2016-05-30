package com.gongdan.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import com.gongdan.dao.UserDao;
import com.gongdan.common.entity.User;
import com.gongdan.service.UserService;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;

	@Override
	public User getUserInfo(String userNum) {
		return userDao.getUserDetailInfo(userNum);
	}

	@Override
	public User doUserLogin(String userNum, String password) {
		User user = getUserInfo(userNum);
		Assert.notNull(user, "该工号不存在！");
		Assert.isTrue(user.getUserPwd().equalsIgnoreCase(password), "密码不正确");

		return user;
	}

	@Override
	public void changePwd(String userNum, String oldPwd, String newPwd) {
		User user = getUserInfo(userNum);
		Assert.isTrue(user.getUserPwd().equalsIgnoreCase(oldPwd), "原始密码不正确");
		user.setUserPwd(newPwd);
		userDao.updateUserInfo(user);
	}

}
