/**
 * 模糊查询列表
 */
function queryKnowledgeList(){
	document.knowledgeQueryForm.orderby.value = DEFAULT_KNOWLEDGE_QUERY_LIST_ORDER_BY;
	document.knowledgeQueryForm.order.value = DEFAULT_KNOWLEDGE_QUERY_LIST_ORDER;
	document.knowledgeQueryForm.currentPage.value = 1;
	document.knowledgeQueryForm.submit();
}

/**
 * 删除知识
 * @param el
 * @param id
 */
function delKnowledge(el, id){
	el = $(el);
	if(confirm('你确定要删除所选知识吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/knowledge/delete',
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