package com.gongdan.common.mqtt;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttPersistenceException;
import org.eclipse.paho.client.mqttv3.MqttTopic;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

public class MqttServer {

	public static final String HOST = "tcp://192.168.1.3:61613";
	public static final String TOPIC = "toclient/124";
	public static final String TOPIC125 = "toclient/125";
	private static final String clientid = "server";

	private static MqttClient client;
	private MqttTopic topic;
	private String userName = "admin";
	private String passWord = "password";
	private MqttMessage message;

	
	public static MqttClient getClient(){
		
		
		return client;
	}
	
	
	
	public MqttServer() throws MqttException {
         // MemoryPersistence设置clientid的保存形式，默认为以内存保存
         client = new MqttClient(HOST, clientid, new MemoryPersistence());
         connect();
     }

	private void connect() {
		MqttConnectOptions options = new MqttConnectOptions();
		options.setCleanSession(false);
		options.setUserName(userName);
		options.setPassword(passWord.toCharArray());
		// 设置超时时间
		options.setConnectionTimeout(10);
		// 设置会话心跳时间
		options.setKeepAliveInterval(20);
		try {
			client.setCallback(new MqttPushCallback());
			client.connect(options);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void publish(MqttTopic topic, MqttMessage message) throws MqttPersistenceException, MqttException {
		MqttDeliveryToken token = topic.publish(message);
		token.waitForCompletion();
	}

}
