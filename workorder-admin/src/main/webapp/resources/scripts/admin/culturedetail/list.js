/**
 * 查询Culture列表
 */
function queryCulturedetailList(){
	document.CultureDetailQueryForm.orderby.value = DEFAULT_CULTURE_DETAIL_QUERY_LIST_ORDER_BY;
	document.CultureDetailQueryForm.order.value = DEFAULT_CULTURE_DETAIL_QUERY_LIST_ORDER;
	document.CultureDetailQueryForm.currentPage.value = 1;
	document.CultureDetailQueryForm.submit();
}

/**
 * 删除该文化动态
 * @param el
 * @param id
 */
function delCulturedetail(el, id){
	el = $(el);
	if(confirm('你确定要删除所选文化动态详情吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/culturedetail/dele',
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


