package com.gongdan.xadmin.dao.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.gongdan.common.mybatis.EscapeFilter;
import com.gongdan.xadmin.consts.em.AdminResourceActionTypeEnum;
import com.gongdan.xadmin.consts.em.AdminResourceTypeEnum;
import com.gongdan.xadmin.dao.AdminResourceDAO;
import com.gongdan.xadmin.dao.base.XadminBaseMybatisDAO;
import com.gongdan.xadmin.model.AdminResource;

@Repository("adminResourceDAO")
public class AdminResourceDAOImpl extends XadminBaseMybatisDAO implements AdminResourceDAO {

	public void insertResource(AdminResource resource) {
		this.getSqlSessionTemplate().insert(getMapperKey("insertResource"), resource);
	}

	public void updateResource(AdminResource resource) {
		this.getSqlSessionTemplate().update(getMapperKey("updateResource"), resource);
	}

	public void deleteResourceByIds(Long... resourceIds) {
		this.getSqlSessionTemplate().batchDelete(getMapperKey("deleteResourceById"), Arrays.asList(resourceIds));
	}

	public AdminResource getResourceById(Long resourceId) {
		return this.getSqlSessionTemplate().selectOne(getMapperKey("selectResourceById"), resourceId, new AdminResourceEscapeFilter());
	}
	
	public AdminResource getThinResourceById(Long resourceId, boolean fetchInuse) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("resourceId", resourceId);
		paramMap.put("fetchInuse", fetchInuse);
		return this.getSqlSessionTemplate().selectOne(getMapperKey("selectThinResourceById"), paramMap);
	}

	public List<AdminResource> getAllResourceList() {
		return this.getSqlSessionTemplate().selectList(getMapperKey("selectAllResourceList"), null, new AdminResourceEscapeFilter());
	}
	
	public List<AdminResource> getAllThinResourceList(boolean fetchInuse) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("fetchInuse", fetchInuse);
		return this.getSqlSessionTemplate().selectList(getMapperKey("selectAllThinResourceList"), paramMap);
	}

	protected Class<?> getBoundModelClass() {
		return AdminResource.class;
	}
	
	public static class AdminResourceEscapeFilter implements EscapeFilter<AdminResource> {

		public void doEscapeFilter(AdminResource element) {
			if(element.getResourceType() != null){
				AdminResourceTypeEnum em = AdminResourceTypeEnum.getType(element.getResourceType());
				if(em != null){
					element.setResourceTypeName(em.getTypeName());
				}
			}
			if(element.getActionType() != null){
				AdminResourceActionTypeEnum em = AdminResourceActionTypeEnum.getType(element.getActionType());
				if(em != null){
					element.setActionTypeName(em.getTypeName());
				}
			}
		}
		
	}

}