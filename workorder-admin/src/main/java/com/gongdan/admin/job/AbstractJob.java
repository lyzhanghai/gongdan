package com.gongdan.admin.job;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.gongdan.common.support.NamedThreadFactory;

public abstract class AbstractJob implements ApplicationContextAware, DisposableBean  {

	private final static ExecutorService executorService = Executors.newCachedThreadPool(new NamedThreadFactory("gongdan-JOB"));
	
	private ApplicationContext applicationContext;
	
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.applicationContext = applicationContext;
	}
	
	public ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	public static ExecutorService getExecutorService() {
		return executorService;
	}

	public abstract void work();
	
	public void destroy() throws Exception {
		executorService.shutdown();
	}
	
}