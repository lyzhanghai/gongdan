<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>用户详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/user/list">用户管理</a></li>
			  <li class="active">用户详情</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">用户ID：</label>
				<div class="uk-width-3-5 uk-color-666">${user.userId}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">用户名称：</label>
				<div class="uk-width-3-5 uk-color-666">${user.userName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">昵&nbsp;&nbsp;称：</label>
				<div class="uk-width-3-5 uk-color-666">${user.nickName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">手机号码：</label>
				<div class="uk-width-3-5 uk-color-666">${user.mobilePhone}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">EMAIL：</label>
				<div class="uk-width-3-5 uk-color-666">${user.email}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">用户类型：</label>
				<div class="uk-width-3-5 uk-color-666">${user.userTypeName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">用户状态：</label>
				<div class="uk-width-3-5 uk-color-666"><span class="label f12 br10 status-${user.status}">${user.statusName}</span></div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">创建者：</label>
				<div class="uk-width-3-5 uk-color-666">
					${user.createBy}<c:if test="${not empty user.createByName}">(${user.createByName})</c:if>	
				</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">创建时间：</label>
				<div class="uk-width-3-5 uk-color-666">${user.createTime}</div>
			</div>
			<c:if test="${not empty user.updateBy}">
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">更新者：</label>
					<div class="uk-width-3-5 uk-color-666">
						${user.updateBy}<c:if test="${not empty user.updateByName}">(${user.updateByName})</c:if>	
					</div>
				</div>
			</c:if>
			<c:if test="${not empty user.updateTime}">
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">更新时间：</label>
					<div class="uk-width-3-5 uk-color-666">${user.updateTime}</div>
				</div>
			</c:if>
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/user/list">返回列表</a></div>
			</div>
		</div>
	</div>
</body>
</html>