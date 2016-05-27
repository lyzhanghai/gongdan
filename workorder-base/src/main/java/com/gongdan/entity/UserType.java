package com.gongdan.entity;

import java.io.Serializable;

public class UserType implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	private Long usertypeId;
	
	
	private String usertypeName;
	
	private String usertypeDesc;

	public Long getUsertypeId() {
		return usertypeId;
	}

	public void setUsertypeId(Long usertypeId) {
		this.usertypeId = usertypeId;
	}

	public String getUsertypeName() {
		return usertypeName;
	}

	public void setUsertypeName(String usertypeName) {
		this.usertypeName = usertypeName;
	}

	public String getUsertypeDesc() {
		return usertypeDesc;
	}

	public void setUsertypeDesc(String usertypeDesc) {
		this.usertypeDesc = usertypeDesc;
	}
	
	

}
