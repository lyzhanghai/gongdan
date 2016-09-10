<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>活动详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/simplePagination/simplePagination.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>
    <style type="text/css">
    	.uk-comment-header {margin: 0;padding: 0;background-color: transparent;border: 0 none;}
    	.uk-comment-title {font-size: 15px;}
    	.datetimepicker-inline {width: 350px;}
    	.datetimepicker table {width: auto;}
    	.datetimepicker table td {height: 50px; width: 50px; line-height: 50px;}
    	.datetimepicker table td.checked {background: #eee url(../../resources/images/green-check-16.png) no-repeat 20px 25px;}
    </style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/user/list">用户管理</a></li>
			  <li class="active">查看用户详情</li>
			</ul>
		</div>
		<ul class="uk-tab" data-uk-tab="{connect:'#tab-content'}">
			<li class="uk-active"><a href="javascript:;">用户详情信息</a></li>
			<li><a href="javascript:;">用户签到信息</a></li>
			<li><a href="javascript:;">用户活动信息</a></li>
			<li><a href="javascript:;">用户优惠券信息</a></li>
			<li><a href="javascript:;">用户借阅信息</a></li>
		</ul>
		<div id="tab-content" class="uk-switcher uk-margin">
			<div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">用户ID：</label>
					<div class="uk-width-4-5 uk-color-666">${user.userId}<input id="userId" type="hidden" name="userId" value="${user.userId}"/></div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">用户昵称：</label>
					<div class="uk-width-4-5 uk-color-666">
						<header class="uk-comment-header">
							<c:if test="${empty user.fullIconUrl}">
								<img class="uk-comment-avatar" src="${CONTEXT_PATH}/resources/images/avatar9.jpg" width="50" height="50" alt=""/>
							</c:if>
							<c:if test="${not empty user.fullIconUrl}">
								<img class="uk-comment-avatar" src="${user.fullIconUrl}" width="50" height="50" alt=""/>
							</c:if>
							<h4 class="uk-comment-title">${user.nickName}</h4>
						</header>
					</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">用户类型：</label>
					<div class="uk-width-4-5 uk-color-666">${user.userTypeName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">手机号码：</label>
					<div class="uk-width-4-5 uk-color-black uk-font-bold">${user.mobilePhone}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">EMAIL：</label>
					<div class="uk-width-4-5 uk-color-666">${user.email}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">积分：</label>
					<div class="uk-width-4-5 uk-color-666">${user.userPoint}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">性别：</label>
					<div class="uk-width-4-5 uk-color-666">${user.genderName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">今日签到：</label>
					<div class="uk-width-4-5 uk-color-666">${user.todaySignin ? '已签' : '未签'}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">签到次数：</label>
					<div class="uk-width-4-5 uk-color-666">${user.signinTotalCount}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">参加活动次数：</label>
					<div class="uk-width-4-5 uk-color-666">${user.activitySignupTotalCount}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">缺席活动次数：</label>
					<div class="uk-width-4-5 uk-color-666">${user.activitySignupAbsentCount}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">注册时间：</label>
					<div class="uk-width-4-5 uk-color-666">${user.createTime}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">单位/团体：</label>
					<div class="uk-width-4-5 uk-color-666">${user.groupName}</div>
				</div>
				<div class="uk-grid uk-row">
					<div class="uk-width-2-5"></div>
					<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/user/list">返回列表</a></div>
				</div>
			</div>
			<!-- 用户签到信息 -->
			<div>
				<h3 style="padding-left:120px;">用户签到日历</h3>
				<div>
					<div id="signinCalendar"></div>
				</div>
			</div>
			<!-- 用户活动信息 -->
			<div>
				<form class="uk-form" name="userActivitySignupForm" action="${CONTEXT_PATH}/admin/user/activity/signuplist" method="post">
					<div class="uk-margin-bottom uk-condition">
						<table class="uk-form-table">
							<tr>
								<td class="uk-width-1-1">
									<input type="hidden" name="userId" value="${user.userId}" />
									<input type="hidden" name="currentPage" value="1" />
									<input type="hidden" name="pageSize" value="10" />
									<button type="button" class="uk-button uk-button-primary" onclick="loadUserActivitySignupList(1);">刷&nbsp;&nbsp;新</button>
								</td>
							</tr>
						</table>
					</div>
					<div>
						<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th width="10%"><label>活动ID</label></th>
									<th width="25%"><label>活动标题</label></th>
									<th width="15%"><label>活动时间</label></th>
									<th width="10%"><label>活动类型</label></th>
									<th width="15%"><label>报名时间</label></th>
								</tr>
								<tr class="gap">
									<td colspan="5"></td>
								</tr>
							</thead>
							<tbody id="signupSearchList">
								<tr><td class="no-result" colspan="5">暂无记录!</td></tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="5">
										<div id="signupSearchPager" class="uk-grid" style="display:none;padding:10px 10px 5px 10px;">
						               		<div class="uk-width-1-3">
												<p>共<span class="total-count">0</span>条</p>
											</div>
						               		<div class="uk-width-2-3">
												<div class="pagination-num uk-float-right"></div>
						               		</div>
						               	</div>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</form>
			</div>
			<!-- 用户优惠券信息 -->
			<div>
				<form class="uk-form" name="userCouponForm" action="${CONTEXT_PATH}/admin/user/coupon/getlist" method="post">
					<div class="uk-margin-bottom uk-condition">
						<table class="uk-form-table">
							<tr>
								<td class="uk-width-1-1">
									<input type="hidden" name="userId" value="${user.userId}" />
									<input type="hidden" name="currentPage" value="1" />
									<input type="hidden" name="pageSize" value="10" />
									<button type="button" class="uk-button uk-button-primary" onclick="loadUserActivitySignupList(1);">刷&nbsp;&nbsp;新</button>
								</td>
							</tr>
						</table>
					</div>
					<div>
						<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th width="10%"><label>优惠券ID</label></th>
									<th width="25%"><label>优惠券标题</label></th>
									<th width="35%"><label>优惠券有效期</label></th>
									<th width="15%"><label>领取时间</label></th>
									<th width="15%"><label>使用时间</label></th>
								</tr>
								<tr class="gap">
									<td colspan="5"></td>
								</tr>
							</thead>
							<tbody id="userCouponSearchList">
								<tr><td class="no-result" colspan="5">暂无记录!</td></tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="5">
										<div id="userCouponSearchPager" class="uk-grid" style="display:none;padding:10px 10px 5px 10px;">
						               		<div class="uk-width-1-3">
												<p>共<span class="total-count">0</span>条</p>
											</div>
						               		<div class="uk-width-2-3">
												<div class="pagination-num uk-float-right"></div>
						               		</div>
						               	</div>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</form>
			</div>
			
			<!-- 用户借阅信息 -->
			<div>
				
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/simplePagination/jquery.simplePagination.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jsrender.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/user/detail.js"></script>
</body>
</html>