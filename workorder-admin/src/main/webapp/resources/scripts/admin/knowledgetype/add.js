var validateOptions = {
	rules: {
		name: {
			required: true
		},
		orderNum: {
			required: true,
			regex : /^\d{1,10}$/ 
		}
	},
	messages: {
		name: {
			required: '请输入知识类别名称，不能为空!'
		},
		orderNum: {
			required: '请输入排序编号，不能为空且要10位以内有效数字!',
			regex : '请输入排序编号，不能为空且要10位以内有效数字!'
		}
	}
};

var knowledgeTypeFormValidator = $(document.knowledgeTypeForm).validate(validateOptions);

/**
 * 添加知识类别
 */
function saveknowledgeType(el){
	var valid = knowledgeTypeFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.knowledgeTypeForm.submit();
		},1000);
	}
}