var validateOptions = {
	rules: {
		roleId: {
			required: true
		},
		roleName: {
			required: true
		},
		roleCode: {
			required: true,
			regex: /^[a-zA-Z0-9_]{1,50}$/
		}
	},
	messages: {
		roleId: {
			required: '未发现角色ID!'
		},
		roleName: {
			required: '请输入角色名称!'
		},
		roleCode: {
			required: '请输入角色代码!',
			regex: '角色代码由不超过50个字母、数字、下划线组成!'
		}
	}
};

var roleEditFormValidator = $(document.roleEditForm).validate(validateOptions);

/**
 * 修改角色
 */
function saveRole(el){
	var valid = roleEditFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.roleEditForm.submit();
		},1000);
	}
}