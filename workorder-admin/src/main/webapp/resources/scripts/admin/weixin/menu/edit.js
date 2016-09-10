var menuEditFormValidator = null;

var validateOptions = {
	rules: {
		menuId: {
			required: true
		},
		menuName: {
			required: true
		},
		siblingsIndex: {
			required: true,
			digits: true
		}
	},
	messages: {
		menuId: {
			required: '未发现菜单ID!'
		},
		menuName: {
			required: '请输入菜单名称!'
		},
		siblingsIndex: {
			required: '请输入菜单排序号!',
			digits: '菜单排序号必须是整数!'
		}
	}
};

menuEditFormValidator = $(document.menuEditForm).validate(validateOptions);

/**
 * 修改菜单
 */
function saveMenu(el){
	var valid = menuEditFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.menuEditForm.submit();
		},1000);
	}
}