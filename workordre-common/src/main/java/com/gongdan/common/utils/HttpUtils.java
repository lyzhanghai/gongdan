package com.gongdan.common.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * 有关HTTP请求的工具类
 * 
 * @author	  	pengpeng
 * @date	  	2014年10月17日 下午7:27:18
 * @version  	1.0
 */
public class HttpUtils {

	public static String getRequestURL(HttpServletRequest request, boolean includeQueryString) {
		StringBuffer url = new StringBuffer();
        String scheme = request.getScheme();
        int port = request.getServerPort();
        String urlPath = request.getRequestURI();

        url.append (scheme);                // http, https
        url.append ("://");
        url.append (request.getServerName());
        if ((scheme.equals ("http") && port != 80)
                || (scheme.equals ("https") && port != 443)) {
            url.append (':');
            url.append (request.getServerPort());
        }
        url.append(urlPath);
        if(includeQueryString && !StringUtils.isEmpty(request.getQueryString())){
        	url.append("?" + request.getQueryString());
		}
        return url.toString();
	}
	
	public static String getRequestURI(HttpServletRequest request, boolean includeQueryString) {
		String url = request.getRequestURI();
		if(includeQueryString && !StringUtils.isEmpty(request.getQueryString())){
			url += "?" + request.getQueryString();
		}
		return url;
	}
	
	/**
	 * 判断来的请求是否是异步请求
	 * @param request
	 * @return
	 */
    public static boolean isAsynRequest(HttpServletRequest request) {
    	return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }

}
