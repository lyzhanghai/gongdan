package com.gongdan.common.support;

import java.util.List;
/**
 * 构造java或json树形数据的builder
 * 
 * @param <I>
 * @param <T>
 * @author	  	pengpeng
 * @date	  	2014年7月28日 下午9:46:03
 * @version  	1.0
 */
public interface XTreeBuilder<I,T extends Comparable<T>> {

	/**
	 * <p>
	 * 	1、根据根节点id[rootTreeObjId]即所有节点数据[allTreeObjList]调用buildObjectTree方法来构造一个具有父子树形关系的allTreeObjList
	 *  2、然后将allTreeObjList通过递归构造出最终的json树形数据
	 * </p>
	 * 
	 * @param rootTreeObjId
	 * @param allTreeObjList
	 * @param treeNodeBuilder
	 * @return
	 */
	public String buildJsonTree(I rootTreeObjId, List<T> allTreeObjList, TreeNodeBuilder<T> treeNodeBuilder);
	
	public List<T> buildObjectTree(I rootTreeObjId, List<T> allTreeObjList);
	
}
