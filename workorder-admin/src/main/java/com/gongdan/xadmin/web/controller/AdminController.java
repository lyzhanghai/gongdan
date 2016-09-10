package com.gongdan.xadmin.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdan.common.support.AbstractXTreeBuilder;
import com.gongdan.common.utils.CollectionUtils;
import com.gongdan.common.utils.DateTimeUtils;
import com.gongdan.common.utils.NetUtils;
import com.gongdan.common.utils.StringUtils;
import com.gongdan.common.web.shiro.ShiroUtils;
import com.gongdan.common.web.shiro.authz.CustomAuthorizationInfo;
import com.gongdan.xadmin.consts.XAdminConstants;
import com.gongdan.xadmin.consts.em.AdminResourceActionTypeEnum;
import com.gongdan.xadmin.model.AdminResource;
import com.gongdan.xadmin.model.AdminUser;
import com.gongdan.xadmin.service.AdminUserService;
import com.gongdan.xadmin.support.AdminResourceTreeBuilder;
import com.gongdan.xadmin.web.BaseController;
import com.gongdan.xadmin.web.LoginToken;
import com.gongdan.xadmin.web.shiro.realm.AdminUserRealm;
/**
 * 管理后台Controller
 * 
 * @author  pengpeng
 * @date 	 2015年4月5日 下午8:44:00
 * @version 1.0
 */
@Controller
public class AdminController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	private AbstractXTreeBuilder<Long, AdminResource> resourceTreeBuilder = new AdminResourceTreeBuilder();
	
	@Resource(name="adminUserFacadeService")
	private AdminUserService userService;
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response) {
		return "login";
	}
	
	@RequestMapping("/login/submit")
	public String doLogin(HttpServletRequest request, HttpServletResponse response, String userName, String password, RedirectAttributes redirectAttributes) {
		logger.info(">>> 用户登录, userName = {}, password = {}", userName, password);
		Subject currentUser = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(userName, password);
		//token.setRememberMe(true);
		try {
			currentUser.login(token);
			if(currentUser.isAuthenticated()){ //用户是否登录成功
				String nowTime = DateTimeUtils.formatNow();
				AdminUser user = userService.getUserByUserName(token.getUsername(), true);
				userService.updateLoginTime(user.getUserId(), nowTime);
				LoginToken<AdminUser> loginToken = new LoginToken<AdminUser>();
				loginToken.setLoginId(user.getUserId());
				loginToken.setLoginName(user.getUserName());
				loginToken.setLoginAddrIp(NetUtils.getRemoteIpAddr(request));
				loginToken.setLoginTime(DateTimeUtils.formatNow());
				loginToken.setLoginTimes(user.getLoginTimes());
				loginToken.setLastLoginTime(StringUtils.defaultIfEmpty(user.getLastLoginTime(), nowTime));
				user.setLastLoginTime(nowTime);
				loginToken.setLoginUser(user);
				ShiroUtils.getSession().setAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY, loginToken);
				logger.info(">>> 用户登录成功! {} = {}", LoginToken.LOGIN_TOKEN_SESSION_KEY, ShiroUtils.getSession().getAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY));
			}else{
				logger.info(">>> 用户登录失败!");
				redirectAttributes.addFlashAttribute("message", "用户登录失败!");
				return "redirect:/login";
			}
		} catch (IncorrectCredentialsException e) {
			logger.error(e.getMessage(), e);
			redirectAttributes.addFlashAttribute("message", "用户名或密码不正确!");
			return "redirect:/login";
		} catch (UnknownAccountException e) {
			logger.error(e.getMessage(), e);
			redirectAttributes.addFlashAttribute("message", "用户名或密码不正确!");
			return "redirect:/login";
		} catch (LockedAccountException e) {
			logger.error(e.getMessage(), e);
			redirectAttributes.addFlashAttribute("message", "对不起,该账户被锁定!");
			return "redirect:/login";
		} catch (ExcessiveAttemptsException e) {
			logger.error(e.getMessage(), e);
			String maxPasswordRetry = e.getMessage();
			redirectAttributes.addFlashAttribute("message", String.format("对不起,您已重试密码次数达到%s次,请稍后再试!", maxPasswordRetry));
			return "redirect:/login";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			redirectAttributes.addFlashAttribute("message", String.format("登录出错!(错误信息:%s)", ExceptionUtils.getRootCauseMessage(e)));
			return "redirect:/login";
		}
		return "redirect:/";
	}
	
	/**
	 * 后台管理首页
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/", "/index"})
	public String index(HttpServletRequest request, HttpServletResponse response, Map<String,Object> modelMap) {
		LoginToken<AdminUser> loginToken = (LoginToken<AdminUser>) ShiroUtils.getSession().getAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY);
		
		if(loginToken == null){
			String nowTime = DateTimeUtils.formatNow();
			AdminUser user = userService.getUserByUserName("xadmin", true);
			loginToken = new LoginToken<AdminUser>();
			loginToken.setLoginId(user.getUserId());
			loginToken.setLoginName(user.getUserName());
			loginToken.setLoginAddrIp(NetUtils.getRemoteIpAddr(request));
			loginToken.setLoginTime(DateTimeUtils.formatNow());
			loginToken.setLastLoginTime(StringUtils.defaultIfEmpty(user.getLastLoginTime(), nowTime));
			user.setLastLoginTime(nowTime);
			loginToken.setLoginUser(user);
			ShiroUtils.getSession().setAttribute(LoginToken.LOGIN_TOKEN_SESSION_KEY, loginToken);
		}
		
		modelMap.put("loginToken", loginToken);
		List<AdminResource> userMenuResources = new ArrayList<AdminResource>();
		AdminUserRealm realm = ShiroUtils.getRealm(AdminUserRealm.class);
		AuthorizationInfo authInfo = realm.getAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
		if(authInfo instanceof CustomAuthorizationInfo){
			CustomAuthorizationInfo<AdminResource> authorizationInfo = (CustomAuthorizationInfo<AdminResource>) authInfo;
			Set<AdminResource> userResources = authorizationInfo.getResources();
			if(!CollectionUtils.isEmpty(userResources)){
				for(AdminResource resource : userResources){
					if(AdminResourceActionTypeEnum.ADMIN_RESOURCE_ACTION_TYPE_MENU.getTypeCode().equals(resource.getActionType())){
						userMenuResources.add(resource);
					}
				}
				userMenuResources = resourceTreeBuilder.buildObjectTree(XAdminConstants.DEFAULT_XADMIN_ROOT_RESOURCE_ID, userMenuResources); //构建菜单对象树
			}
		}
		if(!userMenuResources.isEmpty() && userMenuResources.size() == 1){
			modelMap.put("lv1Menus", userMenuResources.get(0).getSubResourceList());
		}else{
			modelMap.put("lv1Menus", userMenuResources);
		}
		return "index";
	}
	
	@RequestMapping(value="index1")
	public String index1() {
		return "index1";
	}
	
	/**
	 * 用户登出系统
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		if (SecurityUtils.getSubject().getSession() != null) {
	        SecurityUtils.getSubject().logout();
	    }
		return "redirect:/login";
	}
	
}
