package com.gongdan.xadmin.support;

import java.util.List;

import com.gongdan.common.support.AbstractXTreeBuilder;
import com.gongdan.xadmin.model.AdminResource;

/**
 * 资源树结构builder
 * 
 * @author	  	pengpeng
 * @date	  	2015年11月15日 下午8:04:19
 * @version  	1.0
 */
public class AdminResourceTreeBuilder extends AbstractXTreeBuilder<Long, AdminResource> {

	protected Long getParentTreeObjectId(AdminResource treeObj) {
		return treeObj.getParentResourceId();
	}

	protected Long getTreeObjectId(AdminResource treeObj) {
		return treeObj.getResourceId();
	}

	protected void setSubTreeObjectList(AdminResource treeObj, List<AdminResource> directChildList) {
		treeObj.setSubResourceList(directChildList);
	}

	protected List<AdminResource> getSubTreeObjectList(AdminResource treeObj) {
		return treeObj.getSubResourceList();
	}

}
