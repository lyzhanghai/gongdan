<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>Banner详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/banner/list">Banner管理</a></li>
			  <li class="active">查看Banner</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">BannerID：</label>
				<div class="uk-width-4-5 uk-color-666">${banner.id}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">Banner标题：</label>
				<div class="uk-width-4-5 uk-color-666">${banner.title}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">Banner图片：</label>
				<div class="uk-width-4-5 uk-color-666"><img alt="" src="${banner.fullImageUrl}" style="max-width:300px;max-height:300px;"/></div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">Banner链接URL：</label>
				<div class="uk-width-4-5 uk-color-666">${banner.linkUrl}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">Banner类型：</label>
				<div class="uk-width-4-5 uk-color-666">${banner.typeName}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">Banner排序：</label>
				<div class="uk-width-4-5 uk-color-666">${banner.typeIndex}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">备注：</label>
				<div class="uk-width-4-5 uk-color-666">${banner.remark}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">创建时间：</label>
				<div class="uk-width-4-5 uk-color-666">${banner.createTime}</div>
			</div>
			
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/banner/list">返回列表</a></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
</body>
</html>