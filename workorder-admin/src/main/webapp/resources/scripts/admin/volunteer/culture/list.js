/**
 * 查询志愿文化列表
 */
function queryCultureList(){
	document.cultureQueryForm.orderby.value = DEFAULT_VOLUNTEER_CULTURE_QUERY_LIST_ORDER_BY;
	document.cultureQueryForm.order.value = DEFAULT_VOLUNTEER_CULTURE_QUERY_LIST_ORDER;
	document.cultureQueryForm.currentPage.value = 1;
	document.cultureQueryForm.submit();
}

/**
 * 删除该志愿文化
 * @param el
 * @param id
 */
function delCulture(el, id){
	el = $(el);
	if(confirm('你确定要删除所选志愿文化吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/volunteer/culture/del',
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