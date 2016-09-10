package com.gongdan.xadmin.consts;

import com.gongdan.common.consts.AbstractConstants;
import com.gongdan.common.support.ServletContextAttribute;

/**
 * 后台管理常量
 * 
 * @author	  	pengpeng
 * @date	  	2014年11月15日 下午1:38:38
 * @version  	1.0
 */
public class XAdminConstants extends AbstractConstants {

	/**
	 * 默认的根资源id
	 */
	@ServletContextAttribute
	public static final Long DEFAULT_XADMIN_ROOT_RESOURCE_ID = 0L;
	
	/**
	 * 默认的密码加密次数
	 */
	public static final int DEFAULT_PASSWORD_HASH_ITERATIONS = 1;
	
}
