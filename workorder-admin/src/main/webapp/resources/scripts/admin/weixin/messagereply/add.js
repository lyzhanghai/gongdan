var messageReplyAddFormValidator = null;

var validateOptions = {
	rules: {
		keyword: {
			required: true
		},
		matchMode: {
			required: true
		},
		msgId: {
			required: true,
			digits: true
		}
	},
	messages: {
		keyword: {
			required: '请输入匹配关键字!'
		},
		matchMode: {
			required: '请选择匹配模式!'
		},
		msgId: {
			required: '请输入关联消息ID!',
			digits: '关联消息ID必须是整数!'
		}
	}
};

messageReplyAddFormValidator = $(document.messageReplyAddForm).validate(validateOptions);

/**
 * 新增自动回复
 */
function saveMessageReply(el){
	var valid = messageReplyAddFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.messageReplyAddForm.submit();
		},1000);
	}
}