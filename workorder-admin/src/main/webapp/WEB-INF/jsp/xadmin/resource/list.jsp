<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>资源管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/css/jquery.treetable.css"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/css/jquery.treetable.theme.css"/>
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
			  <li class="active">资源查询</li>
			</ul>
		</div>
		<form id="resourceQueryForm" class="uk-form" name="resourceQueryForm" action="${CONTEXT_PATH}/xadmin/resource/list" method="post">
			<fieldset>
				<legend>资源查询</legend>
				<div class="uk-margin-bottom">
					<table id="resource-table" class="treetable treetable-primary">
						<caption style="text-align:left;">
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="toAddResource(this);">新增资源</a>&nbsp;&nbsp;
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="toEditResource(this);">修改所选资源</a>&nbsp;&nbsp;
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="delResource(this);">删除所选资源</a>&nbsp;&nbsp;
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="refreshResourceTree();">刷新资源树</a>
						</caption>
						<thead>
							<tr>
								<th class="white" width="3%"><label></label></th>
								<th class="white" width="33%"><label>资源名称</label></th>
								<th class="white align-center" width="7%"><label>排序号</label></th>
								<th class="white align-center" width="7%"><label>功能类型</label></th>
								<th class="white" width="25%"><label>资源URL</label></th>
								<th class="white" width="15%"><label>权限表达式</label></th>
								<th class="white align-center" width="10%"><label>操作</label></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr><td class="no-result" colspan="7">没有查询到符合条件的记录.</td></tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item">
									<tr data-tt-id="${item.resourceId}" data-tt-parent-id='${item.parentResourceId}' data-inuse="${item.inuse}">
										<td class="white" style="text-align:center;"><input type="radio" name="resourceId" onclick="selectThisRow(this);" value="${item.resourceId}"/></td>
										<td class="bold black white"><span class='${item.resourceIcon}'>${item.resourceName}</span></td>
										<td class="align-center white">${item.siblingsIndex}</td>
										<td class="align-center white">${item.actionTypeName}</td>
										<td class="white">${item.resourceUrl}</td>
										<td class="white">${item.permissionExpression}</td>
										<td class="align-center white">
											<a class="uk-button uk-button-primary uk-button-small-mini" href="${CONTEXT_PATH}/xadmin/resource/detail?id=${item.resourceId}">查看详情</a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</fieldset>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/jquery.treetable.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/xadmin/resource/list.js"></script>
</body>
</html>