var resourceAddFormValidator = null;
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

resourceAddFormValidator = $(document.resourceAddForm).validate(validateOptions);

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
		otherParam: {resourceId: document.resourceAddForm.parentResourceId.value}
	},
	callback: {
		onClick: function(event, treeId, treeNode) {
		    //alert(treeNode.tId + ", " + treeNode.name);
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
			var checked = !treeNode.checked;
			treeObj.checkNode(treeNode, checked, false, true);
		    document.resourceAddForm.parentResourceId.value = checked ? treeNode.treeNodeObj.resourceId : '';
		    document.resourceAddForm.parentResourceName.value = checked ? treeNode.treeNodeObj.resourceName : '';
		    resourceAddFormValidator.element($(document.resourceAddForm.parentResourceId)); // call jquery.validate.js validate immediately
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
			document.resourceAddForm.parentResourceId.value = checked ? treeNode.treeNodeObj.resourceId : '';
		    document.resourceAddForm.parentResourceName.value = checked ? treeNode.treeNodeObj.resourceName : '';
		    resourceAddFormValidator.element($(document.resourceAddForm.parentResourceId)); // call jquery.validate.js validate immediately
		}
	}
};

/**
 * 新增资源
 */
function saveResource(el){
	var valid = resourceAddFormValidator.form();
	if(valid){
		showLoadingText(el);
		setTimeout(function(){
			document.resourceAddForm.submit();
		},1000);
	}
}