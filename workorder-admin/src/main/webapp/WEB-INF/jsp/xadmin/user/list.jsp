<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>用户管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<script type="text/javascript">
		var DEFAULT_USER_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_ADMIN_USER_QUERY_LIST_ORDER_BY}';
		var DEFAULT_USER_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_ADMIN_USER_QUERY_LIST_ORDER}';
		var USER_STATUS_ENABLED = {
			statusCode: '${applicationScope.ADMIN_USER_STATUS_ENABLED.statusCode}',
			statusName: '${applicationScope.ADMIN_USER_STATUS_ENABLED.statusName}'
		};
		var USER_STATUS_DISABLED = {
			statusCode: '${applicationScope.ADMIN_USER_STATUS_DISABLED.statusCode}',
			statusName: '${applicationScope.ADMIN_USER_STATUS_DISABLED.statusName}'
		};
		var USER_TYPE_SYSTEM = {
			typeCode: '${applicationScope.ADMIN_USER_TYPE_SYSTEM.typeCode}',
			typeName: '${applicationScope.ADMIN_USER_TYPE_SYSTEM.typeName}'
		}
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/user/list">用户管理</a></li>
			  <li class="active">用户查询</li>
			</ul>
		</div>
		<form id="userQueryForm" class="uk-form" name="userQueryForm" action="${CONTEXT_PATH}/xadmin/user/list" method="post">
			<fieldset>
				<legend>用户查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
               				<td class="uk-form-label uk-width-1-5">用&nbsp;户&nbsp;名：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="userName" value="${userQueryForm.userName}"/></td>
               				<td class="uk-form-label uk-width-1-5">昵&nbsp;&nbsp;称：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="nickName" value="${userQueryForm.nickName}"/></td>
               				<td class="uk-width-1-5"></td>
               			</tr>
               			<tr>
               				<td class="uk-form-label">用户类型：</td>
               				<td class="uk-form-field">
               					<select id="userType" name="userType">
									<option value="">--请选择--</option>
									<c:forEach items="${userTypes}" var="item">
										<option value="${item.typeCode}" ${userQueryForm.userType eq item.typeCode ? 'selected' : ''}>${item.typeName}</option>
									</c:forEach>
								</select>
               				</td>
               				<td class="uk-form-label">状&nbsp;&nbsp;态：</td>
               				<td class="uk-form-field">
               					<select name="status">
									<option value="">--请选择--</option>
									<c:forEach items="${userStatuses}" var="item">
										<option value="${item.statusCode}" ${userQueryForm.status eq item.statusCode ? 'selected' : ''}>${item.statusName}</option>
									</c:forEach>
								</select>
               				</td>
               				<td class="uk-center">
               					<input type="hidden" name="orderby"  value="${orderBy.orderby}"/>
	                            <input type="hidden" name="order"  value="${orderBy.order}"/>
	                            <input type="hidden" name="currentPage"  value="${pager.currentPage}"/>
	                            <input type="hidden" name="pageSize"  value="${pager.pageSize}"/>
	                            <button type="button" class="uk-button uk-button-primary" onclick="queryUserList();">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
	                            <button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
               				</td>
               			</tr>
                	</table>
				</div>
				<div>
					<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
				        <thead>
				            <tr>
				            	<th width="3%">#</th>
                                <th width="13%" class="orderby ${orderBy.orderby eq 'userName' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'userName', 'userQueryForm');"><label>用户名</label></th>
                                <th width="12%" class="orderby ${orderBy.orderby eq 'nickName' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'nickName', 'userQueryForm');"><label>昵称</label></th>
                                <th class="uk-center" width="10%">手机</th>
                                <th width="15%">EMAIL</th>
                                <th width="12%" class="orderby ${orderBy.orderby eq 'userType' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'userType', 'userQueryForm');"><label>用户类型</label></th>
                                <th width="10%" class="orderby ${orderBy.orderby eq 'status' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'status', 'userQueryForm');"><label>状态</label></th>
                                <th width="10%" class="uk-center orderby ${orderBy.orderby eq 'createTime' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'createTime', 'userQueryForm');"><label>创建时间</label></th>
                                <th class="uk-center" width="15%">操作</th>
				            </tr>
				            <tr class="gap">
								<td colspan="9"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="9">
									<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/xadmin/user/add">新增用户</a>
									<span class="selected-row-count"></span>
								</td>
							</tr>
							<tr class="gap">
								<td colspan="9"></td>
							</tr>
				        </thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr><td class="no-result" colspan="9">没有查询到符合条件的记录.</td></tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item" varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td>${item.userName}</td>
										<td>${item.nickName}</td>
										<td class="uk-center">${item.mobilePhone}</td>
										<td>${item.email}</td>
										<td>${item.userTypeName}</td>
										<td><span class="uk-label user-status uk-status-${item.status}">${item.statusName}</span></td>
										<td class="uk-center"><span class="uk-cell uk-center">${item.createTime}</span></td>
										<td class="uk-center">
											<div class="uk-button-group uk-button-dropdown-small">
							                    <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/user/detail?userId=${item.userId}">查看详细</a>
							                    <div data-uk-dropdown="{mode:'click'}">
							                        <button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
							                        <div class="uk-dropdown uk-dropdown-shadow">
							                            <ul class="uk-nav uk-nav-dropdown">
							                                <li><a href="href="${CONTEXT_PATH}/xadmin/user/detail?userId=${item.userId}">查看详细</a></li>
							                                <li><a href="${CONTEXT_PATH}/xadmin/user/edit?userId=${item.userId}">修改用户</a></li>
							                                <!-- 系统用户不允许禁用其账号 -->
							                                <c:if test="${item.userType ne applicationScope.ADMIN_USER_TYPE_SYSTEM.typeCode}">
																<c:if test="${item.status == applicationScope.ADMIN_USER_STATUS_ENABLED.statusCode}">
																	<li><a href="javascript:;" data-status="${item.status}" onclick="updateUserStatus(this, '${item.userId}');">${applicationScope.ADMIN_USER_STATUS_DISABLED.statusName}该用户</a></li>
																</c:if>
																<c:if test="${item.status == applicationScope.ADMIN_USER_STATUS_DISABLED.statusCode}">
																	<li><a href="javascript:;" data-status="${item.status}" onclick="updateUserStatus(this, '${item.userId}');">${applicationScope.ADMIN_USER_STATUS_ENABLED.statusName}该用户</a></li>
																</c:if>
															</c:if>
															<li><a href="${CONTEXT_PATH}/xadmin/user/config?userId=${item.userId}">配置用户角色</a></li>
							                                <!-- 系统用户不允许删除 -->
							                                <c:if test="${item.userType ne applicationScope.ADMIN_USER_TYPE_SYSTEM.typeCode}">
							                                	<li class="uk-nav-divider"></li>
							                                	<li><a href="javascript:;" onclick="delUser(this,'${item.userId}');">删除用户</a></li>
							                                </c:if>
							                            </ul>
							                        </div>
							                    </div>
							                </div>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="userQueryForm"/></jsp:include>
				</div>
			</fieldset>
		</form>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/user/list.js"></script>
</body>
</html>