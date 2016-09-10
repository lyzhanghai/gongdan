var messageReplyEditFormValidator = null;

var validateOptions = {
	rules: {
		id: {
			required: true
		},
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
		id: {
			required: '未发现自动回复ID'
		},
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

messageReplyEditFormValidator = $(document.messageReplyEditForm).validate(validateOptions);

/**
 * 修改自动回复
 */
function saveMessageReply(el){
	var valid = messageReplyEditFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.messageReplyEditForm.submit();
		},1000);
	}
}