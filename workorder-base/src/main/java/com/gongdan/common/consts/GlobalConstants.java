package com.gongdan.common.consts;

import java.util.Locale;

/**
 * 全局共通常量
 * 
 * @author  pengpeng
 * @date 	 2015年4月18日 下午5:50:07
 * @version 1.0
 */
public class GlobalConstants extends AbstractConstants {

	/**
	 * 系统默认字符编码
	 */
	public static final String SYSTEM_DEFAULT_ENCODING = valueOf("UTF-8");
	
	/**
	 * 系统默认Locale
	 */
	public static final Locale SYSTEM_DEFAULT_LOCALE = valueOf(new Locale("zh", "CN"));
	
	/**
	 * 返回结果之成功
	 */
	public static final String RESULT_CODE_SUCCESS = valueOf("1");

	/**
	 * 返回结果之失败
	 */
	public static final String RESULT_CODE_FAILURE = valueOf("0");

	/**
	 * 针对数据库字段,诸如:'是','真','已删除',...等等由数字"1"代表的真值
	 */
	public static final String DEFAULT_YES_TRUE_FLAG = valueOf("1");

	/**
	 * 针对数据库字段,诸如:'否','假','未删除',...等等由数字"0"代表的假值
	 */
	public static final String DEFAULT_NO_FALSE_FLAG = valueOf("0");
	
}
