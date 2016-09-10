/**
 * 初始化treetable
 */
$("#menu-table").treetable({
	column: 1,
	expandable: true,
	initialState: 'expanded'
});
/**
 * 查询菜单列表
 */
function refreshMenuTree(){
	document.menuQueryForm.submit();
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
function toAddMenu(el){
	var $selectedTR = $(el).closest("table").find("tbody tr.selected");
	var parentMenuId = $selectedTR.attr('data-tt-id');
	if(!parentMenuId){
		alert('请先选择父级菜单!');
		return;
	}
	var parentMenuType = $selectedTR.attr("data-menu-type");
	if(WEIXIN_MENU_TYPE_LV2.typeCode == parentMenuType){
		alert('二级菜单下不允许再建子菜单!');
		return;
	}else if(WEIXIN_MENU_TYPE_LV1.typeCode == parentMenuType){
		var lv2Menus = $(el).closest("table").find("tbody tr[data-tt-parent-id='" + parentMenuId + "']").length;
		if(lv2Menus >= WEIXIN_MENU_TYPE_LV1.allowedMaxSubMenus){
			alert(WEIXIN_MENU_TYPE_LV1.typeName + '下最多只能有' + WEIXIN_MENU_TYPE_LV1.allowedMaxSubMenus + '个子菜单!');
			return;
		}
	}else if(WEIXIN_MENU_TYPE_LV0.typeCode == parentMenuType){
		var lv1Menus = $(el).closest("table").find("tbody tr[data-tt-parent-id='" + parentMenuId + "']").length;
		if(lv1Menus >= WEIXIN_MENU_TYPE_LV0.allowedMaxSubMenus){
			alert(WEIXIN_MENU_TYPE_LV0.typeName + '下最多只能有' + WEIXIN_MENU_TYPE_LV0.allowedMaxSubMenus + '个子菜单!');
			return;
		}
	}
	window.location.href = CONTEXT_PATH + '/admin/weixin/menu/add?parentMenuId=' + parentMenuId;
}
/**
 * 去编辑节点页面
 * @param el
 */
function toEditMenu(el){
	var $selectedTR = $(el).closest("table").find("tbody tr.selected");
	var parentMenuId = $selectedTR.attr('data-tt-parent-id') || '';
	var menuId = $selectedTR.attr('data-tt-id') || '';
	if(parentMenuId == DEFAULT_ADMIN_ROOT_MENU_ID){
		alert('根菜单不能修改!');
		return;
	}
	if(menuId){
		window.location.href = CONTEXT_PATH + '/admin/weixin/menu/edit?id=' + menuId;
	}else{
		alert('请选择需要修改的菜单!');
	}
}
/**
 * 删除所选资源
 * @param el
 * @param menuId
 */
function delMenu(el){
	var $selectedTR = $(el).closest("table").find("tbody tr.selected");
	var parentMenuId = $selectedTR.attr('data-tt-parent-id') || '';
	var menuId = $selectedTR.attr('data-tt-id') || '';
	if(parentMenuId == DEFAULT_ADMIN_ROOT_MENU_ID){
		alert('根菜单不能删除!');
		return;
	}
	if(menuId){
		if(confirm('你确定要删除所选菜单及其子菜单吗?') && isSubmitable(el)){
			$.ajax({
				async : true,
				cache : false,
				type : 'post',
				dataType : 'json',
				data : 'id=' + menuId,
				url : CONTEXT_PATH + '/admin/weixin/menu/del',
				success : function(response) {
					if (response) {
						alert(response.message);
						if(response.success) {
							refreshMenuTree();
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
		alert('请选择需要删除的菜单!');
	}
}

/**
 * 立即发布菜单到微信
 */
function publishMenuTree(el) {
	if(confirm('你确定要立即发布菜单到微信吗?') && isSubmitable(el)){
		showLoadingText(el);
		setTimeout(function(){
			$.ajax({
				async : true,
				cache : false,
				type : 'post',
				dataType : 'json',
				data : null,
				url : CONTEXT_PATH + '/admin/weixin/menu/pub',
				success : function(response) {
					showOrginalText(el);
					if (response) {
						alert(response.message);
						if(response.success) {
							refreshMenuTree();
						}
					} else {
						alert('请求失败!');
					}
					afterSubmited(el);
				},
				error : function() {
					alert('请求失败!');
					afterSubmited(el);
					showOrginalText(el);
				}
			});
		});
	}
}