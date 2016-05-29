package com.gongdan.common.exception;

import com.gongdan.common.em.ErrorCodeEnum;



/**
 * 系统异常基类
 * 
 *@author	  	yanziqi
 */
public abstract class SystemException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	private String code =ErrorCodeEnum.FAIL.getCode();
	
	public SystemException(String message) {
		super(message);
	}

	public SystemException(Throwable cause) {
		super(cause);
	}

	public SystemException(String message, Throwable cause) {
		super(message, cause);
	}

	public SystemException(String code, String message) {
		super(message);
		setCode(code);
	}
	
	public SystemException(String code, String message, Throwable cause) {
		super(message, cause);
		setCode(code);
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
}
