package com.gongdan.common.utils;
//package com.jacars.common.util;
//
//import java.util.HashMap;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//
//import com.cloopen.rest.sdk.CCPRestSmsSDK;
//import com.jacars.common.consts.AbstractConstants;
//import com.jacars.common.support.ConstValue;
//
//public class SmsUtils extends AbstractConstants {
//
//	private static final Logger logger = LoggerFactory.getLogger(SmsUtils.class);
//
//	@ConstValue("${sms.serverhost}")
//	private static final String SMS_SERVER_HOST = valueOf("app.cloopen.com");
//
//	@ConstValue("${sms.serverport}")
//	private static final String SMS_SERVER_PORT = valueOf("8883");
//
//	@ConstValue("${sms.appid}")
//	private static final String SMS_APP_ID = valueOf("8a48b55152a56fc20152e912c2bb4a64");
//
//	@ConstValue("${sms.accountsid}")
//	private static final String SMS_ACCOUNT_SID = valueOf("8a48b551505b4af001505bc06d0801f2");
//
//	@ConstValue("${sms.authtoken}")
//	private static final String SMS_AUTH_TOKEN = valueOf("bc2c7ec8ff894c61bb6289eda6a90aaf");
//
//	@ConstValue("${sms.templateid.smscode}")
//	private static final String SMS_TEMPLATE_ID_SMSCODE = valueOf("87635");
//
//	@ConstValue("${sms.templateid.activity.code}")
//	private static final String SMS_TEMPLATE_ID_ACITVITY = valueOf("87635");
//
//	private static final CCPRestSmsSDK smsRestApi = new CCPRestSmsSDK();
//
//	private static final Object mutex = new Object();
//
//	private static boolean initialized = false;
//
//	protected static void init() {
//		if (!initialized) {
//			synchronized (mutex) {
//				if (!initialized) {
//					logger.info(">>> 初始化云通讯短信网关配置!");
//					// ******************************注释*********************************************
//					// *初始化服务器地址和端口 *
//					// *沙盒环境（用于应用开发调试）：restAPI.init("sandboxapp.cloopen.com", "8883");*
//					// *生产环境（用户应用上线使用）：restAPI.init("app.cloopen.com", "8883"); *
//					// *******************************************************************************
//					smsRestApi.init(SMS_SERVER_HOST, SMS_SERVER_PORT);
//					// *应用ID的获取：登陆官网，在“应用-应用列表”，点击应用名称，看应用详情获取APP ID*
//					smsRestApi.setAppId(SMS_APP_ID);
//					// *初始化主帐号和主帐号令牌,对应官网开发者主账号下的ACCOUNT SID和AUTH TOKEN *
//					// *ACOUNT SID和AUTH TOKEN在登陆官网后，在“应用-管理控制台”中查看开发者主账号获取*
//					// *参数顺序：第一个参数是ACOUNT SID，第二个参数是AUTH TOKEN。 *
//					// *******************************************************************************
//					smsRestApi.setAccount(SMS_ACCOUNT_SID, SMS_AUTH_TOKEN);
//					initialized = true;
//				}
//			}
//		}
//	}
//
//	protected static CCPRestSmsSDK getSmsRestApi() {
//		if (!initialized) {
//			init();
//		}
//		return smsRestApi;
//	}
//
//	/**
//	 * 发送短信验证码
//	 * 
//	 * @param mobilePhone
//	 * @param code
//	 * @return
//	 */
//	public static boolean sendSmsCode(String mobilePhone, String code) {
//		HashMap<String, Object> result = getSmsRestApi().sendTemplateSMS(mobilePhone, SMS_TEMPLATE_ID_SMSCODE, new String[] { code });
//		boolean flag = "000000".equals(result.get("statusCode"));
//		if (!flag) {
//			logger.error(">>> 发送短信结果 : " + result);
//		} else {
//			logger.info(">>> 发送短信结果 : " + result);
//		}
//		return flag;
//	}
//
//	/**
//	 * 发送短信内容
//	 * 
//	 * @param mobilePhone
//	 * @param code
//	 * @return
//	 */
//	public static boolean sendSmsActivity(String mobilePhone, String code) {
//		HashMap<String, Object> result = getSmsRestApi().sendTemplateSMS(mobilePhone, SMS_TEMPLATE_ID_ACITVITY, new String[] { code });
//		boolean flag = "000000".equals(result.get("statusCode"));
//		if (!flag) {
//			logger.error(">>> 发送短信结果 : " + result);
//		} else {
//			logger.info(">>> 发送短信结果 : " + result);
//		}
//		return flag;
//	}
//
//	public static void main(String[] args) {
//		sendSmsCode("15151887280", "981945");
//	}
//
//}
