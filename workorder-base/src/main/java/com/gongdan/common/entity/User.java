package com.gongdan.common.entity;

import java.io.Serializable;
import java.util.List;

public class User implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7063540330843071503L;

	private Long userId;
	
	private String userNum;
	
	private String userPwd;
	
	private String userName;
	
	private Long deptId;
	
	private Long locationId;
	private Integer userType;
	
	private Integer status;
	
	
	private LocationInfo locationInfo;
	
	private List<GroupInfo> groupList;
	

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Long getDeptId() {
		return deptId;
	}

	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}

	public Long getLocationId() {
		return locationId;
	}

	public void setLocationId(Long locationId) {
		this.locationId = locationId;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public LocationInfo getLocationInfo() {
		return locationInfo;
	}

	public void setLocationInfo(LocationInfo locationInfo) {
		this.locationInfo = locationInfo;
	}

	public List<GroupInfo> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<GroupInfo> groupList) {
		this.groupList = groupList;
	}
	
	
	
}
