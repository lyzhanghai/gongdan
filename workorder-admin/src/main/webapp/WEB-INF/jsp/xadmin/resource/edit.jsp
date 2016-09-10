<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>修改资源</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/components/dropdownselect.css"/>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-zTree-3.5.15/css/zTreeStyle/zTreeStyle.css"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-zTree-3.5.15/css/zTreeStyle/flat-blue.css"/>
	<script type="text/javascript">
		var DEFAULT_ROOT_RESOURCE_ID = '${applicationScope.DEFAULT_XADMIN_ROOT_RESOURCE_ID}';
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/resource/list">资源管理</a></li>
			  <li class="active">修改资源</li>
			</ul>
		</div>
		<form id="resourceEditForm" class="uk-form" name="resourceEditForm" action="${CONTEXT_PATH}/xadmin/resource/edit/submit" method="post">
			<input type="hidden" name="token" value="${token}"/>
			<fieldset>
				<legend>修改资源</legend>
				<div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="parentResourceName">父级资源：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<div id="resourceSelector" class="uk-dropdownselect" data-uk-dropdownselect>
								<input type="hidden" name="parentResourceId" value="${resourceEditForm.parentResourceId}"/>
								<input type="text" name="parentResourceName" readonly="readonly" value="${resourceEditForm.parentResourceName}"/><i class="uk-icon-caret-down"></i>
								<div class="uk-dropdownselect-content">
									<div style="height:250px;width:350px;overflow:auto;display:block;">
										<ul id="resourceTree" class="ztree" style="display:inline-block;position:relative;"></ul>
									</div>
								</div>
							</div>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="parentResourceId">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="resourceName">资源名称：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="hidden" name="resourceId" value="${resourceEditForm.resourceId}"/>
							<input type="text" name="resourceName" maxlength="20" value="${resourceEditForm.resourceName}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="resourceId">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
							<div class="uk-validate-message uk-validate-message-tips" for="resourceName">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">资源名称由不超过20个汉字、字符组成.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><label for="permissionExpression">权限表达式：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="permissionExpression" maxlength="100" value="${resourceEditForm.permissionExpression}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="permissionExpression">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">权限表达式由[功能模块名(字母数字下划线组成)]:[操作名(字母数字下划线)]两部分组成,例如: admin:user:add、order:check等.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="actionType">资源功能类型：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<select name="actionType" value="${resourceEditForm.actionType}">
	                            <option value="">--请选择--</option>
	                            <c:forEach items="${resourceActionTypes}" var="item">
	                            	<option value="${item.typeCode}" ${resourceEditForm.actionType eq item.typeCode ? 'selected' : ''}>${item.typeName}</option>
	                            </c:forEach>
                            </select>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="actionType">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><label for="resourceUrl">资源URL：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<textarea name="resourceUrl" rows="3" maxlength="500">${resourceEditForm.resourceUrl}</textarea>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="resourceUrl">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-label uk-width-1-5"><em>*</em><label for="siblingsIndex">排序号：</label></div>
						<div class="uk-form-field uk-width-2-5">
							<input type="text" name="siblingsIndex" maxlength="10" value="${resourceEditForm.siblingsIndex}"/>
						</div>
						<div class="uk-form-info uk-width-2-5">
							<div class="uk-validate-message uk-validate-message-tips" for="siblingsIndex">
								<em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">兄弟节点间按升序排序.</span>
							</div>
						</div>
					</div>
					<div class="uk-form-row">
						<div class="uk-form-btn uk-width-1-1">
							<button type="button" class="uk-button uk-button-primary" onclick="saveResource(this);" data-loading-text="保存中....">保存信息</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/resource/list">返回列表</a>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/components/dropdownselect.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery-zTree-3.5.15/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery-zTree-3.5.15/js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/resource/edit.js"></script>
</body>
</html>