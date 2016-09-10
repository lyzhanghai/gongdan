/**
 * 查询知识类别列表
 */
function queryClubList(){
	document.clubQueryForm.orderby.value = DEFAULT_CLUB_QUERY_LIST_ORDER_BY;
	document.clubQueryForm.order.value = DEFAULT_CLUB_QUERY_LIST_ORDER;
	document.clubQueryForm.currentPage.value = 1;
	document.clubQueryForm.submit();
}
/**
 * 删除知识类别
 * @param el
 */
function delClub(el, clubId){
	el = $(el);
	if(confirm('你确定要删除所选俱乐部吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + clubId,
			url : CONTEXT_PATH + '/admin/club/delete',
			success : function(response) {
				if (response) {
					if(response.success) {
						el.closest("tr").remove();
					}
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