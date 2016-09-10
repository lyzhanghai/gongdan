package com.gongdan.xadmin.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.gongdan.common.mybatis.EscapeFilter;
import com.gongdan.common.support.OrderBy;
import com.gongdan.common.support.Pager;
import com.gongdan.xadmin.consts.em.AdminRoleTypeEnum;
import com.gongdan.xadmin.dao.AdminRoleDAO;
import com.gongdan.xadmin.dao.base.XadminBaseMybatisDAO;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminRole;

@Repository("adminRoleDAO")
public class AdminRoleDAOImpl extends XadminBaseMybatisDAO implements AdminRoleDAO {

	public void insertRole(AdminRole role) {
		this.getSqlSessionTemplate().insert(getMapperKey("insertRole"), role);
	}

	public void updateRole(AdminRole role) {
		this.getSqlSessionTemplate().update(getMapperKey("updateRole"), role);
	}
	
	public void deleteRoleById(Long roleId) {
		this.getSqlSessionTemplate().delete(getMapperKey("deleteRoleById"), roleId);
	}
	
	public AdminRole getThinRoleById(Long roleId) {
		return this.getSqlSessionTemplate().selectOne(getMapperKey("selectThinRoleById"), roleId);
	}

	public AdminRole getRoleById(Long roleId) {
		return this.getSqlSessionTemplate().selectOne(getMapperKey("selectRoleById"), roleId, new AdminRoleEscapeFilter());
	}

	public List<AdminRole> getRoleList(AdminRole role, Pager pager, OrderBy orderby) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("roleName", role.getRoleName());
		paramMap.put("roleCode", role.getRoleCode());
		paramMap.put("orderby", orderby.getOrderby());
		paramMap.put("order", orderby.getOrder());
		return this.getSqlSessionTemplate().selectList(getMapperKey("selectRoleList"), paramMap, new AdminRoleEscapeFilter(), pager);
	}
	
	public List<AdminResource> getResourceListByRoleId(Long roleId) {
		return this.getSqlSessionTemplate().selectList(getMapperKey("selectResourceListByRoleId"), roleId);
	}

	public void deleteRoleResourcesByRoleId(Long roleId) {
		this.getSqlSessionTemplate().delete(getMapperKey("deleteRoleResourcesByRoleId"), roleId);
	}
	
	public void insertRoleResources(Long roleId, List<Long> resourceIdList, Long optUserId, String optTime) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("roleId", roleId);
		paramMap.put("resourceIdList", resourceIdList);
		paramMap.put("createBy", optUserId);
		paramMap.put("createTime", optTime);
		this.getSqlSessionTemplate().insert(getMapperKey("insertRoleResources"), paramMap);
	}
	
	protected Class<?> getBoundModelClass() {
		return AdminRole.class;
	}

	public static class AdminRoleEscapeFilter implements EscapeFilter<AdminRole> {

		public void doEscapeFilter(AdminRole element) {
			if(element.getRoleType() != null){
				AdminRoleTypeEnum em = AdminRoleTypeEnum.getType(element.getRoleType());
				if(em != null){
					element.setRoleTypeName(em.getTypeName());
				}
			}
		}
		
	}
	
}