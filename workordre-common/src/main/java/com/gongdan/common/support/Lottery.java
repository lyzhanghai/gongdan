package com.gongdan.common.support;

/**
 * 抽奖对象
 * 
 * @param <T>
 * @author  pengpeng
 * @date 	 2016年4月19日 下午2:18:17
 * @version 1.0
 */
public abstract class Lottery<T> implements Comparable<Lottery<T>> {
	
	public abstract T getObject();
	
	public abstract int getObjectCount();

	public int compareTo(Lottery<T> o) {
		if(o == null){
			return -1;
		}
		return this.getObjectCount() - o.getObjectCount();
	}
	
}