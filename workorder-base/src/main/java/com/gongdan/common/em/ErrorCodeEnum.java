package com.gongdan.common.em;

public enum ErrorCodeEnum {

	 	SUCCESS("0","成功"),
	 	USER_NOT_EXIST("1000","用户不存在"),
	 	USER_PWD_ERROR("1001","用户密码错误"),
		FAIL("-1","系统异常")
	 	;
	 	
	 	private String code;
	 	
	 	private String msg;

	 	
	 	
		private ErrorCodeEnum(String code, String msg) {
			this.code = code;
			this.msg = msg;
		}

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}
	 	
	 	
}
