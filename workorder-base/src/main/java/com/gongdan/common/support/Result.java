package com.gongdan.common.support;

import com.gongdan.common.consts.GlobalConstants;


/**
 * 通用返回结果类
 *
 * @param <T>
 * @author pengpeng
 * @version 1.0
 * @date 2014年6月13日 上午8:59:37
 */
public class Result<T> {

	/** 成功与否 */
    private boolean success;

    /** 结果代码 */
    private String resultCode;
    
    /** 消息 */
    private String resultMsg;
    
    /** 结果数据 */
    private T resultData;
    
	public Result() {
		super();
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}


	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public T getResultData() {
		return resultData;
	}

	public void setResultData(T resultData) {
		this.resultData = resultData;
	}
	
	


	
}
