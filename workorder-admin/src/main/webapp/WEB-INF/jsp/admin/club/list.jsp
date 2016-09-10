<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<html lang="zh-CN">
<head>
	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
	<title>俱乐部管理</title>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css" />
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css" />
	<style type="text/css">
	.uk-comment-header {margin: 0; padding: 0; background-color: transparent;border: 0 none;}
	.uk-comment-title {font-size: 15px;}
	.uk-comment-avatar {border-radius: 0;}
	</style>
	<script type="text/javascript">
	    var DEFAULT_CLUB_QUERY_LIST_ORDER_BY = '${applicationScope.DEFAULT_CLUB_QUERY_LIST_ORDER_BY}';
	    var DEFAULT_CLUB_QUERY_LIST_ORDER = '${applicationScope.DEFAULT_CLUB_QUERY_LIST_ORDER}';
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
				<li><i></i><a href="javascript:;">业务管理</a></li>
				<li><i></i><a href="${CONTEXT_PATH}/admin/club/list">俱乐部管理</a></li>
				<li class="active">俱乐部查询</li>
			</ul>
		</div>
		<form id="clubQueryForm" class="uk-form" name="clubQueryForm" action="${CONTEXT_PATH}/admin/club/list" method="post">
			<fieldset>
				<legend>俱乐部查询</legend>
				<div class="uk-margin-bottom uk-condition">
					<table class="uk-form-table">
						<tr>
							<td class="uk-form-label uk-width-1-5">俱乐部名称：</td>
							<td class="uk-form-field uk-width-1-5">
								<input type="text" name="name" value="${query.name}" />
							</td>
							<td class="uk-form-label uk-width-1-5">区域名称：</td>
               				<td class="uk-form-field uk-width-1-5">
               					<select id="areainfo" name="areainfo">
									<option value="">--请选择--</option>
									<option value="1">无锡市区</option>
									<option value="2">滨湖区</option>
									<option value="3">惠山区</option>
									<option value="4">锡山区</option>
									<option value="5">梁溪区</option>
									<option value="6">新吴区</option>
									<option value="7">江阴市</option>
									<option value="8">宜兴市</option>
								</select>
               				</td>
							<td class="uk-width-2-6 uk-center">
								<input type="hidden" name="orderby" value="${orderBy.orderby}" />
								<input type="hidden" name="order" value="${orderBy.order}" /> 
								<input type="hidden" name="currentPage" value="${pager.currentPage}" />
								<input type="hidden" name="pageSize" value="${pager.pageSize}" />
								<button type="button" class="uk-button uk-button-primary" onclick="queryClubList();">查&nbsp;&nbsp;询</button>
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
								<th width="15%"><label>logo图片</label></th>
								<th width="25%"><label>俱乐部名称</label></th>
								<th width="15%"><label>区域名称</label></th>
								<th width="20%"><label>更新时间</label></th>
								<th class="uk-center" width="15%">操作</th>
							</tr>
							<tr class="gap">
								<td colspan="6"></td>
							</tr>
							<tr class="toolbar">
								<td colspan="6">
								
								<shiro:hasPermission name="admin:club:add">  
 		 <a class="uk-button uk-button-primary uk-button-small" href="${CONTEXT_PATH}/admin/club/toAdd">新增俱乐部</a>
	</shiro:hasPermission>  
									
									<span class="selected-row-count"></span>
								</td>
							</tr>
							<tr class="gap">
								<td colspan="6"></td>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty clubList}">
								<tr>
									<td class="no-result" colspan="6">没有查询到符合条件的记录.</td>
								</tr>
							</c:if>
							<c:if test="${not empty clubList}">
								<c:forEach items="${clubList}" var="club" varStatus="status">
									<tr>
										<td>${club.orderNum}</td>
										<td><img alt="${club.logo}" src="${CONTEXT_PATH}${club.logo}" width="40" height="30"/></td>
										<td>${club.name}</td>
										<td>
											<c:if test="${club.areainfo==1}">无锡市区</c:if>
											<c:if test="${club.areainfo==2}">滨湖区</c:if>
											<c:if test="${club.areainfo==3}">惠山区</c:if>
											<c:if test="${club.areainfo==4}">锡山区</c:if>
											<c:if test="${club.areainfo==5}">梁溪区</c:if>
											<c:if test="${club.areainfo==6}">新吴区</c:if>
											<c:if test="${club.areainfo==7}">江阴市</c:if>
											<c:if test="${club.areainfo==8}">宜兴市</c:if>
										</td>
										<td><fmt:formatDate value="${club.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td class="uk-center">
											<div class="uk-button-group uk-button-dropdown-small">
												<a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/clubdetail/list?club_id=${club.id}">活动列表</a>
												<div data-uk-dropdown="{mode:'click'}">
													<button class="uk-button uk-button-primary"><i class="uk-icon-caret-down"></i></button>
													<div class="uk-dropdown uk-dropdown-shadow">
														<ul class="uk-nav uk-nav-dropdown">
															<li><a href="${CONTEXT_PATH}/admin/club/detail?id=${club.id}">查看详细</a></li>
															<li><a href="${CONTEXT_PATH}/admin/club/toEdit?id=${club.id}">修改俱乐部</a></li>
							                                <li><a href="javascript:;" onclick="delClub(this,'${club.id}');">删除俱乐部</a></li>
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
					<jsp:include page="/WEB-INF/jsp/common/include/pager.jsp"><jsp:param name="targetQueryFormId" value="clubQueryForm"/></jsp:include>
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
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/club/list.js"></script>
</body>
</html>