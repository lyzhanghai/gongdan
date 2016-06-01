package com.gongdan.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gongdan.common.entity.TaskInfo;
import com.gongdan.common.support.Pager;

@Repository
public interface TaskInfoDao {
	
	
	
	
	/**
	 * 获取自己的任务列表
	 * 
	 * @param queryTime
	 * @param flag 1上拉 2:下拉刷新
	 * @param userNum 工号
	 * @param type 1:表示自己创建的任务，2:表示自己接受的任务
	 * @return
	 */
	public List<TaskInfo> queryTaskInfoList(String queryTime,Integer flag,Long userId,Integer type,Integer pageSize);
	
	/**
	 * 获取自己的任务列表
	 * 
	 * @param queryTime
	 * @param flag 1上拉 2:下拉刷新
	 * @param userNum 工号
	 * @param type 1:表示自己创建的任务，2:表示自己接受的任务
	 * @return
	 */
	public Integer queryTaskInfoList_count(String queryTime,Integer flag,Long userId,Integer type);
	
	
	public TaskInfo getTaskInfo(Long taskId);
	
	
	public Long createTask(TaskInfo info);
	
	
	public void updateTask(TaskInfo info);
}
