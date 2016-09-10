/**
 * 查询Banner列表
 */
function queryBannerList(){
	document.bannerQueryForm.orderby.value = DEFAULT_BANNER_QUERY_LIST_ORDER_BY;
	document.bannerQueryForm.order.value = DEFAULT_BANNER_QUERY_LIST_ORDER;
	document.bannerQueryForm.currentPage.value = 1;
	document.bannerQueryForm.submit();
}

/**
 * 删除该Banner
 * @param el
 * @param id
 */
function delBanner(el, id){
	el = $(el);
	if(confirm('你确定要删除所选Banner吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/banner/del',
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