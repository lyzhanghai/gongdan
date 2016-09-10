<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>新增知识</title>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.css">
    <style type="text/css">
    	.xupload-list-banner-image .xupload-box > a.xupload-uploading,.xupload-list-banner-image .xupload-box > a.xupload-error { min-width: 200px;height: 200px; }
    	.xupload-list-banner-image .xupload-box > a > img { min-width: 200px;height: 200px; }
    </style>
</head>
<body>
<div class="uk-container">
    <div class="uk-location">
        <ul class="uk-breadcrumb">
            <li><i></i><a href="javascript:;">业务管理</a></li>
            <li><i></i><a href="${CONTEXT_PATH}/admin/knowledgetype/list">知识云管理</a></li>
            <li class="active">知识列表管理</li>
        </ul>
    </div>
    <form id="knowledgeAddForm" class="uk-form" name="knowledgeAddForm" action="${CONTEXT_PATH}/admin/knowledge/add" method="post">
        <fieldset>
            <legend>新增知识</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="title">知识标题</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                    	<input id="typeId" type="hidden" name="typeId" value="${knowledge.typeId}"/>
                        <input type="text" name="title" value="${knowledgeAddForm.title}" maxlength="100"/>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="title">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">知识标题不能为空</span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="fileType">文件类型</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <select id="fileType" name="fileType"  onchange="getType(this)">
							<option value="">--请选择--</option>
							<option value="1">文本文件（.doc / .text / ...）</option>
							<option value="2">视频文件（.mp4 / .avi / ...）</option>
							<option value="3">图片文件（.jpg / .gif / ...）</option>
							<option value="4">pdf文件（.pdf / ...）</option>
						</select>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="fileType">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">文件类型不能为空</span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="filePath">知识文件</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <input id="filePath" type="hidden" name="filePath"/>
						<a class="xupload-btn" href="javascript:;">
							<label>请选择文件</label>
							<input type="file" name="uploadFile"/>
						</a>
						<div class="xupload-list xupload-list-banner-image" style="display:block;"></div>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="filePath">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">上传文件不能为空</span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row" id="bannerDiv">
                    <div class="uk-form-label uk-width-1-5"><label for="fileName">文件名字</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <div id="fileName"></div>
                    </div>
                </div>      
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="saveKnowledge(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/knowledge/list?typeId=${knowledge.typeId}">返回列表</a>
                    </div>
                </div>
            </div>
        </fieldset>
    </form>
</div>
<form id="fileUploadForm" action="${CONTEXT_PATH}/admin/xupload/file" method="post" enctype="multipart/form-data" style="display:none;">
	<input type="hidden" name="uploadSerialNo"/>
	<input type="hidden" name="maxFileSize" value="104857600000"/>
	<input type="hidden" id="type" name="type"/>
</form>
<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/knowledge/add.js"></script>
</body>
</html>