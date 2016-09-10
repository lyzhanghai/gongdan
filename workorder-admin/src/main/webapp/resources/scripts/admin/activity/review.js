var VIDEO_REGEX = new RegExp(".mp4$");
var videoFileIconUrl = CONTEXT_PATH + '/resources/components/jquery.xupload/images/green/xupload-video-success-icon-128.png';
var currentRowIndex = 1;

function addReviewItem(){
	addReviewItemRow(++currentRowIndex);
}

/**
 * 添加一行
 * @param rowIndex
 */
function addReviewItemRow(rowIndex){
	var $reviewItems = $(".review-item");
	if($reviewItems.length >= 20){
		alert('最多只能添加20组活动回顾!');
		return;
	}
	var html = '<div class="review-item" data-rowindex="' + rowIndex + '">'
				+ '<a class="uk-button uk-button-danger uk-button-small uk-position-top-right" onclick="removeReviewItemRow(' + rowIndex + ');"><i class="uk-icon-minus-circle"></i>&nbsp;删除该行</a>'
				+ '<div class="uk-form-row">'
					+ '<div class="uk-form-label uk-width-1-5"><em>*</em><label for="mediaUrl' + rowIndex + '">回顾图片/视频：</label></div>'
					+ '<div class="uk-form-field uk-width-2-5">'
						+ '<input id="mediaUrl' + rowIndex + '" type="hidden" name="mediaUrl' + rowIndex + '"/>'
						+ '<input id="mediaType' + rowIndex + '" type="hidden" name="mediaType' + rowIndex + '"/>'
						+ '<div class="xupload-list xupload-list-review" data-rowindex="' + rowIndex + '" style="display:block;"></div>'
						+ '<a class="xupload-btn" data-rowindex="' + rowIndex + '" href="javascript:;">'
							+ '<label>请选择文件</label>'
							+ '<input type="file" name="uploadFile"/>'
						+ '</a>'
					+ '</div>'
					+ '<div class="uk-form-info uk-width-2-5">'
						+ '<div class="uk-validate-message uk-validate-message-tips" for="mediaUrl' + rowIndex + '">'
							+ '<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">图片限1M以内(支持jpg/png/gif)<br/>视频限100M以内(仅支持mp4)</span>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
				+ '<div class="uk-form-row">'
					+ '<div class="uk-form-label uk-width-1-5"><label for="mediaTitle' + rowIndex + '">图片/视频标题：</label></div>'
					+ '<div class="uk-form-field uk-width-2-5">'
						+ '<input id="mediaTitle' + rowIndex + '" type="text" name="mediaTitle' + rowIndex + '" maxlength="255" value=""/>'
					+ '</div>'
					+ '<div class="uk-form-info uk-width-2-5">'
						+ '<div class="uk-validate-message uk-validate-message-tips" for="mediaTitle' + rowIndex + '">'
							+ '<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
			+ '</div>';
	$reviewItems.last().after(html);
	initXUpload(rowIndex);
	addValidateRules(rowIndex);
}
/**
 * 删除一行
 * @param rowIndex
 */
function removeReviewItemRow(rowIndex){
	if(confirm('你确定要删除该行?')){
		removeValidateRules(rowIndex);
		$(".review-item[data-rowindex='" + rowIndex + "']").remove();
	}
}

/**
 * 初始化上传组件
 */
