package com.gongdan.em;

public enum ErrorCodeEnum {

	 	SUCCESS(0,"成功"),FAIL(1,"系统异常");
	 	
	 	private int code;
	 	
	 	private String msg;

	 	
	 	
		private ErrorCodeEnum(int code, String msg) {
			this.code = code;
			this.msg = msg;
		}

		public int getCode() {
			return code;
		}

		public void setCode(int code) {
			this.code = code;
		}

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}
	 	
	 	
}
