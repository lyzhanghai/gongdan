<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>新增用户</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/user/list">用户管理</a></li>
			  <li class="active">新增用户</li>
			</ul>
		</div>
		<form id="userAddForm" class="uk-form" name="userAddForm" action="${CONTEXT_PATH}/xadmin/user/add/submit" method="post">
			<input type="hidden" name="token" value="${token}"/>
			<fieldset data-uk-margin>
				<legend>新增用户</legend>
				<div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="userName">用户名：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="userName" maxlength="20" value="${userAddForm.userName}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="userName">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">用户名由字母开头,5~20个字母、数字及下划线组成,且名称要唯一.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="password">账户密码：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="password" id="password" name="password" maxlength="20" value="${userAddForm.password}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="password">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">账户密码由6~20位个字母、数字及下划线组成.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="repassword">重复密码：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="password" name="repassword" maxlength="20" value="${userAddForm.repassword}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="repassword">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">请再次确认您输入的密码.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="nickName">昵&nbsp;&nbsp;称：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="nickName" maxlength="15" value="${userAddForm.nickName}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="nickName">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">用户昵称由不超过15个汉字、字符组成.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="mobilePhone">手机号码：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="mobilePhone" maxlength="11" value="${userAddForm.mobilePhone}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="mobilePhone">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="email">Email：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="email" maxlength="100" value="${userAddForm.email}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="email">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-btn uk-width-1-1">
							<button type="button" class="uk-button uk-button-primary" onclick="saveUser(this);" data-loading-text="保存中....">保存信息</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/user/list">返回列表</a>
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
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/user/add.js"></script>
</body>
</html>