function initXUpload(rowIndex) {
	$(".xupload-btn[data-rowindex='" + rowIndex + "']").xupload({
		xuploadListExtClass: "xupload-list-review",
		maxUpload: 1,
		maxUploadTips: "对不起,最多只能上传{0}个图片或视频!",
		moveable: false,
		fileFormats: ["jpg", "jpeg", "png", "mp4"],
		fileFormatTips: "上传文件格式必须是{0}中的一种!",
		uploadForm: "fileUploadForm",
		uploadListWrapper: $(".xupload-list-review[data-rowindex='" + rowIndex + "']"),
		onInit: function(delegate, options){ //初始化已上传的图片
			var fullMediaUrl = $("#fullMediaUrl" + rowIndex).val();
			var mediaType = $("#mediaType" + rowIndex).val();
			if(fullMediaUrl){
				var $uploadBox = options.createUploadBox.call(this, options.uploadListWrapper, delegate.randomID(), false);
				delegate._bindBoxEvent.call(this, $uploadBox);
				var $imgWrapper = $uploadBox.children("a");
				if(mediaType == 1){
					$imgWrapper.append('<img src="' + fullMediaUrl + '"/>');
				}else if(mediaType == 2){
					$imgWrapper.append('<img title="' + fullMediaUrl + '" src="' + videoFileIconUrl + '"/>');
				}
			}
		},
		beforeUpload: function($file, $uploadBox, uploadSerialNo){
			var originalFileName = $file.val();
			if(VIDEO_REGEX.test(originalFileName.toLowerCase())){
				document.fileUploadForm.action = CONTEXT_PATH + '/xupload/file/submit';
				document.fileUploadForm.maxFileSize.value = 104857600; //视频最大100M
			}else{
				document.fileUploadForm.action = CONTEXT_PATH + '/xupload/image/submit';
				document.fileUploadForm.maxFileSize.value = 1048576; //图片最大1M
			}
			return true;
		},
		uploadCallback: function($uploadBox, resultObj){
			if(resultObj){
				var options = this.data("options");
				var $imgWrapper = $uploadBox.children("a");
				$imgWrapper.removeClass(options.uploadingClass);
				var $hiddenField = $("#mediaUrl" + rowIndex);
				var $mediaType = $("#mediaType" + rowIndex);
				if(resultObj.success){
					var originalFileName = resultObj.retObj.originalFileName;
					var mediaType = 1;
					if(VIDEO_REGEX.test(originalFileName.toLowerCase())){
						mediaType = 2;
					}
					var fileRelativePath = resultObj.retObj.fileRelativePath;
					var fileViewUrl = resultObj.retObj.fileViewUrl;
					if(mediaType == 1){
						$imgWrapper.append('<img title="' + originalFileName + '" src="' + fileViewUrl + '" />');
					}else if(mediaType == 2){
						$imgWrapper.append('<img title="' + originalFileName + '" src="' + videoFileIconUrl + '"/>');
					}
					$hiddenField.val(fileRelativePath);
					$mediaType.val(mediaType);
				}else{
					$imgWrapper.addClass("xupload-error")
					$imgWrapper.append('<label>' + resultObj.message + '</label>');
					$hiddenField.val('');
					$mediaType.val('');
				}
				activityReviewFormValidator.element($hiddenField);
			}else{
				alert("上传失败!");
			}
		},
		onUploadBoxRemove: function($uploadBox, $removeElement){
			var rowindex = $uploadBox.closest(".xupload-list").attr("data-rowindex");
			$uploadBox.remove();
			var $hiddenField = $("#mediaUrl" + rowindex);
			var $mediaType = $("#mediaType" + rowIndex);
			if($hiddenField.length){
				$hiddenField.val('');
				$mediaType.val('');
				activityReviewFormValidator.element($hiddenField);
			}
		}
	});
}

var validateOptions = {
	rules: {
		activityId: {
			required: true
		}
	},
	messages: {
		activityId: {
			required: '未发现活动ID!'
		}
	}
};

var activityReviewFormValidator = $(document.activityReviewForm).validate(validateOptions);

/**
 * 动态添加验证规则
 * @param rowIndex
 */
function addValidateRules(rowIndex){
	$("#mediaUrl" + rowIndex).rules("add", {required: true, messages: {required: '请上传消息图片!'}});
}

/**
 * 动态删除验证规则
 * @param rowIndex
 */
function removeValidateRules(rowIndex){
	$("#mediaUrl" + rowIndex).rules("remove");
}

function initReviewItem(rowIndex) {
	initXUpload(rowIndex);
	addValidateRules(rowIndex);
}

/**
 * 页面初始化
 */
$(".review-item").each(function(){
	var el = $(this);
	var rowIndex = parseInt(el.attr("data-rowindex"));
	initReviewItem(rowIndex);
});

function saveReviews(el){
	var valid = activityReviewFormValidator.form();
	if(valid){
		var form = document.activityReviewForm;
		buildReviewItemJson(form);
		if(isSubmitable(el)){
			showLoadingText(el);
			setTimeout(function(){
				$.ajax({
					async : true,
					cache : false,
					type : 'post',
					dataType : 'json',
					data : $(form).serialize(),
					url : CONTEXT_PATH + '/admin/activity/review/save',
					success : function(response) {
						showOrginalText(el);
						if (response) {
							alert(response.message);
							if(response.success) {
								window.location.href = CONTEXT_PATH + '/admin/activity/list';
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

function buildReviewItemJson(form){
	var $reviewItems = $(".review-item");
	var reviewItems = [];
	$reviewItems.each(function(i){
		var el = $(this);
		var rowIndex = el.attr("data-rowindex");
		reviewItems.push({
			mediaType: form['mediaType' + rowIndex].value,
			mediaTitle: form['mediaTitle' + rowIndex].value,
			mediaUrl: form['mediaUrl' + rowIndex].value
		});
	});
	form.jsonReviews.value = $.toJSON(reviewItems);
}