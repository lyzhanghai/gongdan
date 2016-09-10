var ValidateOptions = {
	rules: {
		id: {
			required: true
		},
		name: {
			required: true,
		},
		orderNum: {
			required: true,
			regex : /^\d{1,10}$/ 
		}
	},
	messages: {
		id: {
			required: '未发现知识类别id!'
		},
		name: {
			required: '请输入知识类别名称，不能为空!',
		},
		orderNum: {
			required: '请输入排序编号，不能为空且要10位以内有效数字!',
			regex : '请输入排序编号，不能为空且要10位以内有效数字!'
		}
	}
};

var knowledgeTypeAddFormValidator = $(document.knowledgeTypeAddForm).validate(ValidateOptions);

/**
 * 修改知识类别
 */
function saveknowledgeType(el){
	var valid = knowledgeTypeAddFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.knowledgeTypeAddForm.submit();
		},1000);
	}
}