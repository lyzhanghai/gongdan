var validateOptions = {
	rules: {
		roleName: {
			required: true
		},
		roleCode: {
			required: true,
			regex: /^[a-zA-Z0-9_]{1,50}$/
		}
	},
	messages: {
		roleName: {
			required: '请输入角色名称!'
		},
		roleCode: {
			required: '请输入角色代码!',
			regex: '角色代码由不超过50个字母、数字、下划线组成!'
		}
	}
};

var roleAddFormValidator = $(document.roleAddForm).validate(validateOptions);

/**
 * 添加角色
 */
function saveRole(el){
	var valid = roleAddFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.roleAddForm.submit();
		},1000);
	}
}