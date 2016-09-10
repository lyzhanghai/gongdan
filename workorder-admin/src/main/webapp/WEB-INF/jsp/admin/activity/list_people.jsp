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
		<form id="activityQueryForm" class="uk-form" name="activityQueryForm" action="${CONTEXT_PATH}/admin/activity/people//list" method="post">
			<fieldset>
				<legend>活动查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
							<td class="uk-form-label uk-width-1-6">活动名称：</td>
							<td class="uk-form-field uk-width-2-6"><input type="text"  class="uk-w160" name="activityName" value="${activityQueryForm.activity.title}" /></td>
							<td class="uk-width-1-6"></td>
						</tr>
						<tr>
							<td class="uk-form-label uk-width-1-6">人员名称：</td>
							<td class="uk-form-field uk-width-2-6">
								<input id="name" class="uk-w160" type="text" name="name" value="${activityQueryForm.name}"/>
							</td>
							<td class="uk-width-1-6 uk-center">
								<input type="hidden" name="orderby" value="${orderBy.orderby}" />
								<input type="hidden" name="order" value="${orderBy.order}" /> 
								<input type="hidden" name="currentPage" value="${pager.currentPage}" />
								<input type="hidden" name="pageSize" value="${pager.pageSize}" />
								<button type="button" class="uk-button uk-button-primary" onclick="queryActivitySignupList();">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th width="5%"><label>id</label></th>
								<th width="15%" ><label>活动名称</label></th>
								<th width="10%"><label>报名人</label></th>
								<th width="8%" ><label>手机号</label></th>
								<th width="9%"><label>选座位置</label></th>
								<th width="15%" ><label>活动时间</label></th>
								<th width="20%"><label>活动地址</label></th>
								<th width="5%" colspan="2"><label>是否参加</label></th>
							</tr>
							<tr class="gap">
								<td colspan="9"></td>
							</tr>
							<tr class="gap">
								<td colspan="9"></td>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr>
									<td class="no-result" colspan="9">没有查询到符合条件的记录.</td>
								</tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item" varStatus="status">
									<tr>
										<td>${item.id}
										</td>
										<td>${item.activity.title}</td>
										<td>${item.name}</td>
										<td>${item.phone}</td>
										<td>
										<c:if test="${empty item.selectedSeatNames }">无</c:if>
										<c:if test="${not empty item.selectedSeatNames }">${item.selectedSeatNames}</c:if>
										</td>
										<td>${item.activity.startTime}</td>
										<td >${item.activity.place}</td>
										<td>
											<c:if test="${1 eq item.status}">
												已参加
											</c:if>
											<c:if test="${0 eq item.status}">
													未参加
											</c:if>
										</td>
										<td class="uk-center">
										<!--  
											<div class="uk-button-group uk-button-dropdown-small">
												<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/activity/detail?id=${item.id}">查看详细</a>
												<div data-uk-dropdown="{mode:'click'}">
													<button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
													<div class="uk-dropdown uk-dropdown-shadow">
														<ul class="uk-nav uk-nav-dropdown">
															<li><a href="${CONTEXT_PATH}/admin/activity/detail?id=${item.id}">查看详细</a></li>
														</ul>
													</div>
												</div>
											</div>-->
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