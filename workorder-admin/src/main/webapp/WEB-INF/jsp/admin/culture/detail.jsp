<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>文化动态详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/culture/list">文化动态管理</a></li>
			  <li class="active">查看文化动态</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">文化动态ID：</label>
				<div class="uk-width-4-5 uk-color-666">${entity.id}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">文化动态标题：</label>
				<div class="uk-width-4-5 uk-color-666">${entity.name}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">logo图片：</label>
				<div class="uk-width-4-5 uk-color-666"><img alt="" src="${CONTEXT_PATH}/${entity.logo}" style="max-width:300px;max-height:300px;"/></div>
			</div>
			
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">是否置顶：</label>
				<div class="uk-width-4-5 uk-color-666">${entity.isTop}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">备注：</label>
				<div class="uk-width-4-5 uk-color-666">${entity.remark}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">创建时间：</label>
				<div class="uk-width-4-5 uk-color-666"><fmt:formatDate value="${entity.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
			</div>
			
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/culture/list">返回列表</a></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
</body>
</html>