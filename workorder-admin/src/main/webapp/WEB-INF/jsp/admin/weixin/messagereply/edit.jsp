<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>修改自动回复</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/weixin/messagereply/list">自动回复管理</a></li>
			  <li class="active">修改自动回复</li>
			</ul>
		</div>
		<form id="messageReplyEditForm" class="uk-form" name="messageReplyEditForm" action="${CONTEXT_PATH}/admin/weixin/messagereply/edit/submit" method="post">
			<input type="hidden" name="token" value="${token}"/>
			<fieldset>
				<legend>修改自动回复</legend>
				<div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="keyword">匹配关键字：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="hidden" name="id" value="${messageReplyEditForm.id}"/>
							<input type="text" name="keyword" maxlength="50" value="${messageReplyEditForm.keyword}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="id">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
							<div class="uk-validate-message uk-validate-message-tips" for="keyword">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">匹配关键字由不超过50个汉字、字符组成.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><label for="matchMode">匹配模式：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<select name="matchMode">
								<option value="">--请选择--</option>
								<c:forEach items="${matchModes}" var="item">
									<option value="${item.modeCode}" ${messageReplyEditForm.matchMode eq item.modeCode ? 'selected' : ''}>${item.modeName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="matchMode">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="msgId">关联消息ID：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="msgId" maxlength="10" value="${messageReplyEditForm.msgId}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="msgId">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">关联的微信自动回复消息ID.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-btn uk-width-1-1">
							<button type="button" class="uk-button uk-button-primary" onclick="saveMessageReply(this);" data-loading-text="保存中....">保存信息</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/weixin/messagereply/list">返回列表</a>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/weixin/messagereply/edit.js"></script>
</body>
</html>