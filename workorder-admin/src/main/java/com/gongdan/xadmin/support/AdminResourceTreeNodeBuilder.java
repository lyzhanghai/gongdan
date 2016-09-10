package com.gongdan.xadmin.support;

import java.util.HashMap;
import java.util.Map;

import com.gongdan.common.support.TreeNodeBuilder;
import com.gongdan.common.utils.JsonUtils;
import com.gongdan.xadmin.consts.XAdminConstants;
import com.gongdan.xadmin.model.AdminResource;

/**
 * 资源数节点builder
 * 
 * @author	  	pengpeng
 * @date	  	2015年11月15日 下午8:03:51
 * @version  	1.0
 */
public class AdminResourceTreeNodeBuilder implements TreeNodeBuilder<AdminResource> {

	private static final String format = "id: \"%s\", name: \"%s\", pId: \"%s\", isParent: %s, open: %s, checked: %s, resourceType: \"%s\",treeNodeObj: %s";
	
	public AdminResourceTreeNodeBuilder() {
		super();
	}
	
	public void build4Leaf(AdminResource treeNode, StringBuilder sb) {
		boolean open = XAdminConstants.DEFAULT_XADMIN_ROOT_RESOURCE_ID.equals(treeNode.getParentResourceId());
		try {
			sb.append(String.format(format, treeNode.getResourceId(), treeNode.getResourceName(), treeNode.getParentResourceId(), false, open, treeNode.isChecked(), treeNode.getResourceType(), JsonUtils.object2Json(getResourceMap(treeNode))));
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}
	public void build4Folder(AdminResource treeNode, StringBuilder sb) {
		boolean open = XAdminConstants.DEFAULT_XADMIN_ROOT_RESOURCE_ID.equals(treeNode.getParentResourceId());
		try {
			sb.append(String.format(format, treeNode.getResourceId(), treeNode.getResourceName(), treeNode.getParentResourceId(), true, open, treeNode.isChecked(), treeNode.getResourceType(), JsonUtils.object2Json(getResourceMap(treeNode))));
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}
	
	protected Map<String,Object> getResourceMap(AdminResource resource) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("resourceId", resource.getResourceId());
		map.put("resourceName", resource.getResourceName());
		map.put("parentResourceId", resource.getParentResourceId());
		return map;
	}
}