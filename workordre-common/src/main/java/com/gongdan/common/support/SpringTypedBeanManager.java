package com.gongdan.common.support;

public interface SpringTypedBeanManager<T,P> {

	public T getTypedBean(P parameter);
	
}
