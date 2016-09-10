package com.gongdan.common.web.interceptor;
import com.gongdan.common.exception.SystemException;

public class RepeatSubmitException extends SystemException {

	private static final long serialVersionUID = 1L;

	public RepeatSubmitException(String message, Throwable cause) {
		super(message, cause);
	}

	public RepeatSubmitException(String message) {
		super(message);
	}

}
