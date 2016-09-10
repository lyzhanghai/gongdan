<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>修改知识</title>
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
    <form id="knowledgeEditForm" class="uk-form" name="knowledgeEditForm" action="${CONTEXT_PATH}/admin/knowledge/edit" method="post">
        <fieldset>
            <legend>修改知识</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="title">知识标题</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                    	<input id="id" type="hidden" name="id" value="${knowledge.id}"/>
                    	<input id="status" type="hidden" name="status" value="${knowledge.status}"/>
                    	<input id="typeId" type="hidden" name="typeId" value="${knowledge.typeId}"/>
                        <input type="text" name="title" value="${knowledge.title}" maxlength="100"/>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="title">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">知识标题不能为空</span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><label for="fileType">文件类型</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <select id="fileType" name="fileType"  onchange="getType(this)">
							<option value="">--请选择--</option>
							<option value="1" <c:if test="${knowledge.fileType eq 1}">selected</c:if>>文本文件（.doc / .text / ...）</option>
							<option value="2" <c:if test="${knowledge.fileType eq 2}">selected</c:if>>视频文件（.mp4 / .avi / ...）</option>
							<option value="3" <c:if test="${knowledge.fileType eq 3}">selected</c:if>>图片文件（.jpg / .gif / ...）</option>
							<option value="4" <c:if test="${knowledge.fileType eq 4}">selected</c:if>>pdf文件（.pdf / ...）</option>
						</select>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><label for="filePath">知识文件</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <input id="filePath" type="hidden" name="filePath" value="${knowledge.filePath}"/>
						<a class="xupload-btn" href="javascript:;">
							<label>请选择文件</label>
							<input type="file" name="uploadFile"/>
						</a>
						<div class="xupload-list xupload-list-banner-image" style="display:block;"></div>
                    </div>
                </div>
                <div class="uk-form-row" id="bannerDiv">
                    <div class="uk-form-label uk-width-1-5"><label for="fileName">文件名字</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <div id="fileName">${fileName}</div>
                    </div>
                </div>      
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="editKnowledge(this);" data-loading-text="保存中....">修改信息</button>
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
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/knowledge/edit.js"></script>
</body>
</html>