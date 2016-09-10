<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>角色详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/role/list">角色管理</a></li>
			  <li class="active">角色详情</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">角色ID：</label>
				<div class="uk-width-3-5 uk-color-666">${role.roleId}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">角色名称：</label>
				<div class="uk-width-3-5 uk-color-666">${role.roleName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">角色代码：</label>
				<div class="uk-width-3-5 uk-color-666">${role.roleCode}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">角色类型：</label>
				<div class="uk-width-3-5 uk-color-666">${role.roleTypeName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">角色描述：</label>
				<div class="uk-width-3-5 uk-color-666">${role.description}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">角色使用状态：</label>
				<div class="uk-width-3-5 uk-color-666"><span class="uk-label uk-status-${role.inuse ? 1 : 0}">${role.inuse ? '使用中' : '未使用'}</span></div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">创建者：</label>
				<div class="uk-width-3-5 uk-color-666">
					${role.createBy}<c:if test="${not empty role.createByName}">(${role.createByName})</c:if>	
				</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">创建时间：</label>
				<div class="uk-width-3-5 uk-color-666">${role.createTime}</div>
			</div>
			<c:if test="${not empty role.updateBy}">
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">更新者：</label>
					<div class="uk-width-3-5 uk-color-666">
						${role.updateBy}<c:if test="${not empty role.updateByName}">(${role.updateByName})</c:if>	
					</div>
				</div>
			</c:if>
			<c:if test="${not empty role.updateTime}">
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">更新时间：</label>
					<div class="uk-width-3-5 uk-color-666">${role.updateTime}</div>
				</div>
			</c:if>
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/role/list">返回列表</a></div>
			</div>
		</div>
	</div>
</body>
</html>