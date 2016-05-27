package com.gongdan.entity;

import java.io.Serializable;
import java.util.List;

public class TaskInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long taskId;
	private Long taskTypeId;

	private Long createUserId;

	private String taskDesc;

	private Integer taskStatus;

	private String startTime;

	private String endTime;

	private String updateTime;
	
	
	
	private List<TaskExtraInfo> extraInfos;

	
	private List<TaskParticipator> participators;
	
	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	public Long getTaskTypeId() {
		return taskTypeId;
	}

	public void setTaskTypeId(Long taskTypeId) {
		this.taskTypeId = taskTypeId;
	}

	public Long getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Long createUserId) {
		this.createUserId = createUserId;
	}

	public String getTaskDesc() {
		return taskDesc;
	}

	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
	}

	public Integer getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public List<TaskExtraInfo> getExtraInfos() {
		return extraInfos;
	}

	public void setExtraInfos(List<TaskExtraInfo> extraInfos) {
		this.extraInfos = extraInfos;
	}

	public List<TaskParticipator> getParticipators() {
		return participators;
	}

	public void setParticipators(List<TaskParticipator> participators) {
		this.participators = participators;
	}

	
	
}
