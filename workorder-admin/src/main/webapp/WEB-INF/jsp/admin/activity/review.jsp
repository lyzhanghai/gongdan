<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>活动回顾</title>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.css">
    <style type="text/css">
    	.xupload-list-review .xupload-box > a.xupload-uploading,.xupload-list-review .xupload-box > a.xupload-error { min-width: 200px;height: 200px; }
    	.xupload-list-review .xupload-box > a > img { min-width: 200px;height: 200px; }
    	.uk-label {font-size:13px;padding:2px 10px 4px 10px;margin-top: 2px;}
    	.review-item {display: block;position: relative;padding: 10px 0; margin: 5px 0;}
    	.review-item:hover {background-color: #f6f6f6;}
    	.uk-position-top-right {display: none;top: 15px;right: 15px;z-index: 999;}
    	.review-item:hover .uk-position-top-right {display: block;}
    </style>
</head>
<body>
<div class="uk-container">
    <div class="uk-location">
        <ul class="uk-breadcrumb">
            <li><i></i><a href="javascript:;">业务管理</a></li>
            <li><i></i><a href="${CONTEXT_PATH}/admin/activity/list">活动管理</a></li>
            <li class="active">活动回顾</li>
        </ul>
    </div>
    <form id="activityReviewForm" class="uk-form" name="activityReviewForm" action="${CONTEXT_PATH}/admin/activity/review/save" method="post">
        <fieldset>
            <legend>活动回顾</legend>
            <div>
            	<h3 class="uk-title uk-title-small uk-clearfix">活动回顾 <a class="uk-button uk-button-success uk-button-small uk-float-right" onclick="addReviewItem();"><i class="uk-icon-plus-circle"></i>&nbsp;添加一行</a></h3>
				<hr class="uk-title-hr"/>
				<c:forEach items="${reviewList}" var="item" varStatus="status">
					<div class="review-item" data-rowindex="${status.index + 1}">
		                <div class="uk-form-row">
		                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="mediaUrl${status.index + 1}">回顾图片/视频</label>：</div>
		                    <div class="uk-form-field uk-width-2-5">
		                        <input id="mediaUrl${status.index + 1}" type="hidden" name="mediaUrl${status.index + 1}" value="${item.mediaUrl}"/>
		                        <input id="fullMediaUrl${status.index + 1}" type="hidden" name="fullMediaUrl${status.index + 1}" value="${item.fullMediaUrl}"/>
		                        <input id="mediaType${status.index + 1}" type="hidden" name="mediaType${status.index + 1}" value="${item.mediaType}"/>
								<div class="xupload-list xupload-list-review" data-rowindex="${status.index + 1}" style="display:block;"></div>
								<a class="xupload-btn" data-rowindex="${status.index + 1}" href="javascript:;">
									<label>请选择文件</label>
									<input type="file" name="uploadFile"/>
								</a>
		                    </div>
		                    <div class="uk-form-info uk-width-2-5">
		                        <div class="uk-validate-message uk-validate-message-tips" for="mediaUrl${status.index + 1}">
		                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">图片限1M以内(支持jpg/png/gif)<br/>视频限100M以内(仅支持mp4)</span>
		                        </div>
		                    </div>
		                </div>
		                <div class="uk-form-row">
							<div class="uk-form-label uk-width-1-5"><label for="mediaTitle${status.index + 1}">图片/视频标题：</label></div>
							<div class="uk-form-field uk-width-2-5">
								<input type="text" name="mediaTitle${status.index + 1}" maxlength="250" value="${item.mediaTitle}"/>
							</div>
							<div class="uk-form-info uk-width-2-5">
								<div class="uk-validate-message uk-validate-message-tips" for="mediaTitle${status.index + 1}">
									<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
								</div>
							</div>
						</div>
					</div>
                </c:forEach>
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                    	<input type="hidden" name="activityId" value="${activityId}"/>
                    	<input type="hidden" name="jsonReviews" value=""/>
                        <button type="button" class="uk-button uk-button-primary" onclick="saveReviews(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/activity/list">返回列表</a>
                    </div>
                </div>
            </div>
        </fieldset>
    </form>
</div>
<form id="fileUploadForm" name="fileUploadForm" action="${CONTEXT_PATH}/xupload/image/submit" method="post" enctype="multipart/form-data" style="display:none;">
	<input type="hidden" name="uploadSerialNo"/>
	<input type="hidden" name="maxFileSize" value="1048576"/>
</form>
<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/activity/review.js"></script>
</body>
</html>