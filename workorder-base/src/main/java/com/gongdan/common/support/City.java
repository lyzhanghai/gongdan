package com.gongdan.common.support;

import java.io.Serializable;


public class City implements Serializable{
	private String cityName;
	private Integer value;
	

	
    public Integer getValue() {
    	return value;
    }
	
    public void setValue(Integer value) {
    	this.value = value;
    }

	
    public String getCityName() {
    	return cityName;
    }

	
    public void setCityName(String cityName) {
    	this.cityName = cityName;
    }

	public City(String cityName, Integer value) {
	    super();
	    this.cityName = cityName;
	    this.value = value;
    }


}
