package com.gongdan.service;

import java.util.List;

import com.gongdan.common.entity.SysConfigInfo;

public interface SysConfigService {

	
	public SysConfigInfo queryConfigByTypeAndKey(Integer type,String key);
	
	
	public List<SysConfigInfo> queryConfigListByType(Integer type);
}
