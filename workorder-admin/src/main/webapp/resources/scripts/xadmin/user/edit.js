var userValidateOptions = {
	rules: {
		userId: {
			required: true
		},
		userName: {
			required: true,
			regex: /^[a-zA-Z]{1}[a-zA-Z0-9_]{4,19}$/
		},
		nickName: {
			required: true
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
		userId: {
			required: '未发现角色id!'
		},
		userName: {
			required: '请输入用户名!',
			regex: '用户名必须由字母开头,5~20个字母、数字及下划线组成!'
		},
		nickName: {
			required: '请输入用户昵称!'
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

var passwdValidateOptions = {
	rules: {
		userId: {
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
		}
	},
	messages: {
		userId: {
			required: '未发现用户id!'
		},
		password: {
			required: '账户密码不能为空!',
			regex: '账户密码由6~20个字母、数字及下划线组成!'
		},
		repassword: {
			required: '重复密码不能为空!',
			regex: '账户密码由6~20个字母、数字及下划线组成!',
			equalTo: '两次输入密码不一致!'
		}
	}
};

var userEditFormValidator = $(document.userEditForm).validate(userValidateOptions);
var passwdEditFormValidator = $(document.passwdEditForm).validate(passwdValidateOptions);

/**
 * 修改用户
 */
function saveUser(el){
	var valid = userEditFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.userEditForm.submit();
		},1000);
	}
}
/**
 * 修改密码
 */
function savePasswd(el){
	var valid = passwdEditFormValidator.form();
	if(valid && confirm('你确定要修改账户密码?')){
		showLoadingText(el);
		setTimeout(function(){
			$.ajax({
				async : true,
				cache : false,
				type : 'post',
				dataType : 'json',
				data : $(document.passwdEditForm).serialize(),
				url : document.passwdEditForm.action,
				success : function(response) {
					showOrginalText(el);
					if (response) {
						if(response.success) {
							document.passwdEditForm.reset();
						}
						alert(response.message);
					} else {
						alert('请求失败!');
					}
				},
				error : function() {
					showOrginalText(el);
					alert('请求失败!');
				}
			});
		},1000);
	}
}