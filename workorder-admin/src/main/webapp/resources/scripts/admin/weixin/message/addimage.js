/**
 * 初始化上传组件
 */
$(".xupload-btn").xupload({
	xuploadListExtClass: "xupload-list-message-image",
	maxUpload: 1,
	maxUploadTips: "对不起,最多只能上传{0}个图片!",
	moveable: false,
	fileFormats: ["jpg", "jpeg", "png"],
	fileFormatTips: "上传图片格式必须是{0}中的一种!",
	uploadForm: "imageUploadForm",
	uploadListWrapper: $(".xupload-list-message-image"),
	uploadCallback: function($uploadBox, resultObj){
		if(resultObj){
			var options = this.data("options");
			var $imgWrapper = $uploadBox.children("a");
			$imgWrapper.removeClass(options.uploadingClass);
			var $hiddenField = $("#mediaUrl");
			if(resultObj.success){
				var originalFileName = resultObj.retObj.originalFileName;
				var fileRelativePath = resultObj.retObj.fileRelativePath;
				var fileViewUrl = resultObj.retObj.fileViewUrl;
				$imgWrapper.append('<img title="' + originalFileName + '" src="' + fileViewUrl + '" />');
				$hiddenField.val(fileRelativePath);
			}else{
				$imgWrapper.addClass("xupload-error")
				$imgWrapper.append('<label>' + resultObj.message + '</label>');
				$hiddenField.val('');
			}
			messageAddFormValidator.element($hiddenField);
		}else{
			alert("上传失败!");
		}
	},
	onUploadBoxRemove: function($uploadBox, $removeElement){
		$uploadBox.remove();
		var $hiddenField = $("#mediaUrl");
		$hiddenField.val('');
		messageAddFormValidator.element($hiddenField);
	}
});

var validateOptions = {
	rules: {
		title: {
			required: true
		},
		mediaType: {
			required: true
		},
		mediaUrl: {
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
		mediaUrl: {
			required: '请选择上传图片!'
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
					url : CONTEXT_PATH + '/admin/weixin/message/addimage/submit',
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
		mediaUrl: form.mediaUrl.value
	};
	form.messageItemsJson.value = $.toJSON([obj])
}