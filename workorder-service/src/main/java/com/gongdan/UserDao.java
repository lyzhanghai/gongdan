package com.gongdan;

import org.apache.ibatis.annotations.Param;

import com.gongdan.entity.User;

public interface UserDao {
	
	public  User  getUserInfo(@Param("userNum")String userNum);

}
