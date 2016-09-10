/**
 * 初始化上传组件
 */
$(".xupload-btn").xupload({
	xuploadListExtClass: "xupload-list-message-video",
	maxUpload: 1,
	maxUploadTips: "对不起,最多只能上传{0}个视频文件!",
	moveable: false,
	fileFormats: ["mp4"],
	fileFormatTips: "上传视频文件格式必须是{0}中的一种!",
	uploadForm: "fileUploadForm",
	uploadListWrapper: $(".xupload-list-message-video"),
	uploadCallback: function($uploadBox, resultObj){
		if(resultObj){
			var options = this.data("options");
			var $imgWrapper = $uploadBox.children("a");
			$imgWrapper.removeClass(options.uploadingClass);
			var $hiddenField = $("#mediaUrl");
			if(resultObj.success){
				var originalFileName = resultObj.retObj.originalFileName;
				var fileRelativePath = resultObj.retObj.fileRelativePath;
				var fileViewUrl = CONTEXT_PATH + '/resources/components/jquery.xupload/images/green/xupload-file-success-icon-128.png';
				$imgWrapper.append('<img title="' + originalFileName + '" src="' + fileViewUrl + '" /><h5>' + originalFileName + '</h5>');
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
		description: {
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
		description: {
			required: '请输入消息描述!'
		},
		mediaUrl: {
			required: '请选择上传视频!'
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
					url : CONTEXT_PATH + '/admin/weixin/message/addvideo/submit',
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
		mediaUrl: form.mediaUrl.value,
		description: form.description.value
	};
	form.messageItemsJson.value = $.toJSON([obj])
}