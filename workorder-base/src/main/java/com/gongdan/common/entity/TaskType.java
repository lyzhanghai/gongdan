package com.gongdan.common.entity;

import java.io.Serializable;

public class TaskType implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long tasktypeId;
	
	private String tasktypeName;

	public Long getTasktypeId() {
		return tasktypeId;
	}

	public void setTasktypeId(Long tasktypeId) {
		this.tasktypeId = tasktypeId;
	}

	public String getTasktypeName() {
		return tasktypeName;
	}

	public void setTasktypeName(String tasktypeName) {
		this.tasktypeName = tasktypeName;
	}
	
	
}
