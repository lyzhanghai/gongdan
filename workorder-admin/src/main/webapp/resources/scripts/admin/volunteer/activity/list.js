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
	document.activityQueryForm.orderby.value = DEFAULT_VOLUNTEER_ACTIVITY_QUERY_LIST_ORDER_BY;
	document.activityQueryForm.order.value = DEFAULT_VOLUNTEER_ACTIVITY_QUERY_LIST_ORDER;
	document.activityQueryForm.currentPage.value = 1;
	document.activityQueryForm.submit();
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
			url : CONTEXT_PATH + '/admin/volunteer/activity/del',
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