/**
 * 查询角色列表
 */
function queryRoleList(){
	document.roleQueryForm.orderby.value = DEFAULT_ROLE_QUERY_LIST_ORDER_BY;
	document.roleQueryForm.order.value = DEFAULT_ROLE_QUERY_LIST_ORDER;
	document.roleQueryForm.currentPage.value = 1;
	document.roleQueryForm.submit();
}
/**
 * 删除该角色
 * @param el
 * @param roleId
 * @param roleType
 */
function delRole(el, roleId, roleType){
	el = $(el);
	if(roleType == ROLE_TYPE_SYSTEM.typeCode){
		alert(ROLE_TYPE_SYSTEM.typeName + '不允许删除!');
		return;
	}
	if(confirm('你确定要删除所选角色吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + roleId,
			url : CONTEXT_PATH + '/xadmin/role/del',
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