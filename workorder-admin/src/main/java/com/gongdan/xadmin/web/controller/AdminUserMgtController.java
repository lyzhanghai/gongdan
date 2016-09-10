package com.gongdan.xadmin.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdan.common.support.AbstractXTreeBuilder;
import com.gongdan.common.support.ModuleExceptionResolver;
import com.gongdan.common.support.OrderBy;
import com.gongdan.common.support.Pager;
import com.gongdan.common.support.Result;
import com.gongdan.common.support.ServletContextAttribute;
import com.gongdan.common.utils.CollectionUtils;
import com.gongdan.common.utils.DateTimeUtils;
import com.gongdan.common.utils.StringUtils;
import com.gongdan.common.web.interceptor.Token;
import com.gongdan.common.web.interceptor.TokenAction;
import com.gongdan.common.web.shiro.ShiroUtils;
import com.gongdan.xadmin.consts.XAdminConstants;
import com.gongdan.xadmin.consts.em.AdminUserStatusEnum;
import com.gongdan.xadmin.consts.em.AdminUserTypeEnum;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminRole;
import com.gongdan.xadmin.model.AdminUser;
import com.gongdan.xadmin.service.AdminResourceService;
import com.gongdan.xadmin.service.AdminUserService;
import com.gongdan.xadmin.support.AdminResourceTreeBuilder;
import com.gongdan.xadmin.web.BaseController;
import com.gongdan.xadmin.web.LoginToken;
/**
 * 管理后台-用户管理
 * 
 * @author  pengpeng
 * @date 	 2015年5月4日 上午9:36:59
 * @version 1.0
 */
