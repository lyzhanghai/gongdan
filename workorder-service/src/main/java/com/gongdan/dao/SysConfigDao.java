package com.gongdan.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gongdan.common.entity.SysConfigInfo;

@Repository
public interface SysConfigDao {
	
	
	public SysConfigInfo querySysConfigInfo(@Param("configKey")String key,@Param("configType")Integer type);
	
	public List<SysConfigInfo> querySysConfigInfoList(Integer type);

}
