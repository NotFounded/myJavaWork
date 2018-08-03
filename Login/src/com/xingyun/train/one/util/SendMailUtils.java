package com.xingyun.train.one.util;

import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * 发送邮件工具类
 * @author feijunhui
 *
 */
public class SendMailUtils {
	public static void sendMail(String sendAdd,String text,String subject ) throws AddressException, MessagingException, IOException{
		
		Properties properties = new Properties();
		properties.load(new InputStreamReader(SendMailUtils.class.getClassLoader().getResourceAsStream("mail.properties"), "UTF-8"));   
		// smtp邮件服务器地址
		final String HOST = (String) properties.get("host");
		// smtp服务器端口
		final String POST = (String) properties.get("post");
		// 是否启用身份认证
		final String AUTH = (String) properties.get("auth");
		// 发件人地址
		final String SEND_ADD = (String) properties.get("sendAdd");
		// 发件人邮箱密码
		final String SEND_PWD = (String) properties.get("sendPwd");
//		//发送邮件服务器
//		properties.setProperty("mail.transport.protocol", "smtp"); 
		properties.put("mail.smtp.host", HOST );
		//发送端口
		properties.put("mail.smtp.post", POST );
		properties.put("mail.smtp.auth", AUTH );
		//设置发送邮件的帐号和密码
		Authenticator auth = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(SEND_ADD, SEND_PWD);
			}
		};
		//放入session
		Session session = Session.getInstance(properties,auth);
		//创建邮件对象
		Message message = new MimeMessage(session);
		//设置发件人
		message.setFrom(new InternetAddress(SEND_ADD));
		//设置收件人
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(sendAdd));
		//设置主题
		message.setSubject(subject);
		//设置内容
		message.setContent(text, "text/html;charset=UTF-8");
		//发送
		Transport.send(message);
	}
}
