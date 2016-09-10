package com.gongdan.xadmin.web.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdan.common.consts.GlobalConstants;
import com.gongdan.common.support.AbstractXTreeBuilder;
import com.gongdan.common.support.ModuleExceptionResolver;
import com.gongdan.common.support.OrderBy;
import com.gongdan.common.support.Pager;
import com.gongdan.common.support.PagingResult;
import com.gongdan.common.support.Result;
import com.gongdan.common.support.ServletContextAttribute;
import com.gongdan.common.support.TreeNodeBuilder;
import com.gongdan.common.utils.DateTimeUtils;
import com.gongdan.common.utils.StringUtils;
import com.gongdan.common.web.interceptor.Token;
import com.gongdan.common.web.interceptor.TokenAction;
import com.gongdan.common.web.shiro.ShiroUtils;
import com.gongdan.xadmin.consts.XAdminConstants;
import com.gongdan.xadmin.consts.em.AdminRoleTypeEnum;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminRole;
import com.gongdan.xadmin.model.AdminUser;
import com.gongdan.xadmin.service.AdminResourceService;
import com.gongdan.xadmin.service.AdminRoleService;
import com.gongdan.xadmin.support.AdminResourceTreeBuilder;
import com.gongdan.xadmin.support.AdminResourceTreeNodeBuilder;
import com.gongdan.xadmin.web.BaseController;
import com.gongdan.xadmin.web.LoginToken;

/**
 * 管理后台-角色管理Controller
 * 
 * @author	  	pengpeng
 * @date	  	2015年11月3日 上午11:17:24
 * @version  	1.0
 */
