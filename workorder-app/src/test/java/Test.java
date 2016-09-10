import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.gongdan.common.redis.RedisClientTemplate;


public class Test {
	 public static void main(String[] args) {
	        ApplicationContext ac =  new ClassPathXmlApplicationContext("classpath:/spring/spring-cache.xml");
	        RedisClientTemplate redisClient = (RedisClientTemplate)ac.getBean("redisClientTemplate");
	        redisClient.set("a", "abc");
	        System.out.println(redisClient.get("a"));
	    }
}
