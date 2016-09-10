package com.gongdan.xadmin.web;

import javax.servlet.http.HttpServletRequest;

import com.gongdan.admin.web.controller.DateEditor;
import com.gongdan.common.consts.GlobalConstants;
import com.gongdan.common.exception.BusinessException;
import com.gongdan.common.support.Result;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;

import java.util.Date;

public abstract class BaseController {

	@SuppressWarnings("unchecked")
	protected <T> T getRequestAttribute(HttpServletRequest request, String key) {
		return (T) request.getAttribute(key);
	}
	
	@SuppressWarnings("unchecked")
	protected <T> T getSessionAttribute(HttpServletRequest request, String key) {
		return (T) request.getSession().getAttribute(key);
	}
	
	protected void setRequestAttribute(HttpServletRequest request, String key, Object value) {
		request.setAttribute(key, value);
	}
	
	protected void setSessionAttribute(HttpServletRequest request, String key, Object value) {
		request.getSession().setAttribute(key, value);
	}
	
	protected void removeRequestAttribute(HttpServletRequest request, String key) {
		request.removeAttribute(key);
	}
	
	protected void removeSessionAttribute(HttpServletRequest request, String key) {
		request.getSession().removeAttribute(key);
	}
	
	protected Result<Object> genSuccessResult(Object data) {
		Result<Object> result = new Result<Object>();
		result.setSuccess(true);
		result.setResultCode(GlobalConstants.RESULT_CODE_SUCCESS);
		result.setResultData(data);
		return result;
	}
	
	protected Result<Object> genSuccessResult(String message, Object data) {
		Result<Object> result = new Result<Object>();
		result.setSuccess(true);
		result.setResultCode(GlobalConstants.RESULT_CODE_SUCCESS);
		result.setResultMsg(message);
		result.setResultData(data);
		return result;
	}
	
	protected Result<Object> genSuccessResult(String code, String message, Object data) {
		Result<Object> result = new Result<Object>();
		result.setSuccess(true);
		result.setResultCode(code);
		result.setResultMsg(message);
		result.setResultData(data);
		return result;
	}
	
	protected Result<Object> genFailureResult(Object data) {
		Result<Object> result = new Result<Object>();
		result.setSuccess(false);
		result.setResultCode(GlobalConstants.RESULT_CODE_FAILURE);
		result.setResultData(data);
		return result;
	}
	
	protected Result<Object> genFailureResult(String message, Object data) {
		Result<Object> result = new Result<Object>();
		result.setSuccess(false);
		result.setResultCode(GlobalConstants.RESULT_CODE_FAILURE);
		result.setResultMsg(message);
		result.setResultData(data);
		return result;
	}
	
	protected Result<Object> genFailureResult(String code, String message, Object data) {
		Result<Object> result = new Result<Object>();
		result.setSuccess(false);
		result.setResultCode(code);
		result.setResultMsg(message);
		result.setResultData(data);
		return result;
	}

	@ExceptionHandler
	public String exceptionHandler(HttpServletRequest request, Exception ex) {
		ex.printStackTrace();
		request.setAttribute("ex", ex);

		// 根据不同错误转向不同页面
		if(ex instanceof BusinessException) {
			return "error-business";
		}else {
			return "error";
		}
	}

    @InitBinder
    protected void initBinder(HttpServletRequest request,
                              ServletRequestDataBinder binder) throws Exception {
        //对于需要转换为Date类型的属性，使用DateEditor进行处理
        binder.registerCustomEditor(Date.class, new DateEditor());
    }
}
