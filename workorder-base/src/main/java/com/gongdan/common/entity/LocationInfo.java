package com.gongdan.common.entity;

import java.io.Serializable;

/**
 * 工位信息
 * @author yanziqi
 *
 */
public class LocationInfo implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long locationId;
	
	private String locationName;

	public Long getLocationId() {
		return locationId;
	}

	public void setLocationId(Long locationId) {
		this.locationId = locationId;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	
	
}
