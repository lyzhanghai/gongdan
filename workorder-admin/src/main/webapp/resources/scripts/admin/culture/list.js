/**
 * 查询Culture列表
 */
function queryCultureList(){
	document.CultureQueryForm.orderby.value = DEFAULT_CULTURE_QUERY_LIST_ORDER_BY;
	document.CultureQueryForm.order.value = DEFAULT_CULTURE_QUERY_LIST_ORDER;
	document.CultureQueryForm.currentPage.value = 1;
	document.CultureQueryForm.submit();
}

/**
 * 删除该文化动态
 * @param el
 * @param id
 */
function delCulture(el, id){
	el = $(el);
	if(confirm('你确定要删除所选文化动态吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/culture/dele',
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

function change(){
	alert("a");
	
	
}








