/**
 * 查询消息列表
 */
function queryMessageList(){
	document.messageQueryForm.orderby.value = DEFAULT_WEIXIN_MESSAGE_QUERY_LIST_ORDER_BY;
	document.messageQueryForm.order.value = DEFAULT_WEIXIN_MESSAGE_QUERY_LIST_ORDER;
	document.messageQueryForm.currentPage.value = 1;
	document.messageQueryForm.submit();
}

function delMessage(el, id){
	if(confirm('你确定要删除该条消息?')){
		window.location.href = CONTEXT_PATH + '/admin/weixin/message/del?id=' + id;
	}
}