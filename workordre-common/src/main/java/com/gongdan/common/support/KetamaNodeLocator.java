package com.gongdan.common.support;

import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

public class KetamaNodeLocator implements NodeLocator {

	public static final int DEFAULT_VIRTUAL_NODES = 160;
	
	private HashAlgorithm hashAlg = HashAlgorithm.KETAMA_HASH;
	
	private int virtualNodes = DEFAULT_VIRTUAL_NODES;
	
	private volatile TreeMap<Long,Node> ketamaNodes;
	
	public KetamaNodeLocator() {
		super();
	}
	
	public KetamaNodeLocator(List<Node> nodeList) {
		super();
		refreshLocator(nodeList);
	}
	
	public KetamaNodeLocator(int virtualNodes) {
		super();
		this.virtualNodes = virtualNodes;
	}
	
	public KetamaNodeLocator(int virtualNodes, List<Node> nodeList) {
		super();
		this.virtualNodes = virtualNodes;
		refreshLocator(nodeList);
	}

	public Node getNodeByKey(final String key) {
		if(key == null || ketamaNodes == null || ketamaNodes.isEmpty()){
			return null;
		}
		long hash = hashAlg.hash(key);
		return getNodeByHash(hash);
	}
	
	protected Node getNodeByHash(long hash) {
		TreeMap<Long,Node> ketamaNodes = this.ketamaNodes;
		if(ketamaNodes == null || ketamaNodes.isEmpty()) {
			return null;
		}
		Long key = hash;
		if (!ketamaNodes.containsKey(hash)) {
			SortedMap<Long,Node> tailMap = ketamaNodes.tailMap(hash);
			if(tailMap.isEmpty()) {
				key=ketamaNodes.firstKey();
			} else {
				key=tailMap.firstKey();
			}
			//For JDK1.6 version
			/*key = ketamaNodes.ceilingKey(key);
			if (key == null) {
				key = ketamaNodes.firstKey();
			}*/
		}
		return ketamaNodes.get(key);
	} 

	public void refreshLocator(final List<Node> nodeList) {
		TreeMap<Long,Node> ketamaNodes = new TreeMap<Long,Node>();
		if(nodeList != null && !nodeList.isEmpty()){
			for (Node node : nodeList) {
				for (int i = 0; i < virtualNodes / 4; i++) {
					byte[] digest = HashAlgorithm.computeMd5(node.getNodeId() + "-" + i);
					for (int h = 0; h < 4; h++) {
						long k = (long) (digest[3 + h * 4] & 0xFF) << 24
								| (long) (digest[2 + h * 4] & 0xFF) << 16
								| (long) (digest[1 + h * 4] & 0xFF) << 8
								| digest[h * 4] & 0xFF;
						ketamaNodes.put(k, node);
					}
				}
			}
		}
		this.ketamaNodes = ketamaNodes;
	}
	
}
