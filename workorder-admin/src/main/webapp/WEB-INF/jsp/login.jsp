<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN" class="uk-height-1-1">
<head>
  	<%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  	<title>后台管理系统-登录</title>
  	<link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <style type="text/css">
    	.uk-container {padding:0;margin:0;}
    	.uk-panel-title {border-bottom:1px solid #dfdfdf;margin:0;padding:10px 0;color:#333333;text-shadow:rgba(50, 50, 50, 0.292969) 1px 1px 3px;font-family:verdana;}
    	.login-form-row {margin:0;}
    	.login-form-row > .uk-width-1-1 {padding:10px;}
    	.uk-form-icon > i, .uk-form-icon > input {height:45px;line-height:45px;}
    	.uk-form-icon > [class*="uk-icon-"] {margin-top:-22px !important;width:60px;}
    	.uk-form-icon:not(.uk-form-icon-flip) > input {padding-left:60px !important;}
    	.login-error-message {display:block;height:20px;line-height:20px;color:#c11a39;padding:0 0 0 13px !important;margin-top:5px;}
    	.uk-form-control:focus {box-shadow:none;}
    	.uk-form-control:focus + i {color:red !important;}
    	.uk-button-large {height:45px;}
    </style>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript">
		CONTEXT_PATH = '${CONTEXT_PATH}';
		if(window.parent != window){ //iframe子页面跳转到login页面了
			window.parent.location.href = CONTEXT_PATH + '/login';
		}
	</script>
</head>
<body class="uk-height-1-1">
        <div class="uk-container uk-height-1-1">
        	<div class="uk-vertical-align uk-container-center" style="width:500px;">
        		<div class="uk-panel uk-panel-box uk-vertical-align-middle">
	            	<label class="uk-panel-badge uk-badge uk-badge-primary">Welcome</label>
					<h3 class="uk-panel-title">User Login</h3>
					<form name="userLoginForm" action="${CONTEXT_PATH}/login/submit" method="post">
		            	<div class="uk-grid login-form-row">
		            		<div class="uk-width-1-1 login-error-message">
		            			<label>${message}</label>
		            		</div>
		            		<div class="uk-form-icon uk-width-1-1">
		            			<i class="uk-icon-user"></i>
	    						<input class="uk-form-control" type="text" name="userName" placeholder='Username'>
		            		</div>
		            		<div class="uk-form-icon uk-width-1-1">
		            			<i class="uk-icon-key"></i>
	    						<input class="uk-form-control" type="password" name="password" placeholder='Password'>
		            		</div>
		            		<div class="uk-width-1-1">
		            			<button class="uk-button uk-button-primary uk-button-large uk-width-1-1" type="button" onclick="doUserLogin();">Login</button>
		            		</div>
		            		<div class="uk-width-1-1">
		            			<a class="uk-float-right" href="#">Forgot Password?</a>
		            		</div>
		            	</div>
	            	</form>
            	</div>
        	</div>
        </div>
</body>
<script type="text/javascript">
	function doUserLogin(){
		if(!document.userLoginForm.userName.value){
			alert("请输入用户名!");
			return;
		}
		if(!document.userLoginForm.password.value){
			alert("请输入密码!");
			return;
		}
		document.userLoginForm.submit();
	}
</script>
</html>