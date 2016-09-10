var validateOptions = {
	rules: {
		userName: {
			required: true,
			regex: /^[a-zA-Z]{1}[a-zA-Z0-9_]{4,19}$/
		},
		nickName: {
			required: true
		},
		password: {
			required: true,
			regex: /^[a-zA-Z0-9_]{6,20}$/
		},
		repassword: {
			required: true,
			regex: /^[a-zA-Z0-9_]{6,20}$/,
			equalTo: "#password"
		},
		mobilePhone: {
			required: true,
			regex: /^1[0-9]{2}[0-9]{8}$/
		},
		email: {
			required: true,
			email: true
		}
	},
	messages: {
		userName: {
			required: '请输入用户名!',
			regex: '用户名必须由字母开头,5~20个字母、数字及下划线组成!'
		},
		nickName: {
			required: '请输入用户昵称!'
		},
		password: {
			required: '账户密码不能为空!',
			regex: '账户密码由6~20个字母、数字及下划线组成!'
		},
		repassword: {
			required: '重复密码不能为空!',
			regex: '账户密码由6~20个字母、数字及下划线组成!',
			equalTo: '两次输入密码不一致!'
		},
		mobilePhone: {
			required: '请输入手机号码!',
			regex: '手机号码不合法!'
		},
		email: {
			required: 'Email不能为空!',
			email: 'Email输入不合法!'
		}
	}
};

var userAddFormValidator = $(document.userAddForm).validate(validateOptions);

/**
 * 添加用户
 */
function saveUser(el){
	var valid = userAddFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.userAddForm.submit();
		},1000);
	}
}