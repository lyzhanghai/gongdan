package com.gongdan.service;

import java.util.List;

import com.gongdan.common.entity.TaskInfo;

public interface TaskService {

	
	/**
	 * 根据任务类型获取任务列表
	 * @param queryTime,
	 * @param flag，1上拉 2:下拉刷新
	 * @param type 任务类型
	 * @return
	 */
	public List<TaskInfo> queryTaskListByType(String queryTime,Integer flag,List<Integer> taskType);
	
	
	/**
	 * 获取自己的任务列表
	 * 
	 * @param queryTime
	 * @param flag 1上拉 2:下拉刷新
	 * @param userNum 工号
	 * @param type 1:表示自己创建的任务，2:表示自己接受的任务
	 * @return
	 */
	public List<TaskInfo> queryTaskListByUserNum(String queryTime,Integer flag,Long userId,Integer type,Integer pageSize);
	
	/**
	 * 获取自己的任务列表
	 * 
	 * @param queryTime
	 * @param flag 1上拉 2:下拉刷新
	 * @param userNum 工号
	 * @param type 1:表示自己创建的任务，2:表示自己接受的任务
	 * @return
	 */
	public Integer countTaskListByUserNum(String queryTime,Integer flag,Long userId,Integer type);
	

	
	
	/**
	 * 创建任务
	 * @param userId
	 * @param taskDesc
	 * @param taskTypeId
	 * @return
	 */
	public TaskInfo createTaskInfo(Long userId,String taskDesc,Long taskTypeId);
	
	
	/**
	 * 更新任务
	 * @param taskId
	 * @param userIds
	 */
	public void updateTask(Long taskId,List<Long>userIds,Integer taskStatus);

	
	
	/**
	 * 获取任务详情
	 * @param taskId
	 * @return
	 */
	public TaskInfo queryTaskInfo(Long taskId);
	}



