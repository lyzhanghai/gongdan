<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>新增消息</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link href="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.css" rel="stylesheet">
	<style type="text/css">
    	.xupload-list-message-image .xupload-box > a.xupload-uploading,.xupload-list-message-image .xupload-box > a.xupload-error { min-width: 200px;height: 200px; }
    	.xupload-list-message-image .xupload-box > a > img { min-width: 200px;height: 200px; }
    	.uk-label {font-size:13px;padding:2px 10px 4px 10px;margin-top: 2px;}
    	.message-item {display: block;position: relative;padding: 10px 0; margin: 5px 0;}
    	.message-item:hover {background-color: #f6f6f6;}
    	.uk-position-top-right {display: none;top: 15px;right: 15px;z-index: 999;}
    	.message-item:hover .uk-position-top-right {display: block;}
    </style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="javascript:;">公众号管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/weixin/message/list">消息管理</a></li>
			  <li class="active">新增消息</li>
			</ul>
		</div>
		<form id="messageAddForm" class="uk-form" name="messageAddForm" action="${CONTEXT_PATH}/admin/weixin/message/addnews/submit" method="post">
			<input type="hidden" name="token" value="${token}"/>
			<fieldset data-uk-margin>
				<legend>新增消息</legend>
				<div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="title">消息标题：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="title" maxlength="150" value=""/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="title">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">消息名由不超过150个字符组成,且名称要唯一.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="mediaType">消息类型：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="hidden" name="mediaType" value="${mediaType.typeCode}"/>
							<label class="uk-label uk-success">${mediaType.typeName}消息</label>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="mediaType">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					
					<h3 class="uk-title uk-title-small uk-clearfix">消息体 <a class="uk-button uk-button-success uk-button-small uk-float-right" onclick="addMessageItem();"><i class="uk-icon-plus-circle"></i>&nbsp;添加一行</a></h3>
					<hr class="uk-title-hr"/>
					<!-- 消息体开始 -->
					<div class="message-item" data-rowindex="1">
						<div class="uk-form-row">
							<div class="uk-form-label uk-width-1-5"><em>*</em><label for="description1">消息描述：</label></div>
							<div class="uk-form-field uk-width-2-5">
								<textarea id="description1" rows="2" name="description1"></textarea>
							</div>
							<div class="uk-form-info uk-width-2-5">
								<div class="uk-validate-message uk-validate-message-tips" for="description1">
									<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
								</div>
							</div>
						</div>
						<div class="uk-form-row">
							<div class="uk-form-label uk-width-1-5"><em>*</em><label for="mediaUrl1">上传图片：</label></div>
							<div class="uk-form-field uk-width-2-5">
								<input id="mediaUrl1" type="hidden" name="mediaUrl1"/>
								<div class="xupload-list xupload-list-message-image" data-rowindex="1" style="display:block;"></div>
								<a class="xupload-btn" data-rowindex="1" href="javascript:;">
									<label>请选择图片</label>
									<input type="file" name="uploadFile"/>
								</a>
							</div>
							<div class="uk-form-info uk-width-2-5">
								<div class="uk-validate-message uk-validate-message-tips" for="mediaUrl1">
									<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">图片限1M以内(支持jpg/png/gif)</span>
								</div>
							</div>
						</div>
						<div class="uk-form-row">
							<div class="uk-form-label uk-width-1-5"><em>*</em><label for="linkUrl1">消息链接：</label></div>
							<div class="uk-form-field uk-width-2-5">
								<input id="linkUrl1" type="text" name="linkUrl1" maxlength="255" value=""/>
							</div>
							<div class="uk-form-info uk-width-2-5">
								<div class="uk-validate-message uk-validate-message-tips" for="linkUrl1">
									<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
								</div>
							</div>
						</div>
					</div>
					<!-- 消息体结束 -->
					<div class="uk-form-row">
						<div class="uk-form-btn uk-width-1-1">
							<input type="hidden" name="messageItemsJson" value=""/>
							<button type="button" class="uk-button uk-button-primary" onclick="saveMessage(this);" data-loading-text="保存中....">保存信息</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/weixin/message/list">返回列表</a>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
	<form id="imageUploadForm" action="${CONTEXT_PATH}/xupload/image/submit" method="post" enctype="multipart/form-data" style="display:none;">
		<input type="hidden" name="uploadSerialNo"/>
		<input type="hidden" name="maxFileSize" value="1048576"/>
	</form>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jsrender.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/weixin/message/addnews.js"></script>
</body>
</html>