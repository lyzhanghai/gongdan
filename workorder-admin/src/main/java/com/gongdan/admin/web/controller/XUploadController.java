package com.gongdan.admin.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gongdan.common.consts.GlobalURLConstants;
import com.gongdan.common.support.ModuleExceptionResolver;
import com.gongdan.common.support.ValidationAssert;
import com.gongdan.common.utils.FileUtils;
import com.gongdan.common.utils.JsonUtils;
import com.gongdan.common.utils.UUIDUtils;
import com.gongdan.xadmin.web.BaseController;

/**
 * 基于xupload图片上传的Controller
 * 
 * @author pengpeng
 * @date 2015年5月25日 下午6:09:07
 * @version 1.0
 */
@Controller
public class XUploadController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(XUploadController.class);

	public static final String UPLOAD_TEMP_PATH = "/upload/temp/";

	@RequestMapping("/xupload/ueditor/file/submit")
	@ResponseBody
	public String uploadUeditorImage(HttpServletRequest request, HttpServletResponse response, String uploadSerialNo, Long maxFileSize, Map<String, Object> modelMap) throws Exception {
		Map<String, Object> resultObj = new HashMap<String, Object>();
		String fileViewUrl = "";
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile multipartFile = multipartRequest.getFile("uploadFile");
			if (maxFileSize != null && maxFileSize > 0) {
				ValidationAssert.isTrue(multipartFile.getSize() <= maxFileSize, String.format("对不起!上传图片大小不能超过%s!", FileUtils.getNamedFileSize(maxFileSize)));
			}
			String suffix = FileUtils.getFileFormat(multipartFile.getOriginalFilename());
			String uuid = UUIDUtils.uuid();
			String fileRelativePath = GlobalURLConstants.GLOBAL_IMAGE_SERVER_ROOT + GlobalURLConstants.FILE_SAVE_PATH_UEDITOR_IMAGE + "/" + uuid + "." + suffix;
			fileViewUrl = GlobalURLConstants.FILE_SAVE_PATH_UEDITOR_IMAGE + "/" + uuid + "." + suffix;
			FileUtils.mkDirIfNecessary(fileRelativePath);

			multipartFile.transferTo(new File(fileRelativePath));
			resultObj.put("success", true);
			resultObj.put("message", "上传图片成功!");
			Map<String, Object> retObj = new HashMap<String, Object>();
			retObj.put("originalFileName", multipartFile.getOriginalFilename());
			retObj.put("fileRelativePath", fileRelativePath);
			retObj.put("fileViewUrl", fileViewUrl);
			resultObj.put("retObj", retObj);
		}
		catch (Throwable e) {
			resultObj.put("success", false);
			resultObj.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
		}
		return GlobalURLConstants.GLOBAL_IMAGE_SERVER_DOMAIN + fileViewUrl;
	}

	@RequestMapping("/admin/xupload/image")
	public String uploadImage(HttpServletRequest request, HttpServletResponse response, String uploadSerialNo, Long maxFileSize, Map<String, Object> modelMap) throws Exception {
		Map<String, Object> resultObj = new HashMap<String, Object>();
		resultObj.put("uploadSerialNo", uploadSerialNo);
		String fileViewUrl = "";
		try {
			logger.debug(">>> uploadSerialNo = " + uploadSerialNo);
			// 将request强转为MultipartHttpServletRequest用于接收处理客户端上传的文件
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			// 接收uploadFile上传组件上传的文件
			MultipartFile multipartFile = multipartRequest.getFile("uploadFile");
			// 验证文件大小是否符合条件
			if (maxFileSize != null && maxFileSize > 0) {
				ValidationAssert.isTrue(multipartFile.getSize() <= maxFileSize, String.format("对不起!上传图片大小不能超过%s!", FileUtils.getNamedFileSize(maxFileSize)));
			}
			// getOriginalFilename : 获取上传文件的原名
			String suffix = FileUtils.getFileFormat(multipartFile.getOriginalFilename());
			// 获得上传文件相对路径
			String fileRelativePath = UPLOAD_TEMP_PATH + UUIDUtils.uuid() + "." + suffix;
			// 获得上传文件在服务器端的临时目录的绝对路径
			String tempFileRealPath = FileUtils.formatFilePath(request.getSession().getServletContext().getRealPath("/") + fileRelativePath);
			// 如果不存在就创建该目录
			FileUtils.mkDirIfNecessary(tempFileRealPath);
			// 获得服务器端的相对路径
			fileViewUrl = FileUtils.formatFilePath(request.getContextPath() + fileRelativePath);
			// 将文件上传到服务器端临时目录
			multipartFile.transferTo(new File(tempFileRealPath));
			String uuid = UUIDUtils.uuid();
			fileRelativePath = GlobalURLConstants.GLOBAL_IMAGE_SERVER_ROOT + GlobalURLConstants.FILE_SAVE_PATH_UEDITOR_IMAGE + "/" + uuid + "." + suffix;
			fileViewUrl = GlobalURLConstants.FILE_SAVE_PATH_UEDITOR_IMAGE + "/" + uuid + "." + suffix;
			// String fileRelativePath = UPLOAD_TEMP_PATH + UUIDUtils.uuid() +
			// "." + suffix;
			// String tempFileRealPath =
			// FileUtils.formatFilePath(request.getSession().getServletContext().getRealPath("/")
			// + fileRelativePath);
			FileUtils.mkDirIfNecessary(fileRelativePath);
			// String fileViewUrl =
			// FileUtils.formatFilePath(request.getContextPath() +
			// fileRelativePath);
			multipartFile.transferTo(new File(fileRelativePath));
			resultObj.put("success", true);
			resultObj.put("message", "上传图片成功!");
			Map<String, Object> retObj = new HashMap<String, Object>();
			retObj.put("originalFileName", multipartFile.getOriginalFilename());
			retObj.put("fileRelativePath", fileRelativePath);
			retObj.put("fileViewUrl", fileViewUrl);
			resultObj.put("retObj", retObj);
		}
		catch (Throwable e) {
			resultObj.put("success", false);
			resultObj.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
		}
		modelMap.put("result", JsonUtils.object2Json(resultObj));
		return "common/xupload/result";
	}

	@RequestMapping("/admin/xupload/file")
	public String uploadFile(HttpServletRequest request, HttpServletResponse response, String uploadSerialNo, Long maxFileSize, Map<String, Object> modelMap) throws Exception {
		Map<String, Object> resultObj = new HashMap<String, Object>();
		resultObj.put("uploadSerialNo", uploadSerialNo);
		try {
			logger.debug(">>> uploadSerialNo = " + uploadSerialNo);

			// 将request强转为MultipartHttpServletRequest用于接收处理客户端上传的文件
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			// 接收uploadFile上传组件上传的文件
			MultipartFile multipartFile = multipartRequest.getFile("uploadFile");
			// 验证文件大小是否符合条件
			if (maxFileSize != null && maxFileSize > 0) {
				ValidationAssert.isTrue(multipartFile.getSize() <= maxFileSize, String.format("对不起!上传文件大小不能超过%s!", FileUtils.getNamedFileSize(maxFileSize)));
			}
			// getOriginalFilename : 获取上传文件的原名
			String uuid = UUIDUtils.uuid();
			String suffix = FileUtils.getFileFormat(multipartFile.getOriginalFilename());
			// 获得上传文件相对路径
			String fileRelativePath = GlobalURLConstants.GLOBAL_IMAGE_SERVER_ROOT + GlobalURLConstants.FILE_SAVE_PATH_ADMIN_IMAGE + uuid + "." + suffix;
			// 获得服务器端的相对路径
			String fileViewUrl = GlobalURLConstants.GLOBAL_IMAGE_SERVER_ROOT + GlobalURLConstants.FILE_SAVE_PATH_ADMIN_IMAGE + "/" + uuid + "." + suffix;

			// 如果不存在就创建该目录
			FileUtils.mkDirIfNecessary(fileRelativePath);

			// 将文件上传到服务器端目录
			multipartFile.transferTo(new File(fileRelativePath));
			resultObj.put("success", true);
			resultObj.put("message", "上传文件成功!");
			Map<String, Object> retObj = new HashMap<String, Object>();
			retObj.put("originalFileName", multipartFile.getOriginalFilename());
			retObj.put("fileRelativePath", fileRelativePath);
			retObj.put("fileViewUrl", fileViewUrl);
			resultObj.put("retObj", retObj);
		}
		catch (Throwable e) {
			resultObj.put("success", false);
			resultObj.put("message", ModuleExceptionResolver.resolveException(e).getMessage());
		}
		modelMap.put("result", JsonUtils.object2Json(resultObj));
		return "/common/xupload/result";
	}

}
