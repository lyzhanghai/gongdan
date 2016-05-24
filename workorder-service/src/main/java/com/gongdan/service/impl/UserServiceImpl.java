package com.gongdan.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gongdan.dao.UserDao;
import com.gongdan.entity.User;
import com.gongdan.service.UserService;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService{

	
	@Autowired
	private UserDao userDao;
	
	@Override
	public User getUserInfo(String userNum) {
		return userDao.getUserInfo(userNum);
	}

}
