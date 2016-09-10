<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>消息详细</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<style type="text/css">
    	.uk-label {font-size:13px;padding:2px 10px 4px 10px;margin-top: 2px;}
    	.message-item {display: block;position: relative;padding: 10px 0; margin: 5px 0;}
    	.message-item:hover {background-color: #f6f6f6;}
    	.message-media-img {height: 200px; width: auto;border: 0 none;margin: 10px;}
    	.message-media-file {height: 128px; width: 128px;border: 0 none;margin: 10px;}
    </style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="javascript:;">公众号管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/weixin/message/list">消息管理</a></li>
			  <li class="active">查看消息</li>
			</ul>
		</div>
		<div>
			<h3 class="uk-title uk-title-small">消息头</h3>
			<hr class="uk-title-hr"/>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">消息ID：</label>
				<div class="uk-width-3-5 uk-color-666">${weixinMessage.id}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">消息标题：</label>
				<div class="uk-width-3-5 uk-color-666">${weixinMessage.title}</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">消息类型：</label>
				<div class="uk-width-3-5 uk-color-666">${weixinMessage.mediaTypeName}(${weixinMessage.mediaType})</div>
			</div>
			<div class="uk-grid uk-row uk-row-hover">
				<label class="uk-width-2-5 uk-font-bold uk-right">创建时间：</label>
				<div class="uk-width-3-5 uk-color-666">${weixinMessage.createTime}</div>
			</div>
			
			<h3 class="uk-title uk-title-small">消息体</h3>
			<hr class="uk-title-hr"/>
			<c:forEach var="messageItem" items="${weixinMessage.messageItems}" varStatus="stat">
				<c:if test="${mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_TEXT || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_VIDEO || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_NEWS}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">消息描述：</label>
						<div class="uk-width-3-5 uk-color-666">${messageItem.description}</div>
					</div>
				</c:if>
				<c:if test="${mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_IMAGE || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_VIDEO || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_VOICE || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_NEWS}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">媒体文件：</label>
						<div class="uk-width-3-5 uk-color-666">
							<c:if test="${mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_IMAGE || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_NEWS}">
								<img class="message-media-img" src="${messageItem.fullMediaUrl}"/>
							</c:if>
							<c:if test="${mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_VIDEO || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_VOICE}">
								<img class="message-media-file" src="${CONTEXT_PATH}/resources/components/jquery.xupload/images/green/xupload-file-success-icon-128.png"/>
							</c:if>
							<p>${messageItem.fullMediaUrl}</p>
						</div>
					</div>
				</c:if>
				<c:if test="${mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_IMAGE || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_VIDEO || mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_VOICE}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">微信媒体ID：</label>
						<div class="uk-width-3-5 uk-color-666">${messageItem.mediaId}</div>
					</div>
				</c:if>
				<c:if test="${mediaType eq applicationScope.WEIXIN_MEDIA_TYPE_NEWS}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">消息链接：</label>
						<div class="uk-width-3-5 uk-color-666">${messageItem.linkUrl}</div>
					</div>
				</c:if>
				<c:if test="${!stat.last}">
					<hr style="border-top: 1px dashed #dfdfdf;"/>
				</c:if>
			</c:forEach>
			<div class="uk-grid uk-row">
				<div class="uk-width-2-5"></div>
				<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/weixin/message/list">返回列表</a></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
</body>
</html>