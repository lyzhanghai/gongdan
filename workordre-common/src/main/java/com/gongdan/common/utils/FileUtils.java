package com.gongdan.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.UUID;

import org.springframework.util.Assert;

/**
 * 文件操作工具类
 * 
 * @author	  	pengpeng
 * @date	  	2014年7月20日 上午12:03:21
 * @version  	1.0
 */
public class FileUtils {

	/**
     * 默认的标准推荐使用的文件路径分隔符
     */
    public static final String DEFAULT_STANDARD_FILE_DELIMITER = "/";

    /**
     * 默认的不推荐使用的文件路径分隔符
     */
    public static final String DEFAULT_AGAINST_FILE_DELIMITER = "\\";
    
    /**
     * 默认的http协议地址头
     */
    public static final String DEFAULT_PREFIX_HTTP_PROTOCOL = "http://";
    
    /**
     * 默认文件copy缓冲区大小
     */
    public static final int FILE_COPY_BUFFER_SIZE = 20 * 1024 * 1024;
	
    /**
     * <p>纠正不标准的文件路径分隔符
     * 如：\,\\,\\\,//,/// -> /</p>
     *
     * @param path
     * @return
     */
    public static String formatFilePath(String path){
        if (!StringUtils.isEmpty(path)) {
        	boolean startWithHttpProtocol = path.toLowerCase().startsWith(DEFAULT_PREFIX_HTTP_PROTOCOL);
        	if(startWithHttpProtocol){
        		path = path.substring(DEFAULT_PREFIX_HTTP_PROTOCOL.length());
        	}
        	// 将一个或多个“\”转化成“/”
        	path = path.replaceAll("\\\\{1,}", "/");
            // 将多个“/”转化成一个“/”
        	path = path.replaceAll("\\/{2,}", "/");
        	if(startWithHttpProtocol){
        		path = DEFAULT_PREFIX_HTTP_PROTOCOL + path;
        	}
        }
        return path;
    }
    
    /**
     * <p>获取文件格式,小写,例如: txt、jpg等</p>
     *
     * @param imageFileName
     * @return
     */
    public static String getFileFormat(String fileName) {
        Assert.hasText(fileName, "Parameter 'fileName' can not be empty!");
        return fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
    }
    
    /**
     * <p>根据文件路径获取文件名称</p>
     * 
     * @param filePath
     * @return
     */
    public static String getFileName(String filePath) {
    	Assert.hasText(filePath, "Parameter 'filePath' can not be empty!");
    	filePath = formatFilePath(filePath);
    	return filePath.substring(filePath.lastIndexOf(DEFAULT_STANDARD_FILE_DELIMITER) + 1);
    }
    
    /**
     * <p>获取文件大小,单位字节</p>
     *
     * @param fileFullPath
     * @return
     * @throws IOException
     */
    public static int getFileSize(String fileFullPath) throws IOException {
    	Assert.hasText(fileFullPath, "Parameter 'fileFullPath' can not be empty!");
        int size = 0;
        fileFullPath = formatFilePath(fileFullPath);
        File file = new File(fileFullPath);
        if (file.exists() && !isDirectory(fileFullPath)) {
            FileInputStream fis = new FileInputStream(file);
            size = fis.available();
            if (fis != null) {
                fis.close();
            }
        }
        return size;
    }
    
    /**
     * <p>获取系统临时目录</p>
     * 
     * @return
     */
    public static String getTempDirectoryPath() {
        String path = System.getProperty("java.io.tmpdir");
        if(!StringUtils.isEmpty(path)){
        	return formatFilePath(path);
        }
        return path;
    }
    
    /**
     * <p>获取用户目录</p>
     * 
     * @return
     */
    public static String getUserDirectoryPath() {
        String path = System.getProperty("user.home");
        if(!StringUtils.isEmpty(path)){
        	return formatFilePath(path);
        }
        return path;
    }
    
    /**
     * <p>根据文件路径获取File对象</p>
     * 
     * @param fullFilePath
     * @return
     */
    public static File getFile(String filePath) {
    	Assert.hasText(filePath, "Parameter 'filePath' can not be empty!");
    	filePath = formatFilePath(filePath);
        return new File(filePath);
    }
    
    /**
     * <p>创建文件目录如果需要创建</p>
     *
     * @param filePath
     * @throws Exception
     * @return true-创建了新目录;false-没有创建新目录
     */
    public static boolean mkDirIfNecessary(String filePath) {
        filePath = formatFilePath(filePath);
        File dirFile = new File(getFileDirectory(filePath));
        if (!dirFile.exists()) {
            dirFile.mkdirs();
            return true;
        }
        return false;
    }
    
    /**
     * <p>根据文件路径判断该路径表示的是文件还是目录</p>
     *
     * @param filePath
     * @return
     */
    public static boolean isDirectory(String filePath) {
        if (!StringUtils.isEmpty(filePath)) {
        	filePath = formatFilePath(filePath);
            int index1 = filePath.lastIndexOf('.');
            if (index1 == -1) {
                return true;
            } else {
                int index2 = filePath.lastIndexOf(DEFAULT_STANDARD_FILE_DELIMITER) == -1 ? filePath.lastIndexOf(DEFAULT_AGAINST_FILE_DELIMITER) : filePath.lastIndexOf(DEFAULT_STANDARD_FILE_DELIMITER);
                if (index2 != -1) {
                    if (index1 > index2) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    return false;
                }
            }
        }
        return false;
    }

