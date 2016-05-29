package com.gongdan.app.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdan.common.em.ErrorCodeEnum;
import com.gongdan.common.entity.User;
import com.gongdan.service.UserService;
import com.gongdan.common.support.Result;

@Controller
@RequestMapping("/user/")
public class UserController {
	
	@Resource(name="userServiceImpl")
	private UserService userService;
	
	@RequestMapping("login")
	@ResponseBody
	public Object doUserLogin(@RequestParam("userNum")String userNum,@RequestParam("psw")String password,@RequestParam("version")String version){
		
		Result<Object> result = new  Result<Object>();
		User user = userService.doUserLogin(userNum,password);
	
		result.setResultCode(ErrorCodeEnum.SUCCESS.getCode());
		result.setResultMsg("成功");
		result.setResultData(user);
		return result;
	}

	
	
}
