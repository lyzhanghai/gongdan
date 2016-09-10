package com.gongdan.xadmin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gongdan.common.support.BusinessAssert;
import com.gongdan.common.support.OrderBy;
import com.gongdan.common.support.Pager;
import com.gongdan.common.support.ValidationAssert;
import com.gongdan.common.utils.CollectionUtils;
import com.gongdan.xadmin.consts.em.AdminRoleTypeEnum;
import com.gongdan.xadmin.dao.AdminRoleDAO;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminRole;
import com.gongdan.xadmin.service.AdminRoleService;

@Service("adminRoleService")
public class AdminRoleServiceImpl implements AdminRoleService {

	@Resource(name="adminRoleDAO")
	private AdminRoleDAO roleDAO;
	
	@Transactional(rollbackFor=Exception.class, propagation=Propagation.REQUIRED)
	public void createRole(AdminRole role) {
		ValidationAssert.notNull(role, "参数不能为空!");
		try {
			roleDAO.insertRole(role);
		} catch(DuplicateKeyException e) {
			BusinessAssert.isTrue(!e.getCause().getMessage().toUpperCase().contains("ROLE_NAME"), "新增角色失败,该角色名称已经存在!");
			BusinessAssert.isTrue(!e.getCause().getMessage().toUpperCase().contains("ROLE_CODE"), "新增角色失败,该角色代码已经存在!");
		}
	}

	@Transactional(rollbackFor=Exception.class, propagation=Propagation.REQUIRED)
	public void updateRole(AdminRole role) {
		ValidationAssert.notNull(role, "参数不能为空!");
		ValidationAssert.notNull(role.getRoleId(), "角色ID不能为空!");
		AdminRole prole = roleDAO.getThinRoleById(role.getRoleId());
		ValidationAssert.notNull(prole, "该角色已经不存在了!");
		try {
			roleDAO.updateRole(role);
		} catch(DuplicateKeyException e) {
			BusinessAssert.isTrue(!e.getCause().getMessage().toUpperCase().contains("ROLE_NAME"), "修改角色失败,该角色名称已经存在!");
			BusinessAssert.isTrue(!e.getCause().getMessage().toUpperCase().contains("ROLE_CODE"), "修改角色失败,该角色代码已经存在!");
		}
	}

	@Transactional(rollbackFor=Exception.class, propagation=Propagation.REQUIRED)
	public void deleteRoleById(Long roleId) {
		ValidationAssert.notNull(roleId, "角色ID不能为空!");
		AdminRole role = roleDAO.getThinRoleById(roleId);
		ValidationAssert.notNull(role, "该角色已经不存在了!");
		BusinessAssert.isTrue(!AdminRoleTypeEnum.ADMIN_ROLE_TYPE_SYSTEM.getTypeCode().equals(role.getRoleType()), "删除角色失败,系统角色不允许删除!");
		BusinessAssert.isTrue(!role.isInuse(), "删除角色失败,该角色已经在使用不允许删除!");
		roleDAO.deleteRoleById(roleId);
	}

	public AdminRole getRoleById(Long roleId) {
		return roleDAO.getRoleById(roleId);
	}

	public List<AdminRole> getRoleList(AdminRole role, Pager pager, OrderBy orderby) {
		return roleDAO.getRoleList(role, pager, orderby);
	}

	public List<AdminResource> getResourceListByRoleId(Long roleId) {
		return roleDAO.getResourceListByRoleId(roleId);
	}

	@Transactional(rollbackFor=Exception.class, propagation=Propagation.REQUIRED)
	public void configRoleResources(Long roleId, List<Long> resourceIdList, Long optUserId, String optTime) {
		AdminRole role = roleDAO.getThinRoleById(roleId);
		ValidationAssert.notNull(role, "该角色已经不存在了!");
		roleDAO.deleteRoleResourcesByRoleId(roleId);
		if(!CollectionUtils.isEmpty(resourceIdList)){
			roleDAO.insertRoleResources(roleId, resourceIdList, optUserId, optTime);
		}
	}

}
