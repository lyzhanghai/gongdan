package com.gongdan.common.exceptionhandle;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.gongdan.common.support.ModuleExceptionResolver;
import com.gongdan.common.support.ModuleExceptionResolver.ExceptionMetadata;
import com.gongdan.common.support.Result;

/**
 * 后台管理默认的异常处理器,按请求是异步请求还是同步请求分别做不同的处理
 * 
* @author	  	yanziqi
 */
public class DefaultMvcHandlerExceptionResolver extends AbstractGlobalHandlerExceptionResolver {

	protected ModelAndView handle4AsyncRequest(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		ExceptionMetadata em = ModuleExceptionResolver.resolveException(ex);
		
		Result<Object> result = new Result<Object>();
		result.setResultCode(em.getCode());
		result.setResultMsg(em.getMessage());
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		jsonView.setExtractValueFromSingleKeyModel(true);
		ModelAndView mav = new ModelAndView(jsonView);
		mav.addObject(result);
		return mav;
	}

	protected ModelAndView handle4SyncRequest(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		ExceptionMetadata em = ModuleExceptionResolver.resolveException(ex);
		
		Map<String,Object> exceptionMetadata = new HashMap<String,Object>();
		exceptionMetadata.put("message", em.getMessage());
		exceptionMetadata.put("stackTrace", em.getStackTrace());
		exceptionMetadata.put("code", em.getCode());
		ModelAndView mav = new ModelAndView(getDefaultExceptionView());
		mav.addObject("exceptionMetadata", exceptionMetadata);
		return mav;
	}

}
