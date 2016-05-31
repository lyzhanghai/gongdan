package com.gongdan.common.consts;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 任务相关常量
 * @author yanziqi
 *
 */
public class TaskConts {

	 /**
	  * 任务状态
	  */
	public final static Map<Integer, String> taskStatusMap = new HashMap<Integer, String>();
	
	
	static void initTaskStatusMap(){
		taskStatusMap.put(1, "创建任务");
		taskStatusMap.put(2, "接受任务");
		taskStatusMap.put(3, "完成任务");
		
	}
	
	static{
		initTaskStatusMap();
		
		
	}
}
