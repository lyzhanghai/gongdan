/**
 * 查询用户列表
 */
function queryGroupList(){
	document.groupQueryForm.orderby.value = DEFAULT_GROUP_QUERY_LIST_ORDER_BY;
	document.groupQueryForm.order.value = DEFAULT_GROUP_QUERY_LIST_ORDER;
	document.groupQueryForm.currentPage.value = 1;
	document.groupQueryForm.submit();
}
/**
 * 删除该用户
 * @param el
 * @param id
 */

function delUser(el, id){
	el = $(el);
	if(confirm('你确定要删除所选群组吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/group/del',
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
	
