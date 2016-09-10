<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>知识详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/knowledgetype/list">知识云管理</a></li>
			  <li class="active">知识列表管理</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">知识ID：</label>
				<div class="uk-width-3-5 uk-color-666">${knowledge.id}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">知识标题：</label>
				<div class="uk-width-3-5 uk-color-666">${knowledge.title}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">文件类型：</label>
				<div class="uk-width-3-5 uk-color-666">
					<c:if test="${knowledge.fileType==1}">
						文本文件
					</c:if>
					<c:if test="${knowledge.fileType==2}">
						视频文件
					</c:if>
					<c:if test="${knowledge.fileType==3}">
						图片文件
					</c:if>
					<c:if test="${knowledge.fileType==4}">
						pdf文件
					</c:if>
				</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">更新时间：</label>
				<div class="uk-width-3-5 uk-color-666"><fmt:formatDate value="${knowledge.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">审核状态：</label>
				<div class="uk-width-3-5 uk-color-666">
					<c:if test="${knowledge.status==1}">
						待审核
					</c:if>
					<c:if test="${knowledge.status==2}">
						审核通过
					</c:if>
					<c:if test="${knowledge.status==3}">
						审核拒绝
					</c:if>
				</div>
			</div>			
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/knowledge/list?typeId=${knowledge.typeId}">返回列表</a></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
</body>
</html>