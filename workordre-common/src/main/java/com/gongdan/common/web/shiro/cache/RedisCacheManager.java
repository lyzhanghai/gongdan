package com.gongdan.common.web.shiro.cache;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.util.Assert;

public class RedisCacheManager implements CacheManager, InitializingBean, DisposableBean {

	private static final Map<String,Cache<String,Object>> CACHES = new HashMap<String,Cache<String,Object>>();
	
	private RedisTemplate<String,Object> redisTemplate;
	
	private boolean cacheExpire = false;
	
	private int cacheExpireSeconds = 1800;
	
	public void setRedisTemplate(RedisTemplate<String, Object> redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

	public void setCacheExpire(boolean cacheExpire) {
		this.cacheExpire = cacheExpire;
	}

	public void setCacheExpireSeconds(int cacheExpireSeconds) {
		this.cacheExpireSeconds = cacheExpireSeconds;
	}

	@SuppressWarnings("unchecked")
	public Cache<String,Object> getCache(String cacheName) throws CacheException {
		if(!CACHES.containsKey(cacheName)){
			synchronized (CACHES) {
				if(!CACHES.containsKey(cacheName)){
					CACHES.put(cacheName, new RedisCache(cacheName, redisTemplate, cacheExpire, cacheExpireSeconds));
				}
			}
		}
		return CACHES.get(cacheName);
	}

	public void destroy() {
		CACHES.clear();
	}

	public void afterPropertiesSet() throws Exception {
		Assert.notNull(redisTemplate, "Property 'redisTemplate' can not be null!");
	}
	
}
