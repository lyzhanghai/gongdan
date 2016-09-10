package com.gongdan.common.redis.serializer;

import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.SerializationException;

import com.gongdan.common.serializer.ObjectSerializer;
import com.gongdan.common.serializer.protostuff.ProtostuffSerializer;

/**
 * Spring-Data-Redis序列化类
 * 
 * @author  pengpeng
 * @date 	 2015年4月10日 下午3:27:26
 * @version 1.0
 */
public class ProtostuffRedisSerializer implements RedisSerializer<Object> {

	private ObjectSerializer objectSerializer = new ProtostuffSerializer();
	
	public byte[] serialize(Object object) throws SerializationException {
		if(object != null){
			return objectSerializer.serialize(object);
		}
		return null;
	}

	public Object deserialize(byte[] bytes) throws SerializationException {
		if(bytes == null || bytes.length == 0){
			return null;
		}
		return objectSerializer.deserialize(bytes);
	}

}
