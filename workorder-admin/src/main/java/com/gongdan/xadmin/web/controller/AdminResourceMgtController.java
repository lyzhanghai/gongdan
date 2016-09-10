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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdan.common.consts.GlobalConstants;
import com.gongdan.common.support.AbstractXTreeBuilder;
import com.gongdan.common.support.ModuleExceptionResolver;
import com.gongdan.common.support.Result;
import com.gongdan.common.support.TreeNodeBuilder;
import com.gongdan.common.utils.CollectionUtils;
import com.gongdan.common.utils.DateTimeUtils;
import com.gongdan.common.web.interceptor.Token;
import com.gongdan.common.web.interceptor.TokenAction;
import com.gongdan.common.web.shiro.ShiroUtils;
import com.gongdan.xadmin.consts.XAdminConstants;
import com.gongdan.xadmin.consts.em.AdminResourceActionTypeEnum;
import com.gongdan.xadmin.consts.em.AdminResourceTypeEnum;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminUser;
import com.gongdan.xadmin.service.AdminResourceService;
import com.gongdan.xadmin.support.AdminResourceTreeBuilder;
import com.gongdan.xadmin.support.AdminResourceTreeNodeBuilder;
import com.gongdan.xadmin.web.BaseController;
import com.gongdan.xadmin.web.LoginToken;

/**
 * 管理后台-资源管理Controller
 * 
 * @author	  	pengpeng
 * @date	  	2015年11月3日 上午11:17:24
 * @version  	1.0
 */
@Controller
public class AdminResourceMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(AdminResourceMgtController.class);
	
	private AbstractXTreeBuilder<Long, AdminResource> resourceTreeBuilder = new AdminResourceTreeBuilder();
	
	private TreeNodeBuilder<AdminResource> resourceTreeNodeBuilder = new AdminResourceTreeNodeBuilder();
	
	@Resource(name="adminResourceFacadeService")
	private AdminResourceService resourceService;
	
	/**
	 * 资源管理页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/xadmin/resource/list")
	public String index(HttpServletRequest request, HttpServletResponse response, Map<String, Object> modelMap){
		Long rootResourceId = XAdminConstants.DEFAULT_XADMIN_ROOT_RESOURCE_ID;
		List<AdminResource> list = resourceService.getAllResourceList();
		final List<AdminResource> resourceList = new ArrayList<AdminResource>();
		if(!CollectionUtils.isEmpty(list)){
			list = resourceTreeBuilder.buildObjectTree(rootResourceId, list);
			resourceService.loadTreeResources(list, resourceList);
		}
		modelMap.put("dataList", resourceList);
		return "xadmin/resource/list";
	}
	
	/**
	 * 获取可用的资源树结构
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/xadmin/resource/available")
	public Object loadAvailableResource(HttpServletRequest request, HttpServletResponse response, Long resourceId) throws Exception {
		String resourceJsonList = null; 
		try {
			List<AdminResource> resourceList = resourceService.getAllResourceList();
			if(!CollectionUtils.isEmpty(resourceList)){
				if(resourceId != null){
					for(AdminResource resource : resourceList){
						if(resource.getResourceId().equals(resourceId)){
							resource.setChecked(true);
						}
					}
				}
				resourceJsonList = resourceTreeBuilder.buildJsonTree(XAdminConstants.DEFAULT_XADMIN_ROOT_RESOURCE_ID, resourceList, resourceTreeNodeBuilder);
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resourceJsonList = "[]";
		}
		response.setContentType("application/json;charset=" + GlobalConstants.SYSTEM_DEFAULT_ENCODING);     
		response.setCharacterEncoding(GlobalConstants.SYSTEM_DEFAULT_ENCODING);    
		PrintWriter out = response.getWriter();
		out.print(resourceJsonList);
		out.flush();
		out.close();
		return null;
	}
	
	/**
	 * 去新增资源页面
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CREATE)
	@RequestMapping("/xadmin/resource/add")
	public String resourceAdd(HttpServletRequest request, HttpServletResponse response, AdminResource resourceAddForm, Map<String, Object> modelMap) {
		modelMap.put("resourceActionTypes", AdminResourceActionTypeEnum.values());
		if(resourceAddForm != null && resourceAddForm.getParentResourceId() != null){
			AdminResource parentResource = resourceService.getThinResourceById(resourceAddForm.getParentResourceId(), false);
			resourceAddForm.setParentResourceName(parentResource.getResourceName());
			modelMap.put("resourceAddForm", resourceAddForm);
		}
		return "xadmin/resource/add";
	}
	
	/**
	 * 新增资源
	 * @param request
	 * @param response
	 * @param resourceAddForm
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CHECK)
	@RequestMapping("/xadmin/resource/add/submit")
	public String addResource(HttpServletRequest request, HttpServletResponse response, AdminResource resourceAddForm, Map<String, Object> modelMap) {
		try {
			LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
			resourceAddForm.setCreateTime(DateTimeUtils.formatNow());
			resourceAddForm.setCreateBy(loginToken.getLoginId());
			resourceAddForm.setResourceType(AdminResourceTypeEnum.ADMIN_RESOURCE_TYPE_NORMAL.getTypeCode());
			resourceService.createResource(resourceAddForm);
			setSessionAttribute(request, "message", "保存成功!");
			return "redirect:/xadmin/resource/list";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			modelMap.put("resourceAddForm", resourceAddForm);
			modelMap.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
			return "forward:/xadmin/resource/add";
		}
	}
	
	/**
	 * 去修改资源页面
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CREATE)
	@RequestMapping("/xadmin/resource/edit")
	public String resourceEdit(HttpServletRequest request, HttpServletResponse response, Long id, Map<String, Object> modelMap) {
		modelMap.put("resourceActionTypes", AdminResourceActionTypeEnum.values());
		if(id != null && request.getAttribute("resourceEditForm") == null){
			modelMap.put("resourceEditForm", resourceService.getResourceById(id));
		}
		return "xadmin/resource/edit";
	}
	
	/**
	 * 修改资源
	 * @param request
	 * @param response
	 * @param resourceEditForm
	 * @param modelMap
	 * @return
	 */
	@Token(action=TokenAction.CHECK)
	@RequestMapping("/xadmin/resource/edit/submit")
	public String editResource(HttpServletRequest request, HttpServletResponse response, AdminResource resourceEditForm, Map<String, Object> modelMap) {
		try {
			LoginToken<AdminUser> loginToken = ShiroUtils.getSessionAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
			resourceEditForm.setUpdateTime(DateTimeUtils.formatNow());
			resourceEditForm.setUpdateBy(loginToken.getLoginId());
			resourceService.updateResource(resourceEditForm);
			setSessionAttribute(request, "message", "保存成功!");
			return "redirect:/xadmin/resource/list";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			modelMap.put("resourceEditForm", resourceEditForm);
			modelMap.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
			return "forward:/xadmin/resource/edit";
		}
	}
	
	/**
	 * 删除资源
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/xadmin/resource/del")
	public Object delResource(HttpServletRequest request, HttpServletResponse response, Long id) {
		Result<Object> result = new Result<Object>();
		resourceService.deleteResourceById(id, true);
		result.setSuccess(true);
		result.setResultMsg("删除成功!");
		return result;
	}
	
	
	/**
	 * 查看资源详情
	 * @param request
	 * @param response
	 * @param id
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/xadmin/resource/detail")
	public String viewResource(HttpServletRequest request, HttpServletResponse response, Long id, Map<String, Object> modelMap){
		modelMap.put("resource", resourceService.getResourceById(id));
		return "xadmin/resource/detail";
	}
	
}