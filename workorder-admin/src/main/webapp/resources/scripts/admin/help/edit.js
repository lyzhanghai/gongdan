var introEditor = UE.getEditor('content',{
	enableAutoSave: false,
    initialFrameHeight: 350,
	serverUrl: CONTEXT_PATH + '/ueditor/config',
	toolbars: [
	           [
	               'source', //源代码
	               'undo', //撤销
	               'redo', //重做
	               'bold', //加粗
	               'indent', //首行缩进
	               'italic', //斜体
	               'underline', //下划线
	               'strikethrough', //删除线
	               'subscript', //下标
	               'superscript', //上标
	               'formatmatch', //格式刷
	               'pasteplain', //纯文本粘贴模式
	               'horizontal', //分隔线
	               'removeformat', //清除格式
	               'time', //时间
	               'date', //日期
	               'link', //超链接
	               'unlink', //取消链接
	               'cleardoc', //清空文档
	               'preview', //预览
	               'fullscreen' //全屏
	           ],[
				   'fontfamily', //字体
				   'fontsize', //字号
				   'paragraph', //段落格式
				   'customstyle', //自定义标题
	               'inserttable', //插入表格
	               'insertrow', //前插入行
	               'insertcol', //前插入列
	               'mergeright', //右合并单元格
	               'mergedown', //下合并单元格
	               'deleterow', //删除行
	               'deletecol', //删除列
	               'mergecells', //合并多个单元格
	               'deletetable', //删除表格
	               'insertparagraphbeforetable', //"表格前插入行"
	               'edittable', //表格属性
	               'edittd' //单元格属性
	            ],[
	               'justifyleft', //居左对齐
	               'justifyright', //居右对齐
	               'justifycenter', //居中对齐
	               'justifyjustify', //两端对齐
	               'forecolor', //字体颜色
	               'backcolor', //背景色
	               'insertorderedlist', //有序列表
	               'insertunorderedlist', //无序列表
	               'directionalityltr', //从左向右输入
	               'directionalityrtl', //从右向左输入
	               'rowspacingtop', //段前距
	               'rowspacingbottom', //段后距
	               'imagenone', //默认
	               'imageleft', //左浮动
	               'imageright', //右浮动
	               'imagecenter', //居中
	               'lineheight', //行间距
	               'autotypeset' //自动排版
	           ]
	       ]
});

var validateOptions = {
	rules: {
		title: {
			required: true
		},
		intro: {
			required: true
		},
		content: {
			required: true
		}
	},
	messages: {
		title: {
			required: '请输入标题!'
		},
		intro: {
			required: '请输入帮助简介!'
		},
		content: {
			required: '请输入帮助内容!'
		}
	}
};

var helpEditFormValidator = $(document.helpEditForm).validate(validateOptions);

/**
 * 添加分类
 */
function saveHelp(el){
	var form = document.helpEditForm;
	var valid = helpEditFormValidator.form();
	if(valid){
		if(isSubmitable(el)){
			showLoadingText(el);
			setTimeout(function(){
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
							if(response.success) {
								window.location.href = CONTEXT_PATH + '/admin/help/list';
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