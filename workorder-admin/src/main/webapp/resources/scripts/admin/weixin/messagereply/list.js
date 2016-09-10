/**
 * 查询自动回复列表
 */
function queryMessageReplyList(){
	document.messageReplyQueryForm.orderby.value = DEFAULT_WEIXIN_MESSAGE_REPLY_QUERY_LIST_ORDER_BY;
	document.messageReplyQueryForm.order.value = DEFAULT_WEIXIN_MESSAGE_REPLY_QUERY_LIST_ORDER;
	document.messageReplyQueryForm.currentPage.value = 1;
	document.messageReplyQueryForm.submit();
}

/**
 * 删除自动回复
 * @param el
 * @param id
 */
function delMessageReply(el, id){
	if(id){
		if(confirm('你确定要删除该条自动回复?') && isSubmitable(el)){
			$.ajax({
				async : true,
				cache : false,
				type : 'post',
				dataType : 'json',
				data : 'id=' + id,
				url : CONTEXT_PATH + '/admin/weixin/messagereply/del',
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
}