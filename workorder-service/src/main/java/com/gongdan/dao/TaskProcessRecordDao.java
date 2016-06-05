package com.gongdan.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface TaskProcessRecordDao {
	
	public void createTaskProcessRecord(Map<String,Object> paramMap);
}
