package com.gongdan.common.exception;

/**
 * 用于数据校验的Exception
 * 
 *@author	  	yanziqi
 */
public class DataValidationException extends SystemException {

	private static final long serialVersionUID = 1L;

	public DataValidationException(String message) {
		super(message);
	}

	public DataValidationException(Throwable cause) {
		super(cause);
	}

	public DataValidationException(String message, Throwable cause) {
		super(message, cause);
	}

	public DataValidationException(String code, String message) {
		super(code, message);
	}
	
	public DataValidationException(String code, String message, Throwable cause) {
		super(code, message, cause);
	}
	
}
