package com.gongdan.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.gongdan.common.entity.SysConfigInfo;
import com.gongdan.common.redis.RedisClientTemplate;
import com.gongdan.dao.SysConfigDao;
import com.gongdan.service.SysConfigService;


@Service("sysConfigServiceImpl")
public class SysConfigServiceImpl implements SysConfigService{

	@Autowired
	private SysConfigDao configDao;
	
	@Resource(name="redisClientTemplate")
	private RedisClientTemplate redisTemplate;
	
	
	@Override
	public SysConfigInfo queryConfigByTypeAndKey(Integer type, String key) {
		String info  = redisTemplate.get("SysConfigInfo_"+type+"_"+key);
		if(StringUtils.isNotEmpty(info)){
			return JSON.parseObject(info, SysConfigInfo.class);
		}
		SysConfigInfo config  = configDao.querySysConfigInfo(key, type);
		//
		if(null != config){
			redisTemplate.expire("SysConfigInfo_"+type+"_"+key, 3600);
			redisTemplate.set("SysConfigInfo_"+type+"_"+key, JSON.toJSONString(config));
		}
	
		return config;
	}

	@Override
	public List<SysConfigInfo> queryConfigListByType(Integer type) {
		
		String info  = redisTemplate.get("SysConfigInfo_List_"+type);
		if(null != info){
			return JSON.parseArray(info, SysConfigInfo.class);
		}
		List<SysConfigInfo> configs  = configDao.querySysConfigInfoList(type);
		redisTemplate.expire("SysConfigInfo_"+type, 3600);
		redisTemplate.set("SysConfigInfo_"+type, JSON.toJSONString(configs));
		return configs;
	}

}
