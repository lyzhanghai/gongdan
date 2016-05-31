package com.gongdan.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gongdan.common.consts.TaskConts;
import com.gongdan.common.em.TaskStatusEnum;
import com.gongdan.common.entity.TaskInfo;
import com.gongdan.common.entity.TaskParticipator;
import com.gongdan.common.entity.TaskProcessRecord;
import com.gongdan.common.utils.DateUtil;
import com.gongdan.dao.TaskInfoDao;
import com.gongdan.dao.TaskParticipartorDao;
import com.gongdan.dao.TaskProcessRecordDao;
import com.gongdan.service.TaskService;

@Service("taskServiceImpl")
public class TaskServieImpl implements TaskService{

	@Autowired
	private TaskInfoDao taskInfoDao;
	@Autowired
	private TaskParticipartorDao participartorDao;
	@Autowired
	private TaskProcessRecordDao  recordDao;
	
	
	@Override
	public List<TaskInfo> queryTaskListByType(String queryTime, Integer flag, List<Integer> taskType) {
		return taskInfoDao.queryTaskListByType(queryTime, flag, taskType);
	}

	@Override
	public List<TaskInfo> queryTaskListByUserNum(String queryTime, Integer flag, String userNum, Integer type) {
		return taskInfoDao.queryTaskListByUserNum(queryTime, flag, userNum, type);
	}

	@Override
	@Transactional
	public TaskInfo createTaskInfo(Long userId, String taskDesc,Long taskTypeId) {
		TaskInfo task = new TaskInfo();
		String nowTime =DateUtil.format(new Date());
		task.setStartTime(nowTime);
		task.setTaskDesc(taskDesc);
		task.setTaskStatus(TaskStatusEnum.START.getCode());
		task.setCreateUserId(userId);
		task.setTaskTypeId(taskTypeId);
		
		taskInfoDao.createTask(task);
		
		TaskParticipator participator = new TaskParticipator();
		participator.setTaksId(task.getTaskId());
		participator.setStartTime(nowTime);
		participator.setUserId(userId);
		participator.setUserType(1);
		
		participartorDao.createTaskParticipartor(participator);
		
		
		TaskProcessRecord record = new TaskProcessRecord();
		record.setCreateTime(nowTime);
		record.setTaksId(task.getTaskId());
		record.setTaskStatus(TaskStatusEnum.START.getCode());
		//record.setProcessDesc(TaskStatusEnum.START.getDesc());
		record.setUserId(userId);
		recordDao.createTaskProcessRecord(record);
		return task;
	}

	@Override
	@Transactional
	public void updateTask(Long taskId, List<Long> userIds,Integer status) {
		
		
		String nowTime =DateUtil.format(new Date());
		taskInfoDao.updateTask(new TaskInfo(taskId,status));
		for (Long id : userIds) {
			TaskParticipator participator = new TaskParticipator();
			participator.setTaksId(taskId);
			participator.setStartTime(nowTime);
			participator.setUserId(id);
			participator.setUserType(1);
			
			participartorDao.createTaskParticipartor(participator);
			
			TaskProcessRecord record = new TaskProcessRecord();
			record.setCreateTime(nowTime);
			record.setTaksId(taskId);
			record.setTaskStatus(status);
			record.setProcessDesc(TaskConts.taskStatusMap.get(status));
					
			
			recordDao.createTaskProcessRecord(record);
		}
		
	}

	@Override
	public TaskInfo queryTaskInfo(Long taskId) {
		return taskInfoDao.getTaskInfo(taskId);
	}

}
