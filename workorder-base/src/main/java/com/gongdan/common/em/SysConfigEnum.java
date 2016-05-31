package com.gongdan.common.em;

public enum SysConfigEnum {
	
	MQTT("MQTT_SERVER", 1, "mqtt服务配置"),
	APP_VERSION("APP_VERSION",2,"APP可用版本！");

	private String key;

	private Integer type;

	private String desc;

	private SysConfigEnum() {
	}

	private SysConfigEnum(String key, Integer type, String desc) {
		this.key = key;
		this.type = type;
		this.desc = desc;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

}
