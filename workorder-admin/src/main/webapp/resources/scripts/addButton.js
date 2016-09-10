function inituploadbtn(name) {
	var uploadForm = $("<form enctype ='multipart/form-data'></form>");
	var uploadFile = $("<input type='file' name='uploadFile'/>");
	uploadFile.change(function() {

		submitFile(this, name);
	});
	uploadForm.append(uploadFile);
	UE.registerUI('图片上传', function(editor, uiName) {
		// 注册按钮执行时的command命令，使用命令默认就会带有回退操作
		editor.registerCommand(uiName, {
			execCommand : function() {
				alert('execCommand:' + uiName);
			}
		});
		// 创建一个button
		var btn = new UE.ui.Button({
			// 按钮的名字
			name : uiName,
			// 提示
			title : uiName,
			// 添加额外样式，指定icon图标，这里默认使用一个重复的icon
			cssRules : 'background-position: -380px 0;',
			// 点击时执行的命令
			onclick : function() {
				// 这里可以不用执行命令,做你自己的操作也可
				// var fileBtn = $("<input type='file'
				// name='uploadFile'
				// onchange='submitFile(this)' />");
				uploadFile.trigger("click");
			}
		});
		// 当点到编辑内容上时，按钮要做的状态反射
		editor.addListener('selectionchange', function() {
			var state = editor.queryCommandState(uiName);
			if (state == -1) {
				btn.setDisabled(true);
				btn.setChecked(false);
			} else {
				btn.setDisabled(false);
				btn.setChecked(state);
			}
		});
		// 因为你是添加button,所以需要返回这个button
		return btn;
	});
}

function submitFile(obj, name) {

	var formData = new FormData($(obj).parent()[0]);
	$.ajax({
		url : CONTEXT_PATH + "/xupload/ueditor/file/submit",
		type : 'POST',
		data : formData,
		async : false,
		cache : false,
		contentType : false,
		processData : false,
		success : function(returndata) {
			UE.getEditor(name).focus();
			UE.getEditor(name).execCommand('inserthtml',
					'<img src="' + returndata + '"/>');
		},
		error : function(returndata) {
			alert(returndata);
		}
	});

}
