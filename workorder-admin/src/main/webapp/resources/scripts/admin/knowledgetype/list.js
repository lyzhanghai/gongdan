/**
 * 查询知识类别列表
 */
function queryKnowledgeTypeList(){
	document.knowledgeTypeQueryForm.orderby.value = DEFAULT_KNOWLEDGETYPE_QUERY_LIST_ORDER_BY;
	document.knowledgeTypeQueryForm.order.value = DEFAULT_KNOWLEDGETYPE_QUERY_LIST_ORDER;
	document.knowledgeTypeQueryForm.currentPage.value = 1;
	document.knowledgeTypeQueryForm.submit();
}
/**
 * 删除知识类别
 * @param el
 */
function delknowledgetype(el, knowledgeTypeId){
	el = $(el);
	if(confirm('你确定要删除所选知识类别吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + knowledgeTypeId,
			url : CONTEXT_PATH + '/admin/knowledgetype/delete',
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