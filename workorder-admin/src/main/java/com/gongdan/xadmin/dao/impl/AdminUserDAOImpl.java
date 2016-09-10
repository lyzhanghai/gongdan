package com.gongdan.xadmin.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.gongdan.common.mybatis.EscapeFilter;
import com.gongdan.common.support.OrderBy;
import com.gongdan.common.support.Pager;
import com.gongdan.xadmin.consts.em.AdminUserStatusEnum;
import com.gongdan.xadmin.consts.em.AdminUserTypeEnum;
import com.gongdan.xadmin.dao.AdminUserDAO;
import com.gongdan.xadmin.dao.base.XadminBaseMybatisDAO;
import com.gongdan.xadmin.dao.impl.AdminResourceDAOImpl.AdminResourceEscapeFilter;
import com.gongdan.xadmin.dao.impl.AdminRoleDAOImpl.AdminRoleEscapeFilter;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminRole;
import com.gongdan.xadmin.model.AdminUser;

@Repository("adminUserDAO")
public class AdminUserDAOImpl extends XadminBaseMybatisDAO implements AdminUserDAO {

	public void insertUser(AdminUser user) {
		getSqlSessionTemplate().insert(getMapperKey("insertUser"), user);
	}

	public void updateUser(AdminUser user) {
		getSqlSessionTemplate().update(getMapperKey("updateUser"), user);
	}

	public void deleteUserById(Long userId) {
		getSqlSessionTemplate().delete(getMapperKey("deleteUserById"), userId);
	}

	public void updateUserStatus(Long userId, AdminUserStatusEnum status) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userId", userId);
		paramMap.put("status", status.getStatusCode());
		getSqlSessionTemplate().update(getMapperKey("updateUserStatus"), paramMap);
	}

	public void updatePassword(AdminUser user) {
		getSqlSessionTemplate().update(getMapperKey("updatePassword"), user);
	}

	public void updateLoginTime(Long userId, String lastLoginTime) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userId", userId);
		paramMap.put("lastLoginTime", lastLoginTime);
		getSqlSessionTemplate().update(getMapperKey("updateLoginTime"), paramMap);
	}

	public AdminUser getUserById(Long userId) {
		return getSqlSessionTemplate().selectOne(getMapperKey("getUserById"), userId, new AdminUserEscapeFilter());
	}

	public AdminUser getThinUserById(Long userId) {
		return getSqlSessionTemplate().selectOne(getMapperKey("getThinUserById"), userId);
	}

	public List<AdminUser> getUserList(AdminUser user, Pager pager, OrderBy orderby) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userName", user.getUserName());
		paramMap.put("nickName", user.getNickName());
		paramMap.put("userType", user.getUserType());
		paramMap.put("status", user.getStatus());
		paramMap.put("orderby", orderby.getOrderby());
		paramMap.put("order", orderby.getOrder());
		return getSqlSessionTemplate().selectList(getMapperKey("getUserList"), paramMap, new AdminUserEscapeFilter(), pager);
	}

	public List<AdminRole> getUserRoleList(Long userId) {
		return getSqlSessionTemplate().selectList(getMapperKey("getUserRoleList"), userId, new AdminRoleEscapeFilter());
	}

	public List<AdminResource> getUserResourceList(Long userId) {
		return getSqlSessionTemplate().selectList(getMapperKey("getUserResourceList"), userId, new AdminResourceEscapeFilter());
	}

	public void insertUserRoles(Long userId, List<Long> roleIdList, Long optUserId, String optTime) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userId", userId);
		paramMap.put("roleIdList", roleIdList);
		paramMap.put("createBy", optUserId);
		paramMap.put("createTime", optTime);
		getSqlSessionTemplate().insert(getMapperKey("insertUserRoles"), paramMap);
	}

	public void deleteUserRoles(Long userId, List<Long> roleIdList) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userId", userId);
		paramMap.put("roleIdList", roleIdList);
		getSqlSessionTemplate().insert(getMapperKey("deleteUserRoles"), paramMap);
	}

	public AdminUser getUserByUserName(String userName, boolean fatUser) {
		if(fatUser){
			return getSqlSessionTemplate().selectOne(getMapperKey("getUserByUserName"), userName);
		}else{
			return getSqlSessionTemplate().selectOne(getMapperKey("getThinUserByUserName"), userName);
		}
	}

	protected Class<?> getBoundModelClass() {
		return AdminUser.class;
	}
	
	public static class AdminUserEscapeFilter implements EscapeFilter<AdminUser> {

		public void doEscapeFilter(AdminUser element) {
			element.setRepassword(element.getPassword());
			if(element.getStatus() != null){
				AdminUserStatusEnum em = AdminUserStatusEnum.getStatus(element.getStatus());
				if(em != null){
					element.setStatusName(em.getStatusName());
				}
			}
			if(element.getUserType() != null){
				AdminUserTypeEnum em = AdminUserTypeEnum.getUserType(element.getUserType());
				if(em != null){
					element.setUserTypeName(em.getTypeName());
				}
			}
		}
		
	}

}
