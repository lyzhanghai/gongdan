/**
 * 初始化上传组件
 */
$(".xupload-btn")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-banner-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-banner-image"),
					onInit : function(delegate, options) { // 初始化已上传的图片
						var $uploadBox = options.createUploadBox.call(this,
								options.uploadListWrapper, delegate.randomID(),
								false);
						delegate._bindBoxEvent.call(this, $uploadBox);
						var $imgWrapper = $uploadBox.children("a");
						$imgWrapper.append('<img src="'
								+ $("#fullImageUrl").val() + '" />');
					},
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#imageUrl");
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
							bannerEditFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#imageUrl");
						$hiddenField.val('');
						bannerEditFormValidator.element($hiddenField);
					}
				});

var validateOptions = {
	rules : {
		id : {
			required : true
		},
		title : {
			required : true
		},
		imageUrl : {
			required : true
		},
		type : {
			required : true
		}
	},
	messages : {
		id : {
			required : '未发现ID'
		},
		title : {
			required : '请输入Banner标题!'
		},
		imageUrl : {
			required : '请上传Banner图片!'
		},
		type : {
			required : '请选择Banner类型!'
		}
	}
};

var bannerEditFormValidator = $(document.bannerEditForm).validate(
		validateOptions);

/**
 * 添加Banner
 */
function saveBanner(el) {
	var form = document.bannerEditForm;
	var valid = bannerEditFormValidator.form();
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
					url : form.action,
					success : function(response) {
						showOrginalText(el);
						if (response) {
							alert(response.message);
							if (response.success) {
								window.location.href = CONTEXT_PATH
										+ '/admin/banner/list';
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

function getUrl(obj) {
	if ($(obj).val() == 6) {
		$("#bannerDiv").hide();
	} else {
		$("#bannerDiv").show();
	}

}