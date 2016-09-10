<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CONTEXT_PATH" scope="page" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>XAdmin</title>
	<!-- 设置360浏览器使用webkit引擎 -->
	<meta name="renderer" content="webkit">
	<!-- No Baidu Siteapp -->
	<meta http-equiv="Cache-Control" content="no-siteapp">
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="shortcut icon" href="${CONTEXT_PATH}/resources/images/favicon.ico" type="image/x-icon"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/uikit-2.21.0/css/uikit.almost-flat.min.css"/>
	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/css/admin-index.css"/>
	<script type="text/javascript">
		CONTEXT_PATH = '${CONTEXT_PATH}';
	</script>
</head>
<body>
	<div class="uk-index-wrapper">
		<!-- 首页头部开始 -->
		<div class="uk-index-hd">
			<div class="uk-index-hd-left uk-clearfix">
				<ul class="uk-index-navmenu uk-navbar-nav">
					<li><a class="uk-index-navmenu-logo" href="javascript:;">无锡地税</a></li>
					<li><a class="uk-index-navmenu-toggle" href="javascript:;"></a></li>
				</ul>
			</div>
			<div class="uk-index-hd-right uk-clearfix">
				<div class="uk-navbar">
					<ul class="uk-index-navmenu uk-index-navmenu-nav uk-navbar-nav">
						<li><a href="javascript:;" data-menu-id="">后台管理系统</a></li>
					</ul>
					<ul class="uk-index-navmenu uk-index-navmenu-tool uk-navbar-nav uk-float-right">
						<li class="uk-parent uk-dropdown-account-nav" data-uk-dropdown="{remaintime: 500}">
							<a class="uk-index-navmenu-user uk-clearfix" href="javascript:;">
								<img class="user-icon" alt="" src="${CONTEXT_PATH}/resources/images/avatar9.jpg">
								<span class="user-name">
									<small>Welcome,</small>
									<label title="${sessionScope.loginToken.loginName}">${sessionScope.loginToken.loginName}</label>
								</span>
								<i class="user-arrow"></i>
							</a>
							<div class="uk-dropdown-account uk-dropdown uk-dropdown-flip uk-dropdown-navbar">
								<ul class="uk-nav uk-nav-navbar">
                                     <li><a class="myaccount" href="javascript:;" onclick="loadMenuUrl('/xadmin/user/accountinfo')">我的账户信息</a></li>
                                     <li><a class="modifypwd" href="javascript:;" onclick="loadMenuUrl('/xadmin/user/changepwd')">修改账户密码</a></li>
                                     <li><a class="accountexit" href="${CONTEXT_PATH}/logout">退出登录</a></li>
                                 </ul>
							</div>
						</li>
						<li><a class="uk-index-navmenu-logout" href="${CONTEXT_PATH}/logout" title="退出"></a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 首页头部结束 -->
		<!-- 首页中部开始 -->
		<div class="uk-index-bd">
			<div class="uk-index-bd-left clearfix">
				<div class="uk-index-bd-left-content auto-resize">
					<div class="uk-index-treemenu-panel">
					<c:if test="${not empty lv1Menus}">
						<ul class="uk-index-treemenu-lv1 uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav="{multiple:true}">
						<c:forEach items="${lv1Menus}" var="lv1Menu">
                            <li class="uk-parent uk-active">
                                <a href="#" data-menu-id="${lv1Menu.resourceId}" data-menu-url="${lv1Menu.resourceUrl}">${lv1Menu.resourceName}</a>
                                <c:if test="${not empty lv1Menu.subResourceList}">
                                <ul class="uk-index-treemenu-lv2 uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav="{multiple:true}">
                                <c:forEach items="${lv1Menu.subResourceList}" var="lv2Menu">
                                	<li class="${not empty lv2Menu.subResourceList ? 'uk-parent uk-active' : ''}">
                                		<a href="#" data-menu-id="${lv2Menu.resourceId}" data-menu-url="${lv2Menu.resourceUrl}">${lv2Menu.resourceName}</a>
                                		<c:if test="${not empty lv2Menu.subResourceList}">
		                                <ul class="uk-index-treemenu-lv3 uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav="{multiple:true}">
		                                <c:forEach items="${lv2Menu.subResourceList}" var="lv3Menu">
		                                	<li class="${not empty lv3Menu.subResourceList ? 'uk-parent uk-active' : ''}">
		                                		<a href="#" data-menu-id="${lv3Menu.resourceId}" data-menu-url="${lv3Menu.resourceUrl}">${lv3Menu.resourceName}</a>
		                                		<c:if test="${not empty lv3Menu.subResourceList}">
				                                <ul class="uk-index-treemenu-lv4 uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav="{multiple:true}">
				                                <c:forEach items="${lv3Menu.subResourceList}" var="lv4Menu">
				                                	<li class="${not empty lv4Menu.subResourceList ? 'uk-parent uk-active' : ''}">
				                                		<a href="#" data-menu-id="${lv4Menu.resourceId}" data-menu-url="${lv4Menu.resourceUrl}">${lv4Menu.resourceName}</a>
				                                		<c:if test="${not empty lv4Menu.subResourceList}">
						                                <ul class="uk-index-treemenu-lv5 uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav="{multiple:true}">
						                                <c:forEach items="${lv4Menu.subResourceList}" var="lv5Menu">
						                                	<li class="${not empty lv5Menu.subResourceList ? 'uk-parent uk-active' : ''}">
						                                		<a href="#" data-menu-id="${lv5Menu.resourceId}" data-menu-url="${lv5Menu.resourceUrl}">${lv5Menu.resourceName}</a>
						                                		<!-- 最多支持5个层级的树菜单结构 -->
						                                </c:forEach>
						                                </ul>
						                                </c:if>
				                                </c:forEach>
				                                </ul>
				                                </c:if>
		                                </c:forEach>
		                                </ul>
		                                </c:if>
                                </c:forEach>
                                </ul>
                                </c:if>
                            </li>
                        </c:forEach>
                        </ul>
                    </c:if>
					</div>
				</div>
			</div>
			<div class="uk-index-bd-right clearfix">
				<div class="uk-index-bd-right-content">
					<div class="uk-index-main-content">
						<iframe id="mainFrame" class="auto-resize" name="mainFrame" scrolling="no" frameborder="0" src="about:blank"></iframe>
					</div>
				</div>
			</div>
		</div>
		<!-- 首页中部结束 -->
	</div>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin-index.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/uikit-2.21.0/js/uikit.min.js"></script>
</body>
</html>