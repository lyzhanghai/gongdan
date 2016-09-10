<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>配置角色资源</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
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
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/role/list">角色管理</a></li>
			  <li class="active">配置角色资源</li>
			</ul>
		</div>
		<ul class="uk-tab" data-uk-tab="{connect:'#tab-content'}">
			<li class="uk-active"><a href="javascript:;">配置角色资源</a></li>
			<li><a href="javascript:;">角色基本信息</a></li>
		</ul>
		<div id="tab-content" class="uk-switcher uk-margin-remove">
			<div>
				<div style="padding: 20px;border-bottom: 1px solid #DFDFDF;">
					<a class="uk-button uk-button-primary" href="javascript:;" onclick="refreshRoleResourceTree();">刷新配置</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="uk-button uk-button-primary" href="javascript:;" onclick="expandAllRoleResourceTree();">展开全部</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="uk-button uk-button-primary" href="javascript:;" onclick="collapseAllRoleResourceTree();">全部收起</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				<ul id="roleResourceZTree" class="ztree" style="display:block;position:relative;border:0 none;vertical-align:top;"></ul>
				<div style="margin: 15px auto;text-align:center;">
					<button type="button" class="uk-button uk-button-primary" onclick="configRoleResource(this);" data-loading-text="保存中...." autocomplete="off">保存配置</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/role/list">返回列表</a>
				</div>
				<form id="roleResourceConfigForm" name="roleResourceConfigForm" action="${CONTEXT_PATH}/xadmin/role/config/submit" method="post">
					<input type="hidden" name="roleId" value="${role.roleId}"/>
					<input type="hidden" name="resourceIds"/>
				</form>
			</div>
			<div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">角色ID：</label>
					<div class="uk-width-3-5 uk-color-666">${role.roleId}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">角色名称：</label>
					<div class="uk-width-3-5 uk-color-666">${role.roleName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">角色代码：</label>
					<div class="uk-width-3-5 uk-color-666">${role.roleCode}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">角色类型：</label>
					<div class="uk-width-3-5 uk-color-666">${role.roleTypeName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">角色描述：</label>
					<div class="uk-width-3-5 uk-color-666">${role.description}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">角色使用状态：</label>
					<div class="uk-width-3-5 uk-color-666"><span class="uk-label uk-status-${resource.inuse ? 1 : 0}">${role.inuse ? '使用中' : '未使用'}</span></div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">创建者：</label>
					<div class="uk-width-3-5 uk-color-666">
						${role.createBy}<c:if test="${not empty role.createByName}">(${role.createByName})</c:if>	
					</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">创建时间：</label>
					<div class="uk-width-3-5 uk-color-666">${role.createTime}</div>
				</div>
				<c:if test="${not empty role.updateBy}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">更新者：</label>
						<div class="uk-width-3-5 uk-color-666">
							${role.updateBy}<c:if test="${not empty role.updateByName}">(${role.updateByName})</c:if>	
						</div>
					</div>
				</c:if>
				<c:if test="${not empty role.updateTime}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">更新时间：</label>
						<div class="uk-width-3-5 uk-color-666">${role.updateTime}</div>
					</div>
				</c:if>
				<div class="uk-grid uk-row">
					<div class="uk-width-2-5"></div>
					<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/role/list">返回列表</a></div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery-zTree-3.5.15/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery-zTree-3.5.15/js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/role/config.js"></script>
</body>
</html>