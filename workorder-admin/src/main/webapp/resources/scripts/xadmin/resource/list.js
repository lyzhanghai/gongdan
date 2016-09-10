/**
 * 初始化treetable
 */
$("#resource-table").treetable({
	column: 1,
	expandable: true,
	initialState: 'expanded'
});
/**
 * 查询角色列表
 */
function refreshResourceTree(){
	document.resourceQueryForm.submit();
}
/**
 * 选中行
 * @param el
 */
function selectThisRow(el){
	el = $(el);
	el.closest("tbody").find("tr").removeClass("selected");
	el.closest("tr").addClass("selected");
}
/**
 * 去新增节点页面
 * @param el
 */
function toAddResource(el){
	var parentResourceId = $(el).closest("table").find("tbody tr.selected").attr('data-tt-id') || '';
	window.location.href = CONTEXT_PATH + '/xadmin/resource/add?parentResourceId=' + parentResourceId;
}
/**
 * 去编辑节点页面
 * @param el
 */
function toEditResource(el){
	var $selectedTR = $(el).closest("table").find("tbody tr.selected");
	var parentResourceId = $selectedTR.attr('data-tt-parent-id') || '';
	var resourceId = $selectedTR.attr('data-tt-id') || '';
	if(parentResourceId == DEFAULT_ROOT_RESOURCE_ID){
		alert('根资源不能修改!');
		return;
	}
	if(resourceId){
		window.location.href = CONTEXT_PATH + '/xadmin/resource/edit?id=' + resourceId;
	}else{
		alert('请选择需要修改的资源!');
	}
}
/**
 * 删除所选资源
 * @param el
 * @param resourceId
 */
function delResource(el){
	var $selectedTR = $(el).closest("table").find("tbody tr.selected");
	var resourceId = $selectedTR.attr('data-tt-id') || '';
	var parentResourceId = $selectedTR.attr('data-tt-parent-id') || '';
	if(parentResourceId == DEFAULT_ROOT_RESOURCE_ID){
		alert('根资源不能删除!');
		return;
	}
	if(resourceId){
		if(confirm('你确定要删除所选资源及其子资源吗?') && isSubmitable(el)){
			$.ajax({
				async : true,
				cache : false,
				type : 'post',
				dataType : 'json',
				data : 'id=' + resourceId,
				url : CONTEXT_PATH + '/xadmin/resource/del',
				success : function(response) {
					if (response) {
						alert(response.message);
						if(response.success) {
							refreshResourceTree();
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
	}else{
		alert('请选择需要删除的资源!');
	}
}