@Controller
public class AdminRoleMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(AdminRoleMgtController.class);
	
	@ServletContextAttribute
	public static final String DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER_BY = "createTime";
	
	@ServletContextAttribute
	public static final String DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER = OrderBy.ORDER_DESC;
	
	private AbstractXTreeBuilder<Long, AdminResource> resourceTreeBuilder = new AdminResourceTreeBuilder();
	
	private TreeNodeBuilder<AdminResource> resourceTreeNodeBuilder = new AdminResourceTreeNodeBuilder();
	
	@Resource(name="adminResourceFacadeService")
	private AdminResourceService resourceService;
	
	@Resource(name="adminRoleFacadeService")
	private AdminRoleService roleService;
	
	/**
	 * 角色管理页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/xadmin/role/list")
	public String index(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("roleQueryForm") AdminRole roleQueryForm,
			@ModelAttribute("orderBy") OrderBy orderBy,
			@ModelAttribute("pager") Pager pager,
			Map<String, Object> modelMap){
		if(StringUtils.isEmpty(orderBy.getOrderby())){
			orderBy.setOrderby(DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER_BY);
			orderBy.setOrder(DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER);
		}
		List<AdminRole> roleList = roleService.getRoleList(roleQueryForm, pager, orderBy);
		modelMap.put("dataList", roleList);
		return "xadmin/role/list";
	}
	
	/**
	 * 去新增角色页面
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CREATE)
	@RequestMapping("/xadmin/role/add")
	public String roleAdd(HttpServletRequest request, HttpServletResponse response, Map<String, Object> modelMap) {
		return "xadmin/role/add";
	}
	
	/**
	 * 新增角色
	 * @param request
	 * @param response
	 * @param roleAddForm
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CHECK)
	@RequestMapping("/xadmin/role/add/submit")
	public String addRole(HttpServletRequest request, HttpServletResponse response, AdminRole roleAddForm, Map<String, Object> modelMap) {
		try {
			LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
			roleAddForm.setCreateTime(DateTimeUtils.formatNow());
			roleAddForm.setCreateBy(loginToken.getLoginId());
			roleAddForm.setRoleType(AdminRoleTypeEnum.ADMIN_ROLE_TYPE_NORMAL.getTypeCode());
			roleService.createRole(roleAddForm);
			setSessionAttribute(request, "message", "保存成功!");
			return "redirect:/xadmin/role/list";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			modelMap.put("roleAddForm", roleAddForm);
			modelMap.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
			return "forward:/xadmin/role/add";
		}
	}
	
	/**
	 * 去修改角色页面
	 * @param request
	 * @param response
	 * @param roleId
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CREATE)
	@RequestMapping("/xadmin/role/edit")
	public String roleEdit(HttpServletRequest request, HttpServletResponse response, Long roleId, Map<String, Object> modelMap) {
		if(roleId != null && request.getAttribute("roleEditForm") == null){
			modelMap.put("roleEditForm", roleService.getRoleById(roleId));
		}
		return "xadmin/role/edit";
	}
	
	/**
	 * 修改角色
	 * @param request
	 * @param response
	 * @param roleAddForm
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CHECK)
	@RequestMapping("/xadmin/role/edit/submit")
	public String editRole(HttpServletRequest request, HttpServletResponse response, AdminRole roleEditForm, Map<String, Object> modelMap) {
		try {
			LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
			roleEditForm.setUpdateTime(DateTimeUtils.formatNow());
			roleEditForm.setUpdateBy(loginToken.getLoginId());
			roleService.updateRole(roleEditForm);
			setSessionAttribute(request, "message", "保存成功!");
			return "redirect:/xadmin/role/list";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			modelMap.put("roleEditForm", roleEditForm);
			modelMap.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
			return "forward:/xadmin/role/edit";
		}
	}
	
	/**
	 * 删除角色
	 * @param request
	 * @param response
	 * @param roleId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/role/del")
	public Object delRole(HttpServletRequest request, HttpServletResponse response, Long roleId) {
		Result<Object> result = new Result<Object>();
		roleService.deleteRoleById(roleId);
		result.setSuccess(true);
		result.setResultMsg("删除成功!");
		return result;
	}
	
	/**
	 * 查看角色详情
	 * @param request
	 * @param response
	 * @param roleId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/xadmin/role/detail")
	public String viewRole(HttpServletRequest request, HttpServletResponse response, Long roleId, Map<String, Object> modelMap){
		modelMap.put("role", roleService.getRoleById(roleId));
		return "xadmin/role/detail";
	}
	
	/**
	 * 加载角色-资源配置关系
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 */
	@RequestMapping("/xadmin/role/resources")
	public String loadRoleResources(HttpServletRequest request, HttpServletResponse response, Long roleId) throws Exception {
		String resourceTreeJson = null;
		try {
			List<AdminResource> allResourceList = resourceService.getAllThinResourceList(false);
			List<AdminResource> roleResourceList = roleService.getResourceListByRoleId(roleId);
			if(!CollectionUtils.isEmpty(allResourceList)){
				if(!CollectionUtils.isEmpty(roleResourceList)){
					for(AdminResource resource : allResourceList){
						for(AdminResource rResource : roleResourceList){
							if(resource.getResourceId().equals(rResource.getResourceId())){
								resource.setChecked(true);
								break;
							}
						}
					}
				}
				resourceTreeJson = resourceTreeBuilder.buildJsonTree(XAdminConstants.DEFAULT_XADMIN_ROOT_RESOURCE_ID, allResourceList, resourceTreeNodeBuilder);
			}
		} catch (Exception e) {
			resourceTreeJson = "[]";
			logger.error(e.getMessage(), e);
		}
		response.setContentType("application/json;charset=" + GlobalConstants.SYSTEM_DEFAULT_ENCODING);     
		response.setCharacterEncoding(GlobalConstants.SYSTEM_DEFAULT_ENCODING);    
		PrintWriter out = response.getWriter();
		out.print(resourceTreeJson);
		out.flush();
		out.close();
		return null;
	}
	
	/**
	 * 去角色资源配置页面
	 * @param request
	 * @param response
	 * @param roleId
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/xadmin/role/config")
	public String roleConfig(HttpServletRequest request, HttpServletResponse response, Long roleId, Map<String, Object> modelMap){
		modelMap.put("role", roleService.getRoleById(roleId));
		return "xadmin/role/config";
	}
	
	/**
	 * 配置角色资源
	 * @param request
	 * @param response
	 * @param roleId
	 * @param resourceIds
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/role/config/submit")
	public Object configRoleResources(HttpServletRequest request, HttpServletResponse response, Long roleId, String resourceIds) {
		Result<Object> result = new Result<Object>();
		List<Long> resourceIdList = new ArrayList<Long>();
		if(!StringUtils.isEmpty(resourceIds)){
			String[] resourceIdArray = resourceIds.split(",");
			if(resourceIdArray != null && resourceIdArray.length > 0){
				for(String resourceId : resourceIdArray){
					resourceIdList.add(Long.valueOf(resourceId));
				}
			}
		}
		
		LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
		roleService.configRoleResources(roleId, resourceIdList, loginToken.getLoginId(), DateTimeUtils.formatNow());
		result.setSuccess(true);
		result.setResultMsg("配置成功!");
		return result;
	}
	
	/**
	 * 查询角色
	 * @param request
	 * @param response
	 * @param roleSearchForm
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/role/search")
	public Object searchRoles(HttpServletRequest request, HttpServletResponse response, AdminRole roleQueryForm, OrderBy orderBy, Pager pager) {
		PagingResult<Object> result = new PagingResult<Object>();
		if(StringUtils.isEmpty(orderBy.getOrderby())){
			orderBy.setOrderby(DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER_BY);
			orderBy.setOrder(DEFAULT_ADMIN_ROLE_QUERY_LIST_ORDER);
		}
		List<AdminRole> roleList = roleService.getRoleList(roleQueryForm, pager, orderBy);
		result.setTotalRowCount(pager.getTotalRowCount());
		result.setSuccess(true);
		result.setResultData(roleList);
		return result;
	}
	
}
