var roleResourceZTreeObj = null;
var roleResourceZTreeSetting = {
	simpleData: {
		enable: true,
		idKey: 'id',
		pIdKey: 'pId',
		rootPid: DEFAULT_ROOT_RESOURCE_ID
	},
	check: {
		enable: true,
		chkStyle: "checkbox",
		chkboxType: { "Y": "p", "N": "ps" }
	},
	async: {
		enable: true,
		url: CONTEXT_PATH + "/xadmin/role/resources",
		otherParam: {roleId: function(){return document.roleResourceConfigForm.roleId.value;}}
	},
	callback: {
		onClick: function(event, treeId, treeNode) {
		    //alert(treeNode.tId + ", " + treeNode.name);
		    var treeObj = $.fn.zTree.getZTreeObj(treeId);
		    var checked = !treeNode.checked;
		    treeObj.checkNode(treeNode, checked, true);
		    if(checked){
				treeObj.selectNode(treeNode, false);
			}else{
				treeObj.cancelSelectedNode(treeNode);
			}
		},
		onCheck: function(event, treeId, treeNode) {
		    //alert(treeNode.tId + ", " + treeNode.name);
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
		    var checked = treeNode.checked;
		    if(checked){
				treeObj.selectNode(treeNode, false);
			}else{
				treeObj.cancelSelectedNode(treeNode);
			}
		}
	}
};

$(function(){
	//初始化树结构
	roleResourceZTreeObj = $.fn.zTree.init($("#roleResourceZTree"), roleResourceZTreeSetting); //菜单展示树
});

/**
 * 刷新菜单树
 */
function refreshRoleResourceTree(){
	if(roleResourceZTreeObj != null){
		roleResourceZTreeObj.reAsyncChildNodes(null, 'refresh');
	}
}
/**
 * 展开全部
 */
function expandAllRoleResourceTree(){
	if(roleResourceZTreeObj != null){
		roleResourceZTreeObj.expandAll(true);
	}
}
/**
 * 全部收起
 */
function collapseAllRoleResourceTree(){
	if(roleResourceZTreeObj != null){
		roleResourceZTreeObj.expandAll(false);
	}
}
/**
 * 配置角色-资源关系
 * @param el
 */
function configRoleResource(el){
	el = $(el);
	var selectedResourceIds = [];
	var selectedNodes = roleResourceZTreeObj.getCheckedNodes(true);
	if(selectedNodes && selectedNodes.length){
		for(var i = 0, len = selectedNodes.length; i < len; i++){
			selectedResourceIds.push(selectedNodes[i].id);
		}
	}
	document.roleResourceConfigForm.resourceIds.value = selectedResourceIds.join(",");
	if(confirm('你确定要保存该角色-资源配置?')){
		showLoadingText(el);
		setTimeout(function(){
			$.ajax({
				async : true,
				cache : false,
				type : 'post',
				dataType : 'json',
				data : $(document.roleResourceConfigForm).serialize(),
				url : document.roleResourceConfigForm.action,
				success: function(response){
					showOrginalText(el);
					if (response) {
						if(response.success){
							refreshRoleResourceTree();
						}
						alert(response.message);
					} else {
						alert('请求失败!');
					}
				},
				error: function(){
					showOrginalText(el);
					alert('请求失败!');
				}
			});
		},1000);
	}
}