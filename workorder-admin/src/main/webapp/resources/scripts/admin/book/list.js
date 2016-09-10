/**
 * 查询用户列表
 */
function queryUserList() {
	document.bookQueryForm.orderby.value = DEFAULT_USER_QUERY_LIST_ORDER_BY;
	document.bookQueryForm.order.value = DEFAULT_USER_QUERY_LIST_ORDER;
	document.bookQueryForm.currentPage.value = 1;
	document.bookQueryForm.submit();
}