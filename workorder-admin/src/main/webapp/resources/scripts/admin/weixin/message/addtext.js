var validateOptions = {
	rules: {
		title: {
			required: true
		},
		mediaType: {
			required: true
		},
		description: {
			required: true
		}
	},
	messages: {
		title: {
			required: '请输入消息标题!'
		},
		mediaType: {
			required: '请选择消息类型!'
		},
		description: {
			required: '请输入消息描述!'
		}
	}
};

var messageAddFormValidator = $(document.messageAddForm).validate(validateOptions);

function saveMessage(el){
	var valid = messageAddFormValidator.form();
	if(valid){
		var form = document.messageAddForm;
		buildMessageItemJson(form);
		if(isSubmitable(el)){
			showLoadingText(el);
			setTimeout(function(){
				$.ajax({
					async : true,
					cache : false,
					type : 'post',
					dataType : 'json',
					data : $(form).serialize(),
					url : CONTEXT_PATH + '/admin/weixin/message/addtext/submit',
					success : function(response) {
						showOrginalText(el);
						if (response) {
							alert(response.message);
							if(response.success) {
								window.location.href = CONTEXT_PATH + '/admin/weixin/message/list';
							}
						} else {
							alert('请求失败!');
						}
						afterSubmited(el);
					},
					error : function() {
						alert('请求失败!');
						afterSubmited(el);
						showOrginalText(el);
					}
				});
			});
		}
	}
}

function buildMessageItemJson(form){
	var obj = {
		description: form.description.value
	};
	form.messageItemsJson.value = $.toJSON([obj])
}