package com.gongdan.app.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	
	
	/**
	 * 
	 * @param userId
	 * @param type  上拉下拉同一个接口，该字段区分
	 * @param flag
	 * @param pageSize
	 * @param queryTime
	 * @param mine
	 * @param request
	 * @return
	 */
	@RequestMapping("list")
	@ResponseBody
	public Object queryTaskInfoList(@RequestParam("userId") Long userId, @RequestParam("type") Integer type, @RequestParam("flag") Integer flag, @RequestParam("pageSize") Integer pageSize,
			@RequestParam("queryTime") String queryTime,@RequestParam(value="mine",required=false)String mine,HttpServletRequest request) {

		Result<Object> result = new Result<Object>();
		List<TaskInfo> taskList = taskService.queryTaskListByUserNum(queryTime, flag, userId, type, pageSize);
		Integer count = taskService.countTaskListByUserNum(queryTime, flag, userId, type);
		Map<String,Object> dataMap = new HashMap<String,Object>();
		dataMap.put("hasNextPage", false);
		if(count > pageSize){
			dataMap.put("hasNextPage", true);
			
		}
		dataMap.put("taskList", taskList);
		result.setResultCode(ErrorCodeEnum.SUCCESS.getCode());
		result.setResultMsg("成功");

		return result;
	}
	
	
	@RequestMapping("create")
	@ResponseBody
	public Object createTask(@RequestParam("userId") Long userId, @RequestParam("taskTypeId") Long taskTypeId,
			@RequestParam("taskDesc")String taskDesc,
			HttpServletRequest request) {
		Result<Object> result = new Result<Object>();
		TaskInfo info= taskService.createTaskInfo(userId, taskDesc, taskTypeId);
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
