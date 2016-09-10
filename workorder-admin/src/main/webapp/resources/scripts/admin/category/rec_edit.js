var validateOptions = {
	rules : {
		categoryName : {
			required : true
		}
	},
	messages : {
		categoryName : {
			required : '请输入标题'
		}
	}
};

var categoryEditFormValidator = $(document.categoryEditForm).validate(
		validateOptions);

/**
 * 保存活动
 */
function saveBook(el) {
	var form = document.categoryEditForm;
	var valid = categoryEditFormValidator.form();
	if (valid) {
		if (isSubmitable(el)) {
			showLoadingText(el);
			setTimeout(function() {
				$
						.ajax({
							async : true,
							cache : false,
							type : 'post',
							dataType : 'json',
							data : $(form).serialize(),
							url : CONTEXT_PATH
									+ '/admin/microrec/category/edit/submit',
							success : function(response) {
								showOrginalText(el);
								if (response) {
									alert(response.message);
									if (response.success) {
										window.location.href = CONTEXT_PATH
												+ '/admin/microrec/category/list';
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