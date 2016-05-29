package com.gongdan.common.exceptionhandle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.Ordered;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.AbstractHandlerExceptionResolver;

import com.gongdan.common.exception.SystemException;

/**
 * 全局异常处理器
 * 
* @author	  	yanziqi
 */
public abstract class AbstractGlobalHandlerExceptionResolver extends AbstractHandlerExceptionResolver {

	private static final Logger logger = LoggerFactory.getLogger(AbstractGlobalHandlerExceptionResolver.class);
	
	private String defaultExceptionView;
	
	public void setDefaultExceptionView(String defaultExceptionView) {
		this.defaultExceptionView = defaultExceptionView;
	}
	
	public String getDefaultExceptionView() {
		return defaultExceptionView;
	}

	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		ModelAndView mav = null;
		try {
			if(!(ex instanceof SystemException)){
				logger.error(ex.getMessage(), ex); //未知异常记录下来
			}
			if(handler instanceof HandlerMethod){
				if(isAsyncRequest(request, response, handler)){ //异步请求的异常处理
					return handle4AsyncRequest(request, response, handler, ex);
				} else { //正常页面跳转的同步请求的异常处理
					return handle4SyncRequest(request, response, handler, ex);
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return mav;
	}
	
	/**
	 * 是否是异步请求
	 * @param request
	 * @param response
	 * @param handler
	 * @return
	 */
	protected boolean isAsyncRequest(HttpServletRequest request, HttpServletResponse response, Object handler){
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		ResponseBody responseBodyAnnotation = handlerMethod.getMethodAnnotation(ResponseBody.class);
		boolean isAsync = responseBodyAnnotation != null;
		if(!isAsync){
			isAsync = ResponseEntity.class.equals(handlerMethod.getMethod().getReturnType());
		}
		return isAsync;
	}
	
	/**
	 * 处理异步请求
	 * @param request
	 * @param response
	 * @param handler
	 * @param ex
	 * @return
	 */
	protected abstract ModelAndView handle4AsyncRequest(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex);
	
	/**
	 * 处理同步请求
	 * @param request
	 * @param response
	 * @param handler
	 * @param ex
	 * @return
	 */
	protected abstract ModelAndView handle4SyncRequest(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex);

	public int getOrder() {
		return Ordered.HIGHEST_PRECEDENCE;
	}
	
}