@Controller
public class AdminUserMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(AdminUserMgtController.class);
	
	private AbstractXTreeBuilder<Long, AdminResource> resourceTreeBuilder = new AdminResourceTreeBuilder();
	
	@ServletContextAttribute
	public static final String DEFAULT_ADMIN_USER_QUERY_LIST_ORDER_BY = "createTime";
	
	@ServletContextAttribute
	public static final String DEFAULT_ADMIN_USER_QUERY_LIST_ORDER = OrderBy.ORDER_DESC;
	
	@Resource(name="adminUserFacadeService")
	private AdminUserService userService;
	
	@Resource(name="adminResourceFacadeService")
	private AdminResourceService resourceService;
	
	/**
	 * 用户管理页面
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/xadmin/user/list")
	public String userList(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("userQueryForm") AdminUser userQueryForm,
			@ModelAttribute("orderBy") OrderBy orderBy,
			@ModelAttribute("pager") Pager pager,
			Map<String,Object> modelMap) {
		
		if(StringUtils.isEmpty(orderBy.getOrderby())){
			orderBy.setOrderby(DEFAULT_ADMIN_USER_QUERY_LIST_ORDER_BY);//排序字段
			orderBy.setOrder(DEFAULT_ADMIN_USER_QUERY_LIST_ORDER);//排序类型
		}
		List<AdminUser> dataList = userService.getUserList(userQueryForm, pager, orderBy);
		modelMap.put("dataList", dataList);
		modelMap.put("userTypes", AdminUserTypeEnum.values());
		modelMap.put("userStatuses", AdminUserStatusEnum.values());
		return "xadmin/user/list";
	}
	
	/**
	 * 去新增用户页面
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CREATE)
	@RequestMapping("/xadmin/user/add")
	public String userAdd(HttpServletRequest request, HttpServletResponse response, Map<String, Object> modelMap) {
		return "xadmin/user/add";
	}
	
	/**
	 * 新增用户
	 * @param request
	 * @param response
	 * @param userAddForm
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CHECK)
	@RequestMapping("/xadmin/user/add/submit")
	public String addUser(HttpServletRequest request, HttpServletResponse response, AdminUser userAddForm, Map<String, Object> modelMap) {
		try {
			LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
			userAddForm.setCreateTime(DateTimeUtils.formatNow());
			userAddForm.setCreateBy(loginToken.getLoginId());
			userAddForm.setStatus(AdminUserStatusEnum.ADMIN_USER_STATUS_ENABLED.getStatusCode());
			userAddForm.setUserType(AdminUserTypeEnum.ADMIN_USER_TYPE_NORMAL.getTypeCode());
			userService.createUser(userAddForm);
			setSessionAttribute(request, "message", "保存成功!");
			return "redirect:/xadmin/user/list";
		} catch (Exception e) {//提交出现异常,则forward到add页面
			logger.error(e.getMessage(), e);
			modelMap.put("userAddForm", userAddForm);
			modelMap.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
			return "forward:/xadmin/user/add";
		}
	}
	
	/**
	 * 去修改用户页面
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CREATE)
	@RequestMapping("/xadmin/user/edit")
	public String userEdit(HttpServletRequest request, HttpServletResponse response, Long userId, Map<String, Object> modelMap) {
		if(userId != null && request.getAttribute("userEditForm") == null){
			modelMap.put("userEditForm", userService.getUserById(userId));
		}
		return "xadmin/user/edit";
	}
	
	/**
	 * 修改用户
	 * @param request
	 * @param response
	 * @param userAddForm
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CHECK)
	@RequestMapping("/xadmin/user/edit/submit")
	public String editUser(HttpServletRequest request, HttpServletResponse response, AdminUser userEditForm, Map<String, Object> modelMap) {
		try {
			LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
			userEditForm.setUpdateBy(loginToken.getLoginId());
			userEditForm.setUpdateTime(DateTimeUtils.formatNow());
			userService.updateUser(userEditForm);
			setSessionAttribute(request, "message", "保存成功!");
			return "redirect:/xadmin/user/list";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			modelMap.put("userEditForm", userEditForm);
			modelMap.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
			return "forward:/xadmin/user/edit";
		}
	}
	
	/**
	 * 去查看用户详情
	 * @param userId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/xadmin/user/detail")
	public String detail(Long userId, Map<String, Object> modelMap) {
        modelMap.put("user", userService.getUserById(userId));
        return "/xadmin/user/detail";
	}
	
	/**
	 * 用户查看账户详情
	 * @param userId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/xadmin/user/accountinfo")
	public String accountInfo(Map<String, Object> modelMap) {
		LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
		Long userId = loginToken.getLoginUser().getUserId();
        modelMap.put("user", userService.getUserById(userId));
        modelMap.put("userRoleList", userService.getUserRoleList(userId));
        
        List<AdminResource> userResourceList = userService.getUserResourceList(userId);
        Long rootResourceId = XAdminConstants.DEFAULT_XADMIN_ROOT_RESOURCE_ID;
        final List<AdminResource> resourceList = new ArrayList<AdminResource>();
		if(!CollectionUtils.isEmpty(userResourceList)){
			userResourceList = resourceTreeBuilder.buildObjectTree(rootResourceId, userResourceList);
			resourceService.loadTreeResources(userResourceList, resourceList);
		}
        modelMap.put("userResourceList", resourceList);
        return "/xadmin/user/accountinfo";
	}
	
	/**
	 * 删除用户
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/user/del")
	public Object delUser(HttpServletRequest request, HttpServletResponse response, Long userId) {
		Result<Object> result = new Result<Object>();
		AdminUser user = new AdminUser();
		user.setUserId(userId);
		userService.deleteUserById(user);
		result.setSuccess(true);
		result.setResultMsg("删除成功!");
		return result;
	}
	
	/**
	 * 用户去修改密码页面
	 * @param userId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/xadmin/user/changepwd")
	public String userChangePasswd(Map<String, Object> modelMap) {
		LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
		Long userId = loginToken.getLoginUser().getUserId();
        modelMap.put("user", userService.getUserById(userId));
        return "/xadmin/user/changepwd";
	}
	
	/**
	 * 修改密码
	 * @param request
	 * @param response
	 * @param passwdEditForm
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/user/changepwd/submit")
	public Object changeUserPasswd(HttpServletRequest request, HttpServletResponse response, AdminUser passwdEditForm, Boolean forceUpdate) {
		Result<Object> result = new Result<Object>();
		if(forceUpdate == null){
			forceUpdate = false;
		}
		userService.updatePassword(passwdEditForm, forceUpdate);
		result.setSuccess(true);
		result.setResultMsg("修改成功!");
		return result;
	}
	
	/**
	 * 启用用户
	 * @param request
	 * @param response
	 * @param userId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/user/enable")
	public Object enableUser(HttpServletRequest request, HttpServletResponse response, Long userId) {
		return updateUserStatus(request, response, userId, AdminUserStatusEnum.ADMIN_USER_STATUS_ENABLED);
	}
	
	/**
	 * 禁用用户
	 * @param request
	 * @param response
	 * @param userId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/user/disable")
	public Object disableUser(HttpServletRequest request, HttpServletResponse response, Long userId) {
		return updateUserStatus(request, response, userId, AdminUserStatusEnum.ADMIN_USER_STATUS_DISABLED);
	}
	
	protected Result<Object> updateUserStatus(HttpServletRequest request, HttpServletResponse response, Long userId, AdminUserStatusEnum targetStatus){
		Result<Object> result = new Result<Object>();
		AdminUser user = new AdminUser();
		user.setUserId(userId);
		user.setStatus(targetStatus.getStatusCode());
		userService.updateUserStatus(user);
		result.setSuccess(true);
		result.setResultMsg(targetStatus.getStatusName() + "成功!");
		return result;
	}
	
	/**
	 * 去用户角色配置页面
	 * @param request
	 * @param response
	 * @param userId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/xadmin/user/config")
	public String userConfig(HttpServletRequest request, HttpServletResponse response, Long userId, Map<String, Object> modelMap){
		modelMap.put("user", userService.getUserById(userId));
		return "xadmin/user/config";
	}
	
	
	/**
	 * 获取用户拥有的角色列表
	 * @param request
	 * @param response
	 * @param userId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/user/roles")
	public Object loadUserRoles(HttpServletRequest request, HttpServletResponse response, Long userId) {
		Result<Object> result = new Result<Object>();
		List<AdminRole> roleList = userService.getUserRoleList(userId);
		result.setSuccess(true);
		result.setResultData(roleList);
		return result;
	}
	
	/**
	 * 添加用户-角色配置
	 * @param request
	 * @param response
	 * @param userId
	 * @param roleIds
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/user/config/add")
	public Object addUserRoles(HttpServletRequest request, HttpServletResponse response, Long userId, String roleIds) {
		Result<Object> result = new Result<Object>();
		List<Long> roleIdList = new ArrayList<Long>();
		if(!StringUtils.isEmpty(roleIds)){
			String[] roleIdArray = roleIds.split(",");
			if(roleIdArray != null && roleIdArray.length > 0){
				for(String roleId : roleIdArray){
					roleIdList.add(Long.valueOf(roleId));
				}
			}
		}
		
		LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
		AdminUser user = new AdminUser();
		user.setUserId(userId);
		userService.addUserRoles(user, roleIdList, loginToken.getLoginId(), DateTimeUtils.formatNow());
		result.setSuccess(true);
		result.setResultMsg("添加成功!");
		return result;
	}
	
	/**
	 * 删除户-角色配置
	 * @param request
	 * @param response
	 * @param userId
	 * @param roleIds
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/user/config/del")
	public Object delUserRoles(HttpServletRequest request, HttpServletResponse response, Long userId, String roleIds) {
		Result<Object> result = new Result<Object>();
		List<Long> roleIdList = new ArrayList<Long>();
		if(!StringUtils.isEmpty(roleIds)){
			String[] roleIdArray = roleIds.split(",");
			if(roleIdArray != null && roleIdArray.length > 0){
				for(String roleId : roleIdArray){
					roleIdList.add(Long.valueOf(roleId));
				}
			}
		}
		AdminUser user = new AdminUser();
		user.setUserId(userId);
		userService.delUserRoles(user, roleIdList);
		result.setSuccess(true);
		result.setResultMsg("删除成功!");
		return result;
	}
	
}
