package com.gongdan.em;
/**
 * 任务状态枚举
 */
public enum TaskStatusEnum {

	START(0,"创建任务"),HANDLING(1,"任务处理中"),FINISHED(3,"完成任务");
	
	
	private int code;
	
	private String desc;

	
	
	
	private TaskStatusEnum(int code, String desc) {
		this.code = code;
		this.desc = desc;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	
	
}
