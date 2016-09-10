<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>自定义菜单管理</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <style type="text/css">
    	.uk-grid {margin: 0;}
    	.uk-grid > * {padding: 0;}
    	.uk-icon-button {height: 26px; line-height: 28px; width: 26px;}
    	.uk-nav li > a, .uk-nav li > a:hover {color: #404040; font-weight: normal; height: 22px;line-height: 22px;padding: 5px 0 5px 25px; font-size: 14px;}
    	.uk-nav li > a:hover {color: #07d;}
    	.uk-nav li > a > label {padding-left:10px;cursor: pointer;}
    	.uk-nav-sub li > a {padding-left: 25px;}
    	ul.uk-nav-sub {padding: 0 0 0 15px;}
    	.uk-nav-header {margin: 0 !important; padding: 5px 0;}
    	.uk-nav-header > a {font-weight: bold; color: #000;}
    	.uk-panel-box {border: 0 none;}
    	.uk-panel-box > .uk-nav-side {margin: 0;}
    	.uk-panel-title {padding: 5px 10px; margin: 0; font-size: 15px; border-left: 2px solid #428bca; background-color: #efefef;}
    	.uk-panel-title label {height: 26px;line-height: 26px;font-weight: bold; color: #000;}
    	.uk-nav-side > li > a:focus, .uk-nav-side > li > a:hover {background-color: #efefef;}
    	.uk-icon-arrow-circle-right {color: #428bca;}
    </style>
</head>
<body>
	<div class="uk-container">
		<div class="uk-location">
			<ul class="uk-breadcrumb">
			  <li><i></i><a href="javascript:;">业务管理</a></li>
			  <li><i></i><a href="javascript:;">公众号管理</a></li>
			  <li class="active">自定义菜单管理</li>
			</ul>
		</div>
		<div>
			<div class="uk-grid">
				<div class="uk-panel uk-panel-box uk-width-1-5">
					<h3 class="uk-panel-title uk-clearfix">
						<label>自定义菜单</label>
						<a href="javascript:;" class="uk-icon-button uk-icon-refresh uk-float-right"></a>
						<a href="javascript:;" class="uk-icon-button uk-icon-minus uk-float-right"></a>
						<a href="javascript:;" class="uk-icon-button uk-icon-plus uk-float-right"></a>
					</h3>
					<ul class="uk-nav uk-nav-side">
						<li class="uk-parent uk-open uk-nav-header">
							<a href="javascript:;"><i class="uk-icon-arrow-circle-right"></i><label>无锡地税</label></a>
							<ul class="uk-nav-sub">
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>图书查询</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>图书推荐</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>数字阅读</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>志愿者中心</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>帮助中心</label></a></li>
							</ul>
						</li>
						<li class="uk-parent uk-open uk-nav-header">
							<a href="javascript:;"><i class="uk-icon-arrow-circle-right"></i><label>活动信息</label></a>
							<ul class="uk-nav-sub">
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>展览活动</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>活动回顾</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>周边活动</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>摇一摇</label></a></li>
							</ul>
						</li>
						<li class="uk-parent uk-open uk-nav-header">
							<a href="javascript:;"><i class="uk-icon-arrow-circle-right"></i><label>我的浦图</label></a>
							<ul class="uk-nav-sub">
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>会员登录</label></a></li>
								<li><a href="javascript:;"><i class="uk-icon-caret-right"></i><label>积分商城</label></a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="uk-width-4-5">
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
    <script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/user/list.js"></script>
</body>
</html>