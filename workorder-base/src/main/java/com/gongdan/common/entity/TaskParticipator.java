package com.gongdan.common.entity;

import java.io.Serializable;
import java.util.List;

public class TaskParticipator implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	
	private Long taksId;
	
	private Long userId;
	
	private Integer userType;
	
	private String startTime;
	
	private String endTime;
	
	private List<TaskParticipator>  processRecords;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getTaksId() {
		return taksId;
	}

	public void setTaksId(Long taksId) {
		this.taksId = taksId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
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

	public List<TaskParticipator> getProcessRecords() {
		return processRecords;
	}

	public void setProcessRecords(List<TaskParticipator> processRecords) {
		this.processRecords = processRecords;
	}
	
}
