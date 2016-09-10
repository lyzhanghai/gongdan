<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>角色管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <script type="text/javascript">
		var DEFAULT_ROLE_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER_BY}';
		var DEFAULT_ROLE_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER}';
		var ROLE_TYPE_SYSTEM = {
			typeCode: '${applicationScope.ADMIN_ROLE_TYPE_SYSTEM.typeCode}',
			typeName: '${applicationScope.ADMIN_ROLE_TYPE_SYSTEM.typeName}'
		};
	</script>
</head>
<body>
    <div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">系统管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/xadmin/role/list">角色管理</a></li>
			  <li class="active">角色查询</li>
			</ul>
		</div>
        <form id="roleQueryForm" class="uk-form" name="roleQueryForm" action="${CONTEXT_PATH}/xadmin/role/list" method="post">
            <fieldset>
                <legend>角色查询</legend>
                <div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
               			<tr>
               				<td class="uk-form-label uk-width-1-5">角色名称：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="roleName" value="${roleQueryForm.roleName}"/></td>
               				<td class="uk-form-label uk-width-1-5">角色代码：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="roleCode" value="${roleQueryForm.roleCode}"/></td>
               				<td class="uk-center" colspan="2">
               					<input type="hidden" name="orderby"  value="${orderBy.orderby}"/>
	                            <input type="hidden" name="order"  value="${orderBy.order}"/>
	                            <input type="hidden" name="currentPage"  value="${pager.currentPage}"/>
	                            <input type="hidden" name="pageSize"  value="${pager.pageSize}"/>
	                            <button type="button" class="uk-button uk-button-primary" onclick="queryRoleList();">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
	                            <button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
               				</td>
               			</tr>
                	</table>
                </div>
                <div>
                    <table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th width="4%">序号</th>
                                <th width="15%" class="orderby ${orderBy.orderby eq 'roleName' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'roleName', 'roleQueryForm');"><label>角色名称</label></th>
                                <th width="15%" class="orderby ${orderBy.orderby eq 'roleCode' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'roleCode', 'roleQueryForm');"><label>角色代码</label></th>
                                <th width="12%" class="orderby ${orderBy.orderby eq 'roleType' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'roleType', 'roleQueryForm');"><label>角色类型</label></th>
                                <th width="20%">角色描述</th>
                                <th width="10%" class="uk-center orderby ${orderBy.orderby eq 'createTime' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'createTime', 'roleQueryForm');"><label>创建时间</label></th>
                                <th width="10%">创建者</th>
                                <th class="uk-center" width="14%">操作</th>
                            </tr>
                            <tr class="gap">
								<td colspan="8"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="8">
									<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/xadmin/role/add">新增角色</a>
									<span class="selected-row-count"></span>
								</td>
							</tr>
							<tr class="gap">
								<td colspan="8"></td>
							</tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty dataList}">
                                <tr><td class="no-result" colspan="8">没有查询到符合条件的记录.</td></tr>
                            </c:if>
                            <c:if test="${not empty dataList}">
                                <c:forEach items="${dataList}" var="item" varStatus="status">
                                    <tr>
                                        <td>${status.index+1}</td>
                                        <td>${item.roleName}</td>
                                        <td>${item.roleCode}</td>
                                        <td>${item.roleTypeName}</td>
                                       	<td>${item.description}</td>
                                        <td class="uk-center"><span class="uk-cell uk-center">${item.createTime}</span></td>
                                        <td>${item.createByName}</td>
                                        <td class="uk-center">
                                        	<div class="uk-button-group uk-button-dropdown-small">
							                    <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/xadmin/role/detail?roleId=${item.roleId}">查看详细</a>
							                    <div data-uk-dropdown="{mode:'click'}">
							                        <button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
							                        <div class="uk-dropdown uk-dropdown-shadow">
							                            <ul class="uk-nav uk-nav-dropdown">
							                                <li><a href="${CONTEXT_PATH}/xadmin/role/detail?roleId=${item.roleId}">查看详细</a></li>
							                                <li><a href="${CONTEXT_PATH}/xadmin/role/edit?roleId=${item.roleId}">修改角色</a></li>
															<li><a href="${CONTEXT_PATH}/xadmin/role/config?roleId=${item.roleId}">配置用户角色</a></li>
							                                <!-- 系统用户不允许删除 -->
							                                <c:if test="${item.roleType ne applicationScope.ADMIN_ROLE_TYPE_SYSTEM.typeCode}">
							                                	<li class="uk-nav-divider"></li>
							                                	<li><a href="javascript:;" onclick="delRole(this,'${item.roleId}');">删除角色</a></li>
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
                    <jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="roleQueryForm"/></jsp:include>
                </div>
            </fieldset>
        </form>
    </div>
    <jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/role/list.js"></script>
</body>
</html>