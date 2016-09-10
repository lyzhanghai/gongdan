<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
	<title>活动管理</title>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css" />
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css" />
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>
	<style type="text/css">
		.uk-comment-header {margin: 0; padding: 0; background-color: transparent;border: 0 none;}
		.uk-comment-title {font-size: 15px;}
		.uk-comment-avatar {border-radius: 0;}
		.uk-description-list-horizontal {margin: 0;}
		.uk-description-list-horizontal > dd {margin-left:65px;}
		.uk-description-list-horizontal > dt {width: 60px;}
	</style>
	<script type="text/javascript">
	    var DEFAULT_ACTIVITY_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_ACTIVITY_QUERY_LIST_ORDER_BY}';
	    var DEFAULT_ACTIVITY_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_ACTIVITY_QUERY_LIST_ORDER}';
	    var ACTIVITY_OLOSTATUS_ONLINE = {
			statusCode: '${applicationScope.ACTIVITY_OLOSTATUS_ONLINE.statusCode}',
			statusName: '${applicationScope.ACTIVITY_OLOSTATUS_ONLINE.statusName}'
		};
		var ACTIVITY_OLOSTATUS_OFFLINE = {
			statusCode: '${applicationScope.ACTIVITY_OLOSTATUS_OFFLINE.statusCode}',
			statusName: '${applicationScope.ACTIVITY_OLOSTATUS_OFFLINE.statusName}'
		};
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
				<li><i></i><a href="javascript:;">业务管理</a></li>
				<li><i></i><a href="${CONTEXT_PATH}/admin/activity/list">活动管理</a></li>
				<li class="active">活动查询</li>
			</ul>
		</div>
		<form id="activityQueryForm" class="uk-form" name="activityQueryForm" action="${CONTEXT_PATH}/admin/activity/list" method="post">
			<fieldset>
				<legend>活动查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
							<td class="uk-form-label uk-width-1-6">活动标题：</td>
							<td class="uk-form-field uk-width-2-6"><input type="text" name="title" value="${activityQueryForm.title}" /></td>
							<td class="uk-form-label uk-width-1-6">活动类型：</td>
							<td class="uk-form-field uk-width-1-6">
								<select name="type">
									<option value="">--请选择--</option>
									<c:forEach items="${activityTypes}" var="item">
										<option value="${item.typeCode}" ${activityQueryForm.type eq item.typeCode ? 'selected' : ''}>${item.typeName}</option>
									</c:forEach>
								</select>
							</td>
							<td class="uk-width-1-6"></td>
						</tr>
						<tr>
							<td class="uk-form-label uk-width-1-6">活动时间：</td>
							<td class="uk-form-field uk-width-2-6">
								<input id="startTime" class="uk-w160" type="text" name="startTime" value="${activityQueryForm.startTime}"/>&nbsp;-&nbsp;
								<input id="endTime" class="uk-w160" type="text" name="endTime" value="${activityQueryForm.endTime}"/>
							</td>
							<td class="uk-form-label uk-width-1-6">上下架状态：</td>
							<td class="uk-form-field uk-width-1-6">
								<select name="oloStatus">
									<option value="">--请选择--</option>
									<c:forEach items="${oloStatuses}" var="item">
										<option value="${item.statusCode}" ${activityQueryForm.oloStatus eq item.statusCode ? 'selected' : ''}>${item.statusName}</option>
									</c:forEach>
								</select>
							</td>
							<td class="uk-width-1-6 uk-center">
								<input type="hidden" name="orderby" value="${orderBy.orderby}" />
								<input type="hidden" name="order" value="${orderBy.order}" /> 
								<input type="hidden" name="currentPage" value="${pager.currentPage}" />
								<input type="hidden" name="pageSize" value="${pager.pageSize}" />
								<button type="button" class="uk-button uk-button-primary" onclick="queryActivityList();">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th width="20%"><label>标题</label></th>
								<th width="8%" class="orderby ${orderBy.orderby eq 'type' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'type', 'activityQueryForm');"><label>类型</label></th>
								<th width="13%"><label>地点</label></th>
								<th width="8%" class="orderby ${orderBy.orderby eq 'oloStatus' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'oloStatus', 'activityQueryForm');"><label>状态</label></th>
								<th width="9%" class="uk-center orderby ${orderBy.orderby eq 'startTime' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'startTime', 'activityQueryForm');"><label>开始时间</label></th>
								<th width="9%" class="uk-center orderby ${orderBy.orderby eq 'createTime' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'createTime', 'activityQueryForm');"><label>创建时间</label></th>
								<th width="20%"><label>讲座</label></th>
								<th class="uk-center" width="13%">操作</th>
							</tr>
							<tr class="gap">
								<td colspan="8"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="8">
									<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/admin/activity/add">新增活动</a>
									<span class="selected-row-count"></span>
								</td>
							</tr>
							<tr class="gap">
								<td colspan="8"></td>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr>
									<td class="no-result" colspan="8">没有查询到符合条件的记录.</td>
								</tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item" varStatus="status">
									<tr>
										<td>
											<header class="uk-comment-header">
												<img class="uk-comment-avatar" src="${item.fullThumbnail}" width="50" height="50" alt="" />
												<h4 class="uk-comment-title">${item.title}</h4>
											</header>
										</td>
										<td>${item.typeName}</td>
										<td>${item.place}</td>
										<td><span class="uk-label activity-status uk-status-${item.oloStatus}">${item.oloStatusName}</span></td>
										<td class="uk-center"><span class="uk-cell uk-center">${item.startTime}</span></td>
										<td class="uk-center"><span class="uk-cell uk-center">${item.createTime}</span></td>
										<td>
											<c:if test="${applicationScope.ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeCode eq item.type}">
												<dl class="uk-description-list-horizontal">
									                <dt>讲师</dt>
									                <dd title="${item.lecturerIntro}">${item.lecturer}</dd>
									                <dt>选坐时间</dt>
									                <dd>
									                	<label class="uk-display-block">${item.selectSeatStartTime}</label>
									                	<span class="uk-display-block">~</span>
									                	<label class="uk-display-block">${item.selectSeatEndTime}</label>
									                </dd>
									            </dl>
											</c:if>
										</td>
										<td class="uk-center">
											<div class="uk-button-group uk-button-dropdown-small">
												<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/activity/detail?id=${item.id}">查看详细</a>
												<div data-uk-dropdown="{mode:'click'}">
													<button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
													<div class="uk-dropdown uk-dropdown-shadow">
														<ul class="uk-nav uk-nav-dropdown">
															<li><a href="${CONTEXT_PATH}/admin/activity/detail?id=${item.id}">查看详细</a></li>
															<li><a href="${CONTEXT_PATH}/admin/activity/edit?id=${item.id}">修改活动</a></li>
															<c:if test="${item.type eq applicationScope.ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeCode || item.type eq applicationScope.ACTIVITY_TYPE_USER_SIGNUP.typeCode}">
																<c:if test="${!item.unstart}">
																</c:if>
															</c:if>
															<c:if test="${ nowTime < item.startTime || item.type ==4 }">
															<c:if test="${item.oloStatus == applicationScope.ACTIVITY_OLOSTATUS_ONLINE.statusCode}">
																<li><a href="javascript:;" data-status="${item.oloStatus}" onclick="updateActivityOloStatus(this, '${item.id}');">${applicationScope.ACTIVITY_OLOSTATUS_OFFLINE.statusName}该活动</a></li>
															</c:if>
															</c:if>
												
															
															<c:if test="${item.oloStatus == applicationScope.ACTIVITY_OLOSTATUS_OFFLINE.statusCode}">
																<li><a href="javascript:;" data-status="${item.oloStatus}" onclick="updateActivityOloStatus(this, '${item.id}');">${applicationScope.ACTIVITY_OLOSTATUS_ONLINE.statusName}该活动</a></li>
															</c:if>
																		<!--  
							                                <li class="uk-nav-divider"></li>
							                                <li><a href="javascript:;" onclick="delActivity(this,'${item.id}');">删除活动</a></li>-->
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
					<jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="activityQueryForm"/></jsp:include>
				</div>
			</fieldset>
		</form>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/activity/list.js"></script>
</body>
</html>