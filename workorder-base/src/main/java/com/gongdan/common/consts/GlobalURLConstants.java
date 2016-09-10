package com.gongdan.common.consts;

import com.gongdan.common.support.ConstValue;


/**
 * 全局URL常量
 * 
 * @author pengpeng
 * @date 2016年3月9日 下午9:04:43
 * @version 1.0
 */
public class GlobalURLConstants extends AbstractConstants {

	/** 全局图片服务域名 */
	@ConstValue("${global.imgserver.domain}")
	public static final String GLOBAL_IMAGE_SERVER_DOMAIN = valueOf("http://wechat.iptid.net");

	/** 全局图片服务根物理路径 */
	@ConstValue("${global.imgserver.root}")
	public static final String GLOBAL_IMAGE_SERVER_ROOT = valueOf("d:/data/jacars");

	/** 我方提供给微信OAuth2认证授权的callback URL */
	@ConstValue("${url.app.domain}${uri.app.weixin.oauth2_callback}")
	public static final String WEIXIN_URL_OAUTH2_CALLBACK = valueOf(null);

	/** 微信OAUTH2登录认证URI */
	@ConstValue("${url.weixin.domain}${uri.weixin.oauth2_access_token}")
	public static final String WEIXIN_URL_OAUTH2_ACCESS_TOKEN = valueOf("https://api.weixin.qq.com/sns/oauth2/access_token");

	/** 微信获取access_token的URL */
	@ConstValue("${url.weixin.domain}${uri.weixin.access_token}")
	public static final String WEIXIN_URL_ACCESS_TOKEN = valueOf("https://api.weixin.qq.com/cgi-bin/token");

	/** 微信获取jsapi_ticket的URL */
	@ConstValue("${url.weixin.domain}${uri.weixin.jsapi_ticket}")
	public static final String WEIXIN_URL_JSAPI_TICKET = valueOf("https://api.weixin.qq.com/cgi-bin/ticket/getticket");

	/** 微信获取企业🆗jsapi_ticket的URL */
	@ConstValue("${url.weixin.domain}${uri.weixin.enterprise.jsapi_ticket}")
	public static final String WEIXIN_URL_ENTERPRISE_JSAPI_TICKET = valueOf("https://qyapi.weixin.qq.com/cgi-bin/ticket/get");

	/** 微信企业号发送消息接口 */
	@ConstValue("${url.weixin.domain}${uri.weixin.send.message}")
	public static final String WEIXIN_URL_SEND_MESSAGE = valueOf("https://qyapi.weixin.qq.com/cgi-bin/message/send");

	/** 微信企业号获取部分成员详情接口 */
	@ConstValue("${url.weixin.domain}${uri.weixin.get_userlist}")
	public static final String WEIXIN_URL_GET_DEPTMEMBERS_DETAIL = valueOf("https://qyapi.weixin.qq.com/cgi-bin/user/list");

	/** 微信获取服务器ip列表 */
	@ConstValue("${url.weixin.domain}${uri.weixin.server_ips}")
	public static final String WEIXIN_URL_SERVER_IPS = valueOf("https://api.weixin.qq.com/cgi-bin/getcallbackip");

	/** 微信获取用户基本信息 */
	@ConstValue("${url.weixin.domain}${uri.weixin.userinfo}")
	public static final String WEIXIN_URL_USER_INFO = valueOf("https://api.weixin.qq.com/cgi-bin/user/info");

	/** 创建微信自定义菜单的URL */
	@ConstValue("${url.weixin.domain}${uri.weixin.create_menus}")
	public static final String WEIXIN_URL_CREATE_MENUS = valueOf("https://api.weixin.qq.com/cgi-bin/menu/create");

	/** 删除微信自定义菜单的URL */
	@ConstValue("${url.weixin.domain}${uri.weixin.delete_menus}")
	public static final String WEIXIN_URL_DELETE_MENUS = valueOf("https://api.weixin.qq.com/cgi-bin/menu/delete");

	/** 素材管理上传图片的URL(图文消息专用) */
	@ConstValue("${url.weixin.domain}${uri.weixin.media_upload_img}")
	public static final String WEIXIN_URL_MEDIA_UPLOAD_IMG = valueOf("https://api.weixin.qq.com/cgi-bin/media/uploadimg");

	/** 素材管理下载图片的URL(用户头像使用) */
	@ConstValue("${uri.weixin.media_download_img}")
	public static final String WEIXIN_URL_MEDIA_DOWNLOAD_IMG = valueOf("http://file.api.weixin.qq.com/cgi-bin/media/get");

	/** 素材管理上传其他素材的URL(图片、语音、视频) */
	@ConstValue("${url.weixin.domain}${uri.weixin.media_upload_material}")
	public static final String WEIXIN_URL_MEDIA_UPLOAD_MATERIAL = valueOf("https://api.weixin.qq.com/cgi-bin/material/add_material");

	/** 微信消息图片保存相对路径 */
	public static final String FILE_SAVE_PATH_WX_MESSAGE_IMAGE = valueOf("/img/wxmessage");

	/** 富文本图片保存相对路径 */
	public static final String FILE_SAVE_PATH_UEDITOR_IMAGE = valueOf("/img/ueditor");

	/** 管理后台图片保存相对路径 */
	public static final String FILE_SAVE_PATH_ADMIN_IMAGE = valueOf("/img/admin");

	/** 微信消息文件(语音、视频等)保存相对路径 */
	public static final String FILE_SAVE_PATH_WX_MESSAGE_FILE = valueOf("/file/wxmessage");

	/**
	 * 我的借阅自定义菜单key
	 */
	@ConstValue("${global.pdlib.borrowurl}")
	public static final String GLOBAL_PDLIB_BORROW_URL = valueOf(null);

	/**
	 * 无锡地税接口地址
	 */
	@ConstValue("${wxtax.interfacce.server}")
	public static final String WXTAX_INTERFACE_SERVER = valueOf("http://127.0.0.1:8080/wxtax_interface");

}
