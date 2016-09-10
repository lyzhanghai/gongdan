var introEditor = UE.getEditor('intro', {
	enableAutoSave : false,
	initialFrameHeight : 500,
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

$(function() {
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
});

/**
 * 初始化上传组件
 */
$(".xupload-btn1")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-coupon-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-coupon-image1"),
					onInit : function(delegate, options) { // 初始化已上传的图片
						var $uploadBox = options.createUploadBox.call(this,
								options.uploadListWrapper, delegate.randomID(),
								false);
						delegate._bindBoxEvent.call(this, $uploadBox);
						var $imgWrapper = $uploadBox.children("a");
						$imgWrapper.append('<img src="'
								+ $("#fullThumbnail").val() + '" />');
					},
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
							couponEditFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#thumbnail");
						$hiddenField.val('');
						couponEditFormValidator.element($hiddenField);
					}
				});

$(".xupload-btn2")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-coupon-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-coupon-image2"),
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
							couponEditFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#imageUrl");
						$hiddenField.val('');
						couponEditFormValidator.element($hiddenField);
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
		startTime : {
			required : true,
			regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/
		},
		endTime : {
			required : true,
			regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/,
			dateTimeGT : "#startTime"
		},
		intro : {
			required : true
		},
		inventory : {
			required : true,
			regex : /^\d+$/
		},
		userLimit : {
			required : true,
			regex : /^\d+$/
		}
	},
	messages : {
		id : {
			required : '未发现优惠券ID!'
		},
		title : {
			required : '请输入优惠券标题!'
		},
		imageUrl : {
			required : '请上传优惠券图片!'
		},
		startTime : {
			required : '请选择优惠券开始使用时间!',
			regex : '优惠券开始使用时间格式不正确!'
		},
		endTime : {
			required : '请选择优惠券结束使用时间!',
			regex : '优惠券结束使用时间格式不正确!',
			dateTimeGT : '优惠券结束使用时间必须大于开始使用时间!'
		},
		intro : {
			required : '请输入优惠券简介!'
		},
		inventory : {
			required : '请输入优惠券库存!',
			regex : '优惠券库存数必须为非负整数!'
		},
		userLimit : {
			required : '请输入每人限领数!',
			regex : '每人限领数必须为非负整数!'
		}
	}
};

var couponEditFormValidator = $(document.couponEditForm).validate(
		validateOptions);

/**
 * 添加优惠券
 */
function saveCoupon(el) {
	var form = document.couponEditForm;
	var valid = couponEditFormValidator.form();
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
										+ '/admin/coupon/list';
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