package com.gongdan.dao;

import java.util.List;

import com.gongdan.common.entity.SysConfigInfo;

public interface SysConfigDao {
	
	public SysConfigInfo querySysConfigInfo(String key,Integer type);
	
	public List<SysConfigInfo> querySysConfigInfoList(Integer type);

}
