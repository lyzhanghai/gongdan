<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>修改用户</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/user/list">用户管理</a></li>
			  <li class="active">修改用户</li>
			</ul>
		</div>
		<ul class="uk-tab" data-uk-tab="{connect:'#tab-content'}">
			<li class="uk-active"><a href="javascript:;">修改用户</a></li>
			<li><a href="javascript:;">修改密码</a></li>
		</ul>
		<div id="tab-content" class="uk-switcher uk-margin">
			<div>
				<form id="userEditForm" class="uk-form" name="userEditForm" action="${CONTEXT_PATH}/xadmin/user/edit/submit" method="post">
					<input type="hidden" name="token" value="${token}"/>
					<div>
						<div class="uk-form-row">
							<div class="uk-form-label uk-width-1-5"><em>*</em><label for="userName">用户名：</label></div>
							<div class="uk-form-field uk-width-2-5">
								<input type="text" name="userName" maxlength="20" value="${userEditForm.userName}"/>
								<input type="hidden" name="userId" value="${userEditForm.userId}"/>
							</div>
							<div class="uk-form-info uk-width-2-5">
								<div class="uk-validate-message uk-validate-message-tips" for="userName">
									<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">用户名由字母开头,5~20个字母、数字及下划线组成,且名称要唯一.</span>
								</div>
								<div class="uk-validate-message uk-validate-message-tips" for="userId">
									<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
								</div>
							</div>
						</div>
						<div class="uk-form-row">
							<div class="uk-form-label uk-width-1-5"><em>*</em><label for="nickName">昵&nbsp;&nbsp;称：</label></div>
							<div class="uk-form-field uk-width-2-5">
								<input type="text" name="nickName" maxlength="15" value="${userEditForm.nickName}"/>
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
								<input type="text" name="mobilePhone" maxlength="11" value="${userEditForm.mobilePhone}"/>
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
								<input type="text" name="email" maxlength="100" value="${userEditForm.email}"/>
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
				</form>
			</div>
			<div>
				<form id="passwdEditForm" class="uk-form" name="passwdEditForm" action="${CONTEXT_PATH}/xadmin/user/changepwd/submit" method="post">
					<input type="hidden" name="forceUpdate" value="true"/>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="password">账户密码：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="password" id="password" name="password" maxlength="20" value=""/>
							<input type="hidden" name="userId" value="${userEditForm.userId}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="password">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">账户密码由6~20位个字母、数字及下划线组成.</span>
							</div>
							<div class="uk-validate-message uk-validate-message-tips" for="userId">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="repassword">重复密码：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="password" name="repassword" maxlength="20" value=""/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="repassword">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">请再次确认您输入的密码.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-btn uk-width-1-1">
							<button type="button" class="uk-button uk-button-primary" onclick="savePasswd(this);" data-loading-text="修改中....">立即修改</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/user/list">返回列表</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/user/edit.js"></script>
</body>
</html>