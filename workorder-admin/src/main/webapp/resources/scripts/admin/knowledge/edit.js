/**
 * 初始化上传组件,初始化一些文件的大小和类型以及上传路径
 */
$(".xupload-btn")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-banner-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个文件!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png","doc","docx","txt","gif","mp4","avi","pdf","ppt","rmvb","xls"],
					fileFormatTips : "上传文件格式必须是{0}中的一种!",
					uploadForm : "fileUploadForm",
					uploadListWrapper : $(".xupload-list-banner-image"),
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $fileWrapper = $uploadBox.children("a");
							$fileWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#filePath");
							if (resultObj.success) {
								var originalFileName = resultObj.retObj.originalFileName;
								var fileRelativePath = resultObj.retObj.fileRelativePath;
								var fileViewUrl = resultObj.retObj.fileViewUrl;
								$("#fileName").html(originalFileName);
								$hiddenField.val(fileRelativePath);
							} else {
								$fileWrapper.addClass('xupload-error');
								$fileWrapper.append('<label>'+resultObj.message+'</label>');
								$hiddenField.val('');
							}
							knowledgeAddFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#filePath");
						$hiddenField.val('');
						$("#fileName").empty();
						knowledgeAddFormValidator.element($hiddenField);
					}
				});

var validateOptions = {
	rules : {
		title : {
			required : true
		}
	},
	messages : {
		title : {
			required : '请输入知识标题!'
		}
	}
};

var knowledgeEditFormValidator = $(document.knowledgeEditForm).validate(validateOptions);

/**
 * 修改知识
 */
function editKnowledge(el){
	var valid = knowledgeEditFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.knowledgeEditForm.submit();
		},1000);
	}
}

function getType(obj) {
	var typeid=$("#fileType option:selected").val();
	if(typeid==1){
		$(":file").attr("accept",".txt,.doc,.docx,.xls,.ppt");
	}else if(typeid==2){
		$(":file").attr("accept",".mp4,.rmvb,.avi");
	}else if(typeid==3){
		$(":file").attr("accept",".jpg,.jpeg,.gif,.png");
	}else{
		$(":file").attr("accept",".pdf");
	}
}