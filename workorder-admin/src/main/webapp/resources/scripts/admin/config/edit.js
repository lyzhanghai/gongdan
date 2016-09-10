var validateOptions = {
	rules: {
		optionsValue: {
			required: true
		}
	},
	messages: {
		optionsValue: {
			required: '请输入配置项的值!'
		}
	}
};

var configEditFormValidator = $(document.configEditForm).validate(validateOptions);

/**
 * 保存配置
 */
function saveConfig(el){
	var form = document.configEditForm;
	var valid = configEditFormValidator.form();
	if(valid){
		if(isSubmitable(el)){
			showLoadingText(el);
			setTimeout(function(){
				$.ajax({
					async : true,
					cache : false,
					type : 'post',
					dataType : 'json',
					data : $(form).serialize(),
					url : form.action,
					success : function(response) {
						showOrginalText(el);
						if (response) {
							alert(response.message);
							if(response.success) {
								window.location.href = CONTEXT_PATH + '/admin/config/list';
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