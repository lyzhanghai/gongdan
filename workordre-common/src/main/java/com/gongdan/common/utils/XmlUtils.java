package com.gongdan.common.utils;

import com.fasterxml.aalto.stax.InputFactoryImpl;
import com.fasterxml.aalto.stax.OutputFactoryImpl;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlFactory;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.fasterxml.jackson.dataformat.xml.ser.ToXmlGenerator;
/**
 * 基于jackson2的xml与JavaBean之间的转换
 * 
 * @author  pengpeng
 * @date 	 2015年4月23日 下午5:13:48
 * @version 1.0
 */
public class XmlUtils {

	public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	private static final XmlMapper defaultObjectMapper;
	
	static {
		XmlFactory factory = new XmlFactory(new InputFactoryImpl(), new OutputFactoryImpl());
		defaultObjectMapper = new XmlMapper(factory);
		//如果字段为null或空字符串则不输出对应的xml标签,此为全局设置,不建议设置此全局设置,可在相应类上打上注解@JsonInclude(JsonInclude.Include.NON_EMPTY)
		defaultObjectMapper.setSerializationInclusion(Include.NON_EMPTY);
		defaultObjectMapper.configure(ToXmlGenerator.Feature.WRITE_XML_DECLARATION, false);
	}
	
	/**
	 * 对象转Xml字符串
	 * @param object
	 * @return
	 */
	public static String object2Xml(Object object) {
		try {
			return defaultObjectMapper.writeValueAsString(object);
		} catch (Exception e) {
			throw new JacksonXmlException(e);
		}
	}
	
	/**
	 * Xml字符串转普通javabean
	 * @param <T>
	 * @param xml
	 * @param clazz		- 注：clazz所指对象存在泛型,例如 Result<User> 则转换后User的实际类型是个Map,此类情况应该使用TypeReference进行转换
	 * @return
	 */
	public static <T> T xml2Object(String xml, Class<T> clazz) {
		try {
			return defaultObjectMapper.readValue(xml, clazz);
		} catch (Exception e) {
			throw new JacksonXmlException(e);
		}
	}
	
	/**
	 * Xml字符串转泛型类对象
	 * @param <T>
	 * @param Xml
	 * @param typeReference
	 * @return
	 */
	public static <T> T xml2Object(String xml, TypeReference<T> typeReference) {
		try {
			return defaultObjectMapper.readValue(xml, typeReference);
		} catch (Exception e) {
			throw new JacksonXmlException(e);
		}
	}
	
	public static ObjectMapper getDefaultObjectMapper() {
		return defaultObjectMapper;
	}
	
	public static class JacksonXmlException extends RuntimeException {

		private static final long serialVersionUID = 1L;

		public JacksonXmlException(String message, Throwable cause) {
			super(message, cause);
		}

		public JacksonXmlException(String message) {
			super(message);
		}

		public JacksonXmlException(Throwable cause) {
			super(cause);
		}
		
	}
	
}
