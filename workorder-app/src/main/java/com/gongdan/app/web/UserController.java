package com.gongdan.app.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user/")
public class UserController {
	
	@RequestMapping("login")
	@ResponseBody
	public Object doUserLogin(@RequestParam("userNum")String userNum,@RequestParam("psw")String password,@RequestParam("version")String version){
		
		
		System.out.println("111111111");
		
		return null;
	}

	
	
	@RequestMapping("test")
	@ResponseBody
	public Object test(){
		
		
		System.out.println("111111111");
		
		return null;
	}
}
