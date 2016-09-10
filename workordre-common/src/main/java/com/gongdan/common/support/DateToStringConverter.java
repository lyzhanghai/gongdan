package com.gongdan.common.support;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

/**
 * Date ==> String Type Converter
 * 
 * @author  pengpeng
 * @date 	 2015年12月23日 下午2:08:40
 * @version 1.0
 */
public class DateToStringConverter implements Converter<Date, String> {

	private String pattern = "yyyy-MM-dd HH:mm:ss";
	
	protected String getPattern() {
		return pattern;
	}

	public void setPattern(String pattern) {
		this.pattern = pattern;
	}

	public String convert(Date source) {
		SimpleDateFormat sdf = new SimpleDateFormat(getPattern());
		return sdf.format(source);
	}

}
