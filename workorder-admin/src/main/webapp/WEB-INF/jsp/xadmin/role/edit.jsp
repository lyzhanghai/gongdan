<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>修改角色</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/role/list">角色管理</a></li>
			  <li class="active">修改角色</li>
			</ul>
		</div>
		<form id="roleEditForm" class="uk-form" name="roleEditForm" action="${CONTEXT_PATH}/xadmin/role/edit/submit" method="post">
			<input type="hidden" name="token" value="${token}"/>
			<fieldset>
				<legend>修改角色</legend>
				<div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="roleName">角色名称：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="hidden" name="roleId" value="${roleEditForm.roleId}"/>
							<input type="text" name="roleName" maxlength="20" value="${roleEditForm.roleName}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="roleId">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
							<div class="uk-validate-message uk-validate-message-tips" for="roleName">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">角色名称由不超过20个汉字、字符组成.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="roleCode">角色代码：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="roleCode" maxlength="50" value="${roleEditForm.roleCode}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="roleCode">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">角色代码由不超过50个字母、数字、下划线组成.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><label for="description">角色描述：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<textarea name="description" rows="3" maxlength="200">${roleEditForm.description}</textarea>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="description">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-btn uk-width-1-1">
							<button type="button" class="uk-button uk-button-primary" onclick="saveRole(this);" data-loading-text="保存中....">保存信息</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/role/list">返回列表</a>
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
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/role/edit.js"></script>
</body>
</html>