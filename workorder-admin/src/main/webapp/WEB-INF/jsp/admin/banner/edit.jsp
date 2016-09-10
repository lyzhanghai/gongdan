<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>修改Banner</title>
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
            <li><i></i><a href="${CONTEXT_PATH}/admin/banner/list">Banner管理</a></li>
            <li class="active">修改Banner</li>
        </ul>
    </div>
    <form id="bannerEditForm" class="uk-form" name="bannerEditForm" action="${CONTEXT_PATH}/admin/banner/edit/submit" method="post">
        <fieldset>
            <legend>修改Banner</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-2-10"><em>*</em><label for="title">Banner标题</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                    	<input type="hidden" name="id" value="${bannerEditForm.id}"/>
                        <input type="text" name="title" value="${bannerEditForm.title}" maxlength="100"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                    	<div class="uk-validate-message uk-validate-message-tips" for="id">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                        <div class="uk-validate-message uk-validate-message-tips" for="title">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-2-10"><em>*</em><label for="imageUrl">Banner图片</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                        <input id="imageUrl" type="hidden" name="imageUrl" value="${bannerEditForm.imageUrl}"/>
                        <input id="fullImageUrl" type="hidden" name="fullImageUrl" value="${bannerEditForm.fullImageUrl}"/>
						<div class="xupload-list xupload-list-banner-image" style="display:block;"></div>
						<a class="xupload-btn" href="javascript:;">
							<label>请选择图片</label>
							<input type="file" name="uploadFile"/>
						</a>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="imageUrl">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">图片限1M以内,支持jpg/png/gif,banner图尺寸 750x360
                            </span>
                        </div>
                    </div>
                </div>
            
                <div class="uk-form-row"  id="bannerDiv"     <c:if test="${bannerEditForm.type eq 6 }">style="display:none"</c:if> >
                    <div class="uk-form-label uk-width-2-10"><label for="linkUrl">Banner链接URL</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                        <input type="text" name="linkUrl" value="${bannerEditForm.linkUrl}" maxlength="255"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="linkUrl">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-2-10"><em>*</em><label for="inventory">Banner类型</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                        <select name="type">
							<option value="">--请选择--</option>
							<c:forEach items="${types}" var="item">
								<option value="${item.typeCode}" ${bannerEditForm.type eq item.typeCode ? 'selected' : ''}>${item.typeName}</option>
							</c:forEach>
						</select>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="type">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-2-10"><label for="typeIndex">Banner排序</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                        <input type="text" name="typeIndex" maxlength="11" value="${bannerEditForm.typeIndex != null ? bannerEditForm.typeIndex : '0'}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="typeIndex">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-2-10"><label for="remark">备注</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                       	<textarea rows="3" name="remark" maxlength="500">${bannerEditForm.remark}</textarea>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="remark">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="saveBanner(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/banner/list">返回列表</a>
                    </div>
                </div>
            </div>
        </fieldset>
    </form>
</div>
<form id="imageUploadForm" action="${CONTEXT_PATH}/xupload/image/submit" method="post" enctype="multipart/form-data" style="display:none;">
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
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/banner/edit.js"></script>
</body>
</html>