/**
 * 初始化datetimepicker
 */
$('#startTime').datetimepicker({
	language : 'zh-CN',
	minView : 0,
	format : "yyyy-mm-dd hh:ii:00",
	autoclose : true
});

$('#endTime').datetimepicker({
	language : 'zh-CN',
	minView : 0,
	format : "yyyy-mm-dd hh:ii:00",
	autoclose : true
});

/**
 * 初始化上传组件
 */
$(".xupload-btn1")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-product-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-product-image1"),
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#thumbnail");
							if (resultObj.success) {
								var originalFileName = resultObj.retObj.originalFileName;
								var fileRelativePath = resultObj.retObj.fileRelativePath;
								var fileViewUrl = resultObj.retObj.fileViewUrl;
								$("#fullThumbnail").hide();
								$imgWrapper.append('<img title="'
										+ originalFileName + '" src="'
										+ fileViewUrl + '" />');
								$hiddenField.val(fileRelativePath);
							} else {
								$imgWrapper
										.append('<label class="xupload-error">'
												+ resultObj.message
												+ '</label>');
								$hiddenField.val('');
							}
							bookEditFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#thumbnail");
						$hiddenField.val('');
						bookEditFormValidator.element($hiddenField);
					}
				});

$(".xupload-btn2")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-product-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-product-image2"),
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#imageUri");
							if (resultObj.success) {
								var originalFileName = resultObj.retObj.originalFileName;
								var fileRelativePath = resultObj.retObj.fileRelativePath;
								var fileViewUrl = resultObj.retObj.fileViewUrl;
								$("#imageUrl").hide();
								$imgWrapper.append('<img title="'
										+ originalFileName + '" src="'
										+ fileViewUrl + '" />');
								$hiddenField.val(fileRelativePath);
							} else {
								$imgWrapper
										.append('<label class="xupload-error">'
												+ resultObj.message
												+ '</label>');
								$hiddenField.val('');
							}
							bookEditFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#imageUri");
						$hiddenField.val('');
						bookEditFormValidator.element($hiddenField);
					}
				});

var validateOptions = {
	rules : {
		title : {
			required : true
		},
		thumbnail : {
			required : true
		},
		imageUri : {
			required : true
		},
		score : {
			required : true,
			digits : true
		},
		startTime : {
			required : true,
			regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/
		},
		endTime : {
			required : true,
			regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/
		},
		phoneNum : {
			required : true
		},
		exchangeRule : {
			required : true
		},
		numLimit : {

			range : [ 1, 90000000 ]
		}

	},
	messages : {
		title : {
			required : '请输入标题'
		},
		thumbnail : {
			required : '请选择缩略图片'
		},
		imageUri : {
			required : '请选择图片'
		},
		score : {
			required : '请输入积分'
		},
		startTime : {
			required : '请输入开始时间',
			regex : '格式错误，示例：2015-11-01 10:01:00'
		},
		endTime : {
			required : '请输入结束时间',
			regex : '格式错误，示例：2015-11-01 10:01:00'
		},
		phoneNum : {
			required : '请输入手机号'
		},
		exchangeRule : {
			required : '请输入兑换规则'
		},
		numLimit : {

			range : "输出正确数量，范围1-90000000"
		}
	}
};

var productEditFormValidator = $(document.productEditForm).validate(
		validateOptions);

/**
 * 保存活动
 */
function saveProduct(el) {
	var form = document.productEditForm;
	if (form.startTime.value > form.endTime.value) {

		alert("开始时间必须小于结束时间");
		return;
	}

	var valid = productEditFormValidator.form();
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
					url : CONTEXT_PATH + '/admin/scoreProduct/edit/submit',
					success : function(response) {
						showOrginalText(el);
						if (response) {
							alert(response.message);
							if (response.success) {
								window.location.href = CONTEXT_PATH
										+ '/admin/scoreProduct/list';
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