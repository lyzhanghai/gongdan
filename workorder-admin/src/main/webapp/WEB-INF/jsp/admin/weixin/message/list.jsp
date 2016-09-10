<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>微信消息管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<script type="text/javascript">
		var DEFAULT_WEIXIN_MESSAGE_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_WEIXIN_MESSAGE_QUERY_LIST_ORDER_BY}';
		var DEFAULT_WEIXIN_MESSAGE_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_WEIXIN_MESSAGE_QUERY_LIST_ORDER}';
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="javascript:;">公众号管理</a></li>
			  <li class="active">消息管理</li>
			</ul>
		</div>
		<form id="messageQueryForm" class="uk-form" name="messageQueryForm" action="${CONTEXT_PATH}/admin/weixin/message/list" method="post">
			<fieldset>
				<legend>消息查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
               				<td class="uk-form-label uk-width-1-5">消息标题：</td>
               				<td class="uk-form-field uk-width-1-5"><input type="text" name="title" value="${messageQueryForm.title}"/></td>
               				<td class="uk-form-label uk-width-1-5">消息类型：</td>
               				<td class="uk-form-field uk-width-1-5">
               					<select id="mediaType" name="mediaType">
									<option value="">--请选择--</option>
									<c:forEach items="${mediaTypes}" var="item">
										<option value="${item.typeCode}" ${messageQueryForm.mediaType eq item.typeCode ? 'selected' : ''}>${item.typeName}</option>
									</c:forEach>
								</select>
               				</td>
               				<td class="uk-width-1-5 uk-center">
               					<input type="hidden" name="orderby"  value="${orderBy.orderby}"/>
	                            <input type="hidden" name="order"  value="${orderBy.order}"/>
	                            <input type="hidden" name="currentPage"  value="${pager.currentPage}"/>
	                            <input type="hidden" name="pageSize"  value="${pager.pageSize}"/>
	                            <button type="button" class="uk-button uk-button-primary" onclick="queryMessageList();">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
	                            <button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
               				</td>
               			</tr>
                	</table>
				</div>
				<div>
					<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
				        <thead>
				            <tr>
				            	<th width="10%" class="orderby ${orderBy.orderby eq 'id' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'id', 'messageQueryForm');">ID</th>
                                <th width="45%" class="orderby ${orderBy.orderby eq 'title' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'title', 'messageQueryForm');"><label>消息标题</label></th>
                                <th width="15%" class="uk-center orderby ${orderBy.orderby eq 'mediaType' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'mediaType', 'messageQueryForm');"><label>消息类型</label></th>
                                <th width="15%" class="uk-center orderby ${orderBy.orderby eq 'createTime' ? orderBy.order : ''}" onclick="changeOrderBy(this, 'createTime', 'messageQueryForm');"><label>创建时间</label></th>
                                <th class="uk-center" width="15%">操作</th>
				            </tr>
				            <tr class="gap">
								<td colspan="5"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="5">
									<div class="uk-button-group uk-button-dropdown-small">
					                    <a class="uk-button uk-button-primary" href="javascript:;">新增消息</a>
					                    <div data-uk-dropdown="{mode:'click'}">
					                        <button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
					                        <div class="uk-dropdown uk-dropdown-shadow">
					                            <ul class="uk-nav uk-nav-dropdown">
					                            	<c:forEach items="${mediaTypes}" var="item">
					                            		<li><a href="${CONTEXT_PATH}/admin/weixin/message/add${item.typeCode}">新增${item.typeName}消息</a></li>
													</c:forEach>
					                            </ul>
					                        </div>
					                    </div>
					                </div>
									<span class="selected-row-count"></span>
								</td>
							</tr>
							<tr class="gap">
								<td colspan="5"></td>
							</tr>
				        </thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr><td class="no-result" colspan="5">没有查询到符合条件的记录.</td></tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item" varStatus="status">
									<tr>
										<td>${item.id}</td>
										<td>${item.title}</td>
										<td class="uk-center">${item.mediaTypeName}</td>
										<td class="uk-center">${item.createTime}</td>
										<td class="uk-center">
											<div class="uk-button-group uk-button-dropdown-small">
							                    <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/weixin/message/detail?id=${item.id}">查看详细</a>
							                    <div data-uk-dropdown="{mode:'click'}">
							                        <button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
							                        <div class="uk-dropdown uk-dropdown-shadow">
							                            <ul class="uk-nav uk-nav-dropdown">
							                                <li><a href="${CONTEXT_PATH}/admin/weixin/message/detail?id=${item.id}">查看详细</a></li>
							                                <li class="uk-nav-divider"></li>
							                                <li><a href="javascript:;" onclick="delMessage(this,'${item.id}');">删除消息</a></li>
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
					<jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="messageQueryForm"/></jsp:include>
				</div>
			</fieldset>
		</form>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/weixin/message/list.js"></script>
</body>
</html>