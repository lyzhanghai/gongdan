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
			  <li><i></i><a href="${CONTEXT_PATH}/admin/culturedetail/list?id=${entity.id}">文化动态详情管理</a></li>
			  <li class="active">查看文化动态详情</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">ID：</label>
				<div class="uk-width-4-5 uk-color-666">${entity.id}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">标题：</label>
				<div class="uk-width-4-5 uk-color-666">${entity.title}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">发布时间：</label>
				<div class="uk-width-4-5 uk-color-666"><fmt:formatDate value="${entity.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
			</div>
			
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">状态：</label>
				<div class="uk-width-4-5 uk-color-666">
				<span id="change" class="uk-label user-status uk-status-${entity.status}">
									<c:if test="${entity.status==1}">待审核</c:if> <c:if
									test="${entity.status==2}">审核通过</c:if> <c:if
									test="${entity.status==3}">审核拒绝</c:if> 
										</span>
				</div>
			</div>
			
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">详情：</label>
				<div class="uk-width-4-5 uk-color-666">${entity.content}</div>
			</div>
			
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-1-5 uk-font-bold uk-right">更新时间：</label>
				<div class="uk-width-4-5 uk-color-666"><fmt:formatDate value="${entity.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
			</div>
			
			<input type="hidden" name="cultureId" id="cultureId" value="${entity.cultureId}">
			
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/culturedetail/list?cultureId=${entity.cultureId}">返回列表</a></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
</body>
</html>