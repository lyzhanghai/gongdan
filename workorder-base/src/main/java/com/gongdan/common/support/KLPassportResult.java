package com.gongdan.common.support;

/**
 * 狂龙通行证接口返回结果
 * @param <T>
 * @author  pengpeng
 * @date 	 2016年4月20日 上午10:00:42
 * @version 1.0
 */
public class KLPassportResult<T> {

	public static final int DEFAULT_SUCCESS_CODE = 200;
	
	/** 200 - 成功 */
	private int code;
	
	private String message;
	
	private KLPassportResponse<T> data;
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public KLPassportResponse<T> getData() {
		return data;
	}

	public void setData(KLPassportResponse<T> data) {
		this.data = data;
	}

	public static class KLPassportResponse<T> {
		
		private T response;
		
		private long time;

		public T getResponse() {
			return response;
		}

		public void setResponse(T response) {
			this.response = response;
		}

		public long getTime() {
			return time;
		}

		public void setTime(long time) {
			this.time = time;
		}
		
	}
	
}
