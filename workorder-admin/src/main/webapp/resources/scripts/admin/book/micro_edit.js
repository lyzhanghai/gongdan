/**
 * 初始化上传组件
 */
$(".xupload-btn")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-book-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-book-image"),
					onInit : function(delegate, options) { // 初始化已上传的图片
						var coverUrl = $("#picUrl").val();
						if (coverUrl) {
							var $uploadBox = options.createUploadBox.call(this,
									options.uploadListWrapper, delegate
											.randomID(), false);
							delegate._bindBoxEvent.call(this, $uploadBox);
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper
									.append('<img src="' + coverUrl + '" />');
						}
					},
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#pic");
							if (resultObj.success) {
								var originalFileName = resultObj.retObj.originalFileName;
								var fileRelativePath = resultObj.retObj.fileRelativePath;
								var fileViewUrl = resultObj.retObj.fileViewUrl;
								$imgWrapper.append('<img title="'
										+ originalFileName + '" src="'
										+ fileViewUrl + '" />');
								$hiddenField.val(fileRelativePath);
							} else {
								$imgWrapper.addClass('xupload-error');
								$imgWrapper.append('<label>'
										+ resultObj.message + '</label>');
								$hiddenField.val('');
							}
							bookEditFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#pic");
						$hiddenField.val('');
						bookEditFormValidator.element($hiddenField);
					}
				});

var validateOptions = {
	rules : {
		title : {
			required : true
		},
		pic : {
			required : true
		},
		description : {
			required : true
		},
		url : {
			required : true
		},
		categoryId : {
			required : true
		}
	},
	messages : {
		title : {
			required : '请输入标题'
		},
		pic : {
			required : '请上传缩略图'
		},
		description : {
			required : '请填写简介'
		},
		url : {
			required : '请填写url地址'
		},
		categoryId : {
			required : '请选择分类'
		}
	}
};

var bookEditFormValidator = $(document.bookEditForm).validate(validateOptions);

/**
 * 保存活动
 */
function saveBook(el) {
	var form = document.bookEditForm;
	var valid = bookEditFormValidator.form();
	if (valid) {
		if (isSubmitable(el)) {
			showLoadingText(el);
			setTimeout(function() {
				$.ajax({
					async : true,
					cache : false,
					type : 'post',
					dataType : 'json',
					data : $(form).serialize(),
					url : CONTEXT_PATH + '/admin/book/micro/edit/submit',
					success : function(response) {
						showOrginalText(el);
						if (response) {
							alert(response.message);
							if (response.success) {
								window.location.href = CONTEXT_PATH
										+ '/admin/micro/book/list';
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