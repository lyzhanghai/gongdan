<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>不好意思，服务器内部出现错误!</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Cache-Control" content="no-cache"/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <link type="text/css" rel="stylesheet" href="${CONTEXT_PATH}/resources/error/error.css"/>
</head>
<body>
	<div class="error-page-wrapper">
		<div class="error-page clearfix">
			<div class="error-page-left">
				<div class="error-page-code">
					<h1>500</h1>
					<p>internal server error</p>
				</div>
			</div>
			<div class="error-page-right">
				<h1 class="error-title-main">不好意思，服务器内部出现错误!</h1>
				<p class="error-title-msg">错误信息：<%=exception.getMessage()%></p>
			</div>
		</div>
		<div>
			<pre class="error-exception-stack"><%=exception.toString()%></pre>
		</div>
	</div>
</body>
</html>