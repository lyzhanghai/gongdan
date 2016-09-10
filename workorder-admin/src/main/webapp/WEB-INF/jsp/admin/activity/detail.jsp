<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>活动详情</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/simplePagination/simplePagination.css"/>
    <style type="text/css">
    	.uk-table-seats > caption > div {display: block;text-align: center;font-style: normal; font-weight: bold;width: 100%;height: 50px; line-height: 50px; font-size: 18px; color: #000; background-color: #dfdfdf;margin: 0 0 30px 0;}
    	.uk-table-seats > thead > tr th {width: 50px;text-align: center;vertical-align: middle;}
    	.uk-table-seats > tbody > tr {border: 0 none;}
    	.uk-table-seats > tbody > tr > td {width: 50px;height: 30px; border: 0 none;padding: 5px;text-align: center;vertical-align: middle;}
    	.uk-table-seats > tbody > tr > td .seat-box {display: inline-block;position: relative;padding: 3px;background-color: #ccc;}
    	.uk-table-seats > tbody > tr > td .seat-box-1 {background-color: #27ad60;}
    	.uk-table-seats > tbody > tr > td .seat-box-2 {background-color: #428bca;}
    	.uk-table-seats > tbody > tr > td .seat-box-0 {background-color: #fff;}
    	.uk-table-seats > tbody > tr > td input {display: block;width: 24px !important; height: 24px !important; margin: 4px !important;text-align: center;border: 0 none !important;box-shadow: none !important;}
    	.uk-table-seats > tbody > tr > td input:focus {border: 0 none !important;box-shadow: none !important;}
    </style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="${CONTEXT_PATH}/admin/activity/list">活动管理</a></li>
			  <li class="active">查看活动</li>
			</ul>
		</div>
		<ul class="uk-tab" data-uk-tab="{connect:'#tab-content'}">
			<li class="uk-active"><a href="javascript:;">活动详情信息</a></li>
			<li><a href="javascript:;">活动报名信息</a></li>
			<li><a href="javascript:;">活动回顾信息</a></li>
		</ul>
		<div id="tab-content" class="uk-switcher uk-margin">
			<div>
				<h3 class="uk-title uk-title-small">活动基本信息</h3>
				<hr class="uk-title-hr"/>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动ID：</label>
					<div class="uk-width-4-5 uk-color-666">${activity.id}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动标题：</label>
					<div class="uk-width-4-5 uk-color-666">${activity.title}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动简介：</label>
					<div class="uk-width-4-5 uk-color-666">${activity.decription}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动缩略图片：</label>
					<div class="uk-width-4-5 uk-color-666"><img alt="" src="${activity.fullThumbnail}"></div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动图片：</label>
					<div class="uk-width-4-5 uk-color-666"><img alt="" src="${activity.fullImgUri}"></div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动类型：</label>
					<div class="uk-width-4-5 uk-color-black uk-font-bold">${activity.typeName}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动开始时间：</label>
					<div class="uk-width-4-5 uk-color-666">${activity.startTime}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动截止时间：</label>
					<div class="uk-width-4-5 uk-color-666">${activity.endTime}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动地点：</label>
					<div class="uk-width-4-5 uk-color-666">${activity.place}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">活动介绍：</label>
					<div class="uk-width-4-5 uk-color-666" style="width:70%">${activity.intro}</div>
				</div>
				<div class="uk-grid uk-row uk-row-hover">
					<label class="uk-width-1-5 uk-font-bold uk-right">创建时间：</label>
					<div class="uk-width-4-5 uk-color-666">${activity.createTime}</div>
				</div>
				
				<c:if test="${applicationScope.ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeCode eq activity.type}">
					<h3 class="uk-title uk-title-small">讲师&选座信息</h3>
					<hr class="uk-title-hr"/>
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-1-5 uk-font-bold uk-right">讲师名称：</label>
						<div class="uk-width-4-5 uk-color-666">${activity.lecturer}</div>
					</div>
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-1-5 uk-font-bold uk-right">讲师介绍：</label>
						<div class="uk-width-4-5 uk-color-666">${activity.lecturerIntro}</div>
					</div>
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-1-5 uk-font-bold uk-right">选座开始时间：</label>
						<div class="uk-width-4-5 uk-color-666">${activity.selectSeatStartTime}</div>
					</div>
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-1-5 uk-font-bold uk-right">选座截止时间：</label>
						<div class="uk-width-4-5 uk-color-666">${activity.selectSeatEndTime}</div>
					</div>
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-1-5 uk-font-bold uk-right uk-padding-remove">选座座位矩阵图：</label>
						<div class="uk-width-4-5 uk-color-666">
							<div class="uk-grid">
	                        	<div class="uk-width-1-1">
	                        		<h3 style="margin: 15px 0 10px 0;">座位状态说明：</h3>
	                        		<p>1 - 代表座位可售, 2 - 代表座位已售, 0 - 代表非座位(比如座位坏了不可用、空白位置、墙柱等等情况)</p>
	                        	</div>
	                        </div>
						</div>
						<div class="uk-width1-1 uk-padding-remove" style="display:none">
							<table class="uk-table uk-table-fixed uk-table-hover uk-table-seats" cellspacing="0" width="70%">
	                       		<caption>
	                       			<div>讲台/屏幕位置</div>
	                       		</caption>
	                       		<thead>
	                       			<tr>
	                       				<c:forEach begin="1" end="${activity.cols}" var="idx">
	                       					<th>${idx}</th>
	                       				</c:forEach>
	                       			</tr>
	                       		</thead>
	                       		<tbody>
	                       			<tr>
	                       				<c:forEach items="${activity.activitySeatList}" var="item" varStatus="stat">
		                       				<td><div class="seat-box seat-box-${item.status}"><input type="text" name="status" value="${item.status}" readonly="readonly"/></div></td>
		                       				<c:if test="${item.col eq activity.cols}">
		                       					</tr><tr>
		                       				</c:if>
	                       				</c:forEach>
	                       			</tr>
	                       		</tbody>
	                       	</table>
						</div>
					</div>
				</c:if>
				<div class="uk-grid uk-row">
					<div class="uk-width-2-5"></div>
					<div class="uk-width-3-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/activity/list">返回列表</a></div>
				</div>
			</div>
			<!-- 活动报名信息 -->
			<div>
				<form class="uk-form" name="signupSearchForm" action="#" method="post">
					<div class="uk-margin-bottom uk-condition">
						<table class="uk-form-table">
							<tr>
								<td class="uk-form-label uk-width-1-6">姓&nbsp;&nbsp;&nbsp;名：</td>
								<td class="uk-form-field uk-width-1-6"><input type="text" name="name" value="" /></td>
								<td class="uk-form-label uk-width-1-6">联系电话：</td>
								<td class="uk-form-field uk-width-1-6"><input type="text" name="phone" value="" /></td>
								<td class="uk-width-2-6 uk-center">
									<input type="hidden" name="activityId" value="${activity.id}" />
									<input type="hidden" name="activityType" value="${activity.type}" />
									<input type="hidden" name="currentPage" value="1" />
									<input type="hidden" name="pageSize" value="10" />
									<button type="button" class="uk-button uk-button-primary" onclick="searchSignupList(1);">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
								</td>
							</tr>
						</table>
					</div>
					<div>
						<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th width="10%"><label>用户ID</label></th>
									<th width="15%"><label>用户名</label></th>
									<th width="10%"><label>姓名</label></th>
									<th width="15%"><label>联系电话</label></th>
									<th width="15%"><label>报名时间</label></th>
									<th width="20%"><label>选坐</label></th>
									<th class="uk-center" width="15%">操作</th>
								</tr>
								<tr class="gap">
									<td colspan="7"></td>
								</tr>
							</thead>
							<tbody id="signupSearchList">
								<tr><td class="no-result" colspan="7">暂无记录!</td></tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="7">
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
			<!-- 活动回顾信息 -->
			<div>
				<c:forEach items="${reviewList}" var="item">
					<div class="uk-grid uk-row uk-row-hover">
						<label class="uk-width-1-5 uk-font-bold uk-right">回顾图片/视频：</label>
						<div class="uk-width-4-5 uk-color-666">
							<div>
								<c:if test="${item.mediaType eq applicationScope.ACT_REVIEW_MEDIA_TYPE_IMAGE.typeCode}">
									<img alt="" src="${item.fullMediaUrl}">
								</c:if>
								<c:if test="${item.mediaType eq applicationScope.ACT_REVIEW_MEDIA_TYPE_VIDEO.typeCode}">
									<video type="video/mp4" src="${item.fullMediaUrl}" width="250" height="250" controls autobuffer>您的浏览器不支持mp4视频格式播放。</video> 
								</c:if>
							</div>
							<h5>${item.mediaTitle}</h5>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/simplePagination/jquery.simplePagination.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jsrender.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/activity/detail.js"></script>
</body>
</html>