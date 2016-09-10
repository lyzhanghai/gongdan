<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>新增群组</title>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.css">
	
<!-- 	<script type="text/javascript"> -->
<!-- 		function save(){ -->
<!-- 			document.groupAddForm.submit(); -->
		
		
<!-- 		} -->
	
	
<!-- 	</script> -->


</head>
<body>
<div class="uk-container">
    <div class="uk-location">
        <ul class="uk-breadcrumb">
            <li><i></i><a href="javascript:;">业务管理</a></li>
            <li><i></i><a href="${CONTEXT_PATH}/admin/club/list">群组管理</a></li>
            <li class="active">新增群组</li>
        </ul>
    </div>
    <form id="groupAddForm" class="uk-form" name="groupAddForm" action="${CONTEXT_PATH}/admin/group/add" method="post">
        <fieldset>
            <legend>新增群组</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-2-10"><em>*</em><label for="title">群组名称</label>：</div>
                    <div class="uk-form-field uk-width-6-10">
                        <input type="text" id="groupName" name="groupName" value="${group.groupName}" maxlength="100"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="groupName">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                
<!--                 <div class="uk-form-row"> -->
<!--                     <div class="uk-form-label uk-width-2-10"><label for="typeIndex">群组排序</label>：</div> -->
<!--                     <div class="uk-form-field uk-width-6-10"> -->
<!--                         <input type="text" name="typeIndex" maxlength="11" value=""/> -->
<!--                     </div> -->
<!--                     <div class="uk-form-info uk-width-2-10"> -->
<!--                         <div class="uk-validate-message uk-validate-message-tips" for="typeIndex"> -->
<!--                             <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
           
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="save(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/group/list">返回列表</a>
                    </div>
                </div>
            </div>
        </fieldset>
    </form>
</div>

<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/user/group/add.js"></script>
</body>
</html>