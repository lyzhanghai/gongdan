package com.gongdan.common.support;

import java.util.concurrent.TimeUnit;

/**
 * 统一缓存定义模型
 * 
 * @author  pengpeng
 * @date 	 2015年8月7日 下午1:27:13
 * @version 1.0
 */
public class CacheDefinition {

	private String cacheKey;
	
	private String description;

	/** 0代表不过期 */
	private long expireTime = 0;
	
	private TimeUnit timeUnit = TimeUnit.SECONDS;
	
	public CacheDefinition() {
		super();
	}

	public CacheDefinition(String cacheKey, String description) {
		super();
		this.cacheKey = cacheKey;
		this.description = description;
	}

	public CacheDefinition(String cacheKey, String description, long expireTime) {
		super();
		this.cacheKey = cacheKey;
		this.description = description;
		this.expireTime = expireTime;
	}

	public CacheDefinition(String cacheKey, String description,
			long expireTime, TimeUnit timeUnit) {
		super();
		this.cacheKey = cacheKey;
		this.description = description;
		this.expireTime = expireTime;
		this.timeUnit = timeUnit;
	}

	public String getCacheKey() {
		return cacheKey;
	}

	public void setCacheKey(String cacheKey) {
		this.cacheKey = cacheKey;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getExpireTime() {
		return expireTime;
	}

	public void setExpireTime(long expireTime) {
		this.expireTime = expireTime;
	}

	public TimeUnit getTimeUnit() {
		return timeUnit;
	}

	public void setTimeUnit(TimeUnit timeUnit) {
		this.timeUnit = timeUnit;
	}

	public static CacheDefinition valueOf(String cacheKey, String description, long expireTime, TimeUnit timeUnit) {
		return new CacheDefinition(cacheKey, description, expireTime, timeUnit);
	}
	
	public static CacheDefinition valueOf(String cacheKey, String description, long expireTime) {
		return new CacheDefinition(cacheKey, description, expireTime);
	}
	
	public static CacheDefinition valueOf(String cacheKey, String description) {
		return new CacheDefinition(cacheKey, description);
	}
	
}
