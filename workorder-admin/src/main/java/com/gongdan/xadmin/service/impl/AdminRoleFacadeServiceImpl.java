package com.gongdan.xadmin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.gongdan.common.support.OrderBy;
import com.gongdan.common.support.Pager;
import com.gongdan.common.web.shiro.service.ShiroCacheService;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminRole;
import com.gongdan.xadmin.service.AdminRoleService;

@Lazy
@Service("adminRoleFacadeService")
public class AdminRoleFacadeServiceImpl implements AdminRoleService {

	@Resource(name="shiroCacheService")
	private ShiroCacheService shiroCacheService;
	
	@Resource(name="adminRoleService")
	private AdminRoleService delegate;
	
	public void createRole(AdminRole role) {
		delegate.createRole(role);
	}

	public void updateRole(AdminRole role) {
		delegate.updateRole(role);
		shiroCacheService.clearAllCachedAuthorizationInfo(); //可能角色名发生改变,需要清除所有授权缓存
	}

	public void deleteRoleById(Long roleId) {
		delegate.deleteRoleById(roleId);
		shiroCacheService.clearAllCachedAuthorizationInfo(); //有角色被删除,需要清除所有授权缓存
	}

	public AdminRole getRoleById(Long roleId) {
		return delegate.getRoleById(roleId);
	}

	public List<AdminRole> getRoleList(AdminRole role, Pager pager, OrderBy orderby) {
		return delegate.getRoleList(role, pager, orderby);
	}

	public List<AdminResource> getResourceListByRoleId(Long roleId) {
		return delegate.getResourceListByRoleId(roleId);
	}

	public void configRoleResources(Long roleId, List<Long> resourceIdList, Long optUserId, String optTime) {
		delegate.configRoleResources(roleId, resourceIdList, optUserId, optTime);
		shiroCacheService.clearAllCachedAuthorizationInfo(); //权限发生变动,需要清除所有授权缓存
	}

}
