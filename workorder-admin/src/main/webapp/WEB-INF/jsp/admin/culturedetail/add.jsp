<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>新增文化动态详情</title>
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
            <li><i></i><a href="${CONTEXT_PATH}/admin/culturedetail/list">文化动态详情管理</a></li>
            <li class="active">新增文化动态详情</li>
        </ul>
    </div>
    <form id="culturedetailAddForm" class="uk-form" name="culturedetailAddForm" action="${CONTEXT_PATH}/admin/culturedetail/add" method="post">
        <fieldset>
            <legend>新增文化动态详情</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-2-10"><em>*</em><label for="title">标题</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                        <input type="text" name="title" value="${cultureDetail.title}" maxlength="20"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="title">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">标题不能超过20个字符</span>
                        </div>
                    </div>
                </div>
                	
                	<input type="hidden" id="cultureId" name="cultureId" value="${cultureDetail.cultureId}"/>

                
        			<div class="uk-form-row">
                    <div class="uk-form-label uk-width-2-10"><em>*</em><label for="content">详情内容</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                    	<textarea id="content" rows="3" name="content">${cultureDetail.content}</textarea>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="content">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                
                
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="savedetail(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/culturedetail/list?cultureId=${cultureDetail.cultureId}">返回列表</a>
                    </div>
                </div>
            </div>
        </fieldset>
    </form>
</div>
<form id="imageUploadForm" action="${CONTEXT_PATH}//admin/xupload/file" method="post" enctype="multipart/form-data" style="display:none;"> 
	<input type="hidden" name="uploadSerialNo"/>
	<input type="hidden" name="maxFileSize" value="1048576"/>
</form> 
<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/ueditor-1.4.3.2/ueditor.config.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/ueditor-1.4.3.2/ueditor.all.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/culturedetail/add.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/addButton.js"></script>
<script type="text/javascript">
inituploadbtn('content');
</script>
</body>
</html>