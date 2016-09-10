$(function() {
	$('#startTime').datetimepicker({
		language : 'zh-CN',
		minView : 2,
		format : "yyyy-mm-dd",
		autoclose : true
	});
	$('#endTime').datetimepicker({
		language : 'zh-CN',
		minView : 2,
		format : "yyyy-mm-dd",
		autoclose : true
	});
});

/**
 * 查询活动列表
 */
function queryActivityList() {
	document.activityQueryForm.orderby.value = DEFAULT_ACTIVITY_QUERY_LIST_ORDER_BY;
	document.activityQueryForm.order.value = DEFAULT_ACTIVITY_QUERY_LIST_ORDER;
	document.activityQueryForm.currentPage.value = 1;
	document.activityQueryForm.submit();
}

/**
 * 查询活动人员列表
 */
function queryActivitySignupList() {
	document.activityQueryForm.currentPage.value = 1;
	document.activityQueryForm.submit();
}
/**
 * 修改活动状态(上线/下线活动)
 * 
 * @param el
 * @param id
 */
function updateActivityOloStatus(el, id) {
	el = $(el);
	var url = null;
	var status = el.attr("data-status");
	var currStatus = null;
	var nextStatus = null;
	if (status == ACTIVITY_OLOSTATUS_ONLINE.statusCode) {
		url = CONTEXT_PATH + '/admin/activity/offline';
		currStatus = ACTIVITY_OLOSTATUS_ONLINE;
		nextStatus = ACTIVITY_OLOSTATUS_OFFLINE;
	} else if (status == ACTIVITY_OLOSTATUS_OFFLINE.statusCode) {
		url = CONTEXT_PATH + '/admin/activity/online';
		currStatus = ACTIVITY_OLOSTATUS_OFFLINE;
		nextStatus = ACTIVITY_OLOSTATUS_ONLINE;
	}
	if (url && confirm('你确定要' + nextStatus.statusName + '所选活动吗?')
			&& isSubmitable(el)) {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : url,
			success : function(response) {
				if (response) {
					if (response.success) {
						el.closest("tr").find(".activity-status").text(
								nextStatus.statusName).removeClass(
								'uk-status-' + currStatus.statusCode).addClass(
								'uk-status-' + nextStatus.statusCode);
						el.attr("data-status", nextStatus.statusCode);
						el.text(currStatus.statusName + '该活动');
					}
					alert(response.message);
				} else {
					alert('请求失败!');
				}
				afterSubmited(el);
			},
			error : function() {
				alert('请求失败!');
				afterSubmited(el);
			}
		});
	}
}

/**
 * 删除该活动
 * 
 * @param el
 * @param id
 */
function delActivity(el, id) {
	el = $(el);
	if (confirm('你确定要删除所选活动吗?') && isSubmitable(el)) {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/activity/del',
			success : function(response) {
				if (response) {
					if (response.success) {
						el.closest("tr").remove();
					}
					alert(response.message);
				} else {
					alert('请求失败!');
				}
				afterSubmited(el);
			},
			error : function() {
				alert('请求失败!');
				afterSubmited(el);
			}
		});
	}
}