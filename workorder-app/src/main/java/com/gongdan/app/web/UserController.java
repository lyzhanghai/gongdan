package com.gongdan.app.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdan.service.UserService;

@Controller
@RequestMapping("/user/")
public class UserController {
	
	@Resource(name="userServiceImpl")
	private UserService userService;
	
	@RequestMapping("login")
	@ResponseBody
	public Object doUserLogin(@RequestParam("userNum")String userNum,@RequestParam("psw")String password,@RequestParam("version")String version){
		
		
		System.out.println("111111111");
		
		return null;
	}

	
	
	@RequestMapping("test")
	@ResponseBody
	public Object test(){
		
		
		userService.getUserInfo("11");
		
		return null;
	}
}
