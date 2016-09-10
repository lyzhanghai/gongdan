<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/common/include/taglibs.jsp" %>
<html lang="zh-CN">
<head>
    <%@include file="/WEB-INF/jsp/common/include/header.jsp" %>
    <title>新增活动</title>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.almost-flat.min.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/${UIKIT_VERSION}/css/uikit.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/ueditor-1.4.3.2/themes/default/css/ueditor.css">
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.css">
    <link rel="stylesheet" type="text/css" href="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>
    <style type="text/css">
    	.xupload-list-activity-image .xupload-box > a.xupload-uploading,.xupload-list-activity-image .xupload-box > a.xupload-error { min-width: 200px;height: 200px; }
    	.xupload-list-activity-image .xupload-box > a > img { min-width: 200px;height: 200px; }
    	.uk-table-seats > caption > div {display: block;text-align: center;font-style: normal; font-weight: bold;width: 100%;height: 50px; line-height: 50px; font-size: 18px; color: #000; background-color: #dfdfdf;margin: 0 0 30px 0;}
    	.uk-table-seats > thead > tr th {width: 50px;text-align: center;vertical-align: middle;}
    	.uk-table-seats > tbody > tr {border: 0 none;}
    	.uk-table-seats > tbody > tr > td {width: 50px;height: 30px; border: 0 none;padding: 5px;text-align: center;vertical-align: middle;}
    	.uk-table-seats > tbody > tr > td .seat-box {display: inline-block;position: relative;padding: 3px;background-color: #ccc;}
    	.uk-table-seats > tbody > tr > td .seat-box-1 {background-color: #27ad60;}
    	.uk-table-seats > tbody > tr > td .seat-box-2 {background-color: #428bca;}
    	.uk-table-seats > tbody > tr > td .seat-box-0 {background-color: #fff;}
    	.uk-table-seats > tbody > tr > td input {display: block;width: 24px !important; height: 24px !important; margin: 4px !important;text-align: center;border: 0 none !important;box-shadow: none !important;}
    	.uk-table-seats > tbody > tr > td input:focus {border: 0 none !important;box-shadow: none !important;}
    </style>
    <script type="text/javascript">
    	var ACTIVITY_TYPE_FORUM_SELECT_SEAT = {
    		typeCode: '${applicationScope.ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeCode}',
    		typeName: '${applicationScope.ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeName}'
    	};
    </script>
</head>
<body>
<div class="uk-container">
    <div class="uk-location">
        <ul class="uk-breadcrumb">
            <li><i></i><a href="javascript:;">业务管理</a></li>
            <li><i></i><a href="${CONTEXT_PATH}/admin/activity/list">活动管理</a></li>
            <li class="active">新增活动</li>
        </ul>
    </div>
    <form id="activityAddForm" class="uk-form" name="activityAddForm" action="${CONTEXT_PATH}/admin/activity/add/submit" method="post">
        <fieldset>
            <legend>新增活动</legend>
            <div>
                <div class="uk-form-row uk-form-row-width">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="title">活动标题</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input type="text" name="title" value="${activityAddForm.title}" maxlength="13"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="title">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="type">活动类型</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                    	<select name="type" onchange="onActivityTypeChange(this);">
							<option value="">--请选择--</option>
							<c:forEach items="${activityTypes}" var="item">
								<option value="${item.typeCode}" ${activityAddForm.type eq item.typeCode ? 'selected' : ''}>${item.typeName}</option>
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
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="thumbnail">活动缩略图片</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input id="thumbnail" type="hidden" name="thumbnail"/>
						<div class="xupload-list xupload-list-activity-image xupload-list-activity-image1" style="display:block;"></div>
						<a class="xupload-btn xupload-btn1" href="javascript:;">
							<label>请选择图片</label>
							<input type="file" name="uploadFile"/>
						</a>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="thumbnail">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">图片限1M以内,支持jpg/png/gif,缩略图尺寸164x224
                            </span>
                        </div>
                    </div>
                </div>
                
                
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="imgUri">活动图片</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input id="imgUri" type="hidden" name="imgUri"/>
						<div class="xupload-list xupload-list-activity-image xupload-list-activity-image2" style="display:block;"></div>
						<a class="xupload-btn xupload-btn2" href="javascript:;">
							<label>请选择图片</label>
							<input type="file" name="uploadFile"/>
						</a>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="imgUri">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text">图片限1M以内,支持jpg/png/gif,大图尺寸 750x360
                            </span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="startTime">开始时间</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input type="text" id="startTime" name="startTime" maxlength="20" value="${activityAddForm.startTime}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="startTime">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                 <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="endTime">结束时间</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input type="text" id="endTime" name="endTime" maxlength="20" value="${activityAddForm.endTime}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="endTime">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row"  id="cancelTimeDiv">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="cancelTime">取消活动截止时间</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input type="text" id="cancelTime" name="cancelTime" maxlength="20" value="${activityAddForm.cancelTime}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="cancelTime">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                
                
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="place">活动地点</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input type="text" name="place" maxlength="20" value="${activityAddForm.place}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="place">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                
               <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="traffic">活动交通</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input type="text" name="traffic" maxlength="30" value="${activityAddForm.traffic}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="traffic">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                
                 <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="decription">活动简介</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                        <input type="text" name="decription" maxlength="50" value="${activityAddForm.decription}"/>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="decription">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="intro">活动详情</label>：</div>
                    <div class="uk-form-field uk-width-7-10">
                    	<textarea id="intro" rows="3" name="intro">${activityAddForm.intro}</textarea>
                    </div>
                    <div class="uk-form-info uk-width-2-10">
                        <div class="uk-validate-message uk-validate-message-tips" for="intro">
                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
                        </div>
                    </div>
                </div>
   
                
                <div class="activity-extra" style="display:none;" data-activity-type="${applicationScope.ACTIVITY_TYPE_FORUM_SELECT_SEAT.typeCode}">
                	  <div class="uk-form-row">
	                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="lecturer">讲师名称</label>：</div>
	                    <div class="uk-form-field uk-width-7-10">
	                        <input type="text" id="lecturer" name="lecturer" maxlength="20" value="${activityAddForm.lecturer}"/>
	                    </div>
	                    <div class="uk-form-info uk-width-2-10">
	                        <div class="uk-validate-message uk-validate-message-tips" for="lecturer">
	                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
	                        </div>
	                    </div>
	                </div>
	                <div class="uk-form-row">
	                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="lecturerIntro">讲师简介</label>：</div>
	                    <div class="uk-form-field uk-width-7-10">
	                    	<textarea rows="3" id="lecturerIntro" name="lecturerIntro" maxlength="100">${activityAddForm.lecturerIntro}</textarea>
	                    </div>
	                    <div class="uk-form-info uk-width-2-10">
	                        <div class="uk-validate-message uk-validate-message-tips" for="lecturerIntro">
	                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
	                        </div>
	                    </div>
	                </div>
                	
                	<div class="uk-form-row">
	                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="selectSeatStartTime">选座开始时间</label>：</div>
	                    <div class="uk-form-field uk-width-7-10">
	                        <input type="text" id="selectSeatStartTime" name="selectSeatStartTime" maxlength="20" value="${activityAddForm.selectSeatStartTime}"/>
	                    </div>
	                    <div class="uk-form-info uk-width-2-10">
	                        <div class="uk-validate-message uk-validate-message-tips" for="selectSeatStartTime">
	                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
	                        </div>
	                    </div>
	                </div>
	                <div class="uk-form-row">
	                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="selectSeatEndTime">选座截止时间</label>：</div>
	                    <div class="uk-form-field uk-width-7-10">
	                        <input type="text" id="selectSeatEndTime" name="selectSeatEndTime" maxlength="20" value="${activityAddForm.selectSeatEndTime}"/>
	                    </div>
	                    <div class="uk-form-info uk-width-2-10">
	                        <div class="uk-validate-message uk-validate-message-tips" for="selectSeatEndTime">
	                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
	                        </div>
	                    </div>
	                </div>
	                <div class="uk-form-row">
	                    <div class="uk-form-label uk-width-1-10"><em>*</em><label for="">座位图矩阵</label>：</div>
	                    <div class="uk-form-field uk-width-7-10">
	                        <div class="uk-grid">
	                        	<div class="uk-width-1-2">
	                        		<label>总行数：<input id="rows" class="uk-w40" value="21" type="text" name="rows" readonly="readonly"/></label>
	                        		<label>总列数：<input id="cols" class="uk-w40" value="35"  type="text" name="cols" readonly="readonly"/></label>
	                        	</div>
	                        	<div class="uk-width-1-2">
	                        		<!--  <a class="uk-button uk-button-success" href="javascript:;" onclick="genSeatMatrix();"><i class="uk-icon-navicon"></i>&nbsp;生成座位图矩阵</a>-->
	                        		<input id="seatStatuses" type="hidden" name="seatStatuses" value=""/>
	                        	</div>
	                        	<div class="uk-width-1-1">
	                        		<h3 style="margin: 15px 0 10px 0;">座位状态说明：</h3>
	                        		<p>1 - 代表座位可售, 2 - 代表座位已售, 0 - 代表非座位(比如座位坏了不可用、空白位置、墙柱等等情况)</p>
	                        		<p>请在下方生成的座位矩阵方格中输入0,1,2三种状态</p>
	                        	</div>
	                        </div>
	                    </div>
	                    <div class="uk-form-info uk-width-2-10">
	                        <div class="uk-validate-message uk-validate-message-tips" for="seatStatuses">
	                            <em class="uk-validate-message-icon"></em><span class="uk-validate-message-text"></span>
	                        </div>
	                    </div>
	                </div>
	                <div class="uk-form-row"  style="padding-bottom:30px">
	                	<div class="uk-width-1-1">
	                		<div class="uk-table-scroll-container" data-relative-target=".uk-form-row-width">
	                        	<table class="uk-table uk-table-fixed uk-table-hover uk-table-seats" cellspacing="0" width="100%">
	                        		<caption>
	                        			<div>讲台/屏幕位置</div>
	                        		</caption>
	                        		<thead>
	                        		</thead>
	                        		<tbody>
	                        			<!-- 
	                        			<tr>
	                        				<td><div class="seat-box"><input type="text" name="status" onblur="onSeatStatusBlur(this);"/></div></td>
	                        			</tr> 
	                        			-->
	                        		</tbody>
	                        	</table>
	                        </div>
	                	</div>
	                </div>
                </div>
                <div class="uk-form-row">
                    <div class="uk-form-btn uk-width-1-1">
                        <button type="button" class="uk-button uk-button-primary" onclick="saveActivity(this);" data-loading-text="保存中....">保存信息</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="uk-button uk-button-primary" href="${CONTEXT_PATH}/admin/activity/list">返回列表</a>
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
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/ueditor-1.4.3.2/ueditor.config.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/ueditor-1.4.3.2/ueditor.all.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/js/jquery.json-2.4.min.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/components/jquery.xupload/jquery.xupload.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/common.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/activity/seat.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/admin/activity/add.js"></script>
<script type="text/javascript" src="${CONTEXT_PATH}/resources/scripts/addButton.js"></script>
<script type="text/javascript">
inituploadbtn('intro');
</script>
</body>
</html>