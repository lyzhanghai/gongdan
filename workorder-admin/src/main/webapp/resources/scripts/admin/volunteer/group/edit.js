
var validateOptions = {
	rules: {
		name: {
			required: true
		}
	},
	messages: {
		name: {
			required: '请输入团体名称!'
		}
	}
};

var groupEditFormValidator = $(document.groupEditForm).validate(validateOptions);

/**
 * 保存团体
 */
function saveGroup(el){
	var form = document.groupEditForm;
	var valid = groupEditFormValidator.form();
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
								window.location.href = CONTEXT_PATH + '/admin/volunteer/group/list';
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