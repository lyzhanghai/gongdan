<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>微信自动回复管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<script type="text/javascript">
		var DEFAULT_WEIXIN_MESSAGE_REPLY_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_WEIXIN_MESSAGE_REPLY_QUERY_LIST_ORDER_BY}';
		var DEFAULT_WEIXIN_MESSAGE_REPLY_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_WEIXIN_MESSAGE_REPLY_QUERY_LIST_ORDER}';
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="javascript:;">公众号管理</a></li>
			  <li class="active">自动回复管理</li>
			</ul>
		</div>
		<form id="messageReplyQueryForm" class="uk-form" name="messageReplyQueryForm" action="${CONTEXT_PATH}/admin/weixin/messagereply/list" method="post">
			<fieldset>
				<legend>自动回复查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
               				<td class="uk-form-label uk-width-1-5">匹配关键字：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="keyword" value="${messageReplyQueryForm.keyword}"/></td>
               				<td class="uk-form-label uk-width-1-5">匹配模式：</td>
               				<td class="uk-form-field uk-width-1-5">
               					<select id="matchMode" name="matchMode">
									<option value="">--请选择--</option>
									<c:forEach items="${matchModes}" var="item">
										<option value="${item.modeCode}" ${messageReplyQueryForm.matchMode eq item.modeCode ? 'selected' : ''}>${item.modeName}</option>
									</c:forEach>
								</select>
               				</td>
               				<td class="uk-width-1-5 uk-center">
               					<input type="hidden" name="orderby"  value="${orderBy.orderby}"/>
	                            <input type="hidden" name="order"  value="${orderBy.order}"/>
	                            <input type="hidden" name="currentPage"  value="${pager.currentPage}"/>
	                            <input type="hidden" name="pageSize"  value="${pager.pageSize}"/>
	                            <button type="button" class="uk-button uk-button-primary" onclick="queryMessageReplyList();">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
	                            <button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
               				</td>
               			</tr>
                	</table>
				</div>
				<div>
					<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
				        <thead>
				            <tr>
				            	<th width="10%" class="orderby ${orderBy.orderby eq 'id' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'id', 'messageReplyQueryForm');">ID</th>
                                <th width="15%" class="orderby ${orderBy.orderby eq 'title' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'keyword', 'messageReplyQueryForm');"><label>匹配关键字</label></th>
                                <th width="10%" class="uk-center orderby ${orderBy.orderby eq 'matchMode' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'matchMode', 'messageReplyQueryForm');"><label>匹配模式</label></th>
                                <th width="40%" class="orderby ${orderBy.orderby eq 'msgTitle' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'msgTitle', 'messageReplyQueryForm');"><label>关联内容</label></th>
                                <th width="10%" class="uk-center orderby ${orderBy.orderby eq 'createTime' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'createTime', 'messageReplyQueryForm');"><label>创建时间</label></th>
                                <th class="uk-center" width="15%">操作</th>
				            </tr>
				            <tr class="gap">
								<td colspan="6"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="6">
									<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/admin/weixin/messagereply/add">新增自动回复</a>
									<span class="selected-row-count"></span>
								</td>
							</tr>
							<tr class="gap">
								<td colspan="6"></td>
							</tr>
				        </thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr><td class="no-result" colspan="6">没有查询到符合条件的记录.</td></tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item" varStatus="status">
									<tr>
										<td>${item.id}</td>
										<td>${item.keyword}</td>
										<td class="uk-center">${item.matchModeName}</td>
										<td>${item.msgTitle}</td>
										<td class="uk-center"><span class="uk-cell uk-center">${item.createTime}</span></td>
										<td class="uk-center">
											<div class="uk-button-group uk-button-dropdown-small">
											<a class="uk-button uk-button-primary"  href="${CONTEXT_PATH}/admin/weixin/messagereply/edit?id=${item.id}">修改自动回复</a>
							                  <!--    <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/weixin/messagereply/detail?id=${item.id}">查看详细</a>-->
							                    <div data-uk-dropdown="{mode:'click'}">
							                        <button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
							                        <div class="uk-dropdown uk-dropdown-shadow">
							                            <ul class="uk-nav uk-nav-dropdown">
							                               <!--    <li><a href="${CONTEXT_PATH}/admin/weixin/messagereply/detail?id=${item.id}">查看详细</a></li>-->
							                                <li><a href="${CONTEXT_PATH}/admin/weixin/messagereply/edit?id=${item.id}">修改自动回复</a></li>
							                                <li class="uk-nav-divider"></li>
							                                <li><a href="javascript:;" onclick="delMessageReply(this,'${item.id}');">删除自动回复</a></li>
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
					<jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="messageReplyQueryForm"/></jsp:include>
				</div>
			</fieldset>
		</form>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/weixin/messagereply/list.js"></script>
</body>
</html>