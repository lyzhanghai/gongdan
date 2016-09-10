/**
 * 删除该团体
 * @param el
 * @param id
 */
function delGroup(el, id){
	el = $(el);
	if(confirm('你确定要删除所选团体吗?') && isSubmitable(el)){
		$.ajax({
			async : true,
			cache : false,
			type : 'post',
			dataType : 'json',
			data : 'id=' + id,
			url : CONTEXT_PATH + '/admin/volunteer/group/del',
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