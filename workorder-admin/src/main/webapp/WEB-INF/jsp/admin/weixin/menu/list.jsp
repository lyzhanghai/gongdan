<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>自定义菜单管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/css/jquery.treetable.css"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/css/jquery.treetable.theme.css"/>
	<script type="text/javascript">
		var DEFAULT_ADMIN_ROOT_MENU_ID = '${applicationScope.DEFAULT_ADMIN_ROOT_MENU_ID}';
		var WEIXIN_MENU_TYPE_LV0 = {
			typeCode: '${applicationScope.WEIXIN_MENU_TYPE_LV0.typeCode}',
			typeName: '${applicationScope.WEIXIN_MENU_TYPE_LV0.typeName}',
			allowedMaxSubMenus: '${applicationScope.WEIXIN_MENU_TYPE_LV0.allowedMaxSubMenus}'
		};
		var WEIXIN_MENU_TYPE_LV1 = {
			typeCode: '${applicationScope.WEIXIN_MENU_TYPE_LV1.typeCode}',
			typeName: '${applicationScope.WEIXIN_MENU_TYPE_LV1.typeName}',
			allowedMaxSubMenus: '${applicationScope.WEIXIN_MENU_TYPE_LV1.allowedMaxSubMenus}'
		};
		var WEIXIN_MENU_TYPE_LV2 = {
			typeCode: '${applicationScope.WEIXIN_MENU_TYPE_LV2.typeCode}',
			typeName: '${applicationScope.WEIXIN_MENU_TYPE_LV2.typeName}',
			allowedMaxSubMenus: '${applicationScope.WEIXIN_MENU_TYPE_LV2.allowedMaxSubMenus}'
		};
	</script>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="javascript:;">公众号管理</a></li>
			  <li class="active">自定义菜单</li>
			</ul>
		</div>
		<form id="menuQueryForm" class="uk-form" name="menuQueryForm" action="${CONTEXT_PATH}/admin/weixin/menu/list" method="post">
			<fieldset>
				<legend>菜单列表</legend>
				<div class="uk-margin-bottom">
					<table id="menu-table" class="treetable treetable-success">
						<caption style="text-align:left;" class="uk-clearfix">
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="toAddMenu(this);">新增菜单</a>&nbsp;&nbsp;
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="toEditMenu(this);">修改所选菜单</a>&nbsp;&nbsp;
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="delMenu(this);">删除所选菜单</a>&nbsp;&nbsp;
							<a class="uk-button uk-button-primary uk-button-small" href="javascript:;" onclick="refreshMenuTree();">刷新菜单树</a>
							<a class="uk-button uk-button-success uk-button-small uk-float-right" href="javascript:;" onclick="publishMenuTree(this);" data-loading-text="正在发布....." title="立即发布菜单到微信"><i class="uk-icon-cloud-upload"></i>&nbsp;立即发布菜单</a>
						</caption>
						<thead>
							<tr>
								<th class="white" width="3%"><label></label></th>
								<th class="white" width="25%"><label>菜单名称</label></th>
								<th class="white align-center" width="10%"><label>排序号</label></th>
								<th class="white" width="35%"><label>菜单URL</label></th>
								<th class="white align-center" width="15%"><label>菜单类型</label></th>
								<th class="white align-center" width="12%"><label>最近发布时间</label></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty dataList}">
								<tr><td class="no-result" colspan="6">没有查询到符合条件的记录.</td></tr>
							</c:if>
							<c:if test="${not empty dataList}">
								<c:forEach items="${dataList}" var="item">
									<tr data-tt-id="${item.menuId}" data-tt-parent-id='${item.parentMenuId}' data-menu-type=${item.menuType}>
										<td class="white" style="text-align:center;"><input type="radio" name="menuId" onclick="selectThisRow(this);" value="${item.menuId}"/></td>
										<td class="bold black white"><span class='${item.menuIcon}'>${item.menuName}</span></td>
										<td class="align-center white">${item.siblingsIndex}</td>
										<td class="white">${item.menuUrl}</td>
										<td class="white align-center">${item.menuTypeName}</td>
										<td class="white align-center">${item.lastPublishTime}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</fieldset>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery-treetable-3.2.0/jquery.treetable.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/weixin/menu/list.js"></script>
</body>
</html>