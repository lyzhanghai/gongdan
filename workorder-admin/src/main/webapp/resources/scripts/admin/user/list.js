/**
 * 查询用户列表
 */
function queryUserList(){
	document.userQueryForm.orderby.value = DEFAULT_USER_QUERY_LIST_ORDER_BY;
	document.userQueryForm.order.value = DEFAULT_USER_QUERY_LIST_ORDER;
	document.userQueryForm.currentPage.value = 1;
	document.userQueryForm.submit();
}