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
 * 初始化datetimepicker
 */
$('#startTime').datetimepicker({
	language : 'zh-CN',
	minView : 0,
	format : "yyyy-mm-dd hh:ii:00",
	autoclose : true
});
$('#startTime').datetimepicker({
	language : 'zh-CN',
	minView : 0,
	format : "yyyy-mm-dd hh:ii:00",
	autoclose : true
});
$('#selectSeatStartTime').datetimepicker({
	language : 'zh-CN',
	minView : 0,
	format : "yyyy-mm-dd hh:ii:00",
	autoclose : true
});
$('#selectSeatEndTime').datetimepicker({
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

$('#cancelTime').datetimepicker({
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
					xuploadListExtClass : "xupload-list-activity-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-activity-image1"),
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
							activityAddFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#thumbnail");
						$hiddenField.val('');
						activityAddFormValidator.element($hiddenField);
					}
				});

$(".xupload-btn2")
		.xupload(
				{
					xuploadListExtClass : "xupload-list-activity-image",
					maxUpload : 1,
					maxUploadTips : "对不起,最多只能上传{0}个图片!",
					moveable : false,
					fileFormats : [ "jpg", "jpeg", "png" ],
					fileFormatTips : "上传图片格式必须是{0}中的一种!",
					uploadForm : "imageUploadForm",
					uploadListWrapper : $(".xupload-list-activity-image2"),
					uploadCallback : function($uploadBox, resultObj) {
						if (resultObj) {
							var options = this.data("options");
							var $imgWrapper = $uploadBox.children("a");
							$imgWrapper.removeClass(options.uploadingClass);
							var $hiddenField = $("#imgUri");
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
							activityAddFormValidator.element($hiddenField);
						} else {
							alert("上传失败!");
						}
					},
					onUploadBoxRemove : function($uploadBox, $removeElement) {
						$uploadBox.remove();
						var $hiddenField = $("#imgUri");
						$hiddenField.val('');
						activityAddFormValidator.element($hiddenField);
					}
				});

ACTIVITY_TYPE_FORUM_SELECT_SEAT.removeValidateRules = function() {
	$("#lecturer").rules("remove");
	$("#lecturerIntro").rules("remove");
	$("#selectSeatStartTime").rules("remove");
	$("#selectSeatEndTime").rules("remove");
	$("#seatStatuses").rules("remove");
}
function onActivityTypeChange(el) {
	$(".activity-extra").hide();
	ACTIVITY_TYPE_FORUM_SELECT_SEAT.removeValidateRules();

	// 周边活动
	if ($(el).val() == 4) {
		$("#cancelTimeDiv").hide();
		$("#cancelTime").rules("remove");
	} else {

		$("#cancelTimeDiv").show();
		$("#cancelTime").rules("add", {
			required : true,
			messages : {
				required : '请输入活动取消截止时间!'
			}
		});
	}

	var $activityExtra = $(".activity-extra[data-activity-type='" + el.value
			+ "']");
	if ($activityExtra && $activityExtra.length) {
		$activityExtra.show();
		genSeatMatrix();
		if (ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeCode == el.value) {
			ACTIVITY_TYPE_FORUM_SELECT_SEAT.addValidateRules();
		}
	}
}

ACTIVITY_TYPE_FORUM_SELECT_SEAT.addValidateRules = function() {
	$("#lecturer").rules("add", {
		required : true,
		messages : {
			required : '请输入讲师名称!'
		}
	});
	$("#lecturerIntro").rules("add", {
		required : true,
		messages : {
			required : '请输入讲师简介!'
		}
	});
	$("#selectSeatStartTime").rules("add", {
		required : true,
		regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/,
		messages : {
			required : '请选择选座开始时间!',
			regex : '选座开始时间格式不正确!'
		}
	});
	$("#selectSeatEndTime").rules("add", {
		required : true,
		regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/,
		dateTimeGT : '#selectSeatStartTime',
		messages : {
			required : '请选择选座截止时间!',
			regex : '选座截止时间格式不正确!',
			dateTimeGT : '选座截止时间必须大于选座开始时间!'
		}
	});
	$("#seatStatuses").rules("add", {
		required : true,
		messages : {
			required : '请生成座位矩阵图!'
		}
	});
}

var validateOptions = {
	rules : {
		title : {
			required : true
		},
		thumbnail : {
			required : true
		},
		imgUri : {
			required : true
		},
		startTime : {
			required : true,
			regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/
		},
		endTime : {
			required : true,
			regex : /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/
		},
		place : {
			required : true
		},
		traffic : {
			required : true
		},
		decription : {
			required : true
		},
		intro : {
			required : true

		},
		type : {
			required : true
		}
	},
	messages : {
		title : {
			required : '请输入活动标题!'
		},
		thumbnail : {
			required : '请上传活动缩略图片!'
		},
		imgUri : {
			required : '请上传活动图片!'
		},
		startTime : {
			required : '请选择活动开始时间!',
			regex : '活动开始时间格式不正确!'
		},
		endTime : {
			required : '请选择活动开始时间!',
			regex : '活动结束时间格式不正确!'
		},
		place : {
			required : '请输入活动地点!'
		},
		traffic : {
			required : '请填写活动交通!',
		},
		decription : {
			required : '请填写活动简介!',
		},
		intro : {
			required : '请输入活动简介!',
			maxlength : '最多1000字符'
		},
		type : {
			required : '请选择活动类型!'
		}
	}
};

var activityAddFormValidator = $(document.activityAddForm).validate(
		validateOptions);

/**
 * 添加活动
 */
function saveActivity(el) {
	var form = document.activityAddForm;
	var seats = "";
	if (form.type.value == ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeCode) {
		var seatStatuses = buildSeatStatuses();
		if (seatStatuses.length) {
			seats = $.toJSON(seatStatuses);
		}
	}
	var startTime = form.startTime.value;
	var endTime = form.endTime.value;
	var cancelTime = form.cancelTime.value;

	if (startTime > endTime) {
		alert("结束时间必须大于开始时间！");
		return;
	}
	if (cancelTime > startTime) {
		alert("取消时间必须小于开始时间！");
		return;
	}

	form.seatStatuses.value = seats;
	var valid = activityAddFormValidator.form();
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
					url : CONTEXT_PATH + '/admin/activity/add/submit',
					success : function(response) {
						showOrginalText(el);
						if (response) {
							alert(response.message);
							if (response.success) {
								window.location.href = CONTEXT_PATH
										+ '/admin/activity/list';
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