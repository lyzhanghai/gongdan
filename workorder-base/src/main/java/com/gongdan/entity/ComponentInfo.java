package com.gongdan.entity;

import java.io.Serializable;

/**
 * 总成零件 ，和零件
 * @author yanziqi
 *
 */
public class ComponentInfo implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	
	private String name ;
	
	private String taskDurationtime;
	
	/**
	 * 1:总成零件
	 * 2:普通零件
	 */
	private Integer type;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTaskDurationtime() {
		return taskDurationtime;
	}

	public void setTaskDurationtime(String taskDurationtime) {
		this.taskDurationtime = taskDurationtime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
	
	
	
		
	
}
