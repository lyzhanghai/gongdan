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
								+ $("#logo").val() + '" />');
					},
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#logo");
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
							cultureEditFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#logo");
						$hiddenField.val('');
						cultureEditFormValidator.element($hiddenField);
					}
				});

var validateOptions = {
	rules : {
		name : {
			required : true
		},
		logo : {
			required : true
		},
		
	},
	messages : {
		name : {
			required : '请输入文化动态标题!'
		},
		logo : {
			required : '请上传logo图片!'
		},
	}
};

var cultureEditFormValidator = $(document.cultureEditForm).validate(
		validateOptions);

/**
 * 添加Banner
 */


	function savelogo(el){
		var valid = cultureEditFormValidator.form();
		if(valid){
			showLoadingText(el);
			setTimeout(function(){
				document.cultureEditForm.submit();
			},1000);
		}
	}

