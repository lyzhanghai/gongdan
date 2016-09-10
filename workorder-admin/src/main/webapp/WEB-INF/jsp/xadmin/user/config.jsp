<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>配置用户角色</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/simplePagination/simplePagination.css"/>
	<style type="text/css">
		.uk-modal-dialog {width: 750px;}
		.uk-table thead tr.gap0 th {border: 0;background: none;height: 0;padding:0;line-height:0;}
	</style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/user/list">用户管理</a></li>
			  <li class="active">配置用户角色</li>
			</ul>
		</div>
		<ul class="uk-tab" data-uk-tab="{connect:'#tab-content'}">
			<li class="uk-active"><a href="javascript:;">配置用户角色</a></li>
			<li><a href="javascript:;">用户基本信息</a></li>
		</ul>
		<div id="tab-content" class="uk-switcher uk-margin">
			<div>
				<form id="userRoleConfigForm" name="userRoleConfigForm" action="#" method="post">
					<input type="hidden" name="userId" value="${user.userId}"/>
					<input type="hidden" name="roleIds"/>
				</form>
				<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th width="4%" class="uk-center"><input type="checkbox" onclick="selectAllRow(this);" title="全选"/></th>
							<th width="15%">角色名称</th>
							<th width="14%">角色代码</th>
							<th width="12%">角色类型</th>
							<th width="30%">角色描述</th>
							<th width="10%" class="uk-center">配置时间</th>
							<th width="15%" class="uk-center">操作</th>
						</tr>
						<tr class="gap">
							<td colspan="7"></td>
						</tr>
						<tr class="toolbar">
							<td colspan="7">
								<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="loadAllUserRoleList();">刷新用户角色列表</a>&nbsp;&nbsp;
								<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="openRoleSelectWin();">添加用户角色</a>&nbsp;&nbsp;
								<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="delUserRoles(this);">删除用户角色</a>&nbsp;&nbsp;
								<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/xadmin/user/list">返回列表</a>
							</td>
						</tr>
						<tr class="gap">
							<td colspan="7"></td>
						</tr>
					</thead>
					<tbody id="userRoleList">
						<tr><td class="no-result" colspan="7">暂无记录!</td></tr>
					</tbody>
				</table>
			</div>
<%--			用户基本信息--%>
			<div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">用户ID：</label>
					<div class="uk-width-3-5 uk-color-666">${user.userId}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">用户名称：</label>
					<div class="uk-width-3-5 uk-color-666">${user.userName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">昵&nbsp;&nbsp;称：</label>
					<div class="uk-width-3-5 uk-color-666">${user.nickName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">手机号码：</label>
					<div class="uk-width-3-5 uk-color-666">${user.mobilePhone}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">EMAIL：</label>
					<div class="uk-width-3-5 uk-color-666">${user.email}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">用户类型：</label>
					<div class="uk-width-3-5 uk-color-666">${user.userTypeName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">用户状态：</label>
					<div class="uk-width-3-5 uk-color-666"><span class="label f12 br10 status-${user.status}">${user.statusName}</span></div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">创建者：</label>
					<div class="uk-width-3-5 uk-color-666">
						${user.createBy}<c:if test="${not empty user.createByName}">(${user.createByName})</c:if>	
					</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-2-5 uk-font-bold uk-right">创建时间：</label>
					<div class="uk-width-3-5 uk-color-666">${user.createTime}</div>
				</div>
				<c:if test="${not empty user.updateBy}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">更新者：</label>
						<div class="uk-width-3-5 uk-color-666">
							${user.updateBy}<c:if test="${not empty user.updateByName}">(${user.updateByName})</c:if>	
						</div>
					</div>
				</c:if>
				<c:if test="${not empty user.updateTime}">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-2-5 uk-font-bold uk-right">更新时间：</label>
						<div class="uk-width-3-5 uk-color-666">${user.updateTime}</div>
					</div>
				</c:if>
				<div class="uk-grid uk-row">
					<div class="uk-width-2-5"></div>
					<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/user/list">返回列表</a></div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="roleSelectWin" class="uk-modal uk-primary">
		<div class="uk-modal-dialog">
			<button type="button" class="uk-modal-close uk-close"></button>
               <div class="uk-modal-header">
                   <h3>选择角色</h3>
               </div>
			<div>
				<form id="roleSearchForm" class="uk-form" name="roleSearchForm" action="${CONTEXT_PATH}/xadmin/role/search" method="post" style="margin-bottom:10px;">
					<table class="uk-form-table">
						<tbody>
							<tr>
								<td class="uk-form-label" width="12%"><em></em><label>角色名称</label>：</td>
								<td class="uk-form-field" width="25%"><input type="text" name="roleName" value=""/></td>
								<td class="uk-form-field" width="12%"><em></em><label>角色代码</label>：</td>
								<td class="uk-form-field" width="25%"><input type="text" name="roleCode" value=""/></td>
								<td class="uk-center" width="16%">
									<input type="hidden" name="currentPage"  value="1"/>
									<input type="hidden" name="pageSize"  value="10"/>
									<input class="uk-button uk-button-primary" type="button" value="查&nbsp;&nbsp;询" onclick="searchRoleList(1);"/>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<table id="searchRoleTableHead" class="uk-table uk-table-primary uk-table-hover uk-margin-remove" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th width="8%" class="uk-center"><input type="checkbox" onclick="selectAllRow(this, 'searchRoleTableBody');" title="全选"/></th>
							<th width="20%"><label>角色名称</label></th>
							<th width="20%"><label>角色代码</label></th>
							<th width="17%"><label>角色类型</label></th>
							<th width="35%"><label>角色描述</label></th>
						</tr>
					</thead>
				</table>
				<div class="uk-overflow-container" style="height:500px">
					<table id="searchRoleTableBody" class="uk-table uk-table-primary uk-table-hover uk-margin-remove" cellspacing="0" width="100%">
						<thead>
							<tr class="gap0">
								<th width="8%" class="uk-center"></th>
								<th width="20%"></th>
								<th width="20%"></th>
								<th width="17%"></th>
								<th width="35%"></th>
							</tr>
						</thead>
						<tbody id="searchRoleList">
							<tr><td class="no-result" colspan="5">暂无记录!</td></tr>
						</tbody>
					</table>
				</div>
				<div id="roleSearchPager" class="uk-grid" style="display:none;padding:10px 10px 5px 10px;">
               		<div class="uk-width-1-3">
						<p>共<span class="total-count">0</span>条</p>
					</div>
               		<div class="uk-width-2-3">
						<div class="pagination-num uk-float-right"></div>
               		</div>
               	</div>
			</div>
			<div class="uk-modal-footer uk-text-center">
				<button type="button" class="uk-button uk-button-primary" onclick="addUserRoles(this);">确 定</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="uk-button uk-button-primary" onclick="closeRoleSelectWin();">关 闭</button>
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/simplePagination/jquery.simplePagination.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jsrender.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/user/config.js"></script>
</body>
</html>