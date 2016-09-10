<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>新增菜单</title>
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
			  <li><i></i><a href="${CONTEXT_PATH}/admin/weixin/menu/list">自定义菜单</a></li>
			  <li class="active">修改菜单</li>
			</ul>
		</div>
		<form id="menuEditForm" class="uk-form" name="menuEditForm" action="${CONTEXT_PATH}/admin/weixin/menu/edit/submit" method="post">
			<input type="hidden" name="token" value="${token}"/>
			<fieldset>
				<legend>修改菜单</legend>
				<div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="parentMenuName">父级菜单：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="hidden" name="parentMenuId" value="${menuEditForm.parentMenuId}"/>
							<input type="text" name="parentMenuName" readonly="readonly" value="${menuEditForm.parentMenuName}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="parentMenuId">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">不可编辑</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="menuName">菜单名称：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="hidden" name="menuId" value="${menuEditForm.menuId}"/>
							<input type="text" name="menuName" maxlength="20" value="${menuEditForm.menuName}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="menuId">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
							<div class="uk-validate-message uk-validate-message-tips" for="menuName">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">菜单名称由不超过20个汉字、字符组成.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><label for="menuUrl">菜单URL：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="menuUrl" maxlength="500" value="${menuEditForm.menuUrl}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="menuUrl">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="siblingsIndex">排序号：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="siblingsIndex" maxlength="10" value="${menuEditForm.siblingsIndex}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="siblingsIndex">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">兄弟节点间按升序排序.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-btn uk-width-1-1">
							<button type="button" class="uk-button uk-button-primary" onclick="saveMenu(this);" data-loading-text="保存中....">保存信息</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/weixin/menu/list">返回列表</a>
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
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/weixin/menu/edit.js"></script>
</body>
</html>