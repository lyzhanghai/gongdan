<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>修改密码</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<style type="text/css">
		body {
			background-color: #f6f6f6;
		}
		.uk-description-list-horizontal {
			margin: 0;
		}
		.uk-description-list-horizontal dt {
			padding: 5px 0;
			width: 150px;
			text-align: right;
		}
		.uk-description-list-horizontal dd {
			padding: 5px 0;
			margin-left: 150px;
			text-align: left;
		}
		.uk-comment-header {
			padding: 25px 10px;
			background-color: #f2f2f2;
			border-color: #f2f2f2;
			border-radius: 6px;
			position: relative;
		}
		.uk-comment-title {
			font-weight: bold;
			color: #000;
			margin: 5px 0 0;
		}
		.uk-comment-meta {
			margin: 5px 0 0;
			font-size: 13px;
		}
		.uk-comment-header .uk-badge {
			top: 10px;
			right: 15px;
		}
		.accountinfo .uk-row {
			padding: 5px 0;
		}
	</style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-grid uk-row uk-bg-white accountinfo">
			<div class="uk-width-1-1">
				<h3 class="uk-title">账户资料</h3>
				<hr class="uk-title-hr" style="margin-bottom:15px;"/>
			</div>
			<div class="uk-width-1-3">
				<div class="uk-comment">
					<div class="uk-comment-header">
						<label class="uk-panel-badge uk-badge uk-badge-primary">Info</label>
						<img class="uk-comment-avatar" src="${CONTEXT_PATH}/resources/images/avatar9.jpg" width="75" height="75" alt=""/>
						<h4 class="uk-comment-title">${sessionScope.loginToken.loginName}</h4>
						<div class="uk-comment-meta"><label>最近登录时间</label> <span>${sessionScope.loginToken.lastLoginTime}</span></div>
						<div class="uk-comment-meta"><label>总登录次数</label> <span>${sessionScope.loginToken.loginTimes}</span></div>
					</div>
				</div>
			</div>
			<div class="uk-width-2-3" style="padding:0;">
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">用户名：</div>
					<div class="uk-width-2-6">${user.userName}</div>
					<div class="uk-width-1-6 uk-font-bold">昵称：</div>
					<div class="uk-width-2-6">${user.nickName}</div>
				</div>
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">手机：</div>
					<div class="uk-width-2-6">${user.mobilePhone}</div>
					<div class="uk-width-1-6 uk-font-bold">邮箱：</div>
					<div class="uk-width-2-6">${user.email}</div>
				</div>
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">类型：</div>
					<div class="uk-width-2-6">${user.userTypeName}</div>
					<div class="uk-width-1-6 uk-font-bold">状态：</div>
					<div class="uk-width-2-6">${user.statusName}</div>
				</div>
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">创建时间：</div>
					<div class="uk-width-2-6">${user.createTime}</div>
					<div class="uk-width-1-6 uk-font-bold">
						<c:if test="${not empty user.updateTime}">
						修改时间：
						</c:if>
					</div>
					<div class="uk-width-2-6">
						<c:if test="${not empty user.updateTime}">
						${user.updateTime}
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<div class="uk-grid uk-row uk-bg-white">
			<div class="uk-width-1-1">
				<h3 class="uk-title">修改密码</h3>
				<hr class="uk-title-hr"/>
				<div>
					<div>
						<form id="changePwdForm" class="uk-form" name="changePwdForm" action="${CONTEXT_PATH}/xadmin/user/changepwd/submit" method="post">
							<div class="uk-form-row">
								<label class="uk-form-label uk-width-1-5" for="oldpassword">旧密码：</label>
								<div class="uk-form-field uk-width-2-5">
									<input type="hidden" name="userId" value="${user.userId}"/>
									<input id="oldpassword" type="password" name="oldpassword" maxlength="20" value=""/>
								</div>
								<div class="uk-form-info uk-width-2-5">
									<div class="uk-validate-message uk-validate-message-tips" for="oldpassword"><em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">请输入旧密码.</span></div>
									<div class="uk-validate-message uk-validate-message-tips" for="userId"><em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span></div>
								</div>
							</div>
							<div class="uk-form-row">
								<label class="uk-form-label uk-width-1-5" for="password">新密码：</label>
								<div class="uk-form-field uk-width-2-5">
									<input id="password" type="password" name="password" maxlength="20" value=""/>
								</div>
								<div class="uk-form-info uk-width-2-5">
									<div class="uk-validate-message uk-validate-message-tips" for="password"><em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">账户密码由6~20位个字母、数字及下划线组成.</span></div>
								</div>
							</div>
							<div class="uk-form-row">
								<label class="uk-form-label uk-width-1-5" for="repassword">重复新密码：</label>
								<div class="uk-form-field uk-width-2-5">
									<input id="repassword" type="password" name="repassword" maxlength="20" value=""/>
								</div>
								<div class="uk-form-info uk-width-2-5">
									<div class="uk-validate-message uk-validate-message-tips" for="repassword"><em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">账户密码由6~20位个字母、数字及下划线组成.</span></div>
								</div>
							</div>
							<div class="uk-form-row">
								<div class="uk-form-btn uk-width-1-1">
									<button type="button" class="uk-button uk-button-primary" onclick="changePwd(this);" data-loading-text="修改中...." autocomplete="off">修改密码</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/user/changepwd.js"></script>
</body>
</html>