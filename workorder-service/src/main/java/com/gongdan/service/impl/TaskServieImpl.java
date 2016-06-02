package com.gongdan.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gongdan.common.consts.TaskConts;
import com.gongdan.common.em.TaskStatusEnum;
import com.gongdan.common.entity.TaskInfo;
import com.gongdan.common.entity.TaskParticipator;
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
	public List<TaskInfo> queryTaskListByUserNum(String queryTime,Integer flag,Long userId,Integer type,Integer pageSize) {
		return taskInfoDao.queryTaskInfoList(queryTime, flag, userId, type,pageSize);
	}

	@Override
	public Integer countTaskListByUserNum(String queryTime, Integer flag, Long userId, Integer type) {
		return taskInfoDao.queryTaskInfoList_count(queryTime, flag, userId, type);
	}
	
	@Override
	@Transactional
	public TaskInfo createTaskInfo(Long userId, String taskDesc,Long taskTypeId) {
		TaskInfo task = new TaskInfo();
		Date nowDate = new Date();
		
		String nowTime =DateUtil.format(nowDate);
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
		
		Map<String,Object> recordMap = new HashMap<String, Object>();
		recordMap.put("taskId", task.getTaskId());
		recordMap.put("userId", userId);
		recordMap.put("taskStatus", TaskStatusEnum.START.getCode());
		//record.setProcessDesc(TaskStatusEnum.START.getDesc());
		recordMap.put("tableName", "t_gd_task_process_record"+DateUtil.format(new Date(), "MM"));
		
		recordDao.createTaskProcessRecord(recordMap);
		return task;
	}

	@Override
	@Transactional
	public void updateTask(Long taskId, List<Long> userIds,Integer status) {
		Date nowDate = new Date();
		String nowTime =DateUtil.format(nowDate);
		taskInfoDao.updateTask(new TaskInfo(taskId,status));
		for (Long id : userIds) {
			TaskParticipator participator = new TaskParticipator();
			participator.setTaksId(taskId);
			participator.setStartTime(nowTime);
			participator.setUserId(id);
			participator.setUserType(1);
			
			participartorDao.createTaskParticipartor(participator);
			
					

			Map<String,Object> recordMap = new HashMap<String, Object>();
			recordMap.put("taskId", taskId);
			recordMap.put("userId", id);
			recordMap.put("taskStatus", TaskConts.taskStatusMap.get(status));
			recordMap.put("tableName", "t_gd_task_process_record"+DateUtil.format(new Date(), "MM"));
			
			recordDao.createTaskProcessRecord(recordMap);
		}
		
	}

	@Override
	public TaskInfo queryTaskInfo(Long taskId) {
		return taskInfoDao.getTaskInfo(taskId);
	}

	@Override
	public List<TaskInfo> queryTaskListByType(String queryTime, Integer flag, List<Integer> taskType) {
		// TODO Auto-generated method stub
		return null;
	}


}
