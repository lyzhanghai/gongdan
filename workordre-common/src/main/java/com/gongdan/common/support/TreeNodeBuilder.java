package com.gongdan.common.support;
/**
 * 树结构单个节点的json数据构造接口
 * 
 * @param <T>
 * @author pengpeng
 * @date 2013-10-14 下午11:36:07
 * @version 1.0
 */
public interface TreeNodeBuilder<T> {

	public void build4Leaf(T treeNode, StringBuilder sb);
	
	public void build4Folder(T treeNode, StringBuilder sb);
	
}
