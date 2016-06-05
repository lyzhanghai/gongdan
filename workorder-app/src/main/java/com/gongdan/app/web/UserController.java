package com.gongdan.app.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdan.common.em.ErrorCodeEnum;
import com.gongdan.common.em.SysConfigEnum;
import com.gongdan.common.entity.SysConfigInfo;
import com.gongdan.common.entity.User;
import com.gongdan.service.SysConfigService;
import com.gongdan.service.UserService;
import com.gongdan.common.support.Result;

@Controller
@RequestMapping("/user/")
public class UserController {

	@Resource(name = "userServiceImpl")
	private UserService userService;

	@Resource(name = "sysConfigServiceImpl")
	private SysConfigService configService;

	@RequestMapping("login")
	@ResponseBody
	public Object doUserLogin(@RequestParam(value="userNum",required =false) String userNum, @RequestParam(value="psw",required =false) String password,
			@RequestParam(value="version",required =false) String version) {

		SysConfigInfo versionConfig = configService.queryConfigByTypeAndKey(SysConfigEnum.APP_VERSION.getType(),
				SysConfigEnum.APP_VERSION.getKey());
		Result<Object> result = new Result<Object>();
		if (versionConfig != null && versionConfig.getConfigValue().equals(version)) {

			User user = userService.doUserLogin(userNum, password);
			result.setResultCode(ErrorCodeEnum.SUCCESS.getCode());
			result.setResultMsg("成功");

			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("user", user);
			resultMap.put("mqttsSerevers",
					configService.queryConfigByTypeAndKey(SysConfigEnum.MQTT.getType(), SysConfigEnum.MQTT.getKey()));
			result.setResultData(resultMap);
		} else {

			result.setResultCode(ErrorCodeEnum.NEED_TO_UPDATE.getCode());
			result.setResultMsg("当前版本需要升级！");

		}

		return result;
	}

	@RequestMapping("change")
	@ResponseBody
	public Object changePwd(@RequestParam("userNum") String userNum, @RequestParam("oldPwd") String oldPwd,
			@RequestParam("newPwd") String newPwd) {

		Result<Object> result = new Result<Object>();

		userService.changePwd(userNum, oldPwd, newPwd);
		result.setResultCode(ErrorCodeEnum.SUCCESS.getCode());
		result.setResultMsg("成功");

		return result;
	}
	
	@RequestMapping("test")
	@ResponseBody
	public Object test() {

		Result<Object> result = new Result<Object>();

		result.setResultMsg("成功");

		return result;
	}
}
