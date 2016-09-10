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
					fileFormats : [ "jpg", "jpeg", "png","gif"],
					fileFormatTips : "上传文件格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-banner-image"),
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $imageWrapper = $uploadBox.children("a");
							$imageWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#logo");
							if (resultObj.success) {
								var originalFileName = resultObj.retObj.originalFileName;
								var fileRelativePath = resultObj.retObj.fileRelativePath;
								var fileViewUrl = resultObj.retObj.fileViewUrl;
								$imageWrapper.append('<img title="'+ originalFileName + '" src="'+ fileViewUrl + '" />');
								$hiddenField.val(fileRelativePath);
							} else {
								$imageWrapper.addClass('xupload-error');
								$imageWrapper.append('<label>'+resultObj.message+'</label>');
								$hiddenField.val('');
							}
							clubAddFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#filePath");
						$hiddenField.val('');
						clubAddFormValidator.element($hiddenField);
					}
				});

var validateOptions = {
	rules : {
		orderNum: {
			required: true,
			regex : /^\d{1,10}$/ 
		},
		areainfo : {
			required : true
		},
		name : {
			required : true
		},
		logo : {
			required : true
		}
	},
	messages : {
		orderNum: {
			required: '请输入排序编号，不能为空且要10位以内有效数字!',
			regex : '请输入排序编号，不能为空且要10位以内有效数字!'
		},
		areainfo : {
			required : '未找到匹配的区域编号!'
		},
		name : {
			required : '请输入俱乐部名称!'
		},
		logo : {
			required : '请上传俱乐部logo图片!'
		}
	}
};

var clubAddFormValidator = $(document.clubAddForm).validate(validateOptions);

/**
 * 添加俱乐部
 */
function saveClub(el){
	var valid = clubAddFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.clubAddForm.submit();
		},1000);
	}
}