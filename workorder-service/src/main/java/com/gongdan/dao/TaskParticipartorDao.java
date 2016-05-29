package com.gongdan.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gongdan.common.entity.TaskParticipator;

@Repository
public interface TaskParticipartorDao {

	
	public List<TaskParticipator> queryTaskParticipartorList(Long taskId);
	
	
	public void updateTaskParticipartor(TaskParticipator participator);
	
	
	public void createTaskParticipartor(TaskParticipator participator);
}
