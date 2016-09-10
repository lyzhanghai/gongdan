var menuAddFormValidator = null;

var validateOptions = {
	rules: {
		parentMenuId: {
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
		parentMenuId: {
			required: '请选择父级菜单!'
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

menuAddFormValidator = $(document.menuAddForm).validate(validateOptions);

/**
 * 新增菜单
 */
function saveMenu(el){
	var valid = menuAddFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.menuAddForm.submit();
		},1000);
	}
}