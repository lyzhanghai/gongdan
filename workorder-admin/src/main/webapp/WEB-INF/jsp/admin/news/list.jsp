<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
	<title>news管理</title>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css" />
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css" />
	<style type="text/css">
	.uk-comment-header {margin: 0; padding: 0; background-color: transparent;border: 0 none;}
	.uk-comment-title {font-size: 15px;}
	.uk-comment-avatar {border-radius: 0;}
	</style>
	<script type="text/javascript">
	    var DEFAULT_BANNER_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_BANNER_QUERY_LIST_ORDER_BY}';
	    var DEFAULT_BANNER_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_BANNER_QUERY_LIST_ORDER}';
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
				<li><i></i><a href="javascript:;">帮助中心</a></li>
				<li><i></i><a href="${CONTEXT_PATH}/admin/news/list">news管理</a></li>
				<li class="active">新闻查询</li>
			</ul>
		</div>
		<form id="bannerQueryForm" class="uk-form" name="bannerQueryForm" action="${CONTEXT_PATH}/admin/news/list" method="post">
			<fieldset>
				<legend>新闻查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
							<td class="uk-form-label uk-width-1-6">新闻标题：</td>
							<td class="uk-form-field uk-width-1-6"><input type="text" name="title" value="${newsQueryForm.title}" /></td>
							 
							<td class="uk-width-2-6 uk-center">
								<input type="hidden" name="orderby" value="${orderBy.orderby}" />
								<input type="hidden" name="order" value="${orderBy.order}" /> 
								<input type="hidden" name="currentPage" value="${pager.currentPage}" />
								<input type="hidden" name="pageSize" value="${pager.pageSize}" />
								<button type="button" class="uk-button uk-button-primary" onclick="queryBannerList();">查&nbsp;&nbsp;询</button>&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th width="30%"><label>标题</label></th>
								<th width="30%"><label>创建时间</label></th>
							 
								<th class="uk-center" width="40%">操作</th>
							</tr>
							<tr class="gap">
								<td colspan="8"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="8">
									<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/admin/news/edit">新增新闻</a>
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
										<td>${item.title}</td>
 
										<td class="uk-center"><span class="uk-cell uk-center">${item.publishTime}</span></td>
										<td class="uk-center">
											<div class="uk-button-group uk-button-dropdown-small">
												<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/news/detail?id=${item.id}">查看详细</a>
												<div data-uk-dropdown="{mode:'click'}">
													<button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
													<div class="uk-dropdown uk-dropdown-shadow">
														<ul class="uk-nav uk-nav-dropdown">
															<li><a href="${CONTEXT_PATH}/admin/news/detail?id=${item.id}">查看详细</a></li>
															<li><a href="${CONTEXT_PATH}/admin/news/edit?id=${item.id}">修改新闻</a></li>
							                                <li class="uk-nav-divider"></li>
							                                <li><a href="javascript:;" onclick="delNews(this,'${item.id}');">删除新闻</a></li>
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
					<jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="bannerQueryForm"/></jsp:include>
				</div>
			</fieldset>
		</form>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/news/list.js"></script>
</body>
</html>