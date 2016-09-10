<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>修改俱乐部</title>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.css">
    <style type="text/css">
    	.xupload-list-banner-image .xupload-box > a.xupload-uploading,.xupload-list-banner-image .xupload-box > a.xupload-error { min-width: 200px;height: 200px; }
    	.xupload-list-banner-image .xupload-box > a > img { min-width: 200px;height: 200px; }
    </style>
</head>
<body>
<div class="uk-container">
    <div class="uk-location">
        <ul class="uk-breadcrumb">
            <li><i></i><a href="javascript:;">业务管理</a></li>
            <li><i></i><a href="${CONTEXT_PATH}/admin/club/list">俱乐部管理</a></li>
            <li class="active">修改俱乐部</li>
        </ul>
    </div>
    <form id="clubEditForm" class="uk-form" name="clubEditForm" action="${CONTEXT_PATH}/admin/club/edit" method="post">
        <fieldset>
            <legend>修改俱乐部</legend>
            <div>
               <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="orderNum">排序编号</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                    	<input type="hidden" name="updateUserId" value="${sessionScope.loginToken.loginId}">
                        <input type="text" name="orderNum" value="${club.orderNum}" maxlength="10"/>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="orderNum">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">排序编号不能为空且为10位以内的有效数字</span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-1-5"><em>*</em><label for="title">俱乐部名称</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                    	<input type="hidden" name="id" value="${club.id}"/>
                        <input type="text" name="name" value="${club.name}" maxlength="100"/>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                    	<div class="uk-validate-message uk-validate-message-tips" for="id">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                        <div class="uk-validate-message uk-validate-message-tips" for="name">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">俱乐部名称不能为空</span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><label for="areainfo">所在区域</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
<%--                    <input type="hidden" id="selectvalue" value="${club.areainfo}">--%>
                        <select id="areainfo" name="areainfo">
							<option value="" >--请选择--</option>
							<option value="1" <c:if test="${ club.areainfo eq 1}">selected</c:if>>无锡市区</option>
							<option value="2" <c:if test="${ club.areainfo eq 2}">selected</c:if>>滨湖区</option>
							<option value="3" <c:if test="${ club.areainfo eq 3}">selected</c:if>>惠山区</option>
							<option value="4" <c:if test="${ club.areainfo eq 4}">selected</c:if>>锡山区</option>
							<option value="5" <c:if test="${ club.areainfo eq 5}">selected</c:if>>梁溪区</option>
							<option value="6" <c:if test="${ club.areainfo eq 6}">selected</c:if>>新吴区</option>
							<option value="7" <c:if test="${ club.areainfo eq 7}">selected</c:if>>江阴市</option>
							<option value="8" <c:if test="${ club.areainfo eq 8}">selected</c:if>>宜兴市</option>
						</select>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="areainfo">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><label for="logo">俱乐部logo</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                        <input id="logo" type="hidden" name="logo" value="${club.logo}"/>
						<a class="xupload-btn" href="javascript:;">
							<label>请选择图片</label>
							<input type="file" name="uploadFile" accept=".jpg,.jpeg,.gif,.png"/>
						</a>
						<div class="xupload-list xupload-list-banner-image" style="display:block;">
							<img alt="${club.logo}" src="${CONTEXT_PATH}${club.logo}" style="max-width:200px;max-height:200px;"/>
						</div>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="logo">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">上传图片仅限1M以内
                            </span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-5"><label for="remark">备注</label>：</div>
                    <div class="uk-form-field uk-width-2-5">
                       	<textarea rows="3" name="remark" maxlength="500">${club.remark}</textarea>
                    </div>
                    <div class="uk-form-info uk-width-2-5">
                        <div class="uk-validate-message uk-validate-message-tips" for="remark">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="editClub(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/club/list">返回列表</a>
                    </div>
                </div>
            </div>
        </fieldset>
    </form>
</div>
<form id="imageUploadForm" action="${CONTEXT_PATH}/admin/xupload/file" method="post" enctype="multipart/form-data" style="display:none;">
	<input type="hidden" name="uploadSerialNo"/>
	<input type="hidden" name="maxFileSize" value="1048576"/>
</form>
<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/club/edit.js"></script>
</body>
</html>