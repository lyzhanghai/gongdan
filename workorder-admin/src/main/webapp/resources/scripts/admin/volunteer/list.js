$(function() {
	$('#startApplyTime').datetimepicker({
		language : 'zh-CN',
		minView : 2,
		format : "yyyy-mm-dd",
		autoclose : true
	});
	$('#endApplyTime').datetimepicker({
		language : 'zh-CN',
		minView : 2,
		format : "yyyy-mm-dd",
		autoclose : true
	});
});

/**
 * 查询志愿者列表
 */
function queryVolunteerList() {
	document.volunteerQueryForm.orderby.value = DEFAULT_VOLUNTEER_QUERY_LIST_ORDER_BY;
	document.volunteerQueryForm.order.value = DEFAULT_VOLUNTEER_QUERY_LIST_ORDER;
	document.volunteerQueryForm.currentPage.value = 1;
	document.volunteerQueryForm.submit();
}

/**
 * 标记为已联系
 * 
 * @param el
 * @param id
 */
function markAsContacted(el, id) {
	el = $(el);
	if (confirm('你确定要该申请者标记为已联系?') && isSubmitable(el)) {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/volunteer/contacted',
			success : function(response) {
				if (response) {
					if (response.success) {
						var spano = el.parent().parent().find('span');
						spano.removeClass("uk-status-0");
						spano.addClass("uk-status-1");
						spano.text('已联系');
						el.remove();
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
 * 审核
 * 
 * @param el
 * @param id
 */
function audit(el, id, status) {
	el = $(el);
	var msg = "你确定审核通过该申请者！";
	if (status == 2) {
		msg = "你确定审核拒绝该申请者！";
	}
	if (confirm(msg) && isSubmitable(el)) {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : {
				id : id,
				status : status
			},
			url : CONTEXT_PATH + '/admin/volunteer/audit',
			success : function(response) {
				if (response) {
					if (response.success) {

						if (status == 2) {
							el.parent().prev().text('审核拒绝');
							el.prev().remove();
						} else {
							el.parent().prev().text('审核通过');
							el.next().remove();
						}
						el.remove();
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
function delVolunteer(el, id) {
	el = $(el);
	if (confirm('你确定要删除该志愿者吗?') && isSubmitable(el)) {
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/volunteer/del',
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
