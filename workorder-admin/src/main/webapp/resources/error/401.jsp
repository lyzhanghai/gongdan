<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>不好意思，访问被拒绝!</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Cache-Control" content="no-cache"/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/error/error.css"/>
</head>
<body>
	<div class="error-page-wrapper">
		<div class="error-page">
			<div class="error-page-left">
				<div class="error-page-code">
					<h1>401</h1>
					<p>unauthorized</p>
				</div>
			</div>
			<div class="error-page-right valign">
				<h1 class="error-title-main">不好意思，您没有权限访问该资源!</h1>
			</div>
		</div>
	</div>
</body>
</html>