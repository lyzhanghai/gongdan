<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>俱乐部详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/banner/list">俱乐部管理</a></li>
			  <li class="active">俱乐部详情</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">俱乐部ID：</label>
				<div class="uk-width-3-5 uk-color-666">${club.id}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">俱乐部名称：</label>
				<div class="uk-width-3-5 uk-color-666">${club.name}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">俱乐部logo：</label>
				<div class="uk-width-3-5 uk-color-666"><img alt="${club.logo}" src="${CONTEXT_PATH}${club.logo}" style="max-width:100px;max-height:100px;"/></div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">排序编号：</label>
				<div class="uk-width-3-5 uk-color-666">${club.orderNum}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">所在区域：</label>
				<div class="uk-width-3-5 uk-color-666">
					<c:if test="${club.areainfo==1}">无锡市区</c:if>
					<c:if test="${club.areainfo==2}">滨湖区</c:if>
					<c:if test="${club.areainfo==3}">惠山区</c:if>
					<c:if test="${club.areainfo==4}">锡山区</c:if>
					<c:if test="${club.areainfo==5}">梁溪区</c:if>
					<c:if test="${club.areainfo==6}">新吴区</c:if>
					<c:if test="${club.areainfo==7}">江阴市</c:if>
					<c:if test="${club.areainfo==8}">宜兴市</c:if>
				</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">更新时间：</label>
				<div class="uk-width-3-5 uk-color-666"><fmt:formatDate value="${club.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">备注：</label>
				<div class="uk-width-3-5 uk-color-666">${club.remark}</div>
			</div>
			
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/club/list">返回列表</a></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
</body>
</html>