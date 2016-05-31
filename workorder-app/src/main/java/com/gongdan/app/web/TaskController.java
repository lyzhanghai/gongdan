package com.gongdan.app.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdan.common.em.ErrorCodeEnum;
import com.gongdan.common.entity.TaskInfo;
import com.gongdan.common.entity.User;
import com.gongdan.common.support.Result;
import com.gongdan.service.TaskService;
import com.gongdan.service.UserService;

/**
 * 任务接口处理
 * @author yanziqi
 *
 */
@Controller
@RequestMapping("/task/")
public class TaskController {

	@Resource(name="taskServiceImpl")
	private TaskService taskService;
	
	@Resource
	private UserService userService;
	
	
	
	
	@RequestMapping("list")
	@ResponseBody
	public Object queryTaskInfoList(@RequestParam("userNum") String userNum, @RequestParam("flag") Integer flag,
			@RequestParam("queryTime") String queryTime,@RequestParam(value="mine",required=false)String mine,HttpServletRequest request) {

		User user = userService.getUserInfo(userNum);
		Result<Object> result = new Result<Object>();
		result.setResultCode(ErrorCodeEnum.SUCCESS.getCode());
		result.setResultMsg("成功");

		return result;
	}
	
	
	@RequestMapping("create")
	@ResponseBody
	public Object createTask(@RequestParam("userNum") String userNum, @RequestParam("taskTypeId") Long taskTypeId,
			@RequestParam("taskDesc")String taskDesc,
			HttpServletRequest request) {
		User user = userService.getUserInfo(userNum);
		Result<Object> result = new Result<Object>();
		TaskInfo info= taskService.createTaskInfo(user.getUserId(), taskDesc, taskTypeId);
		result.setResultCode(ErrorCodeEnum.SUCCESS.getCode());
		result.setResultMsg("成功");
		result.setResultData(info);
		return result;
	}
	
	@RequestMapping("update")
	@ResponseBody
	public Object updateTask(@RequestParam("userNums") String[] userNums, @RequestParam("flag") Integer flag,
			@RequestParam("taskId")Long taskId,@RequestParam("taskId")Integer taskStatus,
			@RequestParam("queryTime") String queryTime,@RequestParam(value="mine",required=false)String mine,HttpServletRequest request) {
		List<Long> userIds = new ArrayList<Long>();
		for (String string : userNums) {
			User user = userService.getUserInfo(string);
			userIds.add(user.getUserId());
		}
		Result<Object> result = new Result<Object>();
		taskService.updateTask(taskId, userIds, taskStatus);
		result.setResultCode(ErrorCodeEnum.SUCCESS.getCode());
		result.setResultMsg("成功");
		return result;
	}
}
