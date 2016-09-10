var resourceEditFormValidator = null;
var resourceSelectZTreeObj = null;
var resourceZTreeSetting = null;
/**
 * 文档装载完毕
 */
$(function(){
	resourceSelectZTreeObj = $.fn.zTree.init($("#resourceTree"), resourceZTreeSetting); //菜单新增或更新form中的菜单下拉树
});

var validateOptions = {
	rules: {
		parentResourceId: {
			required: true
		},
		resourceId: {
			required: true
		},
		resourceName: {
			required: true
		},
		permissionExpression: {
			regex: /^\w+(\:\w+){1,2}$/
		},
		actionType: {
			required: true
		},
		siblingsIndex: {
			required: true,
			digits: true
		}
	},
	messages: {
		parentResourceId: {
			required: '请选择父级资源!'
		},
		resourceId: {
			required: '未发现资源ID!'
		},
		resourceName: {
			required: '请输入资源名称!'
		},
		permissionExpression: {
			regex: '请输入合法的权限表达式!'
		},
		actionType: {
			required: '请选择资源类型!'
		},
		siblingsIndex: {
			required: '请输入资源排序号!',
			digits: '资源排序号必须是整数!'
		}
	}
};

resourceEditFormValidator = $(document.resourceEditForm).validate(validateOptions);

resourceZTreeSetting = {
	simpleData: {
		enable: true,
		idKey: 'id',
		pIdKey: 'pId',
		rootPid: DEFAULT_ROOT_RESOURCE_ID
	},
	check: {
		enable: true,
		chkStyle: "radio",
		radioType: "all"
	},
	async: {
		enable: true,
		url: CONTEXT_PATH + "/xadmin/resource/available",
		otherParam: {resourceId: document.resourceEditForm.parentResourceId.value}
	},
	callback: {
		onClick: function(event, treeId, treeNode) {
		    //alert(treeNode.tId + ", " + treeNode.name);
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
			var checked = !treeNode.checked;
			
			var currentEditTreeNode = treeObj.getNodeByParam("id", document.resourceEditForm.resourceId.value);
			var findNodeObj = treeObj.getNodeByParam("id", treeNode.id, currentEditTreeNode);
			if(currentEditTreeNode.id == treeNode.id || findNodeObj != null){
				alert('不能选择被更新资源节点自身及其子节点作为其父资源节点!');
				treeObj.cancelSelectedNode(treeNode);
				return;
			}
			
			treeObj.checkNode(treeNode, checked, false, true);
		    document.resourceEditForm.parentResourceId.value = checked ? treeNode.treeNodeObj.resourceId : '';
		    document.resourceEditForm.parentResourceName.value = checked ? treeNode.treeNodeObj.resourceName : '';
		    resourceEditFormValidator.element($(document.resourceEditForm.parentResourceId)); // call jquery.validate.js validate immediately
		},
		onCheck: function(event, treeId, treeNode) {
		    //alert(treeNode.tId + ", " + treeNode.name);
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
		    var checked = treeNode.checked;
		    
		    var currentEditTreeNode = treeObj.getNodeByParam("id", document.resourceEditForm.resourceId.value);
			var findNodeObj = treeObj.getNodeByParam("id", treeNode.id, currentEditTreeNode);
			if(currentEditTreeNode.id == treeNode.id || findNodeObj != null){
				alert('不能选择被更新资源节点自身及其子节点作为其父资源节点!');
				treeObj.cancelSelectedNode(treeNode);
				return;
			}
		    
			if(checked){
				treeObj.selectNode(treeNode, false);
			}else{
				treeObj.cancelSelectedNode(treeNode);
			}
			document.resourceEditForm.parentResourceId.value = checked ? treeNode.treeNodeObj.resourceId : '';
		    document.resourceEditForm.parentResourceName.value = checked ? treeNode.treeNodeObj.resourceName : '';
		    resourceEditFormValidator.element($(document.resourceEditForm.parentResourceId)); // call jquery.validate.js validate immediately
		}
	}
};

/**
 * 保存资源
 */
function saveResource(el){
	var valid = resourceEditFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.resourceEditForm.submit();
		},1000);
	}
}