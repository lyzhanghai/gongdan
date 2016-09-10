
var validateOptions = {
	rules: {
		name: {
			required: true
		}
	},
	messages: {
		name: {
			required: '请输入分类名称!'
		}
	}
};

var categoryEditFormValidator = $(document.categoryEditForm).validate(validateOptions);

/**
 * 添加分类
 */
function saveCategory(el){
	var form = document.categoryEditForm;
	var valid = categoryEditFormValidator.form();
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
								window.location.href = CONTEXT_PATH + '/admin/volunteer/category/list';
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