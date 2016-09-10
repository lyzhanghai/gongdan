package com.gongdan.common.web.shiro.perm;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;

import com.gongdan.common.support.Messages;
import com.gongdan.common.support.Result;
import com.gongdan.common.utils.JsonUtils;

/**
 * 基于URL的权限判断过滤器
 * 
 * @author	  	pengpeng
 * @date	  	2015年1月29日 上午11:03:06
 * @version  	1.0
 */
public class GlobalUrlPermissionFilter extends PermissionsAuthorizationFilter {

	public static final String MARK_AJAX_REQUEST = "XMLHttpRequest";
	
	private String defaultNoPermissionMessageI18nCode = "message.httpstatus.401";
	
	private String defaultNoPermissionMessage = "不好意思，您没有权限访问该资源!";
	
	protected String getDefaultNoPermissionMessageI18nCode() {
		return defaultNoPermissionMessageI18nCode;
	}

	public void setDefaultNoPermissionMessageI18nCode(
			String defaultNoPermissionMessageI18nCode) {
		this.defaultNoPermissionMessageI18nCode = defaultNoPermissionMessageI18nCode;
	}

	protected String getDefaultNoPermissionMessage() {
		return defaultNoPermissionMessage;
	}

	public void setDefaultNoPermissionMessage(String defaultNoPermissionMessage) {
		this.defaultNoPermissionMessage = defaultNoPermissionMessage;
	}

	protected boolean isAsynRequest(HttpServletRequest request, HttpServletResponse response) {
		if(MARK_AJAX_REQUEST.equals(request.getHeader("X-Requested-With"))){
			return true;
		}
		return false;
	}
	
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws IOException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		if(isAsynRequest(req, res)){
			Result<Object> result = new Result<Object>();
			result.setResultCode("401");
			result.setSuccess(false);
			result.setResultMsg(Messages.getMessage(getDefaultNoPermissionMessageI18nCode(), null, getDefaultNoPermissionMessage()));
			res.setCharacterEncoding("UTF-8");
			res.setContentType("application/json;charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println(JsonUtils.object2Json(result));
			out.flush();
			out.close();
			return false;
		}else{
			return super.onAccessDenied(request, response);
		}
	}
	
}
