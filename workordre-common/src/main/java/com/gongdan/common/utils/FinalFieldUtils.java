package com.gongdan.common.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import com.gongdan.common.utils.ReflectionUtils.ReflectionException;


/**
 * 修改final字段的值的工具类
 * 
 * @author	  	pengpeng
 * @date	  	2014年10月16日 上午10:50:47
 * @version  	1.0
 */
public class FinalFieldUtils {

    public static void setFinalFieldValue(Object target, Field field, Object value) {
    	try {
			field.setAccessible(true);
			final Field modifiersField = Field.class.getDeclaredField("modifiers");
			modifiersField.setAccessible(true);
			modifiersField.setInt(field, field.getModifiers() & ~Modifier.FINAL);
			field.set(target, value);
			//设置完后再将修饰符改回去
			modifiersField.setInt(field, field.getModifiers() | Modifier.FINAL);
			modifiersField.setAccessible(false);
			field.setAccessible(false);
		} catch (Exception e) {
			throw new ReflectionException(String.format("modify the value of final field failed by reflection! error message is: %s", e.getMessage()), e);
		}  
    }
    
}
