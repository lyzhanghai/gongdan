<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp"%>
<html lang="zh-CN">
<head>
  <%@include file="/WEB-INF/jsp/common/include/header.jsp"%>
  <title>增加积分</title>
  <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
  <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
  <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/simplePagination/simplePagination.css"/>
</head>
<body>
<div class="uk-container">
  <div class="uk-location">
    <ul class="uk-breadcrumb">
      <li><i></i><a href="javascript:;">业务管理</a></li>
      <li><i></i><a href="${CONTEXT_PATH}/admin/user/list">用户管理</a></li>
      <li class="active">增加积分</li>
    </ul>
  </div>
  <div>
    <div>
      <div class="uk-grid uk-row uk-row-hover">
        <label class="uk-width-1-5 uk-font-bold uk-right">用户ID：</label>
        <div class="uk-width-4-5 uk-color-666">${user.userId}</div>
      </div>
      <div class="uk-grid uk-row uk-row-hover">
        <label class="uk-width-1-5 uk-font-bold uk-right">用户昵称：</label>
        <div class="uk-width-4-5 uk-color-666">
          <header class="uk-comment-header">
            <c:if test="${empty user.fullIconUrl}">
              <img class="uk-comment-avatar" src="${CONTEXT_PATH}/resources/images/avatar9.jpg" width="50" height="50" alt=""/>
            </c:if>
            <c:if test="${not empty user.fullIconUrl}">
              <img class="uk-comment-avatar" src="${user.fullIconUrl}" width="50" height="50" alt=""/>
            </c:if>
            <h4 class="uk-comment-title">${user.nickName}</h4>
          </header>
        </div>
      </div>
      <div class="uk-grid uk-row uk-row-hover">
        <label class="uk-width-1-5 uk-font-bold uk-right">用户类型：</label>
        <div class="uk-width-4-5 uk-color-666">${user.userTypeName}</div>
      </div>
      <div class="uk-grid uk-row uk-row-hover">
        <label class="uk-width-1-5 uk-font-bold uk-right">手机号码：</label>
        <div class="uk-width-4-5 uk-color-black uk-font-bold">${user.mobilePhone}</div>
      </div>
      <div class="uk-grid uk-row uk-row-hover">
        <label class="uk-width-1-5 uk-font-bold uk-right">EMAIL：</label>
        <div class="uk-width-4-5 uk-color-666">${user.email}</div>
      </div>
      <div class="uk-grid uk-row uk-row-hover">
        <label class="uk-width-1-5 uk-font-bold uk-right">积分：</label>
        <div class="uk-width-4-5 uk-color-666">${user.userPoint}</div>
      </div>
      <div class="uk-grid uk-row uk-row-hover">
        <label class="uk-width-1-5 uk-font-bold uk-right">增加积分：</label>
        <div class="uk-width-4-5 uk-color-666">
          <input type="text" id="addedPoint" name="addedPoint" placeholder="请填入正整数">
        </div>
      </div>

      <div class="uk-grid uk-row">
        <div class="uk-width-1-5"></div>
        <div><a class="uk-button uk-button-primary" href="javascript:void(0);" onclick="addUserPoint(${user.userId});">添加</a></div>
        <div class="uk-width-2-5"><a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/user/list">返回列表</a></div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/jsp/common/include/message.jsp"></jsp:include>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/js/uikit.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/simplePagination/jquery.simplePagination.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jsrender.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript">
  function addUserPoint(userId) {
    var addedPoint = $('#addedPoint').val();
	var reg= /^\+?[1-9][0-9]*$/;
    if (!addedPoint.match(reg)) {
    alert("积分必须是大于0的正整数");
    return;
    }

    $.ajax({
      async : true,
      cache : false,
      type : 'post',
      dataType : 'json',
      data : {userId : userId, point : addedPoint},
      url : '${CONTEXT_PATH}/admin/user/addPoint/submit',
      success : function(response) {
        if (response) {
          alert(response.message);
          if (response.success) {
            window.location.href = '${CONTEXT_PATH}/admin/user/list';
          }
        } else {
          alert('请求失败!');
        }
      },
      error : function() {
        alert('请求失败!');
      }
    });
  }
</script>
</body>
</html>