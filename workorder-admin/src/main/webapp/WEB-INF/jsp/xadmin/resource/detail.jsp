<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>资源详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/resource/list">资源管理</a></li>
			  <li class="active">资源详情</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">资源ID：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.resourceId}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">资源名称：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.resourceName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">父级资源：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.parentResourceName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">权限表达式：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.permissionExpression}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">资源类型：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.resourceTypeName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">资源功能类型：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.actionTypeName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">资源使用状态：</label>
				<div class="uk-width-3-5 uk-color-666"><span class="uk-label uk-status-${resource.inuse ? 1 : 0}">${resource.inuse ? '使用中' : '未使用'}</span></div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">资源URL：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.resourceUrl}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">排序号：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.siblingsIndex}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">创建者：</label>
				<div class="uk-width-3-5 uk-color-666">
					${resource.createBy}<c:if test="${not empty resource.createByName}">(${resource.createByName})</c:if>	
				</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">创建时间：</label>
				<div class="uk-width-3-5 uk-color-666">${resource.createTime}</div>
			</div>
			<c:if test="${not empty resource.updateBy}">
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">更新者：</label>
					<div class="uk-width-3-5 uk-color-666">
						${resource.updateBy}<c:if test="${not empty resource.updateByName}">(${resource.updateByName})</c:if>	
					</div>
				</div>
			</c:if>
			<c:if test="${not empty resource.updateTime}">
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">更新时间：</label>
					<div class="uk-width-3-5 uk-color-666">${resource.updateTime}</div>
				</div>
			</c:if>
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/resource/list">返回列表</a></div>
			</div>
		</div>
	</div>
</body>
</html>