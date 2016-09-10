var currentRowIndex = 1;

function addMessageItem(){
	addMessageItemRow(++currentRowIndex);
}

/**
 * 添加一行
 * @param rowIndex
 */
function addMessageItemRow(rowIndex){
	var $messageItems = $(".message-item");
	if($messageItems.length >= 10){
		alert('最多只能添加10组消息!');
		return;
	}
	var html = '<div class="message-item" data-rowindex="' + rowIndex + '">'
				+ '<a class="uk-button uk-button-danger uk-button-small uk-position-top-right" onclick="removeMessageItemRow(' + rowIndex + ');"><i class="uk-icon-minus-circle"></i>&nbsp;删除该行</a>'
				+ '<div class="uk-form-row">'
					+ '<div class="uk-form-label uk-width-1-5"><em>*</em><label for="description' + rowIndex + '">消息描述：</label></div>'
					+ '<div class="uk-form-field uk-width-2-5">'
						+ '<textarea id="description' + rowIndex + '" rows="2" name="description' + rowIndex + '"></textarea>'
					+ '</div>'
					+ '<div class="uk-form-info uk-width-2-5">'
						+ '<div class="uk-validate-message uk-validate-message-tips" for="description' + rowIndex + '">'
							+ '<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
				+ '<div class="uk-form-row">'
					+ '<div class="uk-form-label uk-width-1-5"><em>*</em><label for="mediaUrl' + rowIndex + '">上传图片：</label></div>'
					+ '<div class="uk-form-field uk-width-2-5">'
						+ '<input id="mediaUrl' + rowIndex + '" type="hidden" name="mediaUrl' + rowIndex + '"/>'
						+ '<div class="xupload-list xupload-list-message-image" data-rowindex="' + rowIndex + '" style="display:block;"></div>'
						+ '<a class="xupload-btn" data-rowindex="' + rowIndex + '" href="javascript:;">'
							+ '<label>请选择图片</label>'
							+ '<input type="file" name="uploadFile"/>'
						+ '</a>'
					+ '</div>'
					+ '<div class="uk-form-info uk-width-2-5">'
						+ '<div class="uk-validate-message uk-validate-message-tips" for="mediaUrl' + rowIndex + '">'
							+ '<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">图片限1M以内(支持jpg/png/gif)</span>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
				+ '<div class="uk-form-row">'
					+ '<div class="uk-form-label uk-width-1-5"><em>*</em><label for="linkUrl' + rowIndex + '">消息链接：</label></div>'
					+ '<div class="uk-form-field uk-width-2-5">'
						+ '<input id="linkUrl' + rowIndex + '" type="text" name="linkUrl' + rowIndex + '" maxlength="255" value=""/>'
					+ '</div>'
					+ '<div class="uk-form-info uk-width-2-5">'
						+ '<div class="uk-validate-message uk-validate-message-tips" for="linkUrl' + rowIndex + '">'
							+ '<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
			+ '</div>';
	$messageItems.last().after(html);
	initXUpload(rowIndex);
	addValidateRules(rowIndex);
}
/**
 * 删除一行
 * @param rowIndex
 */
function removeMessageItemRow(rowIndex){
	if(confirm('你确定要删除该行?')){
		removeValidateRules(rowIndex);
		$(".message-item[data-rowindex='" + rowIndex + "']").remove();
	}
}

/**
 * 初始化上传组件
 */
function initXUpload(rowIndex) {
	$(".xupload-btn[data-rowindex='" + rowIndex + "']").xupload({
		xuploadListExtClass: "xupload-list-message-image",
		maxUpload: 1,
		maxUploadTips: "对不起,最多只能上传{0}个图片!",
		moveable: false,
		fileFormats: ["jpg", "jpeg", "png"],
		fileFormatTips: "上传图片格式必须是{0}中的一种!",
		uploadForm: "imageUploadForm",
		uploadListWrapper: $(".xupload-list-message-image[data-rowindex='" + rowIndex + "']"),
		uploadCallback: function($uploadBox, resultObj){
			if(resultObj){
				var options = this.data("options");
				var $imgWrapper = $uploadBox.children("a");
				$imgWrapper.removeClass(options.uploadingClass);
				var $hiddenField = $("#mediaUrl" + rowIndex);
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
}

var validateOptions = {
	rules: {
		title: {
			required: true
		},
		mediaType: {
			required: true
		}
	},
	messages: {
		title: {
			required: '请输入消息标题!'
		},
		mediaType: {
			required: '请选择消息类型!'
		}
	}
};

var messageAddFormValidator = $(document.messageAddForm).validate(validateOptions);

/**
 * 动态添加验证规则
 * @param rowIndex
 */
function addValidateRules(rowIndex){
	$("#description" + rowIndex).rules("add", {required: true, messages: {required: '请输入消息描述!'}});
	$("#mediaUrl" + rowIndex).rules("add", {required: true, messages: {required: '请上传消息图片!'}});
	$("#linkUrl" + rowIndex).rules("add", {required: true, url: true, messages: {required: '请输入链接地址!', url: '您输入的链接地址不合法!'}});
}

/**
 * 动态删除验证规则
 * @param rowIndex
 */
function removeValidateRules(rowIndex){
	$("#description" + rowIndex).rules("remove");
	$("#mediaUrl" + rowIndex).rules("remove");
	$("#linkUrl" + rowIndex).rules("remove");
}

/**
 * 初始化
 */
initXUpload(1);
addValidateRules(1);

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
					url : CONTEXT_PATH + '/admin/weixin/message/addnews/submit',
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
	var $messageItems = $(".message-item");
	var messageItems = [];
	$messageItems.each(function(i){
		var el = $(this);
		var rowIndex = el.attr("data-rowindex");
		messageItems.push({
			description: form['description' + rowIndex].value,
			mediaUrl: form['mediaUrl' + rowIndex].value,
			linkUrl: form['linkUrl' + rowIndex].value
		});
	});
	form.messageItemsJson.value = $.toJSON(messageItems);
}