/**
 * 查询优惠券列表
 */
function queryCouponList(){
	document.couponQueryForm.orderby.value = DEFAULT_COUPON_QUERY_LIST_ORDER_BY;
	document.couponQueryForm.order.value = DEFAULT_COUPON_QUERY_LIST_ORDER;
	document.couponQueryForm.currentPage.value = 1;
	document.couponQueryForm.submit();
}
/**
 * 修改优惠券状态(上线/下线优惠券)
 * @param el
 * @param id
 */
function updateCouponStatus(el, id){
	el = $(el);
	var url = null;
	var status = el.attr("data-status");
	var currStatus = null;
	var nextStatus = null;
	if(status == COUPON_STATUS_ONLINE.statusCode){
		url = CONTEXT_PATH + '/admin/coupon/offline';
		currStatus = COUPON_STATUS_ONLINE;
		nextStatus = COUPON_STATUS_OFFLINE;
	}else if(status == COUPON_STATUS_OFFLINE.statusCode){
		url = CONTEXT_PATH + '/admin/coupon/online';
		currStatus = COUPON_STATUS_OFFLINE;
		nextStatus = COUPON_STATUS_ONLINE;
	}
	if(url && confirm('你确定要' + nextStatus.statusName + '所选优惠券吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : url,
			success : function(response) {
				if (response) {
					if(response.success) {
						el.closest("tr").find(".coupon-status").text(nextStatus.statusName).removeClass('uk-status-' + currStatus.statusCode).addClass('uk-status-' + nextStatus.statusCode);
						el.attr("data-status", nextStatus.statusCode);
						el.text(currStatus.statusName + '该优惠券');
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
 * 删除该优惠券
 * @param el
 * @param id
 */
function delCoupon(el, id){
	el = $(el);
	if(confirm('你确定要删除所选优惠券吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/coupon/del',
			success : function(response) {
				if (response) {
					if(response.success) {
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