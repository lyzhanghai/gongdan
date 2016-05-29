package com.gongdan.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gongdan.common.entity.TaskInfo;
import com.gongdan.common.support.Pager;

@Repository
public interface TaskInfoDao {
	
	public List<TaskInfo>  queryTaskInfoList(String quertyTime,Integer type,Pager pager);

	
	
	public TaskInfo getTaskInfo(Long taskId);
	
	
	public Long createTask(TaskInfo info);
}
