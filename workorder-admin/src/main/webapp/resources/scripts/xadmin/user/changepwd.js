var changePwdValidateOptions = {
	rules: {
		userId: {
			required: true
		},
		oldpassword: {
			required: true,
			regex: /^[a-zA-Z0-9_]{6,20}$/
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
		oldpassword: {
			required: '旧密码不能为空!',
			regex: '密码由6~20个字母、数字及下划线组成!'
		},
		password: {
			required: '新密码不能为空!',
			regex: '密码由6~20个字母、数字及下划线组成!'
		},
		repassword: {
			required: '重复新密码不能为空!',
			regex: '密码由6~20个字母、数字及下划线组成!',
			equalTo: '两次输入密码不一致!'
		}
	}
};

var changePwdFormValidator = $(document.changePwdForm).validate(changePwdValidateOptions);

/**
 * 修改密码
 */
function changePwd(el){
	var valid = changePwdFormValidator.form();
	if(valid && confirm('你确定要修改账户密码?')){
		showLoadingText(el);
		setTimeout(function(){
			$.ajax({
				async : true,
				cache : false,
				type : 'post',
				dataType : 'json',
				data : $(document.changePwdForm).serialize(),
				url : document.changePwdForm.action,
				success : function(response) {
					showOrginalText(el);
					if (response) {
						if(response.success) {
							document.changePwdForm.reset();
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