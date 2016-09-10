<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
	<title>知识列表管理</title>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css" />
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css" />
	<style type="text/css">
	.uk-comment-header {margin: 0; padding: 0; background-color: transparent;border: 0 none;}
	.uk-comment-title {font-size: 15px;}
	.uk-comment-avatar {border-radius: 0;}
	</style>
	<script type="text/javascript">
	    var DEFAULT_KNOWLEDGE_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_KNOWLEDGE_QUERY_LIST_ORDER_BY}';
	    var DEFAULT_KNOWLEDGE_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_KNOWLEDGE_QUERY_LIST_ORDER}';
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
				<li><i></i><a href="javascript:;">业务管理</a></li>
				<li><i></i><a href="${CONTEXT_PATH}/admin/knowledgetype/list">知识云管理</a></li>
				<li class="active">知识列表管理</li>
			</ul>
		</div>
		<form id="knowledgeQueryForm" class="uk-form" name="knowledgeQueryForm" action="${CONTEXT_PATH}/admin/knowledge/list" method="post">
			<fieldset>
				<legend>知识列表查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
							<td class="uk-form-label uk-width-1-6">知识标题：</td>
							<td class="uk-form-field uk-width-1-6">
								<input type="text" name="title" value="${query.title}" />
								<input type="hidden" name="typeId" value="${query.typeId}" />
							</td>
							<td class="uk-width-2-6 uk-center">
								<input type="hidden" name="orderby" value="${orderBy.orderby}" />
								<input type="hidden" name="order" value="${orderBy.order}" /> 
								<input type="hidden" name="currentPage" value="${pager.currentPage}" />
								<input type="hidden" name="pageSize" value="${pager.pageSize}" />
								<button type="button" class="uk-button uk-button-primary" onclick="queryKnowledgeList();">查&nbsp;&nbsp;询</button>
								 &nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="uk-button uk-button-primary" onclick="clearAll();">清&nbsp;&nbsp;空</button>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table class="uk-table uk-table-primary uk-table-hover" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th width="10%"><label>序号</label></th>
								<th width="25%"><label>知识标题</label></th>
								<th width="15%"><label>上传类型</label></th>
								<th width="15%"><label>状态</label></th>
								<th width="20%"><label>更新时间</label></th>
								<th width="15%" class="uk-center">操作</th>
							</tr>
							<tr class="gap">
								<td colspan="6"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="6">
									<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/admin/knowledge/toAdd?typeId=${query.typeId}">新增知识</a>
									<a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/admin/knowledgetype/list">返回列表</a>
									<span class="selected-row-count"></span>
								</td>
							</tr>
							<tr class="gap">
								<td colspan="6"></td>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty knowledgeList}">
								<tr>
									<td class="no-result" colspan="6">没有查询到符合条件的记录.</td>
								</tr>
							</c:if>
							<c:if test="${not empty knowledgeList}">
								<c:forEach items="${knowledgeList}" var="knowledge" varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td>${knowledge.title}</td>
										<td>
											<c:if test="${knowledge.fileType==1}">
											文本文件
											</c:if>
											<c:if test="${knowledge.fileType==2}">
											视频文件
											</c:if>
											<c:if test="${knowledge.fileType==3}">
											图片文件
											</c:if>
											<c:if test="${knowledge.fileType==4}">
											pdf文件
											</c:if>
										</td>
										<td>
											<c:if test="${knowledge.status==1}">
											<span class="uk-label user-status uk-status-1">待审核</span>
											</c:if>
											<c:if test="${knowledge.status==2}">
											审核通过
											</c:if>
											<c:if test="${knowledge.status==3}">
											审核拒绝
											</c:if>
										</td>
										<td><fmt:formatDate value="${knowledge.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td class="uk-center">
											<div class="uk-button-group uk-button-dropdown-small">
												<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/knowledge/detail?id=${knowledge.id}">查看详细</a>
												<div data-uk-dropdown="{mode:'click'}">
													<button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
													<div class="uk-dropdown uk-dropdown-shadow">
														<ul class="uk-nav uk-nav-dropdown">
															<li><a href="${CONTEXT_PATH}/admin/knowledge/detail?id=${knowledge.id}">查看详细</a></li>
															<li><a href="${CONTEXT_PATH}/admin/knowledge/toEdit?id=${knowledge.id}">修改知识</a></li>
							                                <li><a href="javascript:;" onclick="delKnowledge(this,'${knowledge.id}');">删除知识</a></li>
							                                <c:if test="${knowledge.status==1}">
							                                	<li class="uk-nav-divider"></li>
																<li><a href="${CONTEXT_PATH}/admin/knowledge/edit?id=${knowledge.id}&status=${knowledge.status+1}&typeId=${knowledge.typeId}">通过审核</a></li>
																<li><a href="${CONTEXT_PATH}/admin/knowledge/edit?id=${knowledge.id}&status=${knowledge.status+2}&typeId=${knowledge.typeId}">拒绝审核</a></li>
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
					<jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="knowledgeQueryForm"/></jsp:include>
				</div>
			</fieldset>
		</form>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/knowledge/list.js"></script>
</body>
</html>