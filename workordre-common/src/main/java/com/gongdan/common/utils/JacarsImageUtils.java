package com.gongdan.common.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;

import com.gongdan.common.consts.GlobalURLConstants;


/**
 * 项目图片工具类
 * 
 * @author pengpeng
 * @date 2016年3月15日 下午4:44:03
 * @version 1.0
 */
public class JacarsImageUtils {

	/**
	 * 生成用户头像图片相对路径 例如：/img/user/20160315/uuid.jpg
	 * 
	 * @return
	 */
	public static String genUserIconImgRealSavePath() {
		return GlobalURLConstants.GLOBAL_IMAGE_SERVER_DOMAIN + "/" + DateTimeUtils.formatNow("yyyyMMdd") + "/" + UUIDUtils.uuid() + ".jpg";
	}

	/**
	 * 根据图片相对路径得到图片的绝对HTTP路径
	 * 
	 * @param imageUrl
	 * @return
	 */
	public static String getFullImageHttpUrl(String imageUrl) {
		if (!StringUtils.isEmpty(imageUrl)) {
			String lImageUrl = imageUrl.toLowerCase();
			if (!lImageUrl.startsWith("http://")) {
				if (!lImageUrl.startsWith("/")) {
					imageUrl = "/" + imageUrl;
				}
				imageUrl = GlobalURLConstants.GLOBAL_IMAGE_SERVER_DOMAIN + imageUrl;
			}
		}
		return imageUrl;
	}

	/**
	 * 下载HTTP图片到本地
	 * 
	 * @param imgHttpUrl
	 *            - 要下载的图片HTTP全路径
	 * @param realImgSavePath
	 *            - 图片保存的相对路径(其相对于 #GlobalURLConstants.GLOBAL_IMAGE_SERVER_ROOT)
	 * @return fullImgFilePath - 返回图片保存的物理全路径 (返回null则表示下载失败)
	 */
	public static String downloadImageByHttpUrl(String imgHttpUrl, String realImgSavePath) {
		if (!StringUtils.isEmpty(imgHttpUrl) && !StringUtils.isEmpty(realImgSavePath)) {
			realImgSavePath = FileUtils.formatFilePath(realImgSavePath);
			if (!realImgSavePath.startsWith(FileUtils.DEFAULT_STANDARD_FILE_DELIMITER)) {
				realImgSavePath = FileUtils.DEFAULT_STANDARD_FILE_DELIMITER + realImgSavePath;
			}
			String fullImgFilePath = GlobalURLConstants.GLOBAL_IMAGE_SERVER_ROOT + realImgSavePath;
			return HttpClientUtils.doGet(imgHttpUrl, new ImageResponseHandler(fullImgFilePath));
		}
		return null;
	}

	public static class ImageResponseHandler implements ResponseHandler<String> {

		private final String fullImgFilePath;

		public ImageResponseHandler(String fullImgFilePath) {
			super();
			this.fullImgFilePath = fullImgFilePath;
		}

		@Override
		public String handleResponse(HttpResponse response) throws ClientProtocolException, IOException {
			HttpEntity httpEntity = response.getEntity();
			if (httpEntity != null) {
				InputStream in = null;
				OutputStream out = null;
				try {
					FileUtils.mkDirIfNecessary(fullImgFilePath);
					in = httpEntity.getContent();
					out = new FileOutputStream(fullImgFilePath);
					IOUtils.copy(in, out);
				}
				finally {
					IOUtils.closeQuietly(in);
					IOUtils.closeQuietly(out);
				}
				return fullImgFilePath;
			}
			return null;
		}
	}

	public static void main(String[] args) {
		String media = "ejwaaql7dHiJmFITNegY2P3wNvpA0qwFylzpTbn7W2vIGqkRIGsLLYa-ZJdybJV";
		String imgHttpUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=YBiXJUj7H5wPhUYDfQiaoBzWL38d4vcExRgVbVgvz1skvCv6g2QYwx8Ajc9m5uRYa0tJ5lZe4c1WCM8Q0-KmSkQAEOB8yxZJhBCER0f2suPhrtK3ZTMviajf5hRDASIlBUOcAJAGZT&media_id=" + media;
		String realImgSavePath = "/img/user/20160316/" + UUIDUtils.uuid() + ".jpg";
		String result = downloadImageByHttpUrl(imgHttpUrl, realImgSavePath);
		System.out.println(result);
		System.out.println(getFullImageHttpUrl("imgHttpUrl"));

	}

}
