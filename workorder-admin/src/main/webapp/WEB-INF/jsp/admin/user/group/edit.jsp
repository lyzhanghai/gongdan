<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>${groupEditForm.id == null ? '新增' : '修改'}用户团体</title>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
<div class="uk-container">
    <div class="uk-location">
        <ul class="uk-breadcrumb">
            <li><i></i><a href="javascript:;">业务管理</a></li>
            <li><i></i><a href="${CONTEXT_PATH}/admin/user/group/list">用户团体管理</a></li>
            <li class="active">${groupEditForm.id == null ? '新增' : '修改'}用户团体</li>
        </ul>
    </div>
    <form id="groupEditForm" class="uk-form" name="groupEditForm" action="${CONTEXT_PATH}/admin/user/group/edit/submit" method="post">
        <fieldset>
            <legend>${groupEditForm.id == null ? '新增' : '修改'}用户团体</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="name">团体名称</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                    	<input type="hidden" name="id" value="${groupEditForm.id}"/>
                        <input type="text" name="name" value="${groupEditForm.name}" maxlength="10"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="name">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="saveGroup(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/user/group/list">返回列表</a>
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
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/user/group/edit.js"></script>
</body>
</html>