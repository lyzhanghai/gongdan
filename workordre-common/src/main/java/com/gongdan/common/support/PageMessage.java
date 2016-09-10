package com.gongdan.common.support;
/**
 * 正常form请求页面间跳转带到页面显示的message
 * 
 * @author	  	pengpeng
 * @date	  	2014年7月28日 下午9:31:56
 * @version  	1.0
 */
public class PageMessage {

	public static final String MESSAGE_CODE_UNKOWN_ERROR = "unkownError";
	
	public static final String MESSAGE_CODE_BUSINESS_ERROR = "businessError";
	
	public static final String MESSAGE_CODE_BUSINESS_MESSAGE = "businessMessage";
	
	private String messageCode;
	
	private String messageText;

	public PageMessage() {
		super();
	}

	public PageMessage(String messageCode, String messageText) {
		super();
		this.messageCode = messageCode;
		this.messageText = messageText;
	}

	public String getMessageCode() {
		return messageCode;
	}

	public void setMessageCode(String messageCode) {
		this.messageCode = messageCode;
	}

	public String getMessageText() {
		return messageText;
	}

	public void setMessageText(String messageText) {
		this.messageText = messageText;
	}
	
}
