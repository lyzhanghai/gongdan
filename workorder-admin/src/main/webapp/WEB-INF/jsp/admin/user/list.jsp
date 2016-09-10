<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>用户管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <style type="text/css">
    	.uk-comment-header {margin: 0;padding: 0;background-color: transparent;border: 0 none;}
    	.uk-comment-title {font-size: 15px;}
    	.uk-description-list-horizontal {margin: 0;}
		.uk-description-list-horizontal > dd {margin-left:85px;min-height:20px;}
		.uk-description-list-horizontal > dt {width: 85px;color:#27ad60;}
		.uk-table > tbody > tr.selected > td .uk-description-list-horizontal > dt {color: #fff;}
		.uk-description-list-horizontal.uk-description-list-signin > dt {width: 75px;}
		.uk-description-list-horizontal.uk-description-list-signin > dd {margin-left: 75px;}
		.uk-description-list-horizontal.uk-description-list-activity > dt {width: 105px;}
		.uk-description-list-horizontal.uk-description-list-activity > dd {margin-left: 105px;}
    </style>
	<script type="text/javascript">
		var DEFAULT_USER_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_USER_QUERY_LIST_ORDER_BY}';
		var DEFAULT_USER_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_USER_QUERY_LIST_ORDER}';
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/user/list">用户管理</a></li>
			  <li class="active">用户查询</li>
			</ul>
		</div>
		<form id="userQueryForm" class="uk-form" name="userQueryForm" action="${CONTEXT_PATH}/admin/user/list" method="post">
			<fieldset>
				<legend>用户查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
               				<td class="uk-form-label uk-width-1-5">用户昵称：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="nickName" value="${userQueryForm.nickName}"/></td>
               				<td class="uk-form-label uk-width-1-5">图书卡号：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="libraryCard" value="${userQueryForm.libraryCard}"/></td>
               				<td class="uk-width-1-5"></td>
               			</tr>
						<tr>
               				<td class="uk-form-label uk-width-1-5">手机号码：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="mobilePhone" value="${userQueryForm.mobilePhone}"/></td>
               				<td class="uk-form-label uk-width-1-5">用户类型：</td>
               				<td class="uk-form-field uk-width-1-5">
               					<select id="userType" name="userType">
									<option value="">--请选择--</option>
									<c:forEach items="${userTypes}" var="item">
										<option value="${item.typeCode}" ${userQueryForm.userType eq item.typeCode ? 'selected' : ''}>${item.typeName}</option>
									</c:forEach>
								</select>
               				</td>
               				<td class="uk-width-1-5 uk-center">
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
				            	<th width="7%" class="orderby ${orderBy.orderby eq 'userId' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'userId', 'userQueryForm');">ID</th>
                                <th width="15%" class="orderby ${orderBy.orderby eq 'nickName' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'nickName', 'userQueryForm');"><label>昵称</label></th>
                                <th width="8%"><label>用户类型</label></th>
                                <th width="10%" class="orderby ${orderBy.orderby eq 'mobilePhone' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'mobilePhone', 'userQueryForm');"><label>手机号</label></th>
                                <th width="10%"><label>EMAIL</label></th>
                                <th width="6%" class="orderby ${orderBy.orderby eq 'userPoint' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'userPoint', 'userQueryForm');"><label>积分</label></th>
                                <th width="6%" class="orderby ${orderBy.orderby eq 'gender' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'gender', 'userQueryForm');"><label>性别</label></th>
                                <th width="13%"><label>签到</label></th>
                                <th width="15%"><label>活动</label></th>
                                <th class="uk-center" width="10%">操作</th>
				            </tr>
				            <tr class="gap">
								<td colspan="10"></td>
							</tr>
				        </thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr><td class="no-result" colspan="10">没有查询到符合条件的记录.</td></tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item" varStatus="status">
									<tr>
										<td>${item.userId}</td>
										<td>
											<header class="uk-comment-header">
												<c:if test="${empty item.fullIconUrl}">
													<img class="uk-comment-avatar" src="${CONTEXT_PATH}/resources/images/avatar9.jpg" width="50" height="50" alt=""/>
												</c:if>
												<c:if test="${not empty item.fullIconUrl}">
													<img class="uk-comment-avatar" src="${item.fullIconUrl}" width="50" height="50" alt=""/>
												</c:if>
												<h4 class="uk-comment-title">${item.nickName}</h4>
											</header>
										</td>
										<td class="uk-center">${item.userTypeName}</td>
										<td>${item.mobilePhone}</td>
										<td>${item.email}</td>
										<td>${item.userPoint}</td>
										<td>${item.genderName}</td>
										<td>
											<dl class="uk-description-list-horizontal uk-description-list-signin">
								                <dt>今日签到：</dt>
								                <dd>${item.todaySignin ? '已签' : '未签'}</dd>
								                <dt>签到次数：</dt>
								                <dd>${item.signinTotalCount}</dd>
								            </dl>
										</td>
										<td>
											<dl class="uk-description-list-horizontal uk-description-list-activity">
								                <dt>报名活动次数：</dt>
								                <dd>${item.activitySignupTotalCount}</dd>
								                <dt>缺席活动次数：</dt>
								                <dd>${item.activitySignupAbsentCount}</dd>
								            </dl>
										</td>
										<td class="uk-center">
											<%--<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/admin/user/detail?userId=${item.userId}">查看详细</a>--%>
											<div class="uk-button-group uk-button-dropdown-small">
												<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/user/detail?userId=${item.userId}">查看详细</a>
												<div data-uk-dropdown="{mode:'click'}">
													<button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
													<div class="uk-dropdown uk-dropdown-shadow">
														<ul class="uk-nav uk-nav-dropdown">
															<li><a href="${CONTEXT_PATH}/admin/user/addPoint?userId=${item.userId}">增加积分</a></li>
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
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/user/list.js"></script>
</body>
</html>