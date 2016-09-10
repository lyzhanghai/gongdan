<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>修改密码</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/css/jquery.treetable.css"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/css/jquery.treetable.theme.css"/>
	<style type="text/css">
		body {
			background-color: #f6f6f6;
		}
		.uk-description-list-horizontal {
			margin: 0;
		}
		.uk-description-list-horizontal dt {
			padding: 5px 0;
			width: 150px;
			text-align: right;
		}
		.uk-description-list-horizontal dd {
			padding: 5px 0;
			margin-left: 150px;
			text-align: left;
		}
		.uk-comment-header {
			padding: 25px 10px;
			background-color: #f2f2f2;
			border-color: #f2f2f2;
			border-radius: 6px;
			position: relative;
		}
		.uk-comment-title {
			font-weight: bold;
			color: #000;
			margin: 5px 0 0;
		}
		.uk-comment-meta {
			margin: 5px 0 0;
			font-size: 13px;
		}
		.uk-comment-header .uk-badge {
			top: 10px;
			right: 15px;
		}
		.accountinfo .uk-row {
			padding: 5px 0;
		}
	</style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-grid uk-row uk-bg-white accountinfo">
			<div class="uk-width-1-1">
				<h3 class="uk-title">账户资料</h3>
				<hr class="uk-title-hr" style="margin-bottom:15px;"/>
			</div>
			<div class="uk-width-1-3">
				<div class="uk-comment">
					<div class="uk-comment-header">
						<label class="uk-panel-badge uk-badge uk-badge-primary">Info</label>
						<img class="uk-comment-avatar" src="${CONTEXT_PATH}/resources/images/avatar9.jpg" width="75" height="75" alt=""/>
						<h4 class="uk-comment-title">${sessionScope.loginToken.loginName}</h4>
						<div class="uk-comment-meta"><label>最近登录时间</label> <span>${sessionScope.loginToken.lastLoginTime}</span></div>
						<div class="uk-comment-meta"><label>总登录次数</label> <span>${sessionScope.loginToken.loginTimes}</span></div>
					</div>
				</div>
			</div>
			<div class="uk-width-2-3" style="padding:0;">
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">用户名：</div>
					<div class="uk-width-2-6">${user.userName}</div>
					<div class="uk-width-1-6 uk-font-bold">昵称：</div>
					<div class="uk-width-2-6">${user.nickName}</div>
				</div>
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">手机：</div>
					<div class="uk-width-2-6">${user.mobilePhone}</div>
					<div class="uk-width-1-6 uk-font-bold">邮箱：</div>
					<div class="uk-width-2-6">${user.email}</div>
				</div>
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">类型：</div>
					<div class="uk-width-2-6">${user.userTypeName}</div>
					<div class="uk-width-1-6 uk-font-bold">状态：</div>
					<div class="uk-width-2-6">${user.statusName}</div>
				</div>
				<div class="uk-grid uk-row">
					<div class="uk-width-1-6 uk-font-bold">创建时间：</div>
					<div class="uk-width-2-6">${user.createTime}</div>
					<div class="uk-width-1-6 uk-font-bold">
						<c:if test="${not empty user.updateTime}">
						修改时间：
						</c:if>
					</div>
					<div class="uk-width-2-6">
						<c:if test="${not empty user.updateTime}">
						${user.updateTime}
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<div class="uk-grid uk-row uk-bg-white">
			<div class="uk-width-1-1">
				<h3 class="uk-title">账户权限</h3>
				<hr class="uk-title-hr"/>
				<ul class="uk-tab" data-uk-tab="{connect:'#tab-content'}">
					<li class="uk-active"><a href="javascript:;">我的角色</a></li>
					<li><a href="javascript:;">我的资源</a></li>
					<!-- <li><a href="javascript:;" >操作日志</a></li> -->
				</ul>
				<div id="tab-content" class="uk-switcher uk-margin">
					<div>
						<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
					        <thead>
					            <tr>
					            	<th width="5%" class="uk-center">序号</th>
									<th width="15%">角色名称</th>
									<th width="15%">角色代码</th>
									<th width="15%">角色类型</th>
									<th width="35%">角色描述</th>
									<th width="15%" class="uk-center">配置时间</th>
					            </tr>
					        </thead>
							<tbody>
								<c:if test="${empty userRoleList}">
									<tr><td class="no-result" colspan="7">系统暂未给您配置任何角色.</td></tr>
								</c:if>
								<c:if test="${not empty userRoleList}">
									<c:forEach items="${userRoleList}" var="item" varStatus="status">
										<tr>
											<td class="uk-center">${status.index + 1}</td>
											<td>${item.roleName}</td>
											<td>${item.roleCode}</td>
											<td>${item.roleTypeName}</td>
											<td>${item.description}</td>
											<td class="uk-center"><span class="uk-cell uk-center">${item.createTime}</span></td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<div>
						<table id="resource-table" class="treetable treetable-success">
							<thead>
								<tr>
									<th class="white" width="5%"><label>序号</label></th>
									<th class="white" width="35%"><label>资源/菜单名称</label></th>
									<th class="white align-center" width="10%"><label>排序号</label></th>
									<th class="white align-center" width="10%"><label>功能类型</label></th>
									<th class="white" width="25%"><label>资源URL</label></th>
									<th class="white" width="15%"><label>权限表达式</label></th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty userResourceList}">
									<tr><td class="no-result" colspan="6">系统暂未给您配置任何资源/菜单.</td></tr>
								</c:if>
								<c:if test="${not empty userResourceList}">
									<c:forEach items="${userResourceList}" var="item" varStatus="status">
										<tr data-tt-id="${item.resourceId}" data-tt-parent-id='${item.parentResourceId}' data-inuse="${item.inuse}">
											<td class="white" style="text-align:center;">${status.index + 1}</td>
											<td class="bold black white"><span class='${item.resourceIcon}'>${item.resourceName}</span></td>
											<td class="align-center white">${item.siblingsIndex}</td>
											<td class="align-center white">${item.actionTypeName}</td>
											<td class="white">${item.resourceUrl}</td>
											<td class="white">${item.permissionExpression}</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<div>
						暂无操作日志
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/jquery.treetable.js"></script>
    <script type="text/javascript">
	    /**
	     * 初始化treetable
	     */
	    $("#resource-table").treetable({
	    	column: 1,
	    	expandable: true,
	    	initialState: 'expanded'
	    });
    </script>
</body>
</html>