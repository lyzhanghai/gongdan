var introEditor = UE.getEditor('intro', {
	enableAutoSave : false,
	initialFrameHeight : 350,
	serverUrl : CONTEXT_PATH + '/ueditor/config',
	toolbars : [ [ 'source', // 源代码
	'undo', // 撤销
	'redo', // 重做
	'bold', // 加粗
	'indent', // 首行缩进
	'italic', // 斜体
	'underline', // 下划线
	'strikethrough', // 删除线
	'subscript', // 下标
	'superscript', // 上标
	'formatmatch', // 格式刷
	'pasteplain', // 纯文本粘贴模式
	'horizontal', // 分隔线
	'removeformat', // 清除格式
	'time', // 时间
	'date', // 日期
	'link', // 超链接
	'unlink', // 取消链接
	'cleardoc', // 清空文档
	'preview', // 预览
	'fullscreen' // 全屏
	], [ 'fontfamily', // 字体
	'fontsize', // 字号
	'paragraph', // 段落格式
	'customstyle', // 自定义标题
	'inserttable', // 插入表格
	'insertrow', // 前插入行
	'insertcol', // 前插入列
	'mergeright', // 右合并单元格
	'mergedown', // 下合并单元格
	'deleterow', // 删除行
	'deletecol', // 删除列
	'mergecells', // 合并多个单元格
	'deletetable', // 删除表格
	'insertparagraphbeforetable', // "表格前插入行"
	'edittable', // 表格属性
	'edittd' // 单元格属性
	], [ 'justifyleft', // 居左对齐
	'justifyright', // 居右对齐
	'justifycenter', // 居中对齐
	'justifyjustify', // 两端对齐
	'forecolor', // 字体颜色
	'backcolor', // 背景色
	'insertorderedlist', // 有序列表
	'insertunorderedlist', // 无序列表
	'directionalityltr', // 从左向右输入
	'directionalityrtl', // 从右向左输入
	'rowspacingtop', // 段前距
	'rowspacingbottom', // 段后距
	'imagenone', // 默认
	'imageleft', // 左浮动
	'imageright', // 右浮动
	'imagecenter', // 居中
	'lineheight', // 行间距
	'autotypeset' // 自动排版
	] ]
});

/**
 * 初始化上传组件
 */
$("#xupload-btn1")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-culture-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $("#xupload-list-culture-image1"),
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {

							var options = this.data("options");
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#smallImage");
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
							cultureAddFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#smallImage");
						$hiddenField.val('');
						cultureAddFormValidator.element($hiddenField);
					}
				});
$("#xupload-btn2")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-culture-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $("#xupload-list-culture-image2"),
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
							cultureAddFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#imageUrl");
						$hiddenField.val('');
						cultureAddFormValidator.element($hiddenField);
					}
				});

var addRule = function(obj) {

	if ($(obj).val() == 1) {
		$("#show1").show();
		$("#show2").show();
		$("#smallImgspan").text("图片限1M以内,支持jpg/png/gif，尺寸164x224");
		$("#imageUrlspan").text("图片限1M以内,支持jpg/png/gif，尺寸 750x360");
		ruleDSJ();
	} else {

		removeRule();

		if ($(obj).val() == 2) {
			$("#imageUrlspan").text("图片限1M以内,支持jpg/png/gif，尺寸400x500");
		} else {
			$("#imageUrlspan").text("图片限1M以内,支持jpg/png/gif，尺寸750x850");
		}

		$("#show1").hide();
		$("#show2").hide();
	}
}

var removeRule = function() {
	$("#decription").rules("remove");
	$("#smallImage").rules("remove");
}
var ruleDSJ = function() {

	$("#decription").rules("add", {
		required : true,
		messages : {
			required : '请输入大事记简介!'
		}
	});
	$("#smallImage").rules("add", {
		required : true,
		messages : {
			required : '请输入大事记缩略图!'
		}
	});

}
var validateOptions = {
	rules : {
		title : {
			required : true
		},
		imageUrl : {
			required : true
		},
		categoryId : {
			required : true
		},
		intro : {
			required : true

		}
	},
	messages : {
		title : {
			required : '请输入活动标题!'
		},
		imageUrl : {
			required : '请上传活动图片!'
		},
		categoryId : {
			required : '请选志愿文化分类!'
		},
		intro : {
			required : '请输入活动简介!'
		}
	}
};

var cultureAddFormValidator = $(document.cultureAddForm).validate(
		validateOptions);

/**
 * 添加活动
 */
function saveCulture(el) {
	var form = document.cultureAddForm;
	var valid = cultureAddFormValidator.form();
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
										+ '/admin/volunteer/culture/list';
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