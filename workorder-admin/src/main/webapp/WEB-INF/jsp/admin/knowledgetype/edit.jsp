<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>修改知识类别</title>
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
            <li><i></i><a href="${CONTEXT_PATH}/admin/club/list">知识云管理</a></li>
            <li class="active">修改知识类别</li>
        </ul>
    </div>
    <form id="knowledgeTypeAddForm" class="uk-form" name="knowledgeTypeAddForm" action="${CONTEXT_PATH}/admin/knowledgetype/edit" method="post">
        <fieldset>
            <legend>修改知识类别</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="name">知识类别名称</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                    	<input type="hidden" name="id" value="${knowledgeType.id}"/>
                        <input type="text" name="name" value="${knowledgeType.name}" maxlength="100"/>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
						<div class="uk-validate-message uk-validate-message-tips" for="name">
							<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">知识类别名称不能为空</span>
						</div>
					</div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="orderNum">知识类别序号</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <input type="text" name="orderNum" maxlength="10" value="${knowledgeType.orderNum}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
						<div class="uk-validate-message uk-validate-message-tips" for="orderNum">
							<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">排序编号不能为空且为10位以内有效数字</span>
						</div>
					</div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                       	<button type="button" class="uk-button uk-button-primary" onclick="saveknowledgeType(this);" data-loading-text="修改中....">立即修改</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/knowledgetype/list">返回列表</a>
                    </div>
                </div>
            </div>
        </fieldset>
    </form>
</div>
<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/knowledgetype/edit.js"></script>
</body>
</html>