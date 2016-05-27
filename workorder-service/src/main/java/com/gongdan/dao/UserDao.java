package com.gongdan.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gongdan.entity.User;

@Repository
public interface UserDao {
	
	public  User  getUserInfo(@Param("userNum")String userNum);
	
	
	

}
