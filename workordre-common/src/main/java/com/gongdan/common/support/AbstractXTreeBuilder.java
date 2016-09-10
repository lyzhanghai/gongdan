package com.gongdan.common.support;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.util.Assert;

import com.gongdan.common.utils.CollectionUtils;
import com.gongdan.common.utils.ObjectUtils;


/**
 * 构造java或json树形数据的抽象基类
 * 
 * @param <I>
 * @param <T>
 * @author	  	pengpeng
 * @date	  	2014年7月28日 下午9:48:05
 * @version  	1.0
 */
public abstract class AbstractXTreeBuilder<I, T extends Comparable<T>> implements XTreeBuilder<I, T> {

	private String jsonChildPropertyName = "children";
	
	protected String getJsonChildPropertyName() {
		return jsonChildPropertyName;
	}

	public void setJsonChildPropertyName(String jsonChildPropertyName) {
		this.jsonChildPropertyName = jsonChildPropertyName;
	}

	public String buildJsonTree(I rootTreeObjId, List<T> allTreeObjList, TreeNodeBuilder<T> treeNodeBuilder) {
		Assert.notNull(rootTreeObjId, "Parameter[rootTreeObjId] can not be empty!");
		List<T> rootLevelTreeObjList = buildObjectTree(rootTreeObjId, allTreeObjList);
		StringBuilder sb = new StringBuilder();
		sb.append("[");
		if(!CollectionUtils.isEmpty(rootLevelTreeObjList)){
			for(T rootLevelTreeObj : rootLevelTreeObjList){
				recurisiveLoadJsonTree(rootLevelTreeObj, treeNodeBuilder, sb);
			}
		}
		sb.append("]");
		return sb.toString().replace("},]", "}]");
	}

	public List<T> buildObjectTree(I rootTreeObjId, List<T> allTreeObjList) {
		Assert.notNull(rootTreeObjId, "Parameter[rootTreeObjId] can not be empty!");
		List<T> rootLevelTreeObjList = null;
		T rootTreeObj = getTreeObjectById(rootTreeObjId, allTreeObjList);
		if(rootTreeObj != null){
			rootLevelTreeObjList = new ArrayList<T>();
			rootLevelTreeObjList.add(rootTreeObj);
		}else{
			rootLevelTreeObjList = getDirectChildMenuList(rootTreeObjId, allTreeObjList);
		}
		if(!CollectionUtils.isEmpty(rootLevelTreeObjList)){
			for(T rootLevelTreeObj : rootLevelTreeObjList){
				recurisiveLoadChilds(rootLevelTreeObj, allTreeObjList);
			}
		}
		return rootLevelTreeObjList;
	}

	/**
	 * <p>递归构造对象树</p>
	 * 
	 * @param currentTreeObj
	 * @param allTreeObjList
	 */
	public void recurisiveLoadChilds(T currentTreeObj, List<T> allTreeObjList) {
		if(currentTreeObj != null && !CollectionUtils.isEmpty(allTreeObjList)){
			List<T> directChildList = getDirectChildMenuList(getTreeObjectId(currentTreeObj), allTreeObjList);
			if(!CollectionUtils.isEmpty(directChildList)){
				Collections.sort(directChildList);
			}
			setSubTreeObjectList(currentTreeObj, directChildList);
			if(!CollectionUtils.isEmpty(directChildList)){
				for(T childTreeObj : directChildList){
					recurisiveLoadChilds(childTreeObj, allTreeObjList);
				}
			}
		}
	}
	
	/**
	 * <p>递归加载json树形结构数据</p>
	 * 
	 * @param currentTreeObj
	 * @param treeNodeBuilder
	 * @param sb
	 */
	protected void recurisiveLoadJsonTree(T currentTreeObj, TreeNodeBuilder<T> treeNodeBuilder, StringBuilder sb) {
		if(currentTreeObj != null){
			List<T> subTreeObjectList = getSubTreeObjectList(currentTreeObj);
			boolean isLeaf = CollectionUtils.isEmpty(subTreeObjectList);
			if(isLeaf){
				sb.append("{");
				treeNodeBuilder.build4Leaf(currentTreeObj, sb);
				sb.append("},");
			}else{
				sb.append("{");
				treeNodeBuilder.build4Folder(currentTreeObj, sb);
				sb.append("," + getJsonChildPropertyName() + ":[");
				for(T treeObj : subTreeObjectList){
					recurisiveLoadJsonTree(treeObj, treeNodeBuilder, sb);
				}
				sb.append("]},");
			}
		}
	}

	protected T getTreeObjectById(I treeObjId, List<T> allTreeObjList) {
		if(CollectionUtils.isEmpty(allTreeObjList) || ObjectUtils.isEmpty(treeObjId)){
			return null;
		}
		for(T treeObj : allTreeObjList){
			if(treeObj != null && treeObjId.equals(getTreeObjectId(treeObj))){
				return treeObj;
			}
		}
		return null;
	}
	
	protected List<T> getDirectChildMenuList(I parentTreeObjId, List<T> allTreeObjList) {
		if(CollectionUtils.isEmpty(allTreeObjList) || ObjectUtils.isEmpty(parentTreeObjId)){
			return null;
		}
		List<T> childList = new ArrayList<T>();
		for(T treeObj : allTreeObjList){
			if(treeObj != null && parentTreeObjId.equals(getParentTreeObjectId(treeObj))){
				childList.add(treeObj);
			}
		}
		return childList.isEmpty() ? null : childList;
	}
	
	protected abstract I getParentTreeObjectId(T treeObj);
	
	protected abstract I getTreeObjectId(T treeObj);
	
	protected abstract void setSubTreeObjectList(T treeObj, List<T> directChildList);
	
	protected abstract List<T> getSubTreeObjectList(T treeObj);

}
