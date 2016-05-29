package com.gongdan.common.support;
import com.gongdan.common.utils.ExceptionUtils;
import com.gongdan.common.em.ErrorCodeEnum;
import com.gongdan.common.exception.SystemException;


/**
 * 模块内异常解析逻辑
 * 
 *@author	  	yanziqi
 */
public class ModuleExceptionResolver {
	
	public static ExceptionMetadata resolveException(Throwable ex) {
		Throwable target = null;
		String code = ErrorCodeEnum.FAIL.getCode();
		String stackTrace = null;
		String message = null;
		boolean found = false;
		Throwable cause = ex;
		while(cause != null){
			if (cause instanceof SystemException) { // 已知的异常信息
				target = cause;
				message = cause.getMessage();
				stackTrace = ExceptionUtils.getStackTrace(cause);
				if(ExceptionUtils.isContainsChineseChar(message)){
					found = true;
					break;
				}
			}
			cause = cause.getCause();
		}
		if(!found){
			target = ExceptionUtils.getRootCause(ex);
			message = Messages.getMessage("message.request.failure", target.getMessage()); // 未知的异常消息,需要转换成统一的,以增强用户体验
			stackTrace = ExceptionUtils.getStackTrace(ex);
		}
		return new ExceptionMetadata(target, message, stackTrace, code);
	}
	
	public static class ExceptionMetadata {
		
		private Throwable target;
		
		private String message;
		
		private String stackTrace;
		
		private String code;

		public ExceptionMetadata() {
			super();
		}

		public ExceptionMetadata(Throwable target, String message,
				String stackTrace, String code) {
			super();
			this.target = target;
			this.message = message;
			this.stackTrace = stackTrace;
			this.code = code;
		}

		public Throwable getTarget() {
			return target;
		}

		public void setTarget(Throwable target) {
			this.target = target;
		}

		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}

		public String getStackTrace() {
			return stackTrace;
		}

		public void setStackTrace(String stackTrace) {
			this.stackTrace = stackTrace;
		}
		
	}
	
}