    /**
     * <p>根据文件路径获取其目录</p>
     *
     * @param filePath
     * @return
     */
    public static String getFileDirectory(String filePath) {
        if (!StringUtils.isEmpty(filePath)) {
            filePath = formatFilePath(filePath);
            if (isDirectory(filePath)) {
                return filePath;
            } else {
                return filePath.substring(0, filePath.lastIndexOf(DEFAULT_STANDARD_FILE_DELIMITER));
            }
        }
        return filePath;
    }
    
    /**
     * <p>重命名文件名</p>
     *
     * @param originalName - 原文件名
     * @param renameAll    - true-舍弃原文件名完全做随机重新命名;false-在原文件名后面做随机重命名
     * @param appendStr    - 加在文件名后的追加后缀,e.g. ${originalName}_${appendStr}.jpg
     * @return
     * @throws Exception
     */
    public static String renameFileName(String originalName, boolean renameAll, String appendStr) {
    	Assert.hasText(originalName, "Parameter 'originalName' can not be empty!");
        String suffix = originalName.substring(originalName.lastIndexOf('.') + 1);
        String fileName = originalName.substring(0, originalName.lastIndexOf('.'));
        String randomName = UUID.randomUUID().toString().replace("-", "");
        if (!StringUtils.isEmpty(appendStr)) {
            return String.format("%s_%s.%s", renameAll ? randomName : fileName + "_" + randomName.substring(0, 8), appendStr, suffix);
        } else {
            return String.format("%s.%s", renameAll ? randomName : fileName + "_" + randomName.substring(0, 8), suffix);
        }
    }
    
    /**
     * <p>文件复制</p>
     *
     * @param srcFile  - 源文件
     * @param destFile - 目标文件
     * @throws Exception
     */
    public static void copyFile(File srcFile, File destFile) throws Exception {
    	Assert.notNull(srcFile, "Parameter 'srcFile' can not be null!");
        Assert.notNull(destFile, "Parameter 'destFile' can not be null!");
        FileInputStream fis = null;
        FileOutputStream fos = null;
        FileChannel input = null;
        FileChannel output = null;
        try {
            fis = new FileInputStream(srcFile);
            fos = new FileOutputStream(destFile);
            input  = fis.getChannel();
            output = fos.getChannel();
            long size = input.size();
            long pos = 0;
            long count = 0;
            while (pos < size) {
                count = size - pos > FILE_COPY_BUFFER_SIZE ? FILE_COPY_BUFFER_SIZE : size - pos;
                pos += output.transferFrom(input, pos, count);
            }
        } finally {
            IOUtils.closeQuietly(output);
            IOUtils.closeQuietly(fos);
            IOUtils.closeQuietly(input);
            IOUtils.closeQuietly(fis);
        }
    }
    
    /**
     * <p>文件复制</p>
     *
     * @param srcFullFileName  - 源文件名
     * @param destFullFileName - 目标文件名
     * @throws Exception
     */
    public static void copyFile(String srcFullFileName, String destFullFileName) throws Exception {
    	Assert.hasText(srcFullFileName, "Parameter 'srcFullFileName' can not be empty!");
    	Assert.hasText(destFullFileName, "Parameter 'destFullFileName' can not be empty!");
    	copyFile(getFile(srcFullFileName), getFile(destFullFileName));
    }
    
    /**
     * <p>删除文件</p>
     *
     * @param fullPath
     * @return
     */
    public static boolean deleteFile(String fullPath) {
        File file = getFile(fullPath);
        if(file.exists()){
        	return file.delete();
        }
        return false;
    }
    
    /**
     * <p>尽最大努力删除文件,删除失败不抛出异常</p>
     *
     * @param fullPath
     * @return
     */
    public static void deleteFileQuietly(String fullPath) {
        try {
			File file = getFile(fullPath);
			if(file.exists()){
				file.delete();
			}
		} catch (Exception e) {
		}
    }
    
    public static String getNamedFileSize(long fileSize) {
    	double d = 0;
    	if(fileSize < 1024){
    		return fileSize + "B";
    	}else if(fileSize < 1024l * 1024){
    		d = (fileSize * 1.0 / 1024);
    		if(d % 1 == 0){
    			return String.format("%.0f", d) + "KB";
    		}else{
    			return String.format("%.1f", d) + "KB";
    		}
    	}else if(fileSize < 1024l * 1024 * 1024){
    		d = fileSize * 1.0 / (1024 * 1024);
    		if(d % 1 == 0){
    			return String.format("%.0f", d) + "MB";
    		}else{
    			return String.format("%.1f", d) + "MB";
    		}
    	}else if(fileSize < 1024l * 1024 * 1024 * 1024){
    		d = fileSize * 1.0 / (1024 * 1024 * 1024);
    		if(d % 1 == 0){
    			return String.format("%.0f", d) + "GB";
    		}else{
    			return String.format("%.1f", d) + "GB";
    		}
    	}
    	return fileSize + "B";
    }
    
    public static void main(String[] args) {
		System.out.println(getNamedFileSize(1024 * 1024 * 1024));
	}
    
}