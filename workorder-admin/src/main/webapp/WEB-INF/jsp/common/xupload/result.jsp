<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setAttribute("CONTEXT_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
	<title>仿Ajax页面无刷新文件上传结果页面</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Cache-Control" content="no-cache"/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
	<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript">
		/**
		 * 该页面最终load进入隐藏的iframe中
		 *
		 * result的数据结构可由具体业务具体定,例如：
		 * {
		 *		success: true,
		 *		message: "上传影片海报图片成功",
		 *      uploadSerialNo: "7192938281",
		 *      retObj: {
		 * 			originalFileName: "变形金刚_1.jpg",
		 *	 		fileRelativePath: "/upload/film/temp/8192938291_200x300.jpg",
		 *          fileViewUrl: '/CONTEXT_PATH/upload/film/temp/8192938291_200x300.jpg'
		 *		}
		 * }
		 *
		 * {
		 *		success: false,
		 *		message: "海报图片尺寸不得小于200x300像素",
		 *		uploadSerialNo: "7192938281",
		 * 		retObj: null
		 * }
		 *
		 */
		var resultString = '${result}';
		var resultObj = eval("(" + resultString + ")");
		var scope = window.parent.document;
		var $uploadBox = window.parent.$("#" + resultObj.uploadSerialNo);
		var btnId = $uploadBox.attr("data-xuploadbtn-id");
		var $this = window.parent.$("#" + btnId);
		var options = $this.data("options");
		options.uploadCallback.call($this, $uploadBox, resultObj);
	</script>
</head>
<body>
</body>
</html>