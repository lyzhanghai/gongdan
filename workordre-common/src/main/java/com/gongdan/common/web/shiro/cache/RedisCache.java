package com.gongdan.common.web.shiro.cache;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.SessionCallback;
import org.springframework.util.Assert;

/**
 * 基于Redis缓存的Cache实现
 * 
 * @author	  	pengpeng
 * @date	  	2015年1月30日 下午2:25:51
 * @version  	1.0
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
public class RedisCache implements Cache<String, Object> {

	/**
	 * 相当于存在redis中的key的prefix
	 */
	private final String cacheName;
	
	private RedisTemplate<String,Object> redisTemplate;
	
	private boolean cacheExpire;
	
	private int cacheExpireSeconds;
	
	public RedisCache(String cacheName, RedisTemplate<String, Object> redisTemplate) {
		super();
		Assert.hasText(cacheName, "Parameter 'cacheName' can not be empty!");
		Assert.notNull(redisTemplate, "Parameter 'redisTemplate' can not be null!");
		this.cacheName = cacheName;
		this.redisTemplate = redisTemplate;
	}
	public RedisCache(String cacheName, RedisTemplate<String, Object> redisTemplate, boolean cacheExpire, int cacheExpireSeconds) {
		this(cacheName, redisTemplate);
		this.cacheExpire = cacheExpire;
		this.cacheExpireSeconds = cacheExpireSeconds;
	}

	public Object get(final String key) throws CacheException {
		String realKey = key(key);
		if(cacheExpire){ //touch
			redisTemplate.expire(realKey, cacheExpireSeconds, TimeUnit.SECONDS);
		}
		Object value = redisTemplate.opsForValue().get(realKey);
		return value;
	}

	public Object put(final String key, final Object value) throws CacheException {
		final String realKey = key(key);
		return redisTemplate.execute(new SessionCallback<Object>(){
			public Object execute(RedisOperations operations) throws DataAccessException {
				operations.multi();//事务开启
				operations.opsForValue().get(realKey);
				if(cacheExpire){
					operations.opsForValue().set(realKey, value, cacheExpireSeconds, TimeUnit.SECONDS);
				}else{
					operations.opsForValue().set(realKey, value);
				}
				List<Object> results = operations.exec(); //结束事务
				return results.get(0);
			}
		});
	}

	public Object remove(final String key) throws CacheException {
		final String realKey = key(key);
		return redisTemplate.execute(new SessionCallback<Object>(){
			public Object execute(RedisOperations operations) throws DataAccessException {
				operations.multi();//事务开启
				operations.opsForValue().get(realKey);
				operations.delete(realKey);
				List<Object> results = operations.exec(); //结束事务
				return results.get(0);
			}
		});
	}

	public void clear() throws CacheException {
		String pattern = key("*");
		redisTemplate.delete(redisTemplate.keys(pattern));
	}

	public int size() {
		String pattern = key("*");
		return redisTemplate.keys(pattern).size();
	}

	public Set<String> keys() {
		String pattern = key("*");
		return redisTemplate.keys(pattern);
	}

	public Collection<Object> values() {
		String pattern = key("*");
		return redisTemplate.opsForValue().multiGet(redisTemplate.keys(pattern));
	}

	protected String key(String key) {
		return cacheName + "-" + key;
	}
	
